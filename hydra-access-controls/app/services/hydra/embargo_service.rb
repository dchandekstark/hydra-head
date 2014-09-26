module Hydra
  module EmbargoService
    class << self
      #
      # Methods for Querying Repository to find Embargoed Objects
      #

      # Returns all assets with embargo release date set to a date in the past
      def assets_with_expired_embargoes
        ActiveFedora::Base.where("#{Hydra.config.permissions.embargo.release_date}:[* TO NOW]")
      end

      # Returns all assets with embargo release date set
      #   (assumes that when lease visibility is applied to assets
      #    whose leases have expired, the lease expiration date will be removed from its metadata)
      def assets_under_embargo
        ActiveFedora::Base.where("#{Hydra.config.permissions.embargo.release_date}:*")
      end

      # Returns all assets that have had embargoes deactivated in the past.
      def assets_with_deactivated_embargoes
        ActiveFedora::Base.where("#{Hydra.config.permissions.embargo.history}:*")
      end
    end
  end
end