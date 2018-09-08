# -*- coding: utf-8 -*-
"""Update search fields"""
from __future__ import print_function, unicode_literals
from django.core.management.base import BaseCommand, CommandError
from django.apps import apps


class Command(BaseCommand):
    help = 'Update search fields'
    args = "appname [model]"

    def handle(self, app=None, model=None, **options):
        if not app:
            raise CommandError("You must provide an app to update search fields.")

        # check application

        try:
            app_models = apps.get_app_config(app).get_models()
        except LookupError:
            raise CommandError("There is no enabled application matching '{]'.".format(app))

        # get models only with search managers

        app_models_for_process = [x for x in app_models if getattr(x, '_fts_manager', None)]

        if not app_models_for_process:
            raise CommandError("There is no models for processing.")

        # processing

        for m in app_models_for_process:
            print("Processing model %s..." % m, end='')
            m._fts_manager.update_search_field()
            print("Done")
