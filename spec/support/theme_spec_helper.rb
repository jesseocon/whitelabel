class ThemeSpecHelper
  SETTINGS = {
    "current" => {
      "sections"=> {
        "hero" => {
          "type" => 'hero',
          "settings" =>  {
            "title" => 'Hero Text',
            "text" => 'The hero text is really important'
          }
        },
        "second_section" => {
          "type" => 'section_section',
          "settings" => {
            "title" => 'Second Section Text',
            "text" => 'The second section is second only to the hero section'
          }
        }
      },
      "content_for_index" => [
        "hero",
        "second_section"
      ]
    }
  }

  def self.default_settings
    SETTINGS.dup
  end
end