class UserServices::Create
  def initialize(context)
    @context = Hashie::Mash.new context

    @valid = nil
    @errors = []
  end

  def execute
    self.validate if @valid.nil?

    return @context if @valid

    ActiveRecord::Base.transaction do
      create_user

      raise ActiveRecord::Rollback if @valid
    end

    @context
  end

  def validate
    errors = []

    errors << "User params not present" if @context.blank?

    @context[:errors] = errors
    return @valid = errors.present?
  end

  private

  def create_user
    @user = User.new(@context["user"])
    if @user.save
      @context[:result] = @user
    else
      @context[:errors] = @user.errors.full_messages
      @valid = true
    end
  end
end
