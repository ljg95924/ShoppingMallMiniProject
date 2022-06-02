package com.bio11.product.dto;

import lombok.Data;

import java.util.Date;

@Data
public class OrderDTO {
    private int orderId;
    private String userId;
    private Date orderTime;
    private String orderName;
}
