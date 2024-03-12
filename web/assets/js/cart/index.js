const updateButton = document.getElementsByClassName("update_cart-btn");
for (let i = 0; i < updateButton.length; i++) {
    updateButton[i].addEventListener("click", handleClick);
}

function handleClick(e) {
    const updateForm = document.getElementById(`update_cart-form-${e.target.id}`);
    updateForm.submit();
}