module RailsAdmin
  module Config
    module Fields
      module Types
        class TimeSpan < RailsAdmin::Config::Fields::Types::Text

          register_instance_option :negative_pretty_value do
            '-'
          end

          register_instance_option :metric do
            :s
          end

          register_instance_option :pretty_value do
            if (v = value).negative?
              negative_pretty_value
            else
              str = ''
              h = {
                ms: 1000,
                s: 1000,
                m: 60,
                h: 60,
                d: 24
              }
              current_metric = metric
              h.keys.each do|m|
                h.delete(m)
                break if m == current_metric
              end
              scaled_v = 0
              h.each do |m, scale|
                if (scaled_v = v / scale).positive?
                  str = "#{v % scale}#{current_metric} #{str}"
                  v = scaled_v
                  current_metric = m
                else
                  str = "#{v}#{current_metric} #{str}"
                  break
                end
              end
              if scaled_v.positive?
                str = "#{v}#{current_metric} #{str}"
              end
              str
            end
          end

        end
      end
    end
  end
end
