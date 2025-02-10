require 'telegram/bot'
require './library/mac-shake'
require './library/database.rb'
require './modules/listener'
require './modules/security'
require './modules/standart_messages'
require './modules/response'

class FishSocket
    # Sorting new message module
    # Сортировка (Обработка) новых сообщений
    module Listener
        attr_accessor :message, :bot
    
        def catch_new_message(message,bot)
            self.message = message
            self.bot = bot
    
            # return false if Security.message_too_far
    
            case self.message
            when Telegram::Bot::Types::CallbackQuery
            CallbackMessages.process
            when Telegram::Bot::Types::Message
            StandartMessages.process
            end
        end
    
        module_function(
            :catch_new_message,
            :message,
            :message=,
            :bot,
            :bot=
        )
    end
end