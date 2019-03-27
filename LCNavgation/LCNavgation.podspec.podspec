Pod::Spec.new do |s|

  s.name         = "LCNavgation"
  s.version      = "0.0.1"
  s.summary      = "LCNavgation."
  s.homepage     = "https://github.com/LucaQAQ/LCNavgation"
  s.license      = "MIT"
  s.author       = { "luca" => "luca@cocoaluca.com" }
  s.platform     = :ios, "7.0"
  s.frameworks   = 'Foundation', 'UIKit'
  s.source       = { :git => "https://github.com/LucaQAQ/LCNavgation.git", :tag => "0.0.1" }
  s.source_files = "LCNavgation/LCNavgation/LCNavgation/**/*.{h,m}"
  s.requires_arc = true
end