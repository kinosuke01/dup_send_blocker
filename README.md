# DupSendBlocker

This gem prevents duplicate mail and SMS messages from being sent.
For example, it prevents batches from running multiple times or human errors.

## Installing

### Add to Gemfile

```
gem 'dup_send_blocker'
```

### Install

```
bundle install
```

### Copy and execute migration file

```
bundle exec rake dup_send_blocker:install:migrations
bundle exec rake db:migrate
```

## Usage

```ruby
# You can specify 3 labels.
# If you try to send the same label combination, it will be blocked.

labels = [
  "info",
  "2020-10-07",
  "U-1233"
]

begin
  DupSendBlocker.perform!(labels) do
    # Implement the sending process.
  end
rescue DupSendBlocker::BlockError
  # Implement the process when it has already been sent.
end
```

