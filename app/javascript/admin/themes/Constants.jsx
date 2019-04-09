export const TEMPLATES = [
  {
    id: 'hero_template',
    kind: 'templates',
    theme_id: 5,
    name: 'hero.liquid',
    template_string: '<div class="awesome"></div>'
  },
  {
    id: 'second_section',
    kind: 'templates',
    theme_id: 5,
    name: 'second-section.liquid',
    template_string: '<div class="awesome"></div>'
  }
]

export const STYLESHEETS = [
  {
    id: 'theme',
    kind: 'stylesheets',
    theme_id: 'stylesheets',
    name: 'theme.css.liquid',
    template_string: '.hero { color: blue; }'
  }
]

export const JAVASCRIPTS = [
  {
    id: 'app',
    kind: 'javascripts',
    theme_id: 5,
    name: 'app.js',
    template_string: 'console.log("awesome");'
  }
]
