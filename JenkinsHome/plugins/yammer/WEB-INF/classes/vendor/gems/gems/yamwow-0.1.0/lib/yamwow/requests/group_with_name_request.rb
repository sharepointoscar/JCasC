require_relative '../response'

module YamWow
  class GroupWithNameRequest

    def initialize(client, group_name)
      @client = client
      @group_name = group_name.downcase.gsub(/[^0-9a-z]/i, '')
    end

    def send
      groups = get_groups
      group = first_group_with_matching_name groups
      Response.new group
    end

    private

    def get_groups
      r = @client.get_autocomplete prefix: 'to:' + @group_name
      r['groups'] || []
    end

    def first_group_with_matching_name(groups)
      groups.select { |g| g['name'] == @group_name }.first
    end

  end
end