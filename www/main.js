function populateSite(container) {
  const env = container.Env;

  return {
    name: env.UPS_DOCK_NAME || env.VIRTUAL_HOST,
    hosts: env.VIRTUAL_HOST,
    protocol: env.VIRTUAL_PROTO || 'http',
    running: container.State.Running
  }
}

async function fetchSites() {
  const resp = await fetch('/index.json');
  const json = await resp.json();
  return json.map(populateSite).filter(site => site.hosts);
}

function renderSiteList(sites) {
  const siteList = sites.map(site => {
    return site.hosts.split(',').map(host => {
      return `
        <div class="card">
          <div class="card__top">
            <div class="status ${site.running && 'on'}"></div>
            <h2>${site.name}</h2>
            <pre>${host}</pre>
          </div>
          <div class="card__bottom">
            <a href="${site.protocol}://${host}" target="_blank">Visit Site</a>
          </div>
        </div>
      `;
    }).join('\n');
  }).join('\n');

  document.getElementById('site-list').innerHTML = siteList;
}

fetchSites().then(renderSiteList);
