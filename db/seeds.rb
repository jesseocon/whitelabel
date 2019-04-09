# Creates a devise user
default_user = User.create(email: 'default_user@jesseocon.com', password: 'password', password_confirmation: 'password')
default_site = default_user.sites.create(name: 'default site')

user = User.create(email: 'jesse@masterclass.com', password: 'password', password_confirmation: 'password')
user2= User.create(email: 'jesseocon@gmail.com', password: 'password', password_confirmation: 'password')

# Creates a site with a subdomain
# This is the basis for the app the UI should provide a way for the
# user to create a named site with a subdomain to point a CNAME to
# I haven't yet decided if the name should be hyphenized and create a
# a subdomain automatically.
site = user.sites.create(name: "jesse's test site")
site2= user2.sites.create(name: "jesse's other test site")

# String for a stylesheet file
theme_css = %{
  .hero {
    color: #fff;
    background: green;
  }

  .second-section {
    background: black;
    color: white;
  }
}

# String for javscript file
script = %{
  console.log('ok');
}

# These are the settings for the entire theme.
# Not sure if each file should generate this hash in
# the app or if the user should do double input
# Cost vs Value
settings_data_hash = {
  current: {
    sections: {
      hero: {
        type: 'hero',
        settings: {
          title: 'Hero Text',
          text: 'The hero text is really important'
        }
      },
      second_section: {
        type: 'section_section',
        settings: {
          title: 'Second Section Text',
          text: 'The second section is second only to the hero section'
        }
      }
    },
    content_for_index: [
      "hero",
      "second_section"
    ]
  }
}

# String for Template file. Multiple template files comprise a theme
# The markup is liquid compliant
hero_template = %{
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

second_section_template = %{
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

templates = {
  hero: { name: 'hero.liquid', template: hero_template, kind: 'templates'},
  second_section: { name: 'second.section', template: second_section_template, kind: 'templates' }
}

stylesheets = {
  theme: { name: 'theme.css.liquid', template: theme_css, kind: 'stylesheets' }
}

javascripts = {
  app: { name: 'app.js', template: script, kind: 'javascripts' }
}

theme_files = {
  templates: templates,
  stylesheets: stylesheets,
  javascripts: javascripts
}

theme = Theme.create(
  settings_data: settings_data_hash,
  name: 'Debut',
  default: true,
  theme_files: theme_files,
  kind: 'public_theme',
  active: false,
  site_id: default_site.id
)

sites_theme = site.themes.create(
  settings_data: theme.settings_data,
  name: theme.name + '-' + site.id.to_s,
  default: false,
  theme_files: theme.theme_files,
  kind: 'personal_theme',
  active: true,
  site_id: site.id
)

sites2_theme = site2.themes.create(
  settings_data: theme.settings_data,
  name: theme.name + '-' + site2.id.to_s,
  default: false,
  theme_files: theme.theme_files,
  kind: 'personal_theme',
  active: true,
  site_id: site2.id
)

# SiteTheme model is a mapping to a Site and a Theme
# which have a many to many relationship
# The theme is just the template for the theme and should never
# be changed without it being versioned. It will also never be
# edited by an end user only the theme author.