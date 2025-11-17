class TwilioService
	def initialize
		@client = Twilio::REST::Client.new(
			ENV['TWILIO_ACCOUNT_SID'],
			ENV['TWILIO_AUTH_TOKEN']
		)
	end

	def send_sms(to:, body:)
		@client.messages.create(
			from: ENV['TWILIO_PHONE_NUMBER'],
			to: to,
			body: body
		)
	rescue Twilio::REST::RestError => e
		Rails.logger.error "Twilio Error: #{e.message}"
		nil
	end
end