class GameOfLife
  def initialize(board)
    raise 'invalid board' if board.empty? || board.first.empty?
    raise 'not square' if board.length != board.first.length
    @dx = board.length
    @display_state = board
    @state = create_board_guards(board)
  end

  def tick
    next_state = create_next_state

    (1..@dx).each do |x|
      row = @state[x]
      (1..@dx).each do |y|
        cell = @state[x][y]
        neighbours_count = alive_neighbours(x, y)

        if alive?(cell)
          if neighbours_count < 2 || neighbours_count > 3
            next_state[x - 1][y - 1] = 0
          else
            next_state[x - 1][y - 1] = 1
          end
        else
          if neighbours_count == 3
            next_state[x - 1][y - 1] = 1
          end
        end
      end
    end

    @display_state = next_state
    @state = create_board_guards(next_state)
  end

  def current_state
    @display_state
  end

  private

  def create_next_state
    (1..@dx).map do
      Array.new(@dx, 0)
    end
  end

  def alive_neighbours(x, y)
    res = 0
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        next if dx == 0 && dy == 0
        res += @state[x + dx][y + dy]
      end
    end
    res
  end

  def guard_row
    Array.new(@dx + 2, 0)
  end

  def alive?(cell)
    cell == 1
  end

  def create_board_guards(board)
    board.map { |row| row.clone.insert(0, 0).append(0) }.insert(0, guard_row).append(guard_row)
  end
end
