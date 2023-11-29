SPARK_MASTER_HOST=$(hostname -i)
spark-submit \
  --master spark://$SPARK_MASTER_HOST:7077 \
  --deploy-mode client \
  --driver-memory 1g \
  --executor-memory 1g \
  --executor-cores 1 \
  --conf spark.driver.bindAddress=$SPARK_MASTER_HOST \
  --conf spark.driver.host=$SPARK_MASTER_HOST \
  /examples/pi.py