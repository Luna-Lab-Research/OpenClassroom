class DashboardController < ApplicationController
    before_action :authenticate_user!

    layout 'authorized'

    def index
    end
end
