import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { TEMPLATES, STYLESHEETS, CONSTANTS } from './Constants' ;

const template = TEMPLATES[0]

const TemplateFileRow = (props = {}) => {
  const { template } = props
  return (
    <div>{template.name}</div>
  )
}

export default TemplateFileRow
