class EventMailer < ApplicationMailer
  def new_event_email
    @event = params[:event]
    organization = params[:organization]
    mail(to: organization.email, subject: "You created a new event!")
  end
end
