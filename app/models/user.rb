class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :email, type: String
  field :token, type: String

  attr_accessible :provider, :uid, :email, :token
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  index({ uid: 1 }, { unique: true, background: true })
  index({ token: 1 }, { unique: true, background: true })

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.token = auth["credentials"]["token"]
      if auth['info']
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
