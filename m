Return-Path: <netdev+bounces-26131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FCC776E5A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 05:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CE11C21445
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFF817;
	Thu, 10 Aug 2023 03:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B77F5
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:11:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2161BFB
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691637083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjSq2/jRZy5vhViCmQhbUeZdXoVE7rcUYsh36jxfIHo=;
	b=VjhS7Dc/C1YOB2FOrQUsttXBw6MGn0JOLHFZpelLCGu6Nxj2Wl8tQ4c7+C0hWONiPAHOiW
	Ykz9gRU/7A9/SvCsN0Hmb3s/Q9iIVkL+G5SQLiNuhl5dHlOBsW5WMcf7jduqg96ewftQV3
	72y96qTwUKn7Klb2KlX5g7pn8Q7DRpY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-OYz6D3TfPLS70aVibUYvYA-1; Wed, 09 Aug 2023 23:11:21 -0400
X-MC-Unique: OYz6D3TfPLS70aVibUYvYA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9b50be2ccso4408541fa.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 20:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691637080; x=1692241880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjSq2/jRZy5vhViCmQhbUeZdXoVE7rcUYsh36jxfIHo=;
        b=MogfAVhvnaLa11pFr3eTs2EZGMmtb9y1pu9j2W3TlGZnZV509i5bW1+FRSaCVaL3jn
         lWS6HoE2eIF2TgcyiBwlnwyG+0QICdmG5RniZGO3L10w6EQZ/GeVeB2Oefibgvaj+3ri
         aVGQDe+ux7IVX4XhUrt8pXqMtmcbuYOiyR2JcXbwXK8I1csg4MRtRnRc4X4lfduo9S/z
         6WJZVrPjaNUEMh95g69LuVUxwjBv4ljk7BDCAWUZYfJK6hQ9Z5T0R0bC38k28K44Igfq
         +dj2X1Gq+z+y8A6guv2jDea9S/O68gPahkpvqK51FOZCKG/M9RkmCv7ijgkg7HnUezXh
         2vZQ==
X-Gm-Message-State: AOJu0YxLR0NGy2SknAVKSLm3dU+u4qkxWJnR9xKxUKHnPbQ0UktdX5XH
	FPJJzz2gvLy7TmDSDwvFvlDMQKqA/+GCZI6IICuWR7XX2NZ1DL7a17gkJQCe09hVMq77QYXQPNX
	zyFxDIhiyg9PoPtwHI5o0oLwKxMfCiYtz
X-Received: by 2002:a2e:99c8:0:b0:2b9:e623:c2d8 with SMTP id l8-20020a2e99c8000000b002b9e623c2d8mr713267ljj.44.1691637080065;
        Wed, 09 Aug 2023 20:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzk68fYfUkbasLCWhJFVsZVjtwL3zuwTfJ/vuTVo0nFCp+aqUEoqlGOG6tDMXmepGT4QFTUr47CTuqGuzptX8=
X-Received: by 2002:a2e:99c8:0:b0:2b9:e623:c2d8 with SMTP id
 l8-20020a2e99c8000000b002b9e623c2d8mr713255ljj.44.1691637079678; Wed, 09 Aug
 2023 20:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809031329.251362-1-jasowang@redhat.com> <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
 <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com> <20230809025039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230809025039-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 11:11:08 +0800
Message-ID: <CACGkMEvHe09tQttaV-eotf+kZMHajLuRJPd0iF6TB-H9xmFNJA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 2:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Aug 09, 2023 at 02:45:17PM +0800, Jason Wang wrote:
> > On Wed, Aug 9, 2023 at 2:23=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > On Tue, 2023-08-08 at 23:13 -0400, Jason Wang wrote:
> > > > Commit 25266128fe16 ("virtio-net: fix race between set queues and
> > > > probe") tries to fix the race between set queues and probe by calli=
ng
> > > > _virtnet_set_queues() before DRIVER_OK is set. This violates virtio
> > > > spec. Fixing this by setting queues after virtio_device_ready().
> > > >
> > > > Fixes: 25266128fe16 ("virtio-net: fix race between set queues and p=
robe")
> > > > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > The patch is needed for -stable.
> > > > ---
> > > >  drivers/net/virtio_net.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 1270c8d23463..ff03921e46df 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -4219,8 +4219,6 @@ static int virtnet_probe(struct virtio_device=
 *vdev)
> > > >         if (vi->has_rss || vi->has_rss_hash_report)
> > > >                 virtnet_init_default_rss(vi);
> > > >
> > > > -       _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > > -
> > > >         /* serialize netdev register + virtio_device_ready() with n=
do_open()
> > > > */
> > > >         rtnl_lock();
> > > >
> > > > @@ -4233,6 +4231,8 @@ static int virtnet_probe(struct virtio_device=
 *vdev)
> > > >
> > > >         virtio_device_ready(vdev);
> > > >
> > > > +       _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > > +
> > > >         /* a random MAC address has been assigned, notify the devic=
e.
> > > >          * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not=
 there
> > > >          * because many devices work fine without getting MAC expli=
citly
> > >
> > > Thanks for the quick fix. Doesn't this fix though bring back the orig=
inal race
> > > that was fixed in commit 25266128fe16 ("virtio-net: fix race between =
set queues
> > > and probe")? Or is being under the same rntl_lock session as register=
_netdev
> > > enough to avoid the race?
> >
> > Yes, rtnl needs to be held for userspace requests to change the number
> > of queues. So we are serialized in this way.
> >
> > Thanks
>
> maybe post v2 adding this in the commit log.

Ok, v2 will be posted soon.

Thanks

>
>
> > >
> > > Thanks,
> > > Dragos
>


