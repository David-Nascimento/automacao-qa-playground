require "yaml"

module DataHelper
    def load_data(user_key)
        file_path = File.join(__dir__, '..', 'data', 'user.yaml')
        YAML.load_file(file_path)[user_key.to_s]
    end
end

World(DataHelper)