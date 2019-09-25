package com.sgic.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sgic.dao.ProjectDao;
import com.sgic.model.Project;

@Controller
public class ProjectController {

	@Autowired
	ProjectDao dao;

	@RequestMapping("/project")
	public String showform(Model m) {
		m.addAttribute("command", new Project());
		return "project";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(@ModelAttribute("project") Project proj) {
		if (proj.getProjectName().length() == 0 || proj.getProjectDescription().length() == 0) {
			//System.out.print("KKKKKKKK"); error
			return "redirect:/project?msg=notvalid";
		} else {
			dao.save(proj);
			
			return "redirect:/project?msg=success";// will redirect to project.jsp request mapping
		}
	}
    /* It provides list of employees in model object */    
    @RequestMapping("/projectlist")    
    public String viewprojects(Model m){    
        List<Project> list=dao.getProjects();    
        m.addAttribute("list",list);  
        System.out.print(list);
        return "projectlist";    
    }  
}
