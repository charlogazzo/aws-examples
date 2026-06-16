FROM public.ecr.aws/lambda/python:3.12

COPY function/index.py function/requirements.txt /var/task/

RUN python3.12 -m pip install -r /var/task/requirements.txt --target /var/task

CMD ["function.handler"]
