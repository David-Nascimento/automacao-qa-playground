require 'allure-cucumber'

module AllureLabels
    def mark_flaky
      Allure.label(name: 'flaky', value: 'true')
    end
end

World(AllureLabels)