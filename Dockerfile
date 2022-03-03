# DIFFERENT PURPOSE / CONFIGRATION - PRODUCTION ENVIRONMENT THAN DEVELOPING ENVIRONEMENT
# --------------- BUILD PHASE --------------
FROM node:16-alpine as builder 

WORKDIR "/app"
COPY ./package.json ./ 

RUN npm install 
COPY . . 

RUN npm run build 
# /app/build <-- all the stuff we care about (server to browser with nginx)

# --------------- RUN PHASE --------------
# NEW BLOCK INDICATED BY using another FROM instruction 
FROM nginx 
# i want to copy over something from that other phase (above) + from where (what) to where 
# nginx configuration extra folder - everything inside the folder will be served up when nginx starts up.  
COPY --from=builder /app/build /usr/share/nginx/html

# default command of the nginx container or nginx image is automatically care. 