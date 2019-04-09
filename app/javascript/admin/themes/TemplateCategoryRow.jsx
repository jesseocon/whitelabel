import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import TemplateFileRow from './TemplateFileRow';

export const TemplateCategoryRow = (props = {}) => {
  const kind = props.kind

  return (
    <div style={{textTransform: 'uppercase'}}>{kind}</div>
  )
}

export default TemplateCategoryRow
