### Technologies
- Ruby 2.6.6
- Rails 5.2.4
- [Bootstrap 3](https://getbootstrap.com/docs/3.4/)
- Haml

### Requirements
Build out the following features

#### Views
  - Order List & Order Search functionality
    - Include at least the order number, state and user email address, any additional information that you think would be helpful to view in the list and search by.
  - Order Detail
    - Display Address / User / OrderItems / Payments

#### Reports:
  - Coupon Users
    - Provide a dropdown to select coupons.
    - Display user email, number of and revenue in orders after the coupon order for that customer
  - Sales By Product
    - Provide a date range
    - Display a table of products name, sold count and revenue during that date range

### Bonus points
  - Cancel order button
  - Pagination
  - Unit testing

### Supporting Information
  - All stateful models have associated `_at` timestamps
  - Orders have 3 states: building, arrived and canceled
    - When the order is canceled all product order items move returned & payments move to refunded
  - Order Items have 2 states: sold and returned
    - Only product order items have states
  - Payments have 2 states: completed and refunded
    - refunded payments do not count towards sales totals
