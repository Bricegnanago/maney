class InfoCustomerUserAccount {
  int idOwner;
  int userId;
  String fullNameOwner;
  String phoneNumberOwner;
  String emailAddressOwner;
  String customerCreatedAt;
  int operationId;
  String operationTitle; 
  int balance; // Le solde actuel du compte
  int amount;
  String accountCreatedAt; // La date de création du compte
  String accountLastUpdate;
  String username;

  InfoCustomerUserAccount({
    this.idOwner,
    this.userId,
    this.fullNameOwner,
    this.phoneNumberOwner,
    this.emailAddressOwner,
    this.customerCreatedAt,
    this.operationId, 
    this.operationTitle, 
    this.balance,
    this.amount,
    this.accountCreatedAt,
    this.accountLastUpdate,
    this.username
  });

  Map<String, dynamic> toMap() {
    return {
      "idOwner" : idOwner,
      "userId": userId,
      "fullNameOwner": fullNameOwner,      
      "phoneNumberOwner": phoneNumberOwner.toUpperCase(),
      "emailAddressOwner": emailAddressOwner.toUpperCase(),
      "customerCreatedAt": customerCreatedAt,
      "operationId" : operationId,
      "operationTitle" : operationTitle,
      "balance" : balance,
      "amount" : amount,
      "accountCreatedAt" : accountCreatedAt,
      "accountLastUpdate": accountLastUpdate,      
      "username" : username,
    };
  }




}