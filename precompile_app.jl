using App
using HTTP

config = App.Config.getconfig()
state = App.State.SharedState(config)
router = App.Router.HttpRouter(state)


req = HTTP.Request("GET", "/health")
HTTP.handle(router, req)
