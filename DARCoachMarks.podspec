Pod::Spec.new do |s|

  s.name         = "DARCoachMarks"
  s.version      = "0.1.0"
  s.summary      = "Coach marks library extracted from DAR Applications."
  s.description  = <<-DESC
    Coach marks DAR Instructions Help Onboarding
                   DESC

  s.homepage     = "https://github.com/vibze/DARCoachMarks.git"
  s.screenshots  = "https://gfycat.com/BestExcitableClumber"
  s.license      = "LICENSE"
  s.author       = { "Viktor Ten" => "ten.viktor@gmail.com" }

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/vibze/DARCoachMarks.git", :tag => "#{s.version}" }

  s.source_files  = "DARFormBuilder/**/*.{h,m,swift}"
  s.exclude_files = "DARFormBuilderExample"

end
