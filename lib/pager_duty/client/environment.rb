module PagerDuty
  module Environment
    def self.get_env_variable(name)
      ENV[name]
    end
  end
end
