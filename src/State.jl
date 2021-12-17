module State

import ..Config

mutable struct SharedState
    config::Config.AppConfig
    healthy::Bool
end

function SharedState(config::Config.AppConfig)
    SharedState(config, true)
end

end