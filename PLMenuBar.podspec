Pod::Spec.new do |s|

  s.name         = "PLMenuBar"
  s.version      = "0.0.1"
  s.summary      = "PLMenuBar is a customized menubar for tvOS, simple and easy to use."
  s.description  = <<-DESC
                   DESC
  s.homepage     = "https://github.com/PatrickSCLin/PLMenuBar"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Patrick Lin" => "patricksclin@gmail.com" }
  s.platform     = :tvos, "9.0"
  s.source       = { :git => "https://github.com/PatrickSCLin/PLMenuBar.git", :tag => "0.0.1" }
  s.source_files  = "PLMenuBar", "PLMenuBar/PLBackdropView/*.{h,m}"
  s.resources = "PLMenuBar/Resources/*.png"
  s.requires_arc = true
  
end
