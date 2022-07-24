require 'glimmer-dsl-libui'

include Glimmer

def x(input)
  input + "111111"
end

window('hello world', 300, 50) { |mw|
  horizontal_box {
    @entry = entry {
      on_changed do
        puts @entry.text
        $stdout.flush # リアルタイムにターミナルに表示
      end
    }
    
    button('Button') {
      stretchy false
      
      on_clicked do
        text = @entry.text
        msg_box(text, "で処理を開始します10秒ぐらい程度所要します")
        @progress_window = window('progress', 300, 150) {
          vertical_box {
            @progress_bar = progress_bar
            @result_label = label
          }
        }
        2.times do |n|
          Glimmer::LibUI.timer(n, repeat: false) do
            Glimmer::LibUI.queue_main do
              n += 1
              @progress_bar.value = n*50
              if n == 2
                result = x(text)
                @result_label.text = "処理結果: #{result}"
              end
            end
          end
        end
        @progress_window.show
      end
    }
  }
}.show
