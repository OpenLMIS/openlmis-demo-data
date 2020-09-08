-- copy referencedata's service demo data
\copy referencedata.roles (id,name,description) FROM '/data/demo-data/referencedata.roles.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.geographic_levels (id,code,levelnumber) FROM '/data/demo-data/referencedata.geographic_levels.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.geographic_zones (id,catchmentpopulation,code,latitude,longitude,name,levelid,parentid,boundary) FROM '/data/demo-data/referencedata.geographic_zones.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.facility_operators (id,code,name,displayorder) FROM '/data/demo-data/referencedata.facility_operators.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.facilities (id,active,code,comment,description,enabled,godowndate,golivedate,name,openlmisaccessible,geographiczoneid,operatedbyid,typeid,extradata,location) FROM '/data/demo-data/referencedata.facilities.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.supply_partners (id,name,code) FROM '/data/demo-data/referencedata.supply_partners.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.supply_partner_associations (id,programId,supervisoryNodeId,supplyPartnerId) FROM '/data/demo-data/referencedata.supply_partner_associations.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.supply_partner_association_orderables (supplyPartnerAssociationId,orderableId,orderableVersionNumber) FROM '/data/demo-data/referencedata.supply_partner_association_orderables.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.users (id,username,email,firstname,lastname,verified,active,allownotify,homefacilityid,timezone) FROM '/data/demo-data/referencedata.users.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.service_accounts (id,createdby,createddate) FROM '/data/demo-data/referencedata.service_accounts.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.supervisory_nodes (id,code,name,facilityid,parentid,partnerid,extradata) FROM '/data/demo-data/referencedata.supervisory_nodes.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.role_assignments (id,type,userid,roleid,programid,supervisorynodeid,warehouseid) FROM '/data/demo-data/referencedata.role_assignments.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.supply_partner_association_facilities (supplyPartnerAssociationId,facilityId) FROM '/data/demo-data/referencedata.supply_partner_association_facilities.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.processing_schedules (id,code,name,modifieddate) FROM '/data/demo-data/referencedata.processing_schedules.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.processing_periods (id,name,startdate,enddate,processingscheduleid,extradata) FROM '/data/demo-data/referencedata.processing_periods.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.trade_items (id,manufactureroftradeitem) FROM '/data/demo-data/referencedata.trade_items.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.trade_item_classifications (id,tradeitemid,classificationsystem,classificationid) FROM '/data/demo-data/referencedata.trade_item_classifications.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.commodity_types (id,name,classificationsystem,classificationid) FROM '/data/demo-data/referencedata.commodity_types.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.requisition_groups (id,code,name,supervisorynodeid) FROM '/data/demo-data/referencedata.requisition_groups.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.ideal_stock_amounts (id,facilityid,commoditytypeid,processingperiodid,amount) FROM '/data/demo-data/referencedata.ideal_stock_amounts.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.supported_programs (facilityid,programid,active,startdate,locallyfulfilled) FROM '/data/demo-data/referencedata.supported_programs.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.requisition_group_members (requisitiongroupid,facilityid) FROM '/data/demo-data/referencedata.requisition_group_members.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.lots (id,lotcode,expirationdate,manufacturedate,tradeitemid,active) FROM '/data/demo-data/referencedata.lots.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.role_rights (roleid,rightid) FROM '/data/demo-data/referencedata.role_rights.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.requisition_group_program_schedules (id,programid,processingscheduleid,directdelivery,requisitiongroupid) FROM '/data/demo-data/referencedata.requisition_group_program_schedules.csv' DELIMITER ',' CSV HEADER;
\copy referencedata.supply_lines (id,supervisorynodeid,programid,supplyingfacilityid,description) FROM '/data/demo-data/referencedata.supply_lines.csv' DELIMITER ',' CSV HEADER;
-- copy requisition's service demo data
\copy requisition.jasper_templates (id,description,name,type,data) FROM '/data/demo-data/requisition.jasper_templates.csv' DELIMITER ',' CSV HEADER;
\copy requisition.template_parameters (id,dataType,displayName,name,selectExpression,selectProperty,templateId,required,selectMethod,selectBody,displayProperty) FROM '/data/demo-data/requisition.template_parameters.csv' DELIMITER ',' CSV HEADER
\copy requisition.jasper_template_parameter_dependencies (id,parameterid,dependency,placeholder) FROM '/data/demo-data/requisition.jasper_template_parameter_dependencies.csv' DELIMITER ',' CSV HEADER;
-- copy notification's service demo data
\copy notification.user_contact_details (referenceDataUserId,phoneNumber,email,allowNotify,emailVerified) FROM '/data/demo-data/notification.user_contact_details.csv' DELIMITER ',' CSV HEADER;
\copy notification.digest_subscriptions (id,userContactDetailsId,digestConfigurationId,cronExpression,preferredChannel,useDigest) FROM '/data/demo-data/notification.digest_subscriptions.csv' DELIMITER ',' CSV HEADER;
-- copy fulfillment service demo data
\copy fulfillment.status_changes (id,createdDate,authorId,status,orderId) FROM '/data/demo-data/fulfillment.status_changes.csv' DELIMITER ',' CSV HEADER;
\copy fulfillment.transfer_properties (id,facilityId,type,protocol,username,password,serverHost,serverPort,remoteDirectory,localDirectory,passiveMode,transferType) FROM '/data/demo-data/fulfillment.transfer_properties.csv' DELIMITER ',' CSV HEADER;
-- copy auth's service demo data
\copy auth.oauth_client_details (clientid,clientsecret,authorities,authorizedgranttypes,resourceids,scope,accesstokenvalidity,redirecturi) FROM '/data/demo-data/auth.oauth_client_details.csv' DELIMITER ',' CSV HEADER;
\copy auth.api_keys (token,createdby,createddate,clientid) FROM '/data/demo-data/auth.api_keys.csv' DELIMITER ',' CSV HEADER;
\copy auth.auth_users (id,enabled,password,username) FROM '/data/demo-data/auth.auth_users.csv' DELIMITER ',' CSV HEADER;
