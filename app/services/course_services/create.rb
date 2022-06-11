class CourseServices::Create
  def initialize(context)
    @context = Hashie::Mash.new context

    @valid = nil
    @errors = []
  end

  def execute
    self.validate if @valid.nil?

    return @context if @valid

    ActiveRecord::Base.transaction do
      create_course

      raise ActiveRecord::Rollback if @valid
    end

    @context
  end

  def validate
    errors = []

    errors << "Course params not present" if @context.blank?
    errors << "Author not present" if !validate_author

    @context[:errors] = errors
    return @valid = errors.present?
  end

  private

  def create_course
    @course = Course.new(@context["course"])
    if @course.save
      @context[:result] = @course
    else
      @context[:errors] = @course.errors.full_messages
      @valid = true
    end
  end

  def validate_author
    author = User.find_by_id(@context["course"]["author_id"])
    if author.present?
      return true
    else
      return false
    end
  end
end
