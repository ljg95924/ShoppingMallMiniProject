package com.bio11.mapper;

import com.bio11.product.dto.BasketDTO;

import java.util.List;

public interface BasketMapper {
	public int addBasket(BasketDTO basket);
	public int deleteBasket(int basketID);
	public int modifyCount(BasketDTO cart);
	public List<BasketDTO> getBasket(String memberId);
	public BasketDTO checkBasket(BasketDTO basket);
}
