import Test
import HTTP
import App

function router()
    config = App.Config.getconfig()
    state = App.State.SharedState(config)
    router = App.Router.HttpRouter(state)
    return router
end

@testset "HealthHandler" begin
    @test begin
        r = router()

        req = HTTP.Request("GET", "/health")
        res = HTTP.handle(r, req)

        res.status == 200
    end
end