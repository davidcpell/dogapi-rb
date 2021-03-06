require 'dogapi'

module Dogapi
  class V1 # for namespacing

    # Dashboard API
    class DashboardService < Dogapi::APIService

      API_VERSION = 'v1'
      RESOURCE_NAME = 'dashboard'

      # Create new dashboard
      #
      # Required arguments:
      # :title                 => String: Title of the dashboard
      # :widgets               => JSON: List of widgets to display on the dashboard
      # :layout_type           => String: Layout type of the dashboard
      #                           (for now, only "ordered" layout - current timeboard layout - is supported)
      # Optional arguments:
      # :description           => String: Description of the dashboard
      # :is_read_only          => Boolean: Whether this dashboard is read-only.
      #                           If True, only the author and admins can make changes to it.
      # :notify_list           => JSON: List of handles of users to notify when changes are made to this dashboard
      #                           e.g. '["user1@domain.com", "user2@domain.com"]'
      # :template_variables    => JSON: List of template variables for this dashboard.
      #                           e.g. [{"name": "host", "prefix": "host", "default": "my-host"}]
      def create_board(title, widgets, layout_type, options)
        # Required arguments
        body = {
          title: title,
          widgets: widgets,
          layout_type: layout_type
        }
        # Optional arguments
        body[:description] = options[:description] if options[:description]
        body[:is_read_only] = options[:is_read_only] if options[:is_read_only]
        body[:notify_list] = options[:notify_list] if options[:notify_list]
        body[:template_variables] = options[:template_variables] if options[:template_variables]

        request(Net::HTTP::Post, "/api/#{API_VERSION}/#{RESOURCE_NAME}", nil, body, true)
      end

      # Update a dashboard
      #
      # Required arguments:
      # :dashboard_id          => String: ID of the dashboard
      # :title                 => String: Title of the dashboard
      # :widgets               => JSON: List of widgets to display on the dashboard
      # :layout_type           => String: Layout type of the dashboard
      #                           (for now, only "ordered" layout - current timeboard layout - is supported)
      # Optional arguments:
      # :description           => String: Description of the dashboard
      # :is_read_only          => Boolean: Whether this dashboard is read-only.
      #                           If True, only the author and admins can make changes to it.
      # :notify_list           => JSON: List of handles of users to notify when changes are made to this dashboard
      #                           e.g. '["user1@domain.com", "user2@domain.com"]'
      # :template_variables    => JSON: List of template variables for this dashboard.
      #                           e.g. [{"name": "host", "prefix": "host", "default": "my-host"}]
      def update_board(dashboard_id, title, widgets, layout_type, options)
        # Required arguments
        body = {
          title: title,
          widgets: widgets,
          layout_type: layout_type
        }
        # Optional arguments
        body[:description] = options[:description] if options[:description]
        body[:is_read_only] = options[:is_read_only] if options[:is_read_only]
        body[:notify_list] = options[:notify_list] if options[:notify_list]
        body[:template_variables] = options[:template_variables] if options[:template_variables]

        request(Net::HTTP::Put, "/api/#{API_VERSION}/#{RESOURCE_NAME}/#{dashboard_id}", nil, body, true)
      end

      # Fetch the given dashboard
      #
      # :dashboard_id          => String: ID of the dashboard
      def get_board(dashboard_id)
        request(Net::HTTP::Get, "/api/#{API_VERSION}/#{RESOURCE_NAME}/#{dashboard_id}", nil, nil, false)
      end

      # Delete the given dashboard
      #
      # :dashboard_id          => String: ID of the dashboard
      def delete_board(dashboard_id)
        request(Net::HTTP::Delete, "/api/#{API_VERSION}/#{RESOURCE_NAME}/#{dashboard_id}", nil, nil, false)
      end

    end

  end
end
