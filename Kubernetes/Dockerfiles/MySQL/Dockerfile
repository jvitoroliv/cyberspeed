# Use the Bitnami MySQL image as the base
FROM bitnami/mysql:8.0.36-debian-12-r8

# Run as non-root user
USER 1001

# Set environment variables for better security
ENV MYSQL_RANDOM_ROOT_PASSWORD=yes \
    MYSQL_AUTHENTICATION_PLUGIN=caching_sha2_password

# Copy your custom MySQL configuration file
COPY my.cnf /opt/bitnami/mysql/conf/my.cnf

# Start MySQL using a custom entrypoint script
COPY custom-entrypoint.sh /custom-entrypoint.sh
ENTRYPOINT ["/custom-entrypoint.sh"]
CMD ["mysqld"]

# Ensure the script and configuration file are owned by the non-root user
RUN chown 1001:1001 /custom-entrypoint.sh /opt/bitnami/mysql/conf/my.cnf
