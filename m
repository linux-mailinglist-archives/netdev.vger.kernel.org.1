Return-Path: <netdev+bounces-25699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58870775339
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4304C1C210FF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E93812;
	Wed,  9 Aug 2023 06:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63427F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:51:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D85B133
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691563862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w/nEU7noPALINH6/4nqQIqQSMTGun1SlIDSuNUh4s1g=;
	b=f37QHqT1Ug16d0pPKbaT9h1Bsq61iTkJ/p8s5Ec9ZTzb0z1jKEEF0KlaBfyFcZt9aK4tdK
	WGK2PJVAWwfR2hpfzf7SVUUOzQ/a1PNeKad8UwW/lVTjX4r3+k5Gtz6fox6X93/Z4w8QN7
	a6NBjCn+8hsmn1zcbk1Lq5uu1DOQQEM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6tnr_NuyPi6bxPXCYWml5A-1; Wed, 09 Aug 2023 02:51:01 -0400
X-MC-Unique: 6tnr_NuyPi6bxPXCYWml5A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-997c891a88dso456123966b.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 23:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563860; x=1692168660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/nEU7noPALINH6/4nqQIqQSMTGun1SlIDSuNUh4s1g=;
        b=GD96OKwKBGKVQQsDiuQXzCEtFfd7xPOw7w7x7cZxtlIw/WwfCykmGgXnMQvAsh87Tg
         SB8v5iGx7KuHP4YfTknxkYFQpybJxoOa42HEDI/eahEHNPLIUeHwZzn1zmlA6ZpBinmu
         KBt+45TzCz7NVdTr3rUpKjLvjlQccz7udKDcoYdOMIpjm0jmSwuO0pElfKXCBETi+OMY
         W2hW7odM7OQYlpNYEB/ojjdw4g/HUur5jkhnnptCigH7uCzwXyAget1Fybam8HbubWcA
         xoAWR8qShmmOVMvqUw/Gt8OWOmYcW9QFLhI5J6qhdwn784+b8t4g+POY4wAqfSsPDW1w
         q4Zg==
X-Gm-Message-State: AOJu0Yx1jjsVyTzjCH54vqosinJXa+TS0RGYS/Kv6atgTabfT61edaA/
	7PSMWTQli9FTxKbzm5whwbqBQrIcJUhlvxz4HKHg14cH0inqxC02glLQViCFbzNcXUdxGKRddpy
	L5lIzGEnWMa8qULHK
X-Received: by 2002:a17:906:5356:b0:96a:63d4:24c5 with SMTP id j22-20020a170906535600b0096a63d424c5mr1275926ejo.77.1691563859966;
        Tue, 08 Aug 2023 23:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFT08LSEXNfTTejf1CndLl/NlP49/szNnPfJQexLpnHSciLvGOx9gyDFsaR7QCEUj/Ah4kzQ==
X-Received: by 2002:a17:906:5356:b0:96a:63d4:24c5 with SMTP id j22-20020a170906535600b0096a63d424c5mr1275917ejo.77.1691563859692;
        Tue, 08 Aug 2023 23:50:59 -0700 (PDT)
Received: from redhat.com ([2.52.159.103])
        by smtp.gmail.com with ESMTPSA id le3-20020a170907170300b0099cf840527csm1614058ejc.153.2023.08.08.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:50:58 -0700 (PDT)
Date: Wed, 9 Aug 2023 02:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
Message-ID: <20230809025039-mutt-send-email-mst@kernel.org>
References: <20230809031329.251362-1-jasowang@redhat.com>
 <66687029c1235e56d9279800ceb026dca029c966.camel@nvidia.com>
 <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvETiKpx3-EsVejLe9EkSroaoFjJkLBEMmh71YU+1GjGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 02:45:17PM +0800, Jason Wang wrote:
> On Wed, Aug 9, 2023 at 2:23 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Tue, 2023-08-08 at 23:13 -0400, Jason Wang wrote:
> > > Commit 25266128fe16 ("virtio-net: fix race between set queues and
> > > probe") tries to fix the race between set queues and probe by calling
> > > _virtnet_set_queues() before DRIVER_OK is set. This violates virtio
> > > spec. Fixing this by setting queues after virtio_device_ready().
> > >
> > > Fixes: 25266128fe16 ("virtio-net: fix race between set queues and probe")
> > > Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > The patch is needed for -stable.
> > > ---
> > >  drivers/net/virtio_net.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 1270c8d23463..ff03921e46df 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -4219,8 +4219,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >         if (vi->has_rss || vi->has_rss_hash_report)
> > >                 virtnet_init_default_rss(vi);
> > >
> > > -       _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > -
> > >         /* serialize netdev register + virtio_device_ready() with ndo_open()
> > > */
> > >         rtnl_lock();
> > >
> > > @@ -4233,6 +4231,8 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >
> > >         virtio_device_ready(vdev);
> > >
> > > +       _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > > +
> > >         /* a random MAC address has been assigned, notify the device.
> > >          * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
> > >          * because many devices work fine without getting MAC explicitly
> >
> > Thanks for the quick fix. Doesn't this fix though bring back the original race
> > that was fixed in commit 25266128fe16 ("virtio-net: fix race between set queues
> > and probe")? Or is being under the same rntl_lock session as register_netdev
> > enough to avoid the race?
> 
> Yes, rtnl needs to be held for userspace requests to change the number
> of queues. So we are serialized in this way.
> 
> Thanks

maybe post v2 adding this in the commit log.


> >
> > Thanks,
> > Dragos


