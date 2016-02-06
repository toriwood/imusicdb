class ArtistsController < ApplicationController
	def index
		@artists = Artist.all		
	end

	def new
		@artist = Artist.new
	end

	def edit
		@artist = Artist.find(params[:id])		
	end

	def create
		@artist = Artist.create(artist_params)

		if @artist.save
			flash[:success] = "Artist created successfully."
			redirect_to :artists => 'show'
		else
			flash[:error] = "There was an error creating this artist."
		end
	end

	def destroy
		@artist = Artist.find(params[:id])		
		@artist.destroy

		redirect_to :artists => "index"		
	end

	private

	def artist_params
		params.require(:artist).permit(:name, :ranking)		
	end
end
