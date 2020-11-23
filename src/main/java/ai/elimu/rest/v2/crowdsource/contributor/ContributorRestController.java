package ai.elimu.rest.v2.crowdsource.contributor;

import ai.elimu.dao.ContributorDao;
import ai.elimu.model.contributor.Contributor;
import ai.elimu.model.enums.Role;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashSet;
import javax.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Stores a Contributor in the database.
 */
@RestController
@RequestMapping(value = "/rest/v2/crowdsource/contributor", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ContributorRestController {
    
    private Logger logger = LogManager.getLogger();
    
    @Autowired
    private ContributorDao contributorDao;
    
    @RequestMapping(method = RequestMethod.POST)
    public String handleGetRequest(
            @RequestBody String requestBody,
            HttpServletResponse response
    ) {
        logger.info("handlePostRequest");
        
        logger.info("requestBody: " + requestBody);
        
        JSONObject contributorJSONObject = new JSONObject(requestBody);
        logger.info("contributorJSONObject: " + contributorJSONObject);
        
        String providerIdGoogle = contributorJSONObject.getString("providerIdGoogle");
        String email = contributorJSONObject.getString("email");
        String firstName = contributorJSONObject.getString("firstName");
        String lastName = contributorJSONObject.getString("lastName");
        String imageUrl = contributorJSONObject.getString("imageUrl");
        
        JSONObject jsonObject = new JSONObject();
        
        // Check if the Contributor has already been stored in the database
        Contributor existingContributor = contributorDao.read(email);
        logger.info("existingContributor: " + existingContributor);
        if (existingContributor == null) {
            // Store the Contributor in the database
            Contributor contributor = new Contributor();
            contributor.setRegistrationTime(Calendar.getInstance());
            contributor.setProviderIdGoogle(providerIdGoogle);
            contributor.setEmail(email);
            contributor.setFirstName(firstName);
            contributor.setLastName(lastName);
            contributor.setImageUrl(imageUrl);
            contributor.setRoles(new HashSet<>(Arrays.asList(Role.CONTRIBUTOR)));
            contributorDao.create(contributor);
            
            jsonObject.put("result", "success");
            jsonObject.put("successMessage", "The Contributor was stored in the database");
        } else {
            // Return error message saying that the Contributor has already been created
            logger.warn("The Contributor has already been stored in the database");
            
            // Update existing contributor with latest account details fetched from provider
            // TODO

            jsonObject.put("result", "error");
            jsonObject.put("errorMessage", "The Contributor has already been stored in the database");
//            response.setStatus(HttpStatus.CONFLICT.value());
        }
        
        String jsonResponse = jsonObject.toString();
        logger.info("jsonResponse: " + jsonResponse);
        return jsonResponse;
    }
}
