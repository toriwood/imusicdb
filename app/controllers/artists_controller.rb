class ArtistsController < ApplicationController
	#use rspotify gem to pull similar artists' top songs as recommendations for user
	#use omniauth gem to allow users to log in and out.

	#artist.name => "Arctic Monkeys"
	#artist.related_artists.first.name => "Miles Kane"

	#have this as a sidebar that shows on the artist showpage

	#can search playlists by type from user input	

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
