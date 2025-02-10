require 'dry-types'
class FishSocket
    # This module assigned to creating InlineKeyboardButton
    module Inline_Button
        puts "Подключение"
        GET_ACCOUNT = Telegram::Bot::Types::InlineKeyboardButton.new(
            GET_ACCOUNT = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Получить account', callback_data: 'get_account')
        )
    end
end