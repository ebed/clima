$localizaciones = Redis::Namespace.new("api.localizaciones", :redis => Redis.new)
$data = Redis::Namespace.new("api.data", :redis => Redis.new)
$errores = Redis::Namespace.new("api.errors", :redis => Redis.new)

