//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

contract LeaseContract is Initializable{
    struct Tenant {
        address id;
        uint256 startDate;
        uint256 endDate;
        uint256 monthlyRent;
        uint256 rentDue;
        uint256 lastRentPaidDate;
        uint256 advanceAmountPaid;
        uint256 securityDepositPaid;
        bool renewLease;
    }
    
    address private owner;
    Tenant private currentTenant;
    address private admin;
    mapping(address => Tenant) public mapTenant;
    
    enum StateLeaseContract { available, rented, inactive }
    StateLeaseContract private leaseState;   
    uint256 monthlyrent;
    uint256 incrementRate;
    bool renewLease;
    function initialize( address _admin, uint _incrementRate, uint _monthlyrent)public initializer {
        owner = msg.sender;
        admin =_admin;
        incrementRate=_incrementRate;
        leaseState=StateLeaseContract.available;
        monthlyrent=_monthlyrent;
    }
    
    modifier onlyOwner() {
         require(msg.sender == owner, "Only tenant can pay rent");
        _;}   
    modifier onlyCurrentTenant() {
        require(msg.sender==currentTenant.id, "Only current tenant can call this function");
        _;}
    modifier onlyOwnerOrCurrentTenant() {
        // Add owner or current tenant check logic here
        require(msg.sender==currentTenant.id||msg.sender, "Only owner or current tenant can call this function");
        _;}
    
   
    
    modifier advancePaid() {
        // Add advance payment check logic here
        require(currentTenant.advanceAmountPaid==(2*currentTenant.monthlyRent), "Advance amount not paid");
        _; }
    
    modifier noRentDue() {
        // Add no rent due check logic here
        require(currentTenant.rentDue==0, "Rent is due");
        _;}
    modifier tenantAgree(){
            require(currentTenant.renewLease==true);
            _;}

    modifier isActive() {
    
        // Add lease contract active check logic here
        require(leaseState==StateLeaseContract.active, "Lease is not up for rent");
        _;}
    
 
    modifier isRented(){
        require(leaseState==StateLeaseContract.rented, "Lease is not rented");
        _;}
    modifier isInactive(){
        require(leaseState==StateLeaseContract.inactive, "Lease is not inactive");
        _;}


    
    
    
   
   
    event RentPaid(Tenant tenant , uint256 rent, uint256 lastRentPaidDate);
    event LeaseRenewed(Tenant tenant, uint256 rent, uint256 newLastDate);
    event StatusChanged(StateLeaseContract state);
    event OwnershipTransferred(address newOwner);
    event LeaseTerminated(Tenant tenant,address owner  ,uint256 endDate, uint256 securityDepositReturned);
    event DisputeHandled(Tenant tenant,address owner );
    
   
    
   
   // set leasestate
    function setAvailable() public onlyOwner {leaseState=StateLeaseContract.available;}
    function setRented() public onlyOwner {leaseState=StateLeaseContract.rented;}
    function setInactive() public onlyOwner {leaseState= StateLeaseContract.inactive;}
    
    function payRent() public payable onlyCurrentTenant advancePaid noRentDue  {
        // Add payRent function logic here
        require(msg.value==monthlyrent,"rent amount not paid");
    }
    function renewLeaseTenant() public onlyCurrentTenant(){
        // Add renewLease function logic here
currentTenant.renewLease==true;
    }
   
    function renewLeaseOwner(bool _decision) public onlyOwner{
    renewLease=_decision;
    require(currentTenant.renewLease==true,"Tenant has not agreed to renew Lease");
    monthlyrent+=monthlyrent*incrementRate/100;                                                  
    }
    function terminateLease()public onlyOwnerOrCurrentTenant {
        bool wrongTermination;
        if(currentTenant.endDate>block.timestamp){
            wrongTermination=true;
        }
        else{
            wrongTermination=false;
        }
        
        if(wrongTermination==true){
          
        if(msg.sender ==owner){
                // transfer security deposit to tenant 
                // make rent due 0
                // return advance to tenant 
        }
        else{    
            // transfer security deposit to owner 
            // transfer advance to owner
        }
        
        }
        else{
           
           // transfer security deposit - fine - rent due to tenant
          // transfer advance to owner
        }
        leaseState=StateLeaseContract.inactive;}



    function handleDispute() public {       }
    function transferSecurityDeposit() private {
       
    }
    function transferOwnership(address newOwner) public onlyOwner {
        owner =newOwner;        }

    
}