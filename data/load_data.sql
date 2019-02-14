-- copy cce's demo data
\copy cce.cce_catalog_items (id,fromPqsCatalog,equipmentCode,type,model,manufacturer,energySource,dateOfPrequal,storageTemperature,maxOperatingTemp,minOperatingTemp,energyConsumption,holdoverTime,netVolume,visibleInCatalog,archived,grossVolume) FROM '/data/demo-data/cce.cce_catalog_items.csv' DELIMITER ',' CSV HEADER;
\copy cce.cce_inventory_items (id,facilityId,catalogItemId,programId,equipmentTrackingId,yearOfInstallation,functionalStatus,utilization,voltageStabilizer,backupGenerator,voltageRegulator,manualTemperatureGauge,remoteTemperatureMonitor,lastModifierId,modifiedDate,referenceName,reasonNotWorkingOrNotInUse,decommissionDate)  FROM '/data/demo-data/cce.cce_inventory_items.csv' DELIMITER ',' CSV HEADER;
\copy cce.cce_alerts (id,externalId,type,inventoryItemId,startTimestamp,active,endTimestamp,dismissTimestamp) FROM '/data/demo-data/cce.cce_alerts.csv' DELIMITER ',' CSV HEADER;
\copy cce.cce_alert_status_messages (alertid,locale,message) FROM '/data/demo-data/cce.cce_alert_status_messages.csv' DELIMITER ',' CSV HEADER;
-- copy notification's demo data
\copy notification.notifications (id,userid,important,createddate) FROM '/data/demo-data/notification.notifications.csv' DELIMITER ',' CSV HEADER;
\copy notification.notification_messages (id,notificationid,channel,body,subject,send) FROM '/data/demo-data/notification.notification_messages.csv' DELIMITER ',' CSV HEADER;
-- copy requisition's demo data
\copy requisition.requisition_templates (id,createdDate,numberOfPeriodsToAverage,populateStockOnHandFromStockCards,name,archived) FROM '/data/demo-data/requisition.requisition_templates.csv' DELIMITER ',' CSV HEADER;
\copy requisition.columns_maps (requisitionTemplateId,key,name,label,indicator,displayOrder,isDisplayed,source,definition,requisitionColumnId,requisitionColumnOptionId,tag) FROM '/data/demo-data/requisition.columns_maps.csv' DELIMITER ',' CSV HEADER;
\copy requisition.requisition_template_assignments (id,programId,facilityTypeId,templateId) FROM '/data/demo-data/requisition.requisition_template_assignments.csv' DELIMITER ',' CSV HEADER;
\copy requisition.requisitions (id,version,createdDate,modifiedDate,facilityId,programId,processingPeriodId,status,emergency,supervisoryNodeId,templateId,numberOfMonthsInPeriod,supplyingFacilityId,draftStatusMessage) FROM '/data/demo-data/requisition.requisitions.csv' DELIMITER ',' CSV HEADER;
\copy requisition.status_changes (id,createdDate,authorId,status,requisitionId,supervisoryNodeId) FROM '/data/demo-data/requisition.status_changes.csv' DELIMITER ',' CSV HEADER;
\copy requisition.status_messages (id,requisitionId,statusChangeId,authorId,body,status,createdDate) FROM '/data/demo-data/requisition.status_messages.csv' DELIMITER ',' CSV HEADER;
\copy requisition.stock_adjustment_reasons (id,reasonId,name,description,reasonCategory,reasonType,isFreeTextAllowed,requisitionId,hidden) FROM '/data/demo-data/requisition.stock_adjustment_reasons.csv' DELIMITER ',' CSV HEADER;
\copy requisition.requisition_line_items (id,orderableId,requisitionId,stockOnHand,beginningBalance,totalReceivedQuantity,requestedQuantity,totalConsumedQuantity,requestedQuantityExplanation,totalStockoutDays,maxPeriodsOfStock,skipped,nonFullSupply,adjustedConsumption,averageConsumption,pricePerPack,idealStockAmount,totalLossesAndAdjustments,remarks,approvedQuantity,packsToShip,calculatedOrderQuantity,total,totalCost,calculatedOrderQuantityIsa) FROM '/data/demo-data/requisition.requisition_line_items.csv' DELIMITER ',' CSV HEADER;
\copy requisition.previous_adjusted_consumptions (requisitionlineitemid,previousadjustedconsumption) FROM '/data/demo-data/requisition.previous_adjusted_consumptions.csv' DELIMITER ',' CSV HEADER;
\copy requisition.stock_adjustments (id,reasonId,quantity,requisitionLineItemId) FROM '/data/demo-data/requisition.stock_adjustments.csv' DELIMITER ',' CSV HEADER;
-- recreate requisitions permission strings
DELETE FROM requisition.requisition_permission_strings;
INSERT INTO requisition.requisition_permission_strings WITH requisition_rights (name) AS (VALUES ('REQUISITION_VIEW')) SELECT uuid_generate_v4() AS id , r.id AS requisitionid , rr.name || '|' || r.facilityid || '|' || r.programid AS permissionstring FROM requisition.requisitions r CROSS JOIN requisition_rights rr;
-- copy stock management's demo data
\copy stockmanagement.stock_card_line_item_reasons (id,name,description,reasonCategory,reasonType,isFreeTextAllowed) FROM '/data/demo-data/stockmanagement.stock_card_line_item_reasons.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.stock_card_line_item_reason_tags (tag,reasonId) FROM '/data/demo-data/stockmanagement.stock_card_line_item_reason_tags.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.valid_reason_assignments (id,programId,facilityTypeId,reasonId,hidden) FROM '/data/demo-data/stockmanagement.valid_reason_assignments.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.organizations (id,name) FROM '/data/demo-data/stockmanagement.organizations.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.nodes (id,isRefDataFacility,referenceId) FROM '/data/demo-data/stockmanagement.nodes.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.valid_source_assignments (id,facilityTypeId,programId,nodeId) FROM '/data/demo-data/stockmanagement.valid_source_assignments.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.valid_destination_assignments (id,facilityTypeId,programId,nodeId) FROM '/data/demo-data/stockmanagement.valid_destination_assignments.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.stock_events (id,documentnumber,facilityid,processeddate,programid,signature,userid) FROM '/data/demo-data/stockmanagement.stock_events.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.stock_event_line_items (id,destinationfreetext,destinationid,lotid,occurreddate,orderableid,quantity,reasonfreetext,reasonid,sourcefreetext,sourceid,stockeventid,extradata) FROM '/data/demo-data/stockmanagement.stock_event_line_items.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.physical_inventories (id,documentnumber,facilityid,isdraft,occurreddate,programid,signature,stockeventid) FROM '/data/demo-data/stockmanagement.physical_inventories.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.physical_inventory_line_items (id,lotid,orderableid,quantity,physicalinventoryid,extradata,previousstockonhandwhensubmitted) FROM '/data/demo-data/stockmanagement.physical_inventory_line_items.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.stock_cards (id,facilityid,lotid,orderableid,programid,origineventid) FROM '/data/demo-data/stockmanagement.stock_cards.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.stock_card_line_items (id,destinationfreetext,documentnumber,occurreddate,processeddate,quantity,reasonfreetext,signature,sourcefreetext,userid,destinationid,origineventid,reasonid,sourceid,stockcardid,extradata) FROM '/data/demo-data/stockmanagement.stock_card_line_items.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.physical_inventory_line_item_adjustments (id,quantity,reasonid,physicalinventorylineitemid,stockcardlineitemid,stockeventlineitemid) FROM '/data/demo-data/stockmanagement.physical_inventory_line_item_adjustments.csv' DELIMITER ',' CSV HEADER;
\copy stockmanagement.jasper_templates (id,data,description,name,type) FROM '/data/demo-data/stockmanagement.jasper_templates.csv' DELIMITER ',' CSV HEADER;
-- copy fulfillment's demo data
\copy fulfillment.orders (id,createdbyid,createddate,emergency,externalid,ordercode,programid,quotedcost,receivingfacilityid,requestingfacilityid,status,supplyingfacilityid,lastupdaterid,lastupdateddate) FROM '/data/demo-data/fulfillment.orders.csv' DELIMITER ',' CSV HEADER;
\copy fulfillment.order_line_items (id,orderId,orderableId,orderedQuantity) FROM '/data/demo-data/fulfillment.order_line_items.csv' DELIMITER ',' CSV HEADER;
\copy fulfillment.shipments (id,orderId,shippedDate,shippedById,extraData,notes) FROM '/data/demo-data/fulfillment.shipments.csv' DELIMITER ',' CSV HEADER;
\copy fulfillment.shipment_line_items (id,shipmentId,orderableId,quantityShipped) FROM '/data/demo-data/fulfillment.shipment_line_items.csv' DELIMITER ',' CSV HEADER;
\copy fulfillment.proofs_of_delivery (id,shipmentId,deliveredBy,receivedBy,receivedDate,status) FROM '/data/demo-data/fulfillment.proofs_of_delivery.csv' DELIMITER ',' CSV HEADER;
\copy fulfillment.proof_of_delivery_line_items (id,orderableId,proofOfDeliveryId,quantityAccepted,useVvm,quantityRejected) FROM '/data/demo-data/fulfillment.proof_of_delivery_line_items.csv' DELIMITER ',' CSV HEADER;
