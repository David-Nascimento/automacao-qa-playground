require "yaml"

module DataHelper
    def load_data(key_or_filename)
        # path base para os dados
        data_dir = File.join(__dir__, '..', '..', 'data')

        # Se foi passado um nome de arquivo (ex: "user.yaml"), retorna todo o conteúdo do arquivo
        if key_or_filename.to_s =~ /\.ya?ml\z/i
            file_path = File.join(data_dir, key_or_filename)
            return YAML.load_file(file_path)
        end
    end
end

World(DataHelper)