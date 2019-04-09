import PropTypes from 'prop-types';
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { ApolloClient } from 'apollo-client';
import { HttpLink } from 'apollo-link-http';
import { InMemoryCache } from 'apollo-cache-inmemory';
import { ApolloProvider } from 'react-apollo';
import { graphql } from 'react-apollo';
import gql from 'graphql-tag';
import TemplateFileRow from './TemplateFileRow';
import TemplateCategoryRow from './TemplateCategoryRow';
import { TEMPLATES, STYLESHEETS, JAVASCRIPTS } from './Constants' ;

const templates = [...TEMPLATES, ...STYLESHEETS, ...JAVASCRIPTS]

const client = new ApolloClient({
  link: new HttpLink(),
  cache: new InMemoryCache()
});

const themeQuery = gql`
  query {
    currentTheme {
      name,
      kind,
      site {
        key,
        name,
        slug,
      },
      templates {
        id,
        kind,
        name,
        templateString,
      }
    }
  }
`

const TemplateFileTable = ({ data: {loading, error, currentTheme }}) => {
  if (loading) {
    return (
      <div className="loading">The templates are loading</div>
    )
  }
  if (error) {
    return (
      <div className="error">There was an error</div>
    )
  }

  const rows = []
  const { templates } = currentTheme
  let lastCategory = null
  templates.forEach((template, index) => {
    if (template.kind !== lastCategory) {
      rows.push(
        <TemplateCategoryRow key={index} kind={template.kind} />
      )
    }
    rows.push(
      <TemplateFileRow key={`tfr-${index}`} template={template} />
    )
    lastCategory = template.kind
  })

  return (
    rows
  )
}

const TemplateFileTableWithData = graphql(themeQuery)(TemplateFileTable)

ReactDOM.render(
  <ApolloProvider client={client}>
    <TemplateFileTableWithData />
  </ApolloProvider>,
  document.getElementById('editor-app')
)
