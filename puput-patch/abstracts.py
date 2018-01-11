import datetime

from django.db import models
from django.utils.translation import ugettext_lazy as _

from wagtail.wagtailadmin.edit_handlers import FieldPanel, InlinePanel, MultiFieldPanel, PageChooserPanel
from wagtail.wagtailimages.edit_handlers import ImageChooserPanel

from modelcluster.contrib.taggit import ClusterTaggableManager
from wagtail.wagtailcore.fields import RichTextField

from .utils import get_image_model_path

from wagtail.wagtailadmin.edit_handlers import StreamFieldPanel
from wagtail.wagtailimages.blocks import ImageChooserBlock
from wagtail.wagtailcore.fields import StreamField
from wagtail.wagtailcore import blocks
from wagtail.wagtailembeds.blocks import EmbedBlock
from wagtail.wagtailsearch import index
from wagtailcodeblock.blocks import CodeBlock


class ContentStreamBlock(blocks.StreamBlock):
    heading = blocks.TextBlock()
    paragraph = blocks.TextBlock()
    code = CodeBlock(label='Code')


class EntryAbstract(models.Model):
    # body = RichTextField(verbose_name=_('body'))
    new_body = StreamField([
                ('paragraph', blocks.RichTextBlock()),
                ('image', ImageChooserBlock()),
                ('embed', EmbedBlock()),
                ('CodeBlock', ContentStreamBlock()),
            ])
    tags = ClusterTaggableManager(through='puput.TagEntryPage', blank=True)
    date = models.DateTimeField(verbose_name=_("Post date"), default=datetime.datetime.today)
    header_image = models.ForeignKey(get_image_model_path(), verbose_name=_('Header image'), null=True, blank=True,
                                     on_delete=models.SET_NULL, related_name='+', )
    categories = models.ManyToManyField('puput.Category', through='puput.CategoryEntryPage', blank=True)
    excerpt = RichTextField(verbose_name=_('excerpt'), blank=True,
                            help_text=_("Entry excerpt to be displayed on entries list. "
                                        "If this field is not filled, a truncate version of body text will be used."))
    num_comments = models.IntegerField(default=0, editable=False)

    content_panels = [
        MultiFieldPanel([
            FieldPanel('title', classname="title"),
            ImageChooserPanel('header_image'),
            # FieldPanel('body', classname="full"),
            FieldPanel('excerpt', classname="full"),
            StreamFieldPanel('new_body'),
        ], heading=_("Content")),
        MultiFieldPanel([
            FieldPanel('tags'),
            InlinePanel('entry_categories', label=_("Categories")),
            InlinePanel('related_entrypage_from', label=_("Related Entries"),
                        panels=[PageChooserPanel('entrypage_to')]),
        ], heading=_("Metadata")),
    ]

    class Meta:
        abstract = True
