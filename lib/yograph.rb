module Yograph
  class Graph
    require 'colorize'
    require 'matrix'
    attr_accessor :vertex, :edges

    def initialize
      @vertex = {}
      @edges = []
    end

    def add_vertex(vertex)
      @vertex[vertex.value] = vertex
    end

    def create_vertex_in_batch(vertex_list)
      vertex_list.each do |vertex|
        v = Vertex.new(vertex)
        @vertex[v.value] = v
      end
    end

    def add_edge(vertex1, vertex2)
      @vertex[vertex1.value].connect(@vertex[vertex2.value])
      @vertex[vertex2.value].connect(@vertex[vertex1.value])
      @edges << [vertex1.value, vertex2.value] unless include_edge?(@edges, vertex1, vertex2)

      @edges
    end

    def create_edges_in_batch(edges_list)
      edges_list.each do |src, dest|
        @vertex[src].connect(@vertex[dest])
        @vertex[dest].connect(@vertex[src])
        @edges << [src, dest] unless include_edge?(@edges, @vertex[src], @vertex[dest])
      end
    end

    def adjacent?(vertex1, vertex2)
      vertex1.adjacent_vertex.any? { |v| v == vertex2 }
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

    def show_adjacency_matrix
      adjancency_matrix = []
      line = []
      keys = @vertex.keys

      # put the matrix header
      adjancency_matrix << [" "] + keys
      
      keys.each do |k1|
        line = []
        line << k1
        keys.each do |k2|
          if adjacent?(@vertex[k1], @vertex[k2])
            line << "1".colorize(:green)
          else
            line << "0".colorize(:red)
          end
        end
        adjancency_matrix << line
      end

      puts("\nAdjacency Matrix - Teoria dos Grafos")
      puts("Yoji W. Kojio\n".colorize(:blue))
      pretty_info_printer(adjancency_matrix)
    end

    private

    def include_edge?(edges_list, vertex1, vertex2)
      (edges_list & [[vertex1.value, vertex2.value], [vertex2.value, vertex1.value]]).any?
    end

    def pretty_info_printer(matrix)
      matrix.each do |m|
        m.map { |k| print "#{k} | " }
        print "\n"
      end

      print "\n"
      puts "Número de vértices: #{vertex_count}".blue
      puts "Número de arestas: #{edges_count}".blue
      puts "Grau mínimo: #{min_degree}".blue
      puts "Grau máximo: #{max_degree}".blue
    end
  end
end
