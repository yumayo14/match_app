class CallbackController < ApplicationController
  protect_from_forgery :except => [:callback]

  def callback
    token = ENV["TOKEN"]
    message = params["entry"][0]["messaging"][0]

    if message.include?("message")
      #ユーザーの発言
      sender = message["sender"]["id"]
      text = message["message"]["text"]

      endpoint_uri = "https://graph.facebook.com/v2.6/me/messages?access_token=" + token
      request_content = {
                         recipient: {id:sender},
                         message: {text: text}
                        }
      request_message =
        if text =~ /天気/
          button_structured_message_request_body(sender, "いつの天気？", *weather_buttons)
        else
          request_content.to_json
        end

      content_json = request_content.to_json
      RestClient.post(endpoint_uri, request_message, {
        'Content-Type' => 'application/json; charset=UTF-8'
      }){ |response, request, result, &block|
        p response
        p request
        p result
      }
    else
      button_structured_message_request_body(sender, "いつの天気？", *weather_buttons)
      #botの発言
      text
    end
  end
end
