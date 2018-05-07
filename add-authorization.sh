# vim: set shiftwidth=4 tabstop=4 expandtab:

QB_REST_API=http://drcis.dyn.rarus.ru:8810/rest
GROUP=$1
shift

GROUP_ID=$(curl -n -s $QB_REST_API/ids?group_name=$GROUP)

if test -z "$GROUP_ID"
then
    echo Cannot determine group id for \"$GROUP\" >&2
    exit
fi

for conf in $@
do
    CONFIG_ID=$(curl -n -s $QB_REST_API/ids?configuration_path=root/$conf)
    if test -z "$CONFIG_ID"
    then
        echo Cannot determine config id for \"$conf\" >&2
        continue
    fi
    AUTH_FILE=/tmp/qb-add-auth-$GROUP_ID-$CONFIG_ID.xml
    cat > $AUTH_FILE <<AUTH
<com.pmease.quickbuild.model.Authorization>
  <group>$GROUP_ID</group>
  <configuration>$CONFIG_ID</configuration>
  <permissions>
    <string>1</string>
    <string>4</string>
  </permissions>
</com.pmease.quickbuild.model.Authorization>
AUTH
    curl -s -n $QB_REST_API/authorizations -d@"$AUTH_FILE" -v
done
