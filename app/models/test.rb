class Test
  def send(message, auth_date)
    user = User.find_by(id: message.user_id)
    service = Service.find_by(name: "Test")
    ServiceUser.find_by(user_id: user.id, service_id: service.id).time_services.each do |time_service|
      if Time.zone.now.in_time_zone(user.timezone).wday == time_service.week_day
        from = Time.zone.now.in_time_zone(user.timezone).beginning_of_day + time_service.from.hour * 3600 + time_service.from.min * 60
        till = Time.zone.now.in_time_zone(user.timezone).beginning_of_day + time_service.till.hour * 3600 + time_service.till.min * 60
        if Time.zone.now.in_time_zone(user.timezone) > from && Time.zone.now.in_time_zone(user.timezone) < till
          puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!TEST SENDED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        end
      end
    end
  end

  def receive(test_id, user_id)
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!TEST RECEIVED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end
end