class Vertex
  attr_reader :value, :value, :adjacent_vertex

  def initialize(value)
    @value = value
    @adjacent_vertex = []
  end

  def connect(adjacent_vertex)
    unless @adjacent_vertex.any? { |vertex| vertex == adjacent_vertex }
      @adjacent_vertex << adjacent_vertex
      adjacent_vertex.connect(self)
    end
  end

  def degree
    @adjacent_vertex.count
  end
end