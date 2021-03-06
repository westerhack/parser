
require_relative 'tokens/container'

class Locals
  attr_reader :knowns
  attr_reader :globals
  attr_reader :stack

  def initialize(knowns: nil, stack: nil, globals: nil)
    @knowns = knowns || {}
    @globals = globals || {}
    @stack = stack || Container.new
  end

#hi from dad
  def [](key)
    @knowns[key] || @globals[key]
  end

  def []=(key, token)
    @knowns[key] = token
  end

  def <<(token)
    @stack << token
  end

  def shift
    @stack.shift
  end

  def pop
    @stack.pop
  end

  def delete_at(pos)
    @stack.delete_at(pos)
  end


  def clone_knowns(stack: nil, transfer: true)
    self.class.new(knowns: !transfer && knowns.clone,
                   stack: stack.nil? ? nil : stack.clone,
                   globals: transfer ? @globals.clone.update(@knowns) : @globals.clone
                   )
  end

  def global_tokens
    @globals.select{ |_, value| value.is_a?(Token) }
  end

  def to_s
    "#{self.class}(\n\tstack:\n\t\t#{@stack}" + 
    "\n\tknowns:\n\t\t{#{@knowns.collect{ |k, v| "#{k}: #{v}"}.join(', ') }}" +
    "\n\tglobals:\n\t\t{#{global_tokens.collect{ |k, v| "#{k}: #{v}"}.join(', ') }}\n\t)"
  end

  def update!(other)
    fail(other.class.to_s) unless other.is_a?(self.class)
    @knowns.update(other.knowns)
    @stack += other.stack
  end

  def execute!
    results = clone_knowns
    until stack.empty?
      token = shift
      case token
      when Keyword
        case token
        when Keyword::Default
          results << token
        when Keyword::Return
          return results
        when Keyword::Newline
          p results.pop
          p stack
        when Keyword::Fetch
          to_get = results.pop
          to_add = results[to_get]
          raise "Unknown variable: `#{to_get}`" unless to_add
          results << to_add

        when Keyword::CallFunction
          args = results.pop
          func = results.pop

          new_locals = results.clone_knowns(stack: args)
          new_locals = new_locals.execute!
          func.call(locals: new_locals, results: results)
        else
          fail token.inspect
        end
      else
        results << token
      end
    end
    results
  end

  def get_binding
    b = binding
    global_tokens.each do |k, v|
      b.local_variable_set(k.value, v.value)
    end
    knowns.each do |k, v|
      b.local_variable_set(k.value, v.value)
    end
    b
  end
end










