require 'bundler'
Bundler.require

module Concerns
    module Findable
        def find_by_name(name)
            self.all.find { |artist| artist.name == name }
          end
      
          def find_or_create_by_name(name)
            if self.name != self
                self.find_by_name(name) || self.create(name)
            end
          end 
    
    end
end

require_all 'lib'
