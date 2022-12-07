//REST CALLOUTS
HttpResponse resp1 = RestCallouts.getAnimals();
HttpResponse resp2 = RestCallouts.getBlogs();
HttpResponse resp3 = RestCallouts.getProducts();
HttpResponse resp4 = RestCallouts.postAnimal();
HttpResponse resp5 = RestCallouts.postGorestContact();

//SOAP CALLOUTS
String[] parks = SoapCallouts.getParksByCountry('United States');