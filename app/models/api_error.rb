class ApiError
  INVALID_ARGUMENT             = 11
  INVALID_RANGE                = 12
  INVALID_USERNAME_OR_PASSWORD = 17
  INVALID_API_TOKEN            = 18
  INVALID_PERSON_ID            = 20
  UNAUTHORIZED                 = 100

  attribute_accessors :code, :description, :status_code
  
  STANDARD_ERRORS =
    [
     { :code => INVALID_ARGUMENT, :description => "Invalid argument", :status_code => 403 },
     { :code => INVALID_RANGE, :description => "Invalid range argument - missing beg or end", :status_code => 403 },
     { :code => INVALID_API_TOKEN, :description => "Invalid API token", :status_code => 401 },
     { :code => INVALID_USERNAME_OR_PASSWORD, :description => "Invalid username or password", :status_code => 401 },
     { :code => INVALID_PERSON_ID, :description => "Invalid person id", :status_code => 401 },
     { :code => UNAUTHORIZED, :description => "Unauthorized for this action", :status_code => 403 },
    ]

  def self.find_by_code code
    by_code[code]
  end

  def as_json(options={})
    super(:only => [:code, :status_code, :description])
  end

  def self.error_with_hash h
    n = new
    n.code = h[:code]
    n.description = h[:description]
    n.status_code = h[:status_code]
    n
  end

  def self._create_by_code
    by_code = {}
    STANDARD_ERRORS.each do |err|
      by_code[err[:code]] = error_with_hash(err)
    end
    by_code
  end
  
  def self.by_code
    @by_code ||= _create_by_code
  end
    

end
