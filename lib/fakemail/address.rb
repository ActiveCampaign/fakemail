# frozen_string_literal: true

module FakeMail
  # Recipient helper
  class Address
    class << self
      def address(address: Config.defaults.email_address, length: 0)
        return address unless length.to_i > address.size

        address_with_id(address: address, id: Faker::Lorem.characters(number: length - address.size - 1))
      end

      def addresses(address: Config.defaults.email_address, length: 0, count: 1)
        Array.new(count) { address(address: address, length: length) }
      end

      def addresses_string(address: Config.defaults.email_address, string_length:)
        address_length = 120
        email_count = string_length / address_length
        addresses = addresses(length: address_length, address: address, count: email_count).join(',')
        "#{addresses},#{address(length: string_length - addresses.size - 1, address: address)}"
      end

      def address_unique(address: Config.defaults.email_address, id_length: 8, base_id: '')
        id = Faker::Number.number(digits: id_length)
        id = base_id.empty? ? id : "#{base_id}-#{id}"
        address_with_id(address: address, id: id)
      end

      def addresses_unique(address: Config.defaults.email_address, id_length: 8, base_id: '', count: 0)
        Array.new(count) { address_unique(address: address, id_length: id_length, base_id: base_id) }
      end

      def addresses_with_id(address: Config.defaults.email_address, id: '', count: 1)
        Array.new(count).map { address.gsub('@', "+#{id}-#{Faker::Number.number(digits: 8)}@") }
      end

      def address_with_id(address: Config.defaults.email_address, id: '')
        address.gsub('@', "+#{id}@")
      end

      # Retrieve from the email address it's hash value between + sign and @
      # john+mailbox_hash@example.com => mailbox_hash
      def address_hash(address:)
        address.match(/\+(.*)@/).captures.first
      end

      # Generate email address with custom full name and email address
      # lengths from existing address
      def address_with_name(address: Config.defaults.email_address, full_name_length: 60, address_length: 120)
        address_placeholder = "'#{full_name(length: full_name_length)}' <>"
        email_address = address(address: address, length: address_length - address_placeholder.size)
        address_placeholder.gsub('<', "<#{email_address}")
      end

      def addresses_with_name(address: Config.defaults.email_address, full_name_length: 60, address_length: 120,
                              count: 1)
        Array.new(count) do
          address_with_name(address: address, full_name_length: full_name_length, address_length: address_length)
        end
      end

      def addresses_with_name_string(address: Config.defaults.email_address, string_length:)
        address_length = 120
        email_count = string_length / address_length
        addresses = addresses_with_name(address: address, address_length: address_length,
                                        full_name_length: 60,
                                        count: email_count).join(',')

        "#{addresses},#{address_with_name(address_length: address_length - addresses.size - 1,
                                          full_name_length: 60,
                                          address: address)}"
      end

      # Generic full name of a-z characters with custom length
      def full_name(length: 60)
        name = Faker::Alphanumeric.alpha(number: length)
        name[name.length / 2] = ' '
        name.split(/([[:alpha:]]+)/).map(&:capitalize).join
      end
    end
  end
end
