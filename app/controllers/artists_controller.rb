class ArtistsController < ApplicationController
	before_action :set_artist, only:[:show, :update, :destroy, :edit]

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
		@songs = Song.where(artist_id: @artist.id)
	end

	def update
		@artist.update(artist_params)
		
		if @artist.save
			flash[:success] = "Artist updated successfully."
			redirect_to :artists => "show"
		else
			flash[:error] = "Your updates were not saved."
			redirect_to :artists => "edit"
		end
	end

	def create
		@artist = Artist.create(artist_params)

		if @artist.save
			flash[:success] = "Artist created successfully."
			redirect_to :artists => 'show'
		else
			flash[:error] = "There was an error creating this artist."
			redirect_to :artists => "edit"
		end
	end

	def destroy
		@songs = Song.where(artist_id: @artist.id)		
		
		@artist.destroy
		
		if @songs != nil
			@songs.each do |song|
				song.destroy
			end
		end

		redirect_to :action => "index"		
	end

	private

	def set_artist
		@artist = Artist.find(params[:id])
	end

	def artist_params
		params.require(:artist).permit(:name, :rating)		
	end
end
