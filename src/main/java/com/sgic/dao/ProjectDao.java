package com.sgic.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.sgic.model.Project;

public class ProjectDao {

	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public int save(Project project) {
		String sql = "insert into springmvc(name,description) values('" + project.getProjectName() + "','"
				+ project.getProjectDescription() + "')";
		return jdbcTemplate.update(sql);
	}

	public List<Project> getProjects() {
		return jdbcTemplate.query("select * from springmvc", new RowMapper<Project>() {
			public Project mapRow(ResultSet rs, int row) throws SQLException {
				Project p = new Project();
				p.setProjectName(rs.getString(1));
				p.setProjectDescription(rs.getString(2));
				return p;
			}
		});
	}

}
