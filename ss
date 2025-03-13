package com.TestApi.start.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class TestApi {

    private final RestTemplate restTemplate;

    public TestApi(RestTemplate restTemplate){
        this.restTemplate=restTemplate;
    }


    @PostMapping("/myTest")
    public ResponseEntity<String> sendDataToApi(
            @RequestHeader Map<String, String> headersFromClient, // this because I want to Receive headers
            @RequestBody String jsonData) { // ..........  Receive JSON body

        String url = "http://10.101.18.36:9235/mdm/v2/golden/person/info";

        // Set up headers for the request  ()
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");

        // Copy incoming headers to be forwarded
        headersFromClient.forEach(headers::set);

        // Create the request with headers and body
        HttpEntity<String> entity = new HttpEntity<>(jsonData, headers);

        // Send the POST request to the external API
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);

        // Return the response received from the external API
        return ResponseEntity.ok(response.getBody());


    }



    }


