module Rails
  require 'recursive_open_struct'
  def self.my
    return RecursiveOpenStruct.new YAML.load_file("#{Rails.root}/config/machine.yml")[Rails.env]
  end
end