(() => {
  const dialog = document.querySelector('.lightbox');
  if (!dialog || typeof dialog.showModal !== 'function') return;
  const items = [...document.querySelectorAll('[data-gallery-item]')]
    .sort((a, b) => Number(a.dataset.order) - Number(b.dataset.order));
  const image = dialog.querySelector('.lightbox-image');
  let current = 0;
  let opener;
  function show(index) {
    current = (index + items.length) % items.length;
    const item = items[current];
    image.src = item.dataset.image;
    image.alt = item.querySelector('img').alt;
    dialog.querySelector('#lightbox-title').textContent = item.dataset.title;
    dialog.querySelector('.lightbox-material').textContent = `Materiaal: ${item.dataset.material}`;
    dialog.querySelector('.lightbox-dimensions').textContent = `Afmetingen: ${item.dataset.dimensions}`;
  }
  items.forEach((item, index) => item.addEventListener('click', event => {
    if (event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
    event.preventDefault();
    opener = item;
    show(index);
    dialog.showModal();
  }));
  dialog.querySelector('.lightbox-close').addEventListener('click', () => dialog.close());
  dialog.querySelector('.lightbox-previous').addEventListener('click', () => show(current - 1));
  dialog.querySelector('.lightbox-next').addEventListener('click', () => show(current + 1));
  dialog.addEventListener('click', event => { if (event.target === dialog) dialog.close(); });
  dialog.addEventListener('keydown', event => {
    if (event.key === 'ArrowLeft' || event.key === 'ArrowRight') {
      event.preventDefault();
      show(current + (event.key === 'ArrowLeft' ? -1 : 1));
    }
  });
  dialog.addEventListener('close', () => opener?.focus());
})();
