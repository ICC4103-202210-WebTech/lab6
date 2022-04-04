namespace :db do
  task :populate_fake_data => :environment do
    # If you are curious, you may check out the file
    # RAILS_ROOT/test/factories.rb to see how fake
    # model data is created using the Faker and
    # FactoryBot gems.
    puts "Populating database"
    # 10 event venues is reasonable...
    create_list(:event_venue, 10)
    # 50 customers with orders should be alright
    create_list(:customer_with_orders, 50)
    # You may try increasing the number of events:
    create_list(:event_with_ticket_types_and_tickets, 3)
  end
  task :model_queries => :environment do
    # Sample query: Get the names of the events available and print them out.
    # Always print out a title for your query
    puts("Query 0: Sample query; show the names of the events available")
    result = Event.select(:name).distinct.map { |x| x.name }
    puts(result)
    puts("EOQ") # End Of Query -- always add this line after a query.

    # Selected models for the next queries
    cust = Customer.find(3) 
    event = Event.find(3)

    # Query #1
    # Report the total number of tickets bought by a given customer. 
    # Hint: see the has_many :through! association that exists between
    # Customer and Ticket.
    puts("Query 1: Total number of tickets bought by a given customer")
    result = cust.tickets.count
    puts result
    puts("EOQ")

    # Query #2
    # Report the total number of different events that a given customer
    # has attended. That is, write a query that works for any Customer 
    # object given its model object, or the id.
    puts("Query 2: Total number of different events that a given customer\n\
      Has attended")
    result = Event.joins(ticket_types: { tickets: :order }).
      where(orders: {customer: cust}).select(:name).
      distinct.count
    puts result
    puts("EOQ")

    # Query #3
    # Names of the events attended by a given customer.
    puts("Query 3: Names of the events attended by a given customer.")
    result = Event.joins(ticket_types: { tickets: :order }).
      where(orders: {customer: cust}).select(:name).
      distinct.map {|x| x.name}
    puts result
    puts("EOQ")

    # Query #4
    # Total number of tickets sold for an event.
    puts("Query 4: Total number of tickets sold for an event.")
    result = Ticket.joins(ticket_type: :event).
      where(events: {id: event.id}).count
    puts result
    puts("EOQ")
    
    # Query #5
    # Total sales of an event.
    puts("Query 5: Total sales of an event.")
    result = TicketType.joins(:tickets, :event).where(event: event).
      select("ticket_types.price").
      sum("price")
    puts result
    puts("EOQ")

    # Query #6
    # The event that has been most attended by women.
    puts("Query 6: The event that has been most attended by women.")
    result = Event.joins(ticket_types: { tickets: { order: :customer } }).
      where(customers: { gender: 'f' }).group(:name).count.max
    puts result
    puts("EOQ")

    # Query #7
    # The event that has been most attended by men ages 18 to 30.
    puts("Query 7: The event that has been most attended by men ages 18 to 30.")
    result = Event.joins(ticket_types: { tickets: { order: :customer } }).
      where("customers.gender = 'm' and\ 
        customers.age >=18 and customers.age <=30").
      group(:name).count.max
    puts result
    puts("EOQ")
    
  end
end
