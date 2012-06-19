module Cure
  class Options
    include Cure::Accessorizer

    #TODO check that we're only creating accessors for options
    # we expect
    def initialize(options)
      global_options = *options_name_array.collect do |o|
        [o,
          begin
           Cure::Environment.send(o)
          rescue NameError
            nil
          end
        ]
      end
      global_options = Hash[*global_options.flatten]
      project_options = *options_name_array.collect do |o|
        [o,
         begin
           #Cure::Environment.send(o)
        rescue NameError
          nil
        end
        ]
      end
      project_options = Hash[*project_options.flatten]
      actual_options = global_options.
        merge(project_options.select { |o,v| v.present? or (v.nil? and global_options[o].nil?) }).
        merge options.select { |o,v| v.present? or (v.nil? and project_options[o].nil?) }
      accessorize actual_options
    end

    def inspect
      Hash[*options_name_array.collect { |x| [x, send(x)] }.flatten].inspect
    end

    def find_config
      Cure::Environment.config #TODO Seriously? This has no checks for project folder config
    end

    def options_name_array
      %w[verbose global user password header params base_url http_method url]
    end
  end
end
