module Router

import HTTP
import ..State

include("HealthHandler.jl")

function HttpRouter(state::State.SharedState)
    router = HTTP.Router()
    HTTP.@register(router, "GET", "/health", HealthHandler.Handler(state))

    return router
end

end # module