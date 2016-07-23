# encoding: utf-8
require 'uri'
require 'open-uri'
require 'json'
require 'pp'
require 'rubygems'
require 'json'
class VKontakteService
  def send(message, vk_id)
    sender = Sender.find(message.sender_id)
    message_text = "#{sender.name}# #{message.text}"
    link = URI::encode "https://api.vk.com/method/messages.send?access_token=d2780e8189c5c5b882d80704a0c1dc3129577c5d8e2e7077158fa93afed687d1d842d5a7f0036b544d6a3&message=#{message_text}&uid=#{vk_id}"
    open(link)
  end
  def receive(vk_id)
    user = User.find_by(vk_user_id: vk_id)
    vk_messages = "https://api.vk.com/method/messages.getHistory?access_token=d2780e8189c5c5b882d80704a0c1dc3129577c5d8e2e7077158fa93afed687d1d842d5a7f0036b544d6a3&count=3&uid=#{vk_id}"
    vk_messages = open(vk_messages).read
    vk_messages = JSON.parse(vk_messages)
    vk_messages = vk_messages["response"]
    vk_messages.delete_at(0)
    messages = Array.new
    messages_vk_id = Array.new
    vk_messages.each do |vk_message|
      if vk_message["read_state"] == 0 && vk_message["out"] == 0
        messages << vk_message["body"]
      end
    end
    vk_messages.each do |vk_message_id|
      if vk_message_id["read_state"] == 0 && vk_message_id["out"] == 0
        messages_vk_id << vk_message_id["mid"]
      end
    end
    open("https://new.vk.com/dev/messages.markAsRead?access_token=d2780e8189c5c5b882d80704a0c1dc3129577c5d8e2e7077158fa93afed687d1d842d5a7f0036b544d6a3&message_ids=#{messages_vk_id}")
    messages.reverse!
    messages.each do |message|
      if message.include?("#")
        sender_name, text = message.split("#")
        user.messages.create(sender_id: Sender.find_by(name: sender_name).id, text: text, incoming: true)
      end
    end
  end
end

