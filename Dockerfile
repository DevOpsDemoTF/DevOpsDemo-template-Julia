FROM julia:1.7.0-alpine3.15 as base
WORKDIR /app

RUN apk add --no-cache \
    gnu-libiconv \
    libxml2 \
    build-base \
    clang \
    musl && \
    julia -e 'import Pkg; Pkg.add("PackageCompiler")'

ENV JULIA_CC clang
COPY Project.toml Manifest.toml ./
RUN julia -q -e 'import Pkg; Pkg.activate("."); Pkg.instantiate()' && \
    julia --project -q -e 'using PackageCompiler; create_sysimage(["HTTP", "JSON3"]; sysimage_path="sysimage.so", incremental=false, cpu_target=PackageCompiler.default_app_cpu_target())'

COPY . .

FROM base as build
RUN julia -q --sysimage="sysimage.so" --project -e 'using PackageCompiler; create_app(".", "AppBin", precompile_execution_file="precompile_app.jl", incremental=true)'

FROM base as test
RUN julia -q --sysimage="sysimage.so" --project -e 'using Pkg; Pkg.add("TestReports"); using TestReports; TestReports.test("App")' && \
    mv testlog.xml test-results.xml

FROM alpine:3.15

RUN mkdir /app && \
    addgroup -S app && adduser -S app -G app && \
    apk add --no-cache dumb-init

EXPOSE 8080
#TODO EXPOSE 9102 no prometheus library available

ENV LOG_LEVEL "DEBUG"

COPY --from=build /app/sysimage.so /app/AppBin /app/
COPY --from=test /app/test-results.xml /app/

USER app
WORKDIR /app
ENTRYPOINT ["dumb-init"]
CMD ["/app/bin/App"]
