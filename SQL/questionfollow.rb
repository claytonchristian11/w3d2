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
    return nil unless questionfollow.length > 0

    QuestionFollow.new(questionfollow.first)
  end

  def self.followers_for_question_id(question_id)
    questionfollow = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, fname, lname
      FROM
        question_follows
      JOIN
        users
        ON question_follows.user_id = users.id
      WHERE
        question_id = ?
    SQL
    return nil unless questionfollow.length > 0

    questionfollow.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, title, body, aa_id
      FROM
        questions
      JOIN
        question_follows
        ON questions.id = question_follows.question_id
      WHERE
        user_id = ?
    SQL
    return nil unless question.length > 0

    question.map { |quest| Question.new(quest) }
  end

  def self.most_followed_questions(n)
    question = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, title, body, aa_id
      FROM
        questions
      JOIN
        question_follows
        ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(user_id) DESC
      LIMIT ?
    SQL
    return nil unless question.length > 0

    question.map { |quest| Question.new(quest) }
  end


  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end


end
