module YamWow
  class PraiseMessagesResponder

    def initialize(messages_responder)
      @messages_responder = messages_responder
    end

    def create_response(messages, references=[])
      @messages = messages
      @references = references
      enhance_messages
      @messages_responder.create_response @messages, @references
    end

    private

    def enhance_messages
      @messages.each { |m| enhance_message m }
    end

    def enhance_message(message)
      praise_attachment = praise_attachment message
      praise_attachment ? enhance_message_with_praise_attachment(message, praise_attachment) : enhance_normal_message(message)
    end

    def enhance_message_with_praise_attachment(message, praise_attachment)
      message['praise_message'] = praise_attachment['comment']
      praised_user_tags = praise_attachment['praised_user_ids'].map { |id| "[[user:#{id}]]" }
      message['praised_user_tags'] = praised_user_tags.join ', '
    end

    def enhance_normal_message(message)
      message['praise_message'] = message['body']['parsed'].split('cc:')[0]
    end

    def praise_attachment(message)
      attachments = message['attachments'] || []
      a = attachments[0]
      a if a && a['type'] == 'praise'
    end

    def split_recipients(recipients)
      recipients = recipients.to_s.include?('praised') ? recipients.match(/praised (.+)/)[1] : ''
      recipients.gsub!(' and ', ', ')
      recipients.split(', ')
    end

  end
end