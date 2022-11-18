class InvitationsController < ApplicationController
  def create
    User.invite!(email: params[:email])
    render_okay(json_content: { message: 'Invitation sent successfully.' })
  end
end
