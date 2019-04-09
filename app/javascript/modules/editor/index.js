import $ from 'jquery'
import CodeMirror from 'codemirror'
import js from 'codemirror/mode/javascript/javascript'
import xml from 'codemirror/mode/xml/xml'
import css from 'codemirror/mode/css/css'
import hmtlmixed from 'codemirror/mode/htmlmixed/htmlmixed'

const updateTextArea = function(instance, $textArea) {
  $textArea.val(instance.getValue())
}

let textArea
let hiddenTextArea
let kindValue
let kind

$(document).ready(function() {
  textArea = document.getElementById('main-editor')
  hiddenTextArea = $('#template_obj_template')
  kindValue = $('#template_obj_kind').val()

  switch (kindValue) {
    case 'templates':
      kind = 'htmlmixed'
      break
    case 'stylesheets':
      kind = 'css'
      break
    case 'javascripts':
      kind = 'javascript'
      break
    case 'json':
      kind = 'javascript'
      break
    default:
      kind = 'htmlmixed'
  }

  let myCodeMirror = CodeMirror.fromTextArea(textArea, {
    lineNumbers: true,
    mode: kind,
  })

  myCodeMirror.on('change', function(instance, changeObj) {
    updateTextArea(instance, hiddenTextArea)
  })
})
