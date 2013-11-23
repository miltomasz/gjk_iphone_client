# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap'
require 'bubble-wrap/http'
require 'formotion'
require 'motion-pixate'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Antykanar'
  app.frameworks += ['CoreLocation', 'MapKit', 'MediaPlayer']

  app.pixate.user = 'tomasz.milczarek@gmail.com' # Valid key removes "splash screen"
  app.pixate.key  = '2KKO9-DQE4G-E5U3L-2P8V6-31JRF-P9EQ0-GTLR5-19M5N-R36P6-BFHMA-D69UB-9TUPV-V3BRM-68A8C-NPMAV-CG' # Visit pixate.com/key for a free key
  app.pixate.framework = 'vendor/Pixate.framework'
end
