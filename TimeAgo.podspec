#
# Be sure to run `pod lib lint TimeAgo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TimeAgo"
  s.version          = "0.1.1"
  s.summary          = "Time Ago, allow custom words "

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Time Ago in Swift, allow custom words
                       DESC

  s.homepage         = "https://github.com/CodeEagle/TimeAgo"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "CodeEagle" => "stasura@hotmail.com" }
  s.source           = { :git => "https://github.com/CodeEagle/TimeAgo.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/_SelfStudio'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*'

  # s.resource_bundles = {
  #   'TimeAgo' => ['TimeAgo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
