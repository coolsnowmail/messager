class SenderController < ApplicationController
  def index
    @sender = Sender.all
  end
end
