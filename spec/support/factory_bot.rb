RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      # Test factories in spec/factories are working.
      FactoryBot.lint
    ensure
      DatabaseCleaner.clean
    end
  end

end