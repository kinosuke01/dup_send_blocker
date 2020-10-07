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

    send_log = nil
    begin
      send_log = DupSendBlocker::SendLog.write_labels!(labels)
    rescue ::DupSendBlocker::SendLog::DupLabelError => e
      raise BlockError.new(e.message)
    end

    res = nil
    begin
      # 送信処理はblock内で行う
      res = yield
    rescue => e
      if send_error_is == :invalid
        send_log.delete
      else # :valid
        send_log.update_columns({error_message: e.message})
      end

      raise e
    end

    {result: res, send_log: send_log}
  end
end
