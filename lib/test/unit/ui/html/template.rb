# coding: utf-8
# Copyright (c) 2013 Azhagu Selvan SP <tamizhgeek@gmail.com> (LGPL V3.0)
require 'rubygems'
gem 'mustache'
require 'mustache'

TEMPLATE_PATH = File.expand_path(File.dirname(__FILE__) + '/../../../../../templates')

module Test
  module Unit
    module UI
      module Html
        class BasicTemplate < Mustache
          self.template_path = TEMPLATE_PATH
        end
        class Summary < BasicTemplate
          attr_reader :total, :pass
          self.template_name = 'summary'
          def initialize(total_time, total, pass)
            @total_time = total_time
            @total = total
            @pass = pass
            @fail = total - pass
          end

          def total_time
            @total_time
          end

          def fail
            @fail
          end

        end

        class TestCaseResult < BasicTemplate
          attr_reader :name, :result, :output

          self.template_name = 'test_case_result'

          def initialize(name, result, output)
            @name = name
            @result = result
            @output = output
          end

          def name
            @name
          end

          def result
            @result
          end
        end

        class TestCaseResultFault < TestCaseResult
          attr_reader :message, :class_name, :line, :source, :backtrace, :exception
          self.template_name = 'test_case_result_fault'
          def initialize(name, result, details ,exception)
            super(name, result, details)
            @exception = true
            @message = exception['message']
            @class_name = exception['class']
            @line = exception['line']
            @source = exception['source']
            @snippet = exception['snippet']
            @backtrace = exception['backtrace']
          end
          def snippet
            @snippet
          end
        end

        class Info < BasicTemplate
          attr_reader :name, :size, :started_at
          self.template_name = 'info'

          def initialize(name, started_at, size)
            @start = started_at
            @name = name
            @size = size
          end

          def started_at
            @start
          end
        end

        class Header < BasicTemplate
          # Dummy class to put html headers
          self.template_name = 'header'
        end

        class Footer < BasicTemplate
          self.template_name = 'footer'
          # Dummy class to put html footers
        end
      end #module Html
    end #module UI
  end #module Unit
end #module Test
