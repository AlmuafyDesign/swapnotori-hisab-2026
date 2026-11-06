const CACHE='samity-shell-v4';
const BASE=new URL('./',self.registration.scope);
const SHELL=['','index.html','styles.css','app.js','config.js','manifest.json','assets/icon.svg'].map(path=>new URL(path,BASE).href);
self.addEventListener('install',event=>event.waitUntil(caches.open(CACHE).then(cache=>cache.addAll(SHELL))));
self.addEventListener('activate',event=>event.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(key=>key!==CACHE).map(key=>caches.delete(key))))));
self.addEventListener('fetch',event=>{
  const url=new URL(event.request.url);
  if(event.request.method!=='GET'||url.origin!==location.origin)return;
  event.respondWith(
    fetch(event.request)
      .then(response=>{
        if(response.ok){const copy=response.clone();caches.open(CACHE).then(cache=>cache.put(event.request,copy))}
        return response;
      })
      .catch(()=>caches.match(event.request).then(cached=>cached||caches.match(new URL('index.html',BASE).href)))
  );
});
