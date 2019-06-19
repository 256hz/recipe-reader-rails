require "google/cloud/text_to_speech/v1"
require "googleauth"
require "json"

class Tts

  def self.create(filename, speech_text)
    @text_to_speech_client = Google::Cloud::TextToSpeech.new
    # input = {text: speech_text}
    input = { ssml: speech_text }
    # Note: the voice can also be specified by name.
    # Names of voices can be retrieved with client.list_voices
    voice = {
      language_code: "en-GB",
      ssml_gender:   "FEMALE"
      # name: "en-GB-Wavenet-C"
    }
    audio_config = {audio_encoding: :MP3}
    response = @text_to_speech_client.synthesize_speech(input, voice, audio_config)
    
    File.open('public/audio/'+filename+'.mp3', "wb"){|file|
      file.write response.audio_content
    }
  end

end

# 