package com.bio11.product.service;

import com.bio11.mapper.BasketMapper;
import com.bio11.mapper.OrderMapper;
import com.bio11.mapper.ProductMapper;
import com.bio11.product.dto.OrderDTO;
import com.bio11.product.dto.OrderDetailDTO;
import com.bio11.product.dto.OrderDetailDTOList;
import com.bio11.product.dto.ProductDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService{
    private OrderMapper orderMapper;
    private BasketMapper basketMapper;
    private ProductMapper productMapper;
    @Override
    @Transactional
    public int orderOne(OrderDTO order) {
        log.info("orderOne...");
        int result = orderMapper.orderOne(order);
        if(result != 1)
            return result;
        OrderDetailDTO orderDetailDTO = new OrderDetailDTO();
        orderDetailDTO.setOrderId(order.getOrderId());
        orderDetailDTO.setOrderProductPrice(order.getProductPrice());
        orderDetailDTO.setOrderProductName(order.getProductName());
        orderDetailDTO.setOrderProductQuantity(order.getProductQuantity());
        orderDetailDTO.setProductId(order.getProductId());

        ProductDTO productDTO = productMapper.read(orderDetailDTO.getProductId());
        int calQuantity =  productDTO.getProductStock() - orderDetailDTO.getOrderProductQuantity();
        productMapper.updateQuantity(calQuantity, orderDetailDTO.getProductId());

        return  orderMapper.insertOrderDetail(orderDetailDTO);

    }

    @Override
    public OrderDTO getOrderOne(int orderId) {
        log.info("getOrder..");
        return orderMapper.getOrderOne(orderId);
    }

    @Override
    @Transactional
    public int orderBasket(OrderDetailDTOList order, String userId) {
        log.info("orderBasket..");
        int result = 0;
        OrderDTO orderDto= new OrderDTO();
        orderDto.setUserId(userId);
        orderMapper.orderBasket(orderDto);
        int orderId = orderDto.getOrderId();
        System.out.println("orderId!!!" + orderId);
        for (OrderDetailDTO orderDetail: order.getList()
             ) {
            orderDetail.setOrderId(orderId);
            result = orderMapper.insertOrderDetail(orderDetail);
            if(result != 1) return result;
            result = basketMapper.deleteBasket(orderDetail.getCartId());
            if(result != 1) return result;
            ProductDTO productDTO = productMapper.read(orderDetail.getProductId());
            int calQuantity =  productDTO.getProductStock() - orderDetail.getOrderProductQuantity();
            result = productMapper.updateQuantity(calQuantity, orderDetail.getProductId());
        }
        return result;
    }

    @Override
    public List<OrderDetailDTO> getOrderList(int orderId) {
        log.info("????????????+"+ orderMapper.getOrderList(orderId));
        return orderMapper.getOrderList(orderId);
    }


}
