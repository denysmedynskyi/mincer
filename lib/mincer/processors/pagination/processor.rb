module Mincer
  module Processors
    module Pagination
      class Processor
        def initialize(mincer)
          @mincer, @args, @relation = mincer, mincer.args, mincer.relation
        end

        def apply
          if kaminari?
            @relation.page(@args['page']).per(@args['per_page'])
          elsif will_paginate?
            @relation.paginate(page: @args['page'], per_page: @args['per_page'])
          else
            warn 'To enable pagination please add kaminari or will_paginate to your Gemfile'
            @relation
          end
        end

        def kaminari?
          defined?(::Kaminari)
        end

        def will_paginate?
          defined?(::WillPaginate)
        end
      end

      module Options
        extend ActiveSupport::Concern

        module ClassMethods
          def skip_pagination!
            active_processors.delete(Mincer::Processors::Pagination::Processor)
          end
        end
      end
    end
  end
end


::Mincer.add_processor(:pagination)
