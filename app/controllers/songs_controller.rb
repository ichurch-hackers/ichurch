class SongsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.search((params[:search] || {})[:query]).page(params[:page]).per(30)
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song = SongPresenter.new(@song, params[:transpose] || 0)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @song.title, layout: 'print.html',
          margin: {
            left: 15, top: 12
          },
          footer: {
            left: @song.copyright.present? ? "© #{@song.copyright}".html_safe : "",
            right: "www.ichurch.co.za",
            font_size: 8
          }
      end
    end
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
    redirect_to @song, alert: "You can't edit that song." and return unless can?(:edit, @song)
  end

  # POST /songs
  # POST /songs.json
  def create
    song_params[:user_id] = current_user.id
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    redirect_to @song, alert: "You can't edit that song." and return unless can?(:edit, @song)
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    redirect_to @song, alert: "You can't delete that song." and return unless can?(:destroy, @song)
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      @song_parmas ||= params.require(:song).permit(:title, :author, :content, :key, :ccli, :body_font_size, :version_comment, :copyright)
    end
end
