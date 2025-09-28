package com.example.userservice.controller;

import com.example.userservice.model.User;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/users")
public class UserController {

    private static Map<Long, User> users = new HashMap<>();

    static {
        users.put(1L, new User(1L, "Alice"));
        users.put(2L, new User(2L, "Bob"));
    }

    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        return users.get(id);
    }
}
