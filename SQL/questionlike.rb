require 'sqlite3'
Dir["/Users/appacademy/Desktop/w3d2/SQL/*.rb"].each {|file| require file }


class QuestionLike
  attr_accessor :id, :question_id, :user_id

  def self.find_by_id(id)
    questionlike = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    return nil unless questionlike.length > 0

    QuestionLike.new(questionlike.first)

  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
