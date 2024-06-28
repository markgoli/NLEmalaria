# # malaria_captioning/celery.py

# from __future__ import absolute_import, unicode_literals
# import os
# from celery import Celery
# import logging

# # Set the default Django settings module for the 'celery' program.
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'malaria_captioning.settings')

# app = Celery('malaria_captioning')

# # Using a string here means the worker doesn't have to serialize
# # the configuration object to child processes.
# # - namespace='CELERY' means all celery-related configuration keys
# #   should have a `CELERY_` prefix.
# app.config_from_object('django.conf:settings', namespace='CELERY')

# # Load task modules from all registered Django app configs.
# app.autodiscover_tasks()

# @app.task(bind=True)
# def debug_task(self):
#     print(f'Request: {self.request!r}')

# # Set up logging
# logger = logging.getLogger('celery')
# logger.setLevel(logging.DEBUG)
# handler = logging.StreamHandler()
# handler.setFormatter(logging.Formatter(
#     '[%(asctime)s: %(levelname)s/%(processName)s] %(message)s'
# ))
# logger.addHandler(handler)
