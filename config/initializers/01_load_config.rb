module Rails
  def self.my
    require 'recursive_open_struct'
    return RecursiveOpenStruct.new YAML.load_file("#{Rails.root}/config/machine.yml")[Rails.env]
  end
end