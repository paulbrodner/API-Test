# don't send/not send email notifications based on environment, but on host; always send from dev and prod, never from development
if( ['production' ].include?( Rails.configuration.machine ) )
  DoxsiteApiTest::Application.config.middleware.use ExceptionNotifier,
    :email_prefix         => "[Exception][API-CONSUMER] [#{Rails.configuration.machine.titleize}] ",
    :sender_address       => %{"Exception Notifier" <paul.brodner@osf-global.com>},
    :exception_recipients => %w{paul.brodner@osf-global.com}
end
