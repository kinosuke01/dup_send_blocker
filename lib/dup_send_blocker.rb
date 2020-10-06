require "dup_send_blocker/engine"

module DupSendBlocker
  class BlockError < StandardError
  end

  def self.perform!(labels = [], send_error_is: :invalid)
    unless [:valid, :invalid].include?(send_error_is)
      raise ArgumentError.new
    end
    unless block_given?
      raise ArgumentError.new('block is required.')
    end

    instance = nil
    begin
      instance = DupSendBlocker::SendLog.write_labels!(labels)
    rescue ::DupSendBlocker::SendLog::DupLabelError => e
      raise BlockError.new(e.message)
    end

    res = nil
    begin
      # 送信処理はblock内で行う
      res = yield
    rescue => e
      if send_error_is == :invalid
        instance.delete
      else # :valid
        instance.update_columns({error_message: e.message})
      end

      raise e
    end

    res
  end

  def self.perform(*args)
    self.perform!(*args)
  rescue BlockError
    nil
  end
end
