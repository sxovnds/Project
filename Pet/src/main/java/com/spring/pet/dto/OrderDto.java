package com.spring.pet.dto;

import java.io.Serializable;
import java.util.Date;

public class OrderDto implements Serializable {

	private static final long serialVersionUID = 1L;
	private String productId;
	private String productName;
	private int price;
	private String productDist;
	private String productInfo;
	private String fullname;
	private int stock;
	
	private String userId;
	private String username;
	private String email;
	private String tel;
	private String useraddress;
	private String postcode;
	
	private String selected_Opt;
	private String order_Qty;
	private Date orderDate;
	private int orderId;
	private Date billingDate;
	private String deliver_msg;
	private int deliver_situ;
	private int totalAmount;
	private String cal_info;

	public OrderDto() {
		// TODO Auto-generated constructor stub
	}
	

	public OrderDto(String productId, String productName, int price, String productDist, String productInfo,
			String fullname, int stock, String userId, String username, String email, String tel, String useraddress,
			String postcode, String selected_Opt, String order_Qty, Date orderDate, int orderId,
			int order_seq_num, Date billingDate, String deliver_msg, int deliver_situ, int totalAmount,
			String cal_info) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.productDist = productDist;
		this.productInfo = productInfo;
		this.fullname = fullname;
		this.stock = stock;
		this.userId = userId;
		this.username = username;
		this.email = email;
		this.tel = tel;
		this.useraddress = useraddress;
		this.postcode = postcode;
		this.selected_Opt = selected_Opt;
		this.order_Qty = order_Qty;
		this.orderDate = orderDate;
		this.orderId = orderId;
		this.billingDate = billingDate;
		this.deliver_msg = deliver_msg;
		this.deliver_situ = deliver_situ;
		this.totalAmount = totalAmount;
		this.cal_info = cal_info;
	}


	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProductDist() {
		return productDist;
	}

	public void setProductDist(String productDist) {
		this.productDist = productDist;
	}

	public String getProductInfo() {
		return productInfo;
	}

	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getUseraddress() {
		return useraddress;
	}

	public void setUseraddress(String useraddress) {
		this.useraddress = useraddress;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getSelected_Opt() {
		return selected_Opt;
	}

	public void setSelected_Opt(String selected_Opt) {
		this.selected_Opt = selected_Opt;
	}

	public String getOrder_Qty() {
		return order_Qty;
	}

	public void setOrder_Qty(String order_Qty) {
		this.order_Qty = order_Qty;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public Date getBillingDate() {
		return billingDate;
	}

	public void setBillingDate(Date billingDate) {
		this.billingDate = billingDate;
	}

	public String getDeliver_msg() {
		return deliver_msg;
	}

	public void setDeliver_msg(String deliver_msg) {
		this.deliver_msg = deliver_msg;
	}

	public int getDeliver_situ() {
		return deliver_situ;
	}

	public void setDeliver_situ(int deliver_situ) {
		this.deliver_situ = deliver_situ;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	

	public String getCal_info() {
		return cal_info;
	}

	public void setCal_info(String cal_info) {
		this.cal_info = cal_info;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + orderId;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderDto other = (OrderDto) obj;
		if (orderId != other.orderId)
			return false;
		return true;
	}

	
	
	

}