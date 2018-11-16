view: sme_padawan_user_facts {
  derived_table: {
    sql: SELECT
        users.id  AS `users.id`,
        users.city  AS `users.city`,
        users.state  AS `users.state`,
        users.zip  AS `users.zip`,
        orders.id  AS `orders.id`,
        orders.status  AS `orders.status`,
        COUNT(DISTINCT orders.id ) AS `orders.count`,
        COALESCE(SUM(order_items.sale_price ), 0) AS `order_items.total_cost`,
        COUNT(*) AS `order_items.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      LEFT JOIN demo_db.users  AS users ON orders.user_id = users.id

      GROUP BY 1,2,3,4,5,6
      ORDER BY COUNT(DISTINCT orders.id ) DESC
      LIMIT 500
       ;;
  }


  dimension: users_id {
    type: number
    sql: ${TABLE}.`users.id` ;;
  }

  measure: User_Has_Moved {
    type: yesno
    sql:
  }
  dimension: users_city {
    type: string
    sql: ${TABLE}.`users.city` ;;
  }

  dimension: users_state {
    type: string
    sql: ${TABLE}.`users.state` ;;
  }

  dimension: users_zip {
    type: number
    sql: ${TABLE}.`users.zip` ;;
  }

  dimension: orders_id {
    type: number
    sql: ${TABLE}.`orders.id` ;;
  }

  dimension: orders_status {
    type: string
    sql: ${TABLE}.`orders.status` ;;
  }

  dimension: orders_count {
    type: number
    sql: ${TABLE}.`orders.count` ;;
  }

  dimension: order_items_total_cost {
    type: number
    sql: ${TABLE}.`order_items.total_cost` ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.`order_items.count` ;;
  }

  set: detail {
    fields: [
      users_id,
      users_state,
      users_zip,
      orders_id,
      orders_status,
      orders_count,
      order_items_total_cost,
      order_items_count
    ]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
}
