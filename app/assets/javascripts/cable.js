// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  console.log("Creando en cable");
  this.App || (this.App = {});
  App.cable = ActionCable.createConsumer("<%= Rails.application.config.web_socket_server_url %>");

}).call(this);
