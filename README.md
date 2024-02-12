```shell
# Generate types
$ supabase gen types typescript --linked --schema=public > utils/database.types.ts
$ supabase gen types typescript typescript --local --schema=public > ../../Projects/Yeko/yeko_admin/lib/supabase/database.types.ts

# Local logs
$ docker exec -it supabase_db_supabase-dev ls -la /var/log/postgresql
```
