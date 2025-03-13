 public ResponseEntity<String> sendDataToApi(
            @RequestHeader Map<String, String> headersFromClient, // Receive headers
            @RequestBody String jsonData) { // Receive JSON body
        
        String url = "http://10.101.18.36:9235/mdm/v2/golden/person/info";

        // Set up headers for the request
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
