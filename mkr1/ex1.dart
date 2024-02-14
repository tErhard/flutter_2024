void main() {
  
  double gasVolume = 100; 
  double electricityConsumption = 500; 
  
 
  double gasTariffIncrease = 0.23; 
  double electricityTariffIncrease = 0.15; 
  

  double gasPriceIncrease = gasVolume * gasTariffIncrease;
  double electricityPriceIncrease = electricityConsumption * electricityTariffIncrease;
  
  print('Зростання абонентської плати за газ: ${gasPriceIncrease.toStringAsFixed(2)} гривень');
  print('Зростання абонентської плати за електроенергію: ${electricityPriceIncrease.toStringAsFixed(2)} гривень');
}
