package com.sparc.knappsack.components.events.sqs;

import com.sparc.knappsack.components.services.EmailService;
import com.sparc.knappsack.models.EmailModel;
import com.sparc.knappsack.models.UserModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component("sqsApplicationVersionPublishRequestEvent")
public class SQSApplicationVersionPublishRequestEvent implements SQSEventDelivery {

    private static final Logger log = LoggerFactory.getLogger(SQSApplicationVersionPublishRequestEvent.class);

    @Qualifier("emailService")
    @Autowired(required = true)
    private EmailService emailService;

    @Override
    public boolean sendNotifications(EmailModel emailModel) {
        boolean success = false;
        if (emailModel != null) {
            try {
                Long applicationVersionId = (Long) emailModel.getParams().get("applicationVersionId");

                UserModel userModel = null;
                Map<String, Object> userModelMap = (Map<String, Object>) emailModel.getParams().get("userModel");
                if (userModelMap != null) {
                    userModel = new UserModel();
                    userModel.setEmail((String) userModelMap.get("email"));
                    Integer id = (Integer) userModelMap.get("id");
                    if (id != null) {
                        userModel.setId(id.longValue());
                    }
                    userModel.setFirstName((String) userModelMap.get("firstName"));
                    userModel.setLastName((String) userModelMap.get("lastName"));
                    userModel.setUserName((String) userModelMap.get("userName"));
                }

                success = emailService.sendApplicationPublishRequestEmail(applicationVersionId, userModel);
            } catch (ClassCastException e) {
                log.info("Error casting params out of EmailModel:", e);
            }
        }

        return success;
    }
}
