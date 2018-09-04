require 'sqlite3'
Dir["/Users/appacademy/Desktop/w3d2/SQL/*.rb"].each {|file| require file }


class Question
  attr_accessor :id, :title, :body, :aa_id

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    return nil unless question.length > 0

    Question.new(question.first)

  end

  def self.find_by_author_id(author_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        aa_id = ?
    SQL
    return nil unless question.length > 0

    Question.new(question.first)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @aa_id = options['aa_id']
  end

  def author
    User.find_by_id(self.id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end


end
