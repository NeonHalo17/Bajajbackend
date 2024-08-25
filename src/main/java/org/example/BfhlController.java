package org.example;

import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/bfhl")
public class BfhlController {

    @PostMapping
    public ResponseData processRequest(@RequestBody RequestData requestData) {
        ResponseData responseData = new ResponseData();

        try {
            String userId = "aman_prasad_14102003"; // Replace with your full_name_ddmmyyyy
            String email = "aman.prasad2021@vitstudent.ac.in";
            String rollNumber = "21BCE0359";

            List<String> numbers = new ArrayList<>();
            List<String> alphabets = new ArrayList<>();
            List<String> highestLowercaseAlphabet = new ArrayList<>();

            for (String item : requestData.getData()) {
                if (item.matches("\\d+")) {
                    numbers.add(item);
                } else {
                    alphabets.add(item);
                    if (item.matches("[a-z]")) {
                        highestLowercaseAlphabet.add(item);
                    }
                }
            }

            highestLowercaseAlphabet.sort(Comparator.reverseOrder());
            responseData.setHighestLowercaseAlphabet(highestLowercaseAlphabet.isEmpty() ? new ArrayList<>() : List.of(highestLowercaseAlphabet.get(0)));
            responseData.setIsSuccess(true);
            responseData.setUserId(userId);
            responseData.setEmail(email);
            responseData.setRollNumber(rollNumber);
            responseData.setNumbers(numbers);
            responseData.setAlphabets(alphabets);
        } catch (Exception e) {
            responseData.setIsSuccess(false);
        }


        return responseData;
    }

    @GetMapping
    public Map<String, Integer> getOperationCode() {
        Map<String, Integer> response = new HashMap<>();
        response.put("operation_code", 1);
        return response;
    }
}
