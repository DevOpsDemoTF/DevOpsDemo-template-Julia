module HealthHandler

import ..State
import HTTP

struct Handler
    state::State.SharedState
end

function (h::Handler)(req::HTTP.Request)
    if h.state.healthy
        HTTP.Response(200)
    else
        HTTP.Response(500)
    end
end


end # module