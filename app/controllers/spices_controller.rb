class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def show
        spice = Spice.find(params[:id])
        render json: spice
    end

    def index
        spices = Spice.all
        render json: spices
    end

    def create
        spice = Spice.create(strong_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(strong_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def strong_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
    def find_spice
        Spice.find(params[:id])
    end
    def record_not_found
        render json: {error: 'Spice not found'}, status: :not_found
    end
end
