Rails.application.routes.draw do

  mount DupSendBlocker::Engine => "/dup_send_blocker"
end
