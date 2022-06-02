package com.bio11.product.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class OrderDetailDTOList {
    List<OrderDetailDTO> list;
    public OrderDetailDTOList(){
        list = new ArrayList<>();
    }
}
