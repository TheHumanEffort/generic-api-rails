GenericApiRails.config do |config|
  # These two calls allow you to configure how your API renders objects.  This
  # location makes it easy to define how you render items on a per-record,
  # contextual basis.  This means that
  config.render_collections_with do |collection|
    collection.as_json
  end

  config.render_records_with do |record|
    record.as_json
  end

  config.login_with do |hash|
    # login_with takes a block that accepts two arguments, username
    # and password, which the caller should use to authenticate the
    # user.  If the user is authenticated, return an object
    # indicating this.  It will be stored along with the API token
    # for later use.

    Credential.authenticate(hash[:username],hash[:password])
  end

  config.signup_with do |hash|
    # signup_with is essentially the same as login_with, with the
    # difference being that it rejects already-used emails and
    # creates a user before it is returned to the client.  It may
    # throw whatever errors it wishes, which will be passed along to
    # the client in JSON form.

    Credential.create(hash)
  end

  # Authorization function: by default does not allow any resources to
  # be accessed:
  config.authorize_with do |user,action,resource|
    false
    # But you can also use your own custom logic (obviously), or a
    # canned (heh) authorization  solution like CanCan:
    #
    # current_ability = Ability.new(user)
    # current_ability.can? action , resource
  end

  # You may also elect to use OmniAuth to allow for user sign in and
  # sign up.  To connect these dots, you must add a glue-function to
  # connect to whatever authentication package you are using.

  config.oauth_with do |hash|
    Credential.authenticate_oauth(hash)
  end

  # Built-in support for facebook requires that you simply add in the
  # app ID and app secret for your app:
  # config.use_facebook app_id: '<APP_ID>', app_secret: '<APP SECRET>'

  # Other options:
  #
  # You may read about the other options in lib/generic_api_rails/config.rb
end
