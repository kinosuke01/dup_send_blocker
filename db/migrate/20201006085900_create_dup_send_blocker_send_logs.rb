class CreateDupSendBlockerSendLogs < ActiveRecord::Migration
  def change
    create_table :dup_send_blocker_send_logs, id: false do |t|
      t.column :id, 'BIGINT PRIMARY KEY AUTO_INCREMENT'

      t.string :label01, null: false, default: ''
      t.string :label02, null: false, default: ''
      t.string :label03, null: false, default: ''
      t.string :label04, null: false, default: ''
      t.string :label05, null: false, default: ''
      t.string :error_message

      t.timestamps null: false
    end

    add_index :dup_send_blocker_send_logs, [:label01], {
      name: :index_dup_send_blocker_send_logs_on_label01
    }
    add_index :dup_send_blocker_send_logs, [:label01, :label02], {
      name: :index_dup_send_blocker_send_logs_on_label01__02
    }
    add_index :dup_send_blocker_send_logs, [:label01, :label02, :label03], {
      name: :index_dup_send_blocker_send_logs_on_label01__03
    }
  end
end
