# Synthesizes speech from the input string of text or ssml.
# Note: ssml must be well-formed according to:
# https://www.w3.org/TR/speech-synthesis/

require "google/cloud/text_to_speech"

# Instantiates a client
client = Google::Cloud::TextToSpeech.new

# Set the text input to be synthesized
synthesis_input = { ssml:
    '<speak>
        Here are <say-as interpret-as="characters">SSML</say-as> samples.
        I can pause <break time="3s"/>.
        I can play a sound
        <audio src="https://www.example.com/MY_MP3_FILE.mp3">didn\'t get your MP3 audio file</audio>.
        I can speak in cardinals. Your number is <say-as interpret-as="cardinal">10</say-as>.
        Or I can speak in ordinals. You are <say-as interpret-as="ordinal">10</say-as> in line.
        Or I can even speak in digits. The digits for ten are <say-as interpret-as="characters">10</say-as>.
        I can also substitute phrases, like the <sub alias="World Wide Web Consortium">W3C</sub>.
        Finally, I can speak a paragraph with two sentences.
        <p><s>This is sentence one.</s><s>This is sentence two.</s></p>
    </speak>'
     }

# Build the voice request, select the language code ("en-US") and the ssml
# voice gender ("neutral")
voice = {
  language_code: "en-US",
  ssml_gender:   "FEMALE"
}

# Select the type of audio file you want returned
audio_config = { audio_encoding: "MP3" }

# Perform the text-to-speech request on the text input with the selected
# voice parameters and audio file type
response = client.synthesize_speech synthesis_input, voice, audio_config

# The response's audio_content is binary.
File.open "output.mp3", "wb" do |file|
  # Write the response to the output file.
  file.write response.audio_content
end

puts "Audio content written to file 'output.mp3'"