module Config

import JSON3
using Memento

struct AppConfig
    loglevel::String
end

function getconfig()::AppConfig
    loglevel = lowercase(get(ENV, "LOG_LEVEL", "warn"))
    config = AppConfig(loglevel)
    configure_logger(config)

    return config
end

function configure_logger(config::AppConfig)
    handler = DefaultHandler(
        stderr,
        DictFormatter(Dict(:time => :date, :msg => :msg, :level => :level), JSON3.write))

    logger = Memento.getlogger()
    logger.handlers["console"] = handler
    setlevel!(logger, config.loglevel; recursive = true)
    Memento.substitute!()
end

end