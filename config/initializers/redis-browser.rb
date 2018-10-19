config = Rails.root.join('config', 'redis-browser.yml')
settings = YAML.load(ERB.new(IO.read(config)).result)
RedisBrowser.configure(settings)

RedisBrowser::Web.class_eval do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'test' && password == '123'
  end
end