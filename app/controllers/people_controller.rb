class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])
    @relations = @person.relations
  end
end
