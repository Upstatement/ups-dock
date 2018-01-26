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
        const off = site.running ? '' : ' (Stopped)';
        return site.hosts.split(',').map(host => {
            return `<li><a href="${site.protocol}://${host}">${site.name}${off}</a></li>`;
        }).join('\n');
    }).join('\n');

    document.getElementById('site-list').innerHTML = siteList;
}

fetchSites().then(renderSiteList);
