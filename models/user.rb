require "sequel"

if ENV['RACK_ENV'] == "production"
    DB = Sequel.connect('postgres://cboodskeuuwfdb:wBzw7HbeB58VGPOwgsqNu4oNYn@ec2-54-228-227-87.eu-west-1.compute.amazonaws.com:5432/dbv6ej3ig9h57k')
else
    DB = Sequel.connect(adapter: 'mysql2', host: 'localhost', database: 'oksana_api', user: 'root', password: 'abcABC123')
end

Sequel::Model.plugin :schema
Sequel::Model.plugin :timestamps

class User < Sequel::Model
    attr_accessor :password, :password_confirmation

    plugin :validation_class_methods
    plugin :validation_helpers

    validates do
        #length_of :password, :minimum => 6
        confirmation_of :password
    end

    def before_create
        d = Digest::MD5.new
        d.update(self.password)

        self.password = d.hexdigest

        super
    end

    def after_create
        d = Digest::SHA1.new
        d.update("#{self.id}+#{self.created_at}")

        self.api_key = d.hexdigest

        super
    end

    set_schema do
        primary_key :id

        String :name
        String :email
        String :password
        String :api_key

        DateTime :created_at
        DateTime :updated_at
    end

    create_table unless table_exists?
    plugin :timestamps
end
