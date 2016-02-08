class SongsController < ApplicationController
	before_action :set_song, only:[:show, :update, :destroy, :edit]

	def index
		@songs = Song.all
	end

	def new
		@song = Song.new
		@artists = Artist.all
	end

	def create
		@song = Song.create(song_params)

		if @song.save
			flash[:success] = "Song created successfully."
			redirect_to :songs => 'show'
		else
			flash[:error] = "There was an error creating this song."
			redirect_to :songs => "edit"
		end
	end

	def show

	end

	def edit
		@artists = Artist.all
	end

	def update
		@song.update(song_params)
		
		if @song.save
			flash[:success] = "Song updated successfully."
			redirect_to :songs => "show"
		else
			flash[:error] = "Your updates were not saved."
			redirect_to :songs => "edit"
		end
	end

	def destroy
		@song.destroy

		redirect_to :action => "index"
	end

	def top
		@top_songs = Song.all.order('rating DESC').take(5)
	end

	private

	def set_song
		@song = Song.find(params[:id])
	end

	def song_params
		params.require(:song).permit(:name, :rating, :artist_id)
	end

end
