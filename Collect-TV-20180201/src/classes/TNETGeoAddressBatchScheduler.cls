global class TNETGeoAddressBatchScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        TNETGeoAddressBatch t = new TNETGeoAddressBatch('TechNet');
        Database.executeBatch(t, 10);
    }
}