const LIMIT = 6;

const categoriesForm = document.getElementById("category-form");
categoriesForm.addEventListener("submit", handleSubmit);

const searchForm = document.getElementById("search-form");
searchForm.addEventListener("submit", handleSubmit);

const orderSelection = document.getElementById("order-selection");
orderSelection.addEventListener("change", handleChange);

const paginationItems = document.getElementsByClassName("pagination-item");
for (let i = 0; i < paginationItems.length; i++) {
  paginationItems[i].addEventListener("click", handleClick);
}

function handleSubmit(event) {
  event.preventDefault();
  const hiddenSearchInput = document.createElement("input");
  hiddenSearchInput.type = "hidden";
  hiddenSearchInput.name = "search";
  hiddenSearchInput.value = searchForm.elements["search"].value;
  categoriesForm.appendChild(hiddenSearchInput);
  const hiddenOrderInput = document.createElement("input");
  hiddenOrderInput.type = "hidden";
  hiddenOrderInput.name = "order";
  hiddenOrderInput.value = orderSelection.value;
  categoriesForm.appendChild(hiddenOrderInput);
  categoriesForm.submit();
}

function handleChange(event) {
  handleSubmit(event);
}

function handleClick(event) {
  const hiddenOffsetInput = document.createElement("input");
  hiddenOffsetInput.type = "hidden";
  hiddenOffsetInput.name = "offset";
  hiddenOffsetInput.value = (Number.parseInt(event.target.value) - 1) * LIMIT;
  categoriesForm.appendChild(hiddenOffsetInput);
  const hiddenLimitInput = document.createElement("input");
  hiddenLimitInput.type = "hidden";
  hiddenLimitInput.name = "limit";
  hiddenLimitInput.value = LIMIT;
  categoriesForm.appendChild(hiddenLimitInput);
  const hiddenOrderInput = document.createElement("input");
  hiddenOrderInput.type = "hidden";
  hiddenOrderInput.name = "order";
  hiddenOrderInput.value = orderSelection.value;
  categoriesForm.appendChild(hiddenOrderInput);
  const hiddenSearchInput = document.createElement("input");
  hiddenSearchInput.type = "hidden";
  hiddenSearchInput.name = "search";
  hiddenSearchInput.value = searchForm.elements["search"].value;
  categoriesForm.appendChild(hiddenSearchInput);
  categoriesForm.submit();
}
