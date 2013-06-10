module StoryboardViewers
  extend ActiveSupport::Concern

  # GET /storyboards/1/designers/invite
  def invite
    @designer = @storyboard.designers.new(params[:storyboard])
    if @designer.save
      head status: :created
    else
      render json: @designer.errors, status: :unprocessable_entity
    end
  end

  # GET /storyboards/1/get_viewer
  def get_viewers
    @designers = @storyboard.designers.where(viewing_storyboard_id: @storyboard.id)
    @viewing = []
    @designers.each {|v| @viewing << v }
    render :json => { viewers: @viewing }
  end

  # PATCH/PUT /storyboards/1/set_viewer
  def set_viewer
    @designer = @storyboard.designers.find_by(id: params[:designer])
    @designer.viewing_storyboard_id = @storyboard.id
    @designer.save
    push_message(viewers, @designer)
  end
end
