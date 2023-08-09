Return-Path: <netdev+bounces-25693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0C775312
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B0B281A5D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B3812;
	Wed,  9 Aug 2023 06:45:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA407F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:45:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915DD10CF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691563531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jIXkVLB4rrGO+avob3qbzgF9vUBthDptdSLeSwUlj4=;
	b=C6/+gwc5sBvB6OYmFhzAivQDwdZmnQ/Z+QOJMhnjJcPQt1j1MWe6CPNKfMe5RQNHL6TApz
	teQ1GD9o374n4xCspEfLBxatuyFiMCt/rBTozrTuwFvBckrwiOYUb0+tRSZOe96tvVStdk
	2vja0+R0rwgavU9vAx1zIGbzl1TItlA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-q042ozIyO7OJuBX937n8Aw-1; Wed, 09 Aug 2023 02:45:30 -0400
X-MC-Unique: q042ozIyO7OJuBX937n8Aw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9fa64db5cso68754601fa.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 23:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563528; x=1692168328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jIXkVLB4rrGO+avob3qbzgF9vUBthDptdSLeSwUlj4=;
        b=AmPnancLKnWGKSzeH4xuSHfVqLl7x4xEH7uYWdupzowYJ7v/z92fKmNZ8yKHgdqJab
         kdzBAiu0/l159GHM1dLrZmbNkrU22qaBxNpWPi4T+y4JC8lEduiNFVhmSdgZhEZ5l1WO
         MI39Oyet0XYLQNnq53bAdfY2bs5yW7M0ZlTyfM1xg+bciY/pZ7y0uD1uPo4dtQIOtzCU
         hANikQgsDMWKeHBykO55klhUxTB0UAI/s6+Tv4VSJdd2MJ409p8z1RAJfTILSanveoXv
         x+VBrRqEMT5GR6tQKuP3YIroh0EjdlSNvcO2qXyEA0lDruIM0L77dTjTQ1CFJS5i+4GU
         kG3Q==
X-Gm-Message-State: AOJu0YygcMcI7hn9ZESdcA+lR1bgExm7YRIgP4wSBpGUJJg6ZCGJsMAC
	e+maQneofog2+y+zTOLTT2yYUpM4AZN/q5nJPjJFVG3Pi7F/AszMui9sy5VETvVaauCpgl8bVTA
	rgpY45rNlQZg6V4zuSfuIrqrk3SQSsfz6
X-Received: by 2002:a2e:b0cd:0:b0:2b6:af60:6342 with SMTP id g13-20020a2eb0cd000000b002b6af606342mr1219914ljl.40.1691563528705;
        Tue, 08 Aug 2023 23:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvXeU+hxOVRt+CjlcsX7U6pemirFfRHkIQ9j8Slm/Egwbs4YChsWclSdSyBCMCtLu2v2IyFxkKcM6l2BwBwMU=
X-Received: by 2002:a2e:b0cd:0:b0:2b6:af60:6342 with SMTP id
 g13-20020a2eb0cd000000b002b6af606342mr1219907ljl.40.1691563528358; Tue, 08
 Aug 2023 23:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809031329.251362-1-jasowang@redhat.com> <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
In-Reply-To: <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Aug 2023 14:45:17 +0800
Message-ID: <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 2:23=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Tue, 2023-08-08 at 23:13 -0400, Jason Wang wrote:
> > Commit 25266128fe16 ("virtio-net: fix race between set queues and
> > probe") tries to fix the race between set queues and probe by calling
> > _virtnet_set_queues() before DRIVER_OK is set. This violates virtio
> > spec. Fixing this by setting queues after virtio_device_ready().
> >
> > Fixes: 25266128fe16 ("virtio-net: fix race between set queues and probe=
")
> > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > The patch is needed for -stable.
> > ---
> >  drivers/net/virtio_net.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1270c8d23463..ff03921e46df 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4219,8 +4219,6 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >         if (vi->has_rss || vi->has_rss_hash_report)
> >                 virtnet_init_default_rss(vi);
> >
> > -       _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > -
> >         /* serialize netdev register + virtio_device_ready() with ndo_o=
pen()
> > */
> >         rtnl_lock();
> >
> > @@ -4233,6 +4231,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >
> >         virtio_device_ready(vdev);
> >
> > +       _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > +
> >         /* a random MAC address has been assigned, notify the device.
> >          * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not the=
re
> >          * because many devices work fine without getting MAC explicitl=
y
>
> Thanks for the quick fix. Doesn't this fix though bring back the original=
 race
> that was fixed in commit 25266128fe16 ("virtio-net: fix race between set =
queues
> and probe")? Or is being under the same rntl_lock session as register_net=
dev
> enough to avoid the race?

Yes, rtnl needs to be held for userspace requests to change the number
of queues. So we are serialized in this way.

Thanks

>
> Thanks,
> Dragos


