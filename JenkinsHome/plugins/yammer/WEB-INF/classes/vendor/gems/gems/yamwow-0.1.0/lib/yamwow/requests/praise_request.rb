require_relative 'messages_with_topic_request'

module YamWow
  class PraiseRequest

    def initialize(client, options={})
      @client = client
      @options = options
    end

    def send
      get_messages_with_praise_topic
    end

    def get_messages_with_praise_topic
      r = MessagesWithTopicRequest.new(@client, 'praise', @options).send
      r.data.each do |m|
        m['praise_message'] = reason m
        m['praise_recipient_names'] = recipient_names m
        m['praise_recipient_tags'] = recipient_tags m
      end
      r
    end

    private

    def reason(message)
      begin
        attachments = message['attachments'] || []
        praise_attachment = attachments.select { |a| a['type'] == 'ymodule' }.select { |a| a['ymodule']['app_id'] == 'praise' }.first
        praise_attachment ? praise_attachment['name'].match(/Praise: (.+)/m)[1] : message['body']['parsed']
      rescue
        '(failed to extract reason)'
      end
    end

    def recipient_names(message)
      split_recipients(message['body']['plain']).map { |r| r.gsub '@', '' }.join ', '
    end

    def recipient_tags(message)
      split_recipients(message['body']['parsed']).join ', '
    end

    def split_recipients(recipients)
      recipients = recipients.include?('praised') ? recipients.match(/praised (.+)/)[1] : ''
      recipients.gsub!(' and ', ', ')
      recipients.split(', ')
    end

  end
end