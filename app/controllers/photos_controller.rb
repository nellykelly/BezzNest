class PhotosController < ApplicationController






	def create
    	@photo = Photo.new(photo_params)
    	if @photo.save
      		flash[:success] = "The photo was added!"
      		redirect_to root_path
    	else
      		render 'new'
    	end
    end
end
