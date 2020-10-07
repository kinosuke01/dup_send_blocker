require 'rails_helper'

describe DupSendBlocker do
  describe "perform!" do
    let(:labels3) { [:info_1, "2020-10-07", 123] }
    let(:sender) {
      _sender = double("MockSender")
      allow(_sender).to receive(:send).and_return(true)
      allow(_sender).to receive(:send_error).and_raise(StandardError)
      _sender
    }

    context 'ブロックを渡さずに実行した場合' do
      subject { DupSendBlocker.perform!(labels3) }
      it '例外発生' do
        expect { subject }.to raise_error(DupSendBlocker::BlockError)
      end
    end

    context 'ラベル/ブロックを指定して実行したとき' do
      subject {
        result = nil
        DupSendBlocker.perform!(labels3) do
          result = sender.send
        end
      }
      it '実行できる' do
        expect(subject).to eq true
      end
    end

    context '実行済と異なるラベルを指定して再実行したとき' do
      subject {
        DupSendBlocker.perform!([:info_1, "2020-10-07", 122]) do
          sender.send
        end

        result = nil
        DupSendBlocker.perform!(labels3) do
          result = sender.send
        end
      }
      it '実行できる' do
        expect(subject).to eq true
      end
    end

    context '実行済のラベルを指定して再実行したとき' do
      subject {
        DupSendBlocker.perform!(labels3) { sender.send }
        DupSendBlocker.perform!(labels3) { sender.send }
      }
      it '例外発生' do
        expect { subject }.to raise_error(DupSendBlocker::BlockError)
      end
    end

    context 'send_error_is :invalidの場合' do
      context '送信処理でエラーしたとき' do
        subject {
          DupSendBlocker.perform!(labels3) { sender.send_error }
        }
        it '例外発生' do
          expect { subject }.to raise_error(StandardError)
        end

        context '再実行したとき' do
          subject {
            DupSendBlocker.perform!(labels3) { sender.send_error } rescue nil

            result = nil
            DupSendBlocker.perform!(labels3) do
              result = sender.send
            end
          }
          it '実行できる' do
            expect(subject).to eq true
          end
        end
      end
    end

    context 'send_error_is :validの場合' do
      context '送信処理でエラーしたとき' do
        subject {
          DupSendBlocker.perform!(labels3, send_error_is: :valid) do
            sender.send_error
          end
        }
        it '例外発生' do
          expect { subject }.to raise_error(StandardError)
        end

        context '再実行したとき' do
          subject {
            DupSendBlocker.perform!(labels3, send_error_is: :valid) {
              sender.send_error
            } rescue nil

            DupSendBlocker.perform!(labels3, send_error_is: :valid) do
              sender.send
            end
          }
          it '例外発生' do
            expect { subject }.to raise_error(DupSendBlocker::BlockError)
          end
        end
      end
    end
  end
end
