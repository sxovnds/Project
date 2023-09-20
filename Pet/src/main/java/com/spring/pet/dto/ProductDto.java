package com.spring.pet.dto;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;

public class ProductDto implements Serializable{

	private static final long serialVersionUID = 1L;
	private String productId;
	private String productName;
	private int price;
	private int stock;
	private String productDist;
	private String productInfo;
	private Date regDate;
	private Date updateDate;
	private String[] files;
	private String fullname;
	private int sold_rate;
	
	
	public ProductDto() {
		// TODO Auto-generated constructor stub
	}

	public ProductDto(String productId, String productName, int price, int stock, String productDist,
			String productInfo) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.stock = stock;
		this.productDist = productDist;
		this.productInfo = productInfo;
	}


	public ProductDto(String productId, String productName, int price, int stock, String productDist,
			String productInfo, String[] files) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.stock = stock;
		this.productDist = productDist;
		this.productInfo = productInfo;
		this.files = files;
	}

	public ProductDto(String productId, String productName, int price, int stock, String productDist,
			String productInfo, Date regDate, Date updateDate, String[] files, String fullname, int sold_rate) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.price = price;
		this.stock = stock;
		this.productDist = productDist;
		this.productInfo = productInfo;
		this.regDate = regDate;
		this.updateDate = updateDate;
		this.files = files;
		this.fullname = fullname;
		this.sold_rate = sold_rate;
	}

	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
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

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
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

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getFilename() {
		return fullname;
	}

	public void setFilename(String filename) {
		this.fullname = filename;
	}

	public int getSold_rate() {
		return sold_rate;
	}

	public void setSold_rate(int sold_rate) {
		this.sold_rate = sold_rate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((productId == null) ? 0 : productId.hashCode());
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
		ProductDto other = (ProductDto) obj;
		if (productId == null) {
			if (other.productId != null)
				return false;
		} else if (!productId.equals(other.productId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProductDto [productId=" + productId + ", productName=" + productName + ", price=" + price + ", stock="
				+ stock + ", productDist=" + productDist + ", productInfo=" + productInfo + ", regDate=" + regDate
				+ ", updateDate=" + updateDate + ", files=" + Arrays.toString(files) + "]";
	}
	
	
	
	
	

}