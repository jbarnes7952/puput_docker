from __future__ import unicode_literals
import graphene
from graphene_django.converter import convert_django_field

from graphene_django import DjangoObjectType
from puput.models import BlogPage, EntryPage

from django.db import models


class ArticleNode(DjangoObjectType):
    class Meta:
        # model = BlogPage
        model = EntryPage
        only_fields = ['id', 'title', 'date', 'excerpt' ]


class Query(graphene.ObjectType):
    articles = graphene.List(ArticleNode)

    @graphene.resolve_only_args
    def resolve_articles(self):
        # return BlogPage.objects.live()
        return EntryPage.objects.live()


schema = graphene.Schema(query=Query)
