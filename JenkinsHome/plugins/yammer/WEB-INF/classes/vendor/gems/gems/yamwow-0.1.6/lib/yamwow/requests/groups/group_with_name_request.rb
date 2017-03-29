require_relative '../../response'

module YamWow
  class GroupWithNameRequest

    def initialize(client)
      @client = client
    end

    def send(group_name)
      @group_name = group_name
      Response.new group_with_name
    end

    private

    def group_with_name
      groups_with_prefix.select { |g| g['full_name'].casecmp(@group_name) == 0 }.first
    end

    def groups_with_prefix
      data = @client.get_autocomplete prefix: 'to:' + @group_name
      data['groups'] || []
    end

  end
end