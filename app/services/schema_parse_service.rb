# should this really be a concern?
class SchemaParseService
  SchemaFilter = /(?<=\{\%\sschema \%\}).+(?=\{\% endschema \%\})/m

  def self.parse(str)
    match = SchemaFilter.match(str)
    if match && match.length == 1
      begin
        JSON.parse(match[0])
      rescue JSON::ParserError
        {}
      end
    else
      {}
    end
  end
end