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
      create_author unless @valid
      create_course_author_association unless @valid

      raise ActiveRecord::Rollback if @valid
    end

    @context
  end

  def validate
    errors = []

    errors << "Course params not present" if @context.blank?

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

  def create_author
    if @context["author"]["email"].present?
      user = User.find_by(email: @context["author"]["email"])

      if user.present?
        @author = user
      else
        result = UserServices::Create.new({user: @context["author"]})
        response = result.execute

        if response.errors.present?
          @context[:errors] = response.errors
          @valid = true
        else
          @author = response.result
        end
      end
    else
      @context[:errors] = ["Author email id not present"]
      @valid = true
    end
  end

  def create_course_author_association
    @course_author_association = CourseTalentAssociation.new(course_author_association)

    unless @course_author_association.save
      @context[:errors] = @course_author_association.errors.full_messages
      @valid = true
    end
  end

  def course_author_association
    params = {
      user_id: @author.id,
      course_id: @course.id,
      user_type: CourseTalentAssociation.user_types[:author]
    }

    params
  end
end
