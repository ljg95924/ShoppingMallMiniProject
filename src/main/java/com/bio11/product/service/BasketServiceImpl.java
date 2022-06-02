package com.bio11.product.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bio11.product.dto.BasketDTO;
import com.bio11.mapper.BasketMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BasketServiceImpl implements BasketService{
	//@Autowired
	private BasketMapper mapper;
	@Override
	public int addBasket(BasketDTO basket) {
		// TODO Auto-generated method stub
		log.info("addBasket: " + basket);
		BasketDTO checkBasket = mapper.checkBasket(basket);
		if(checkBasket != null) {
			return 2;
		}
		try {
			return mapper.addBasket(basket);
		}catch(Exception e) {
			return 0;			
		}
	}

	@Override
	public int deleteBasket(int cartId) {
		// TODO Auto-generated method stub
		return mapper.deleteBasket(cartId);
	}

	@Override
	public int modifyCount(BasketDTO basket) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BasketDTO> getBasketList(String userId) {
		// TODO Auto-generated method stub
		List<BasketDTO> basket = mapper.getBasket(userId);
		
		return basket;
	}

	@Override
	public BasketDTO checkBasket(BasketDTO basket) {
		// TODO Auto-generated method stub
		return null;
	}

}
