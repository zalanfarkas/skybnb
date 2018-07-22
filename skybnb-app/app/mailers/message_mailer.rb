class MessageMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.new_message_notification.subject
  #
  def new_message_notification(sender, recipient, message)
    @message_sender = sender
    @message_recipient = recipient
    @new_message = message
    mail to: @message_recipient.email, subject: "New message from #{@message_sender.fullname} on SkyBnB"
  end
end
