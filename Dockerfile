FROM alpine AS base

RUN apk add g++ make

WORKDIR /vabamorf

COPY apps /vabamorf/apps
COPY dct /vabamorf/dct
COPY lib /vabamorf/lib

RUN cd /vabamorf/apps/cmdline/project/unix && make exe

FROM alpine

RUN apk add libstdc++

COPY --from=base /vabamorf/apps/cmdline/project/unix/etana /usr/bin/
COPY --from=base /vabamorf/apps/cmdline/project/unix/vmeta /usr/bin/
COPY --from=base /vabamorf/apps/cmdline/project/unix/vmyhh /usr/bin/
COPY --from=base /vabamorf/apps/cmdline/project/unix/etdisamb /usr/bin/
COPY --from=base /vabamorf/apps/cmdline/project/unix/etana /usr/bin/
COPY --from=base /vabamorf/apps/cmdline/project/unix/etsyn /usr/bin/
COPY --from=base /vabamorf/apps/cmdline/project/unix/stlspeller /usr/bin/

COPY --from=base /vabamorf/dct/binary/et.dct /vabamorf/et.dct
COPY --from=base /vabamorf/dct/binary/et3.dct /vabamorf/et3.dct