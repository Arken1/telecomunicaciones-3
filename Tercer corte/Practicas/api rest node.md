# API REST

## Node.js

Instalamos Node.js mediante `nvm` [^1]

```apache
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
nvm --version
nvm ls
nvm ls-remote
nvm install 16.11.1
```

Comprovamos la version de `npm`

```apache
nmp -v
```

## clonamos git

```apache
git clone https://github.com/miguel-rondon/api-rest.git
```

## Ejecutamos servicio

```apache
npm run dev
```

## Referencias

[^1]: https://phoenixnap.com/kb/update-node-js-version