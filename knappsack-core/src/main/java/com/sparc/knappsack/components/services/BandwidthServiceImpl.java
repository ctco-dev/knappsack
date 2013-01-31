package com.sparc.knappsack.components.services;

import com.sparc.knappsack.components.entities.*;
import com.sparc.knappsack.enums.StorageType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;

@Service("bandwidthService")
public class BandwidthServiceImpl implements BandwidthService {

    @Autowired
    private OrganizationService organizationService;

    @Qualifier("storageServiceFactory")
    @Autowired(required = true)
    private StorageServiceFactory storageServiceFactory;

    public boolean isBandwidthLimitReached(ApplicationVersion applicationVersion) {
        Application application = applicationVersion.getApplication();
        return isBandwidthLimitReached(application);
    }

    public boolean isBandwidthLimitReached(Application application) {
        Group ownedGroup = application.getOwnedGroup();
        Organization organization = ownedGroup.getOrganization();
        Date startDate = getStartDate(organization);
        Date endDate = getEndDate();

        return organizationService.isBandwidthLimit(organization, application.getStorageConfiguration().getStorageType(), startDate, endDate);
    }

    public double getMegabyteBandwidthUsed(Long organizationId) {
        Organization organization = organizationService.get(organizationId);
        Date startDate = getStartDate(organization);
        Date endDate = getEndDate();
        StorageConfiguration storageConfiguration = organization.getOrgStorageConfig().getStorageConfigurations().get(0);
        StorageType storageType = storageConfiguration.getStorageType();
        if(storageType.isRemote()) {
            StorageService storageService = storageServiceFactory.getStorageService(storageType);
            return ((RemoteStorageService) storageService).getMegabyteBandwidthUsed(organization.getOrgStorageConfig(), startDate, endDate);
        }
        return 0.0;
    }

    private Date getStartDate(Organization organization) {
        Date startDate = organization.getCreateDate();

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        calendar.set(Calendar.HOUR, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);

        return calendar.getTime();
    }

    private Date getEndDate() {
        Calendar calendar = Calendar.getInstance();

        return calendar.getTime();
    }
}
