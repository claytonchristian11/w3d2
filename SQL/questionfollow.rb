require 'sqlite3'
Dir["/Users/appacademy/Desktop/w3d2/SQL/*.rb"].each {|file| require file }


class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    questionfollow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    return nil unless question.length > 0

    QuestionFollow.new(QuestionFollow.first)
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end
