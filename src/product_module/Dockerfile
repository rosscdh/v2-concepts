FROM bitwalker/alpine-elixir:1.4.0

# Set exposed ports
EXPOSE 8880
ENV PORT=8880

ENV MIX_ENV=prod

ADD yourapp.tar.gz ./
RUN tar -xzvf yourapp.tar.gz

USER default

CMD ./bin/yourapp foreground