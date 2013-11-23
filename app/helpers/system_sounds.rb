class SystemSounds
  class << self
 
    BASE_AUDIO_PATH = "#{NSBundle.mainBundle.resourcePath}/audio/"
    @@system_sounds = {}
 
    def play_system_sound(file_name)
      path = "#{BASE_AUDIO_PATH}#{file_name}"
      sound_id = find_or_create_sound_id(path)
      p "Sound id: #{sound_id}"
      AudioServicesPlaySystemSound(1100)
    end
 
    def find_or_create_sound_id(file_name)
      unless sound_id = @@system_sounds[file_name]
        sound_id = Pointer.new('I')
        @@system_sounds[file_name] = sound_id
        AudioServicesCreateSystemSoundID(NSURL.fileURLWithPath(file_name), sound_id)
      end
 
      sound_id
    end
 
  end
end