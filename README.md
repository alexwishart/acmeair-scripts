# acmeair-scripts

Scripts for conveniently executing AcmeAir.

The default paths in these scripts and examples below assume you will be working in `$HOME/acmeair`. Adjust the values in the scripts to suit your environment.

### Set up database

- Get MongoDB v3, install locally.
- Edit `mongo_ramdisk.sh` and adjust `MONGO_ROOT` to the location of your Mongo install.
- Adjust (or remove) `DB_AFFINITY` as appropriate to suit your system.
- Run `mongo_ramdisk.sh start` which will create a ramdisk and start MongoDB with a blank database on it.  (Note, this requires `sudo` permissions for creating the ramdisk)

Other commands for `mongo_ramdisk.sh`: stop the database with `stop`, check if it's running with `status`, or get a MongoDB shell with `shell`.

### Set up Node.js AcmeAir implementation
```
cd $HOME/acmeair
git clone https://github.com/acmeair/acmeair-nodejs.git
```
Edit `acmeair-nodejs/settings.json` and change:
- `mongoHost` - hostname for your database server
- `useDevLogger` - set to `false` to disable verbose logging of requests

Edit `acmeair-nodejs/loader/loader-settings.json` and change:
- `MAX_DAYS_TO_SCHEDULE_FLIGHTS` to 30

This is required to populate the database with enough flight data for the JMeter driver, which will issue queries for flights up to 30 days from today.

### Populate the database

Run `loaddb-nodejs.sh`, which will start the Node.js implementation, then access the http://localhost:9080/rest/api/loader/load URL to populate the database.

### Resetting the database

Between runs, you can quickly reset the database back to a pristine state by running `resetdb.sh`, which will run `mongo_ramdisk.sh stop`, `start` and `loaddb-nodejs.sh` for you.

### Measuring Node.js

`runnode.sh` (in one terminal)
`runclient.sh` (in another terminal)
