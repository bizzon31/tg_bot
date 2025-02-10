require 'telegram/bot'
require './library/mac-shake'
require './library/database.rb'
require './modules/listener'
require './modules/security'
require './modules/standart_messages'
require './modules/response'
require './sandebox.rb'
require './modules/assets/inline_buttom'

class FishSocket
    module Listener
      # This module assigned to processing all standart messages
        module StandartMessages
            def process
                case Listener.message.text
                when '/start'
                    # Response.inline_message 'Привет, выбери из доступных действий', Response::generate_inline_markup(
                    #     Inline_Button::GET_ACCOUNT
                    # )
                when '/action'
                    Action.bizzon_test2
                when '/get_account'
                    Response.std_message 'Very sorry, нету аккаунтов на данный момент'
                else
                    Response.std_message 'Первый раз такое слышу, попробуй другой текст'
                end
            end
        module_function(
            :process
        )
        end
    end
end