function price (){
  const itemPrice  = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const priceVal = itemPrice.value;
    const addTaxPrice  = document.getElementById("add-tax-price");
    const tax = 10 / 100
    addTaxPrice .innerHTML = Math.round(priceVal * tax);
    const profit  = document.getElementById("profit");
    profit .innerHTML = Math.round(priceVal - priceVal * tax);
  });
};

window.addEventListener('turbo:load', price);
