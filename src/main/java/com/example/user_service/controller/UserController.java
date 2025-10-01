package com.example.user_service.controller;

import com.example.user_service.model.User;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/users")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    private static Map<Long, User> users = new HashMap<>();

    static {
        users.put(1L, new User(1L, "Alice"));
        users.put(2L, new User(2L, "Bob"));
    }

    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        logger.info("Received request for user with ID: {}", id);
        User user = users.get(id);
        if (user == null) {
            logger.warn("User with ID {} not found", id);
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }
        return user;
    }
}