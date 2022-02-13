class NewMailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(event_id) #event_name, org_email)
    send_message(event_id)# event_name, org_email)
  end

  def send_message(event_id) #event_name, org_email)
    EventMailer.with(event_id).new_event_email.deliver #(event_name: event_name, org_email: org_email).new_event_email.deliver
  end
end
