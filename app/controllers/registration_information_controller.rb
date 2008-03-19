class RegistrationInformationController < PatientDataChildController

  def new
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@races
      @races = Race.find(:all, :order => "name ASC")
    end
    if !@ethnicities
      @ethnicities = Ethnicity.find(:all, :order => "name ASC")
    end
    if !@religions
      @religions = Religion.find(:all, :order => "name ASC")
    end
    if !@martialStatuses
      @maritalStatuses = MaritalStatus.find(:all, :order => "name ASC")
    end
    if !@genders
      @genders = Gender.find(:all, :order => "name ASC")
    end
    
    @registration_information = RegistrationInformation.new
    @registration_information.person_name = PersonName.new
    @registration_information.address = Address.new
    @registration_information.telecom = Telecom.new
    
    render :partial  => 'edit', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def edit
    
    if !@isoCountries
      @isoCountries = IsoCountry.find(:all, :order => "name ASC")
    end
    if !@races
      @races = Race.find(:all, :order => "name ASC")
    end
    if !@ethnicities
      @ethnicities = Ethnicity.find(:all, :order => "name ASC")
    end
    if !@religions
      @religions = Religion.find(:all, :order => "name ASC")
    end
    if !@martialStatuses
      @maritalStatuses = MaritalStatus.find(:all, :order => "name ASC")
    end
    if !@genders
      @genders = Gender.find(:all, :order => "name ASC")
    end
    
    @registration_information = @patient_data.registration_information
    render :partial  => 'edit', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def create
    @registration_information = RegistrationInformation.new(params[:registration_information])
    @patient_data.registration_information = @registration_information
    @registration_information.create_person_attributes(params)

    render :partial  => 'show', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def update
    @registration_information = @patient_data.registration_information
    @registration_information.update_attributes(params[:registration_information])
    @registration_information.update_person_attributes(params)
    render :partial  => 'show', :locals => {:registration_information =>  @registration_information,
                                            :patient_data => @patient_data}
  end

  def destroy
    @registration_information = @patient_data.registration_information
    @registration_information.destroy
    render :partial  => 'show', :locals => {:registration_information =>  nil,
                                               :patient_data => @patient_data}
  end
  
end
