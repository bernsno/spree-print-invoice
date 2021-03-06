require 'prawn/layout'

bill_address = @order.bill_address
ship_address = @order.ship_address

font "Helvetica"

move_down 125

font "Helvetica", :style => :bold, :size => 14
text "Order Number: #{@order.number}"

font "Helvetica", :size => 8
text @order.completed_at.to_s(:long)

# Address Stuff
bounding_box [0,550], :width => 540 do
  move_down 2
  data = [[Prawn::Table::Cell.new( :text => "Billing Address", :font_style => :bold ),
                Prawn::Table::Cell.new( :text =>"Gift Shipping Address", :font_style => :bold )]]

  table data,
    :position => :center,
    :border_width => 0.5,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :border_style => :underline_header,
    :column_widths => { 0 => 270, 1 => 270 }

  move_down 2
  horizontal_rule

  bounding_box [0,0], :width => 540 do
    move_down 2
    data2 = [["#{bill_address.firstname} #{bill_address.lastname}", "#{ship_address.firstname} #{ship_address.lastname}"],
            [bill_address.address1, ship_address.address1]]
    data2 << [bill_address.address2, ship_address.address2] unless bill_address.address2.blank? and ship_address.address2.blank?
    data2 << ["#{@order.bill_address.city}, #{(@order.bill_address.state ? @order.bill_address.state.abbr : "")} #{@order.bill_address.zipcode}",
              "#{@order.ship_address.city}, #{(@order.ship_address.state ? @order.ship_address.state.abbr : "")} #{@order.ship_address.zipcode}"]
    data2 << [bill_address.country.name, ship_address.country.name]
    data2 << [bill_address.phone, ship_address.phone]

    table data2,
      :position => :center,
      :border_width => 0.0,
      :vertical_padding   => 0,
      :horizontal_padding => 6,
      :font_size => 9,
      :column_widths => { 0 => 270, 1 => 270 }
  end

  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end

move_down 30

# Line Items
bounding_box [0,cursor], :width => 540, :height => 230 do
  font "Helvetica", :style => :bold, :size => 14
  text @order.note
end