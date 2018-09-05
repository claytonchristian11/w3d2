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

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.id, fname, lname
    FROM
      users
    JOIN question_likes
      ON users.id = question_likes.user_id
    WHERE
      question_id = ?
    SQL
    return nil unless likers.length > 0

    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    num = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(user_id) AS likes_count
    FROM
      question_likes
    WHERE
      question_id = ?
    SQL
    num[0]["likes_count"]
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.id, title, body, aa_id
    FROM
      questions
    JOIN question_likes
      ON questions.id = question_likes.question_id
    WHERE
      user_id = ?
    SQL
    questions.map { |quest| Question.new(quest)}
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.id, title, body, aa_id
    FROM
      questions
    JOIN question_likes
      ON questions.id = question_likes.question_id
    GROUP BY
      question_likes.question_id
    ORDER BY 
      COUNT(question_likes.id)
    LIMIT ?
    SQL
    questions.map { |quest| Question.new(quest)}
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
