class CanalDataChannel < ApplicationCable::Channel
  def subscribed
    ap "En subscribed de CanalDataChannel"
    stream_from "datosclima_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
