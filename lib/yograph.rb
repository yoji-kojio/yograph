# require "vertex"

module Yograph
  class Graph
    attr_accessor :vertex, :edges

    def initialize
      @vertex = {}
      @edges = []
    end

    def add_vertex(vertex)
      @vertex[vertex.value] = vertex
    end

    def add_edge(vertex1, vertex2)
      @vertex[vertex1.value].connect(@vertex[vertex2.value])
      @vertex[vertex2.value].connect(@vertex[vertex1.value])
      @edges << [vertex1.value, vertex2.value] unless include_edge?(@edges, vertex1, vertex2)

      @edges
    end

    def vertex_count
      @vertex.count
    end

    def edges_count
      @edges.count
    end

    def min_degree
      @vertex.map { |key, value| value.degree }.min
    end

    def max_degree
      @vertex.map { |key, value| value.degree }.max
    end

    private

    def include_edge?(edges_list, vertex1, vertex2)
      (edges_list & [[vertex1.value, vertex2.value], [vertex2.value, vertex1.value]]).any?
    end
  end
end
