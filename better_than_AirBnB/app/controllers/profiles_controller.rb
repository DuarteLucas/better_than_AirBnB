class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_member, :authenticate_member!
  # GET /profiles
  # GET /profiles.json
  def index
    authorize@profile #pundit method
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    authorize@profile
  end

  # GET /profiles/new
  def new
    @profile = @member.build_profile
    authorize@profile #here it has not been set before action
  end

  # GET /profiles/1/edit
  def edit
    authorize@profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = @member.create_profile(profile_params)
    authorize@profile #again, after profile has been declared
    respond_to do |format|
      if @profile.save
        format.html { redirect_to member_profile_path(@member, @profile), notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    authorize@profile
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    authorize@profile
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def set_member
      @member = Member.find(params[:member_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:bio, :member_id, :profile_pic)
    end
end
