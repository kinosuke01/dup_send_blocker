module DupSendBlocker
  class SendLog < ActiveRecord::Base
    class DupLabelError < StandardError
    end

    def self.write_labels!(labels = [])
      labels = labels.slice(0..4)
      attrs = {}
      [
        :label01, :label02, :label03, :label04, :label05
      ].each.with_index do |key, i|
        attrs[key] = labels[i].to_s
      end

      instance = nil
      begin
        instance = self.create!(attrs)
      rescue ActiveRecord::RecordNotUnique
        raise DupLabelError.new("#{labels.join(', ')} is duplicated.")
      end

      instance
    end
  end
end
