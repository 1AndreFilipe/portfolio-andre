const filterButtons = [...document.querySelectorAll('[data-filter]')];
const cards = [...document.querySelectorAll('.project')];
function filterProjects(category) {
  let count = 0;
  cards.forEach(card => {
    const visible = category === 'all' || card.dataset.category === category || (category === 'digital' && ['design','photo'].includes(card.dataset.category));
    card.hidden = !visible;
    if (visible) count++;
  });
  filterButtons.forEach(button => button.setAttribute('aria-pressed', String(button.dataset.filter === category)));
  const status = document.querySelector('#filter-status'); if (status) status.textContent = `${count} trabalhos apresentados`;
}
filterButtons.forEach(button => button.addEventListener('click', () => filterProjects(button.dataset.filter)));
const initialFilter = document.body.dataset.initialFilter;
if (initialFilter) { filterProjects(initialFilter); requestAnimationFrame(() => document.querySelector('#projects').scrollIntoView({behavior:'instant'})); }
const dialog = document.querySelector('#project-dialog');
const categoryNames = {social:'Redes sociais',design:'Design digital',photo:'Fotografia & edição',web:'Web design'};
document.querySelectorAll('[data-project]').forEach(button => button.addEventListener('click', () => {
  const project = projects[Number(button.dataset.project)];
  document.querySelector('#dialog-title').textContent = project.title;
  document.querySelector('#dialog-category').textContent = categoryNames[project.cat];
  document.querySelector('#dialog-description').textContent = project.desc;
  const image = document.querySelector('#dialog-image'); image.src = project.image; image.alt = project.title;
  const visit = document.querySelector('#dialog-visit'); visit.hidden = !project.url; if(project.url) visit.href = project.url;
  document.querySelector('#dialog-download').href = project.image;
  dialog.showModal(); document.body.classList.add('modal-open');
}));
document.querySelector('.close-dialog').addEventListener('click', () => dialog.close());
dialog.addEventListener('click', event => {if(event.target === dialog){const box=dialog.getBoundingClientRect();if(event.clientX<box.left||event.clientX>box.right||event.clientY<box.top||event.clientY>box.bottom)dialog.close();}});
dialog.addEventListener('close', () => document.body.classList.remove('modal-open'));
