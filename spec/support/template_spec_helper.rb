class TemplateSpecHelper
  def self.theme_files
    {
      templates:  {
        hero_template: { name: 'hero.liquid', template: self.default_template, kind: 'templates' },
        second_section: { name: 'second-section.liquid', template: self.second_section_template, kind: 'templates' }
      },
      stylesheets: {
        theme: { name: 'theme.css.liquid', template: self.stylesheet_file, kind: 'stylesheets' }
      },
      javascripts: {
        app: { name: 'app.js', template: self.javascript_file, kind: 'javascripts' }
      }
    }
  end

  def self.default_template
    %{
      <div class="hero">
        <div class="placeholder-background"></div>
        <div class="hero-inner">
          <div class="page-width text-center">
            <h2 class="h1 mega-title">{{ settings.title }}</h2>
          </div>
          <div class="rte-settings mege-subtitle">{{ settings.text }}</div>
        </div>
      </div>
      {% schema %}
        {
          "name": "value"
        }
      {% endschema %}
    }
  end

  def self.second_section_template
    %{
      <div class="second-section">
        <h2 class="second-section__main-header">{{ settings.title }}</h2>
        <p class="second-section__text">{{ settings.text }}</p>
      </div>
      {% schema %}
        {
          "name": "value"
        }
      {% endschema %}
    }
  end

  def self.javascript_file
    %{
      console.log('ok');
    }
  end

  def self.stylesheet_file
    %{
      .hero {
        color: #fff;
        background: green;
      }

      .second-section {
        background: black;
        color: white;
      }
    }
  end
end
