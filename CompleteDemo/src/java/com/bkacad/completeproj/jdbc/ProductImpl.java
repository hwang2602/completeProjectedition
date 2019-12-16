package com.bkacad.completeproj.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bkacad.completeproj.dto.ProductDTO;

public class ProductImpl {
	private Connection conn;
	public ProductImpl(Connection conn) {
		this.conn = conn;
	}
	public List<ProductDTO> queryProduct() throws SQLException {
		//Connection conn = DBUtil.getSqlConn();
		String sql = "Select a.Code, a.Name, a.Price from Product1 a ";

		PreparedStatement pstm = conn.prepareStatement(sql);

		ResultSet rs = pstm.executeQuery();
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		while (rs.next()) {
			String code = rs.getString("Code");
			String name = rs.getString("Name");
			float price = rs.getFloat("Price");
			ProductDTO product = new ProductDTO();
			product.setCode(code);
			product.setName(name);
			product.setPrice(price);
			list.add(product);
		}
		return list;
	}

	public ProductDTO findProduct(String code) throws SQLException {
		//Connection conn = DBUtil.getSqlConn();
		String sql = "Select a.Code, a.Name, a.Price from Product1 a where a.Code=?";

		PreparedStatement pstm = conn.prepareStatement(sql);
		pstm.setString(1, code);

		ResultSet rs = pstm.executeQuery();

		while (rs.next()) {
			String name = rs.getString("Name");
			float price = rs.getFloat("Price");
			ProductDTO product = new ProductDTO(code, name, price);
			return product;
		}
		return null;
	}

	public void updateProduct(ProductDTO product) throws SQLException {
		//Connection conn = DBUtil.getSqlConn();
		String sql = "Update Product1 set Name =?, Price=? where Code=? ";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, product.getName());
		pstm.setFloat(2, product.getPrice());
		pstm.setString(3, product.getCode());
		pstm.executeUpdate();
	}

	public void insertProduct(ProductDTO product) throws SQLException {
		//Connection conn = DBUtil.getSqlConn();
		String sql = "Insert into Product1(Code, Name,Price) values (?,?,?)";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, product.getCode());
		pstm.setString(2, product.getName());
		pstm.setFloat(3, product.getPrice());

		pstm.executeUpdate();
	}

	public void deleteProduct(String code) throws SQLException {
		//Connection conn = DBUtil.getSqlConn();
		String sql = "Delete Product1 where Code= ?";

		PreparedStatement pstm = conn.prepareStatement(sql);

		pstm.setString(1, code);

		pstm.executeUpdate();
	}

}