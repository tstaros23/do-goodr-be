class EventMailer < ApplicationMailer
  def new_event_email
    @event = Event.find(params)
    org_email = @event.organization.email
    mail(to: org_email, subject: "You created a new event!")
  end
end
