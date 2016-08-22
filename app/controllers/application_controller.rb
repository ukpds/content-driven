class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def update_graph(statements, is_insert)
    repo = SPARQL::Client::Repository.new("#{ContentDriven::Application.config.database}/statements")
    client = repo.client
    graph = RDF::Graph.new
    statements.each { |statement| graph << statement}
    is_insert ? client.insert_data(graph) : client.delete_data(graph)
  end

  def create_statement(subject, predicate, object)
    s = subject
    p = RDF::URI.new(predicate)
    o = object
    RDF::Statement(s, p, o)
  end
end
