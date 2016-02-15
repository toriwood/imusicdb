class ArtistsController < ApplicationController
	
	def index
		@artists = Artist.all
		@songs = Song.all
	end

	def new
		@artist = Artist.new
	end

	def edit
		
	end

	def show
		@spotify_artist = RSpotify::Artist.search(artist.name).first
		@spotify_playlists = RSpotify::Playlist.search(artist.name).take(5)
		@songs = Song.where(artist_id: artist.id)
	end

	def update
		artist.update(artist_params)
		
		if artist.save
			flash[:success] = "Artist updated successfully."
			redirect_to :artists => "show"
		else
			flash[:error] = "Your updates were not saved."
			redirect_to :artists => "edit"
		end
	end

	def create
		@artist = Artist.new(artist_params)
		@artist.save

		if @artist.save
			flash[:success] = "Artist created successfully."
			redirect_to :artists => 'show'
		else
			flash[:error] = "There was an error creating this artist."
			redirect_to :artists => "edit"
		end
	end

	def destroy
		artist.destroy

		redirect_to :action => "index"		
	end
	
	private

	def artist
		@artist ||= Artist.find(params[:id])
	end
	helper_method :artist

	def artist_params
		params.require(:artist).permit(:name, :rating, :image)		
	end
end
