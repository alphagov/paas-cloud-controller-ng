require 'presenters/v3/base_presenter'

module VCAP::CloudController::Presenters::V3
  class AppSshStatusPresenter
    def initialize(app, globally_enabled)
      @app = app
      @globally_enabled = globally_enabled
    end

    def to_hash
      {
        enabled: VCAP::CloudController::AppSshEnabled.new(app).enabled?,
        reason: reason
      }
    end

    private

    attr_reader :app, :globally_enabled

    def reason
      if !globally_enabled
        'Disabled globally'
      elsif !app.space.allow_ssh
        "Disabled for space #{app.space.name}"
      elsif !app.enable_ssh
        'Disabled for app'
      else
        ''
      end
    end
  end
end
