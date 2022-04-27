package com.mentees.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
@EnableWebMvc
@ComponentScan("com.mentees.web")
public class ServletConfig implements WebMvcConfigurer
{

//	@Override
//	public void addCorsMappings(CorsRegistry registry) {
//		registry
//		.addMapping("/**")
////		.allowedOrigins("https://localhost:8080","https://menteesprj.herokuapp.com/")
//		.allowedMethods(
//					HttpMethod.HEAD.name(),
//					HttpMethod.GET.name(),
//					HttpMethod.POST.name(),
//					HttpMethod.PUT.name(),
//					HttpMethod.DELETE.name()
//				);
//	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**")
		.addResourceLocations("/resources/");
	}

	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer tilesConfigurer= new TilesConfigurer();
		tilesConfigurer.setDefinitions(new String [] {"/WEB-INF/tiles.xml"});
		return tilesConfigurer;
	}
	
	@Bean
	public TilesViewResolver tilesViewResolver() {
		TilesViewResolver tilesViewResolver = new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		tilesViewResolver.setOrder(1);
		return tilesViewResolver;
	}
}
