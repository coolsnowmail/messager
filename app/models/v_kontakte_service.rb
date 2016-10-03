# encoding: utf-8
require 'uri'
require 'open-uri'
require 'json'
require 'pp'
require 'rubygems'
require 'json'
class VKontakteService
  def send(message, vk_id)
    user = User.find_by(id: message.user_id)
    service = Service.find_by(name: "VKontakteService")
    ServiceUser.find_by(user_id: user.id, service_id: service.id).time_services.each do |time_service|
      if Time.zone.now.in_time_zone(user.timezone).wday == time_service.week_day
        from = Time.zone.now.in_time_zone(user.timezone).beginning_of_day + time_service.from.hour * 3600 + time_service.from.min * 60
        till = Time.zone.now.in_time_zone(user.timezone).beginning_of_day + time_service.till.hour * 3600 + time_service.till.min * 60
        if Time.zone.now.in_time_zone(user.timezone) > from && Time.zone.now.in_time_zone(user.timezone) < till
          sender = Sender.find(message.sender_id)
          message_text = "#{sender.name}# #{message.text}"
          link = URI::encode "https://api.vk.com/method/messages.send?access_token=#{ENV["pusher_secret"]}&message=#{message_text}&uid=#{vk_id}"
          open(link)
        end
      end
    end
  end

  def receive(vk_id, user_id)
    user = User.find(user_id)
    vk_messages = "https://api.vk.com/method/messages.getHistory?access_token=#{ENV["pusher_secret"]}&count=30&uid=#{vk_id}"
    vk_messages = open(vk_messages).read
    vk_messages = JSON.parse(vk_messages)
    vk_messages = vk_messages["response"]
    vk_messages.delete_at(0)
    messages = []
    messages_vk_id = []
    vk_messages.each do |vk_message|
      if vk_message["read_state"].zero? && vk_message["out"].zero?
        messages << vk_message["body"]
      end
    end
    vk_messages.each do |vk_message_id|
      if vk_message_id["read_state"].zero? && vk_message_id["out"].zero?
        messages_vk_id << vk_message_id["mid"]
      end
    end
    open("https://api.vk.com/method/messages.markAsRead?message_ids=#{messages_vk_id.first}&access_token=#{ENV["pusher_secret"]}")
    messages.reverse!
    messages.each do |message|
      if message.include?("#")
        sender_name, text = message.split("#")
        user.messages.create(sender_id: Sender.find_by(name: sender_name).id, text: text, incoming: false) if Sender.where(name: sender_name).present?
      end
    end
  end
end

