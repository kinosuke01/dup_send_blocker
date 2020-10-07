require 'rails_helper'

describe DupSendBlocker::SendLog do
  describe "write_labels!" do
    let(:labels3) { [:info_1, "2020-10-07", 123] }
    let(:labels2) { [:info_2, 123] }

    context "ラベルを指定して保存したとき" do
      subject {
        DupSendBlocker::SendLog.write_labels!(labels3)
      }
      it "保存に成功する" do
        send_log = subject
        expect(send_log.id.present?).to eq true
      end
    end

    context "保存済のラベルを指定して保存したとき"  do
      subject {
        DupSendBlocker::SendLog.write_labels!(labels3)
        DupSendBlocker::SendLog.write_labels!(labels3)
      }
      it "例外発生" do
        expect { subject }.to raise_error(DupSendBlocker::SendLog::DupLabelError)
      end
    end

    context "保存済のラベルと異なるラベルを指定して保存したとき"  do
      let(:labels3_2) { [:info_1, "2020-10-07", 124] }
      subject {
        DupSendBlocker::SendLog.write_labels!(labels3)
        DupSendBlocker::SendLog.write_labels!(labels3_2)
      }
      it "保存に成功する" do
        subject
        expect(DupSendBlocker::SendLog.where({
          label01: labels3[0],
          label02: labels3[1],
          label03: labels3[2],
        }).exists?).to eq true
        expect(DupSendBlocker::SendLog.where({
          label01: labels3_2[0],
          label02: labels3_2[1],
          label03: labels3_2[2],
        }).exists?).to eq true
      end
    end

    context "空文字を含むラベルを渡したとき" do
      subject {
        DupSendBlocker::SendLog.write_labels!(labels2)
      }
      it "保存に成功する" do
        send_log = subject
        expect(send_log.id.present?).to eq true
      end
    end

    context "保存済の空文字を含むラベルを渡したとき" do
      subject {
        DupSendBlocker::SendLog.write_labels!(labels2)
        DupSendBlocker::SendLog.write_labels!(labels2)
      }
      it "例外発生" do
        expect { subject }.to raise_error(DupSendBlocker::SendLog::DupLabelError)
      end
    end
  end
end
