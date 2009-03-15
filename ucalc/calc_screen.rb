require 'tk'
require 'value'
require 'calculator'
require 'calc_controller'

@my_font = TkFont.new('helvetica 20 bold')
@calculator = Calculator.new(Value.new 0, Dimension.new)
@controller = Calc_Controller.new @calculator

def push
  @controller.push
  @my_text.value = @controller
end

def pop
  @controller.pop 
  @my_text.value = @controller
end

def cab
  @controller.cab  
  @my_text.value = @controller
end

def swap
  @controller.swap
  @my_text.value = @controller
end

def plus
  @controller.plus
  @my_text.value = @controller  
end

def minus
  @controller.subtract
  @my_text.value = @controller
end

def times
  @controller.times
  @my_text.value = @controller
end

def divide
  @controller.divide
  @my_text.value = @controller
end

def extend_unit arg
  @controller.unit(arg)
  @my_text.value = @controller
end

def extend_number n
  @controller.digit(n)
  @my_text.value = @controller
end

def plus_old
  @calculator.binary_op(lambda{|a,b| a+b})  
  @my_text.value = @calculator
end

def make_button frame, name, p
  TkButton.new(frame, :text=>name, :font=>@my_font, :command =>p)   
end

def make_digit root, number
  make_button(root, number, proc{extend_number number})
end

def make_unit root, unit
  make_button(root, unit, proc{extend_unit unit})
end

root = TkRoot.new { title "Calculator" }

output_frame = TkFrame.new(root).pack(
  'side'=>'top',
  'padx'=>10,
  'pady'=>10,
  'fill'=>'both')
  
button_frame = TkFrame.new(root).pack(
  'side'=>'bottom',
  'padx'=>10,
  'pady'=>10)

  @my_text = TkVariable.new

@calculated_result = TkEntry.new(output_frame) {
      width   75
      font @my_font
      state 'readonly'
      justify 'right'
      border 5
    }.pack(
      'fill'=>'y', 
      'expand'=>'true')

@calculated_result.textvariable = @my_text
@my_text.value = @calculator

b0 = make_digit(button_frame, 0)
b1 = make_digit(button_frame, 1)
b2 = make_digit(button_frame, 2)
b3 = make_digit(button_frame, 3)
b4 = make_digit(button_frame, 4)
b5 = make_digit(button_frame, 5)
b6 = make_digit(button_frame, 6)
b7 = make_digit(button_frame, 7)
b8 = make_digit(button_frame, 8)
b9 = make_digit(button_frame, 9)

bm  = make_unit(button_frame, Dimension.new({'m'=>1}))
b1m = make_unit(button_frame, Dimension.new({'m'=>-1}))
bk   = make_unit(button_frame, Dimension.new({'k'=>1}))
b1k  = make_unit(button_frame, Dimension.new({'k'=>-1}))
bs   = make_unit(button_frame, Dimension.new({'s'=>1}))
b1s  = make_unit(button_frame, Dimension.new({'s'=>-1}))

b_plus   = make_button(button_frame, '+', proc{plus})
b_minus = make_button(button_frame, '-', proc{minus})
b_times = make_button(button_frame, '*', proc{times})
b_divide = make_button(button_frame, '/', proc{divide})

b_push = make_button(button_frame, 'Push', proc{push})
b_pop = make_button(button_frame, 'Pop', proc{pop})
b_swap = make_button(button_frame, 'Swap', proc{swap})
b_cab = make_button(button_frame, 'CAB', proc{cab})

spaceholder = TkLabel.new(button_frame)

buttons = [
b7, b8, b9, bm, b1m, b_plus, b_push,
b4, b5, b6, bk, b1k, b_minus, b_pop,
b1, b2, b3, bs, b1s, b_times, b_swap,
spaceholder, b0, spaceholder, spaceholder, spaceholder, b_divide, b_cab]

items_per_row = 7

buttons.each_index { |i|
  buttons[i].grid(
    'column'=>(i%items_per_row),
    'row'=>(i/items_per_row),
    'sticky'=>'news',
    'padx'=>5,
    'pady'=>5)
}
    
Tk.mainloop