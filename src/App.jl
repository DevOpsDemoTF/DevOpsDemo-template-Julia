module App

import HTTP, Sockets

include("Config.jl")
include("State.jl")
include("Router.jl")

function julia_main()::Cint
    try
        real_main()
    catch
        Base.invokelatest(Base.display_error, Base.catch_stack())
        return 1
    end
    return 0
end

function real_main()
    config = Config.getconfig()
    state = State.SharedState(config)
    router = Router.HttpRouter(state)

    host = "0.0.0.0"
    port = 8080
    server = Sockets.listen(Sockets.InetAddr(parse(Sockets.IPAddr, host), port))
    p = @async HTTP.serve(router, host, port; server = server)
    @info "Service is running..."

    # close server which will stop HTTP.serve
    Base.exit_on_sigint(false)
    try
        wait(p)
    catch e
        if isa(e, InterruptException)
            @warn "Caught SIGINT"
            close(server)
            wait(p)
        else
            @warn "Caught SIGTERM"
            kill(p) # SIGTERM
            rethrow()
        end
    end
    return
end

end # module
