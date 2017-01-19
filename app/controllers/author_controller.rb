class AuthorController < ApplicationController
  before_action :authenticate_author!

  def home
  end

end
