/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


const pathName = window.location.pathname
console.log(pathName)
import('homepage')

if (pathName === '/admin/themes') {
  import('admin/themes')

} else if (pathName.indexOf('templates') > -1 ) {
} else if (pathName === '/') {
  import('homepage')
  console.log('futcking awesome!')
}
