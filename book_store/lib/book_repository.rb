class BookRepository

  def all
    sql = 'SELECT id, title, author_name FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])

    books = []

    result_set.each do |record|
      book = Book.new
      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']

      books << book
    end

    return books


  end


  def find(id)
    sql = 'SELECT id, title, author_name FROM books WHERE id =' + id.to_s + ';'
    result = DatabaseConnection.exec_params(sql, []).to_a[0]
    
    book = Book.new
    book.id = result['id']
    book.title = result['title']
    book.author_name = result['author_name']

    return book

    
  end

  # def create(book)
  # end

  # def update(book)
  # end

  # def delete(book)
  # end
end