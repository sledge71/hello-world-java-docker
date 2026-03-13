package com.edw.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class IndexController {
    private Logger logger = LoggerFactory.getLogger(IndexController.class);

    @GetMapping("/")
    public Map<String, Object> index() {
        logger.debug("request served");

        return Map.of(
                "success", true,
                "hello", "world",
                "new-message", "adding a new msg"
        );
    }
}
