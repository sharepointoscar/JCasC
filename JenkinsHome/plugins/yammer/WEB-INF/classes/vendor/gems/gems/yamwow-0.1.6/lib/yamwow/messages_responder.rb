require 'time'
require_relative 'response'

module YamWow
  class MessagesResponder

    def create_response(messages, references=[])
      @messages = messages
      @references = references
      remove_comments
      sort_by_most_recent_first
      enhance_messages
      YamWow::Response.new @messages, @references
    end

    private

    def remove_comments
      @messages.select! { |m| m['replied_to_id'].nil? }
    end

    def sort_by_most_recent_first
      @messages.sort! { |x, y| Time.parse(y['created_at']) <=> Time.parse(x['created_at']) }
    end

    def enhance_messages
      @messages.each { |m| enhance_message m }
    end

    def enhance_message(message)
      message['sender_tag'] = "[[user:#{message['sender_id']}]]" if message['sender_id']
    end

  end
end