Return-Path: <netdev+bounces-21122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E9762857
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBA21C21082
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0D1118;
	Wed, 26 Jul 2023 01:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CC7C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:55:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1469226A8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690336508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWu3B8vvWTlSK2/gVzv/iHW5SwZZZ1PnJ4r4lJp+rz4=;
	b=DvmeigSAit7lbxGRWoHnrVHadouGqxeTh8zuU53pgbaj1ttC5DVQVY1T3S8Yep4hm7dAHg
	CLkYo09J499xfvWMKE8Pjo9Aa1/3SVkRmk17f6rm1NFWkqR3xqAh8WNsvLEQOsxRmITrtg
	mejmW1y98BAhPXDezm+gVEXkC++aNJs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-PNwBxu60PjKyOYIpCrlbPw-1; Tue, 25 Jul 2023 21:55:05 -0400
X-MC-Unique: PNwBxu60PjKyOYIpCrlbPw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b93faa81c9so51881971fa.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690336504; x=1690941304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWu3B8vvWTlSK2/gVzv/iHW5SwZZZ1PnJ4r4lJp+rz4=;
        b=AQJWtcb0Y5leAqkFX2KWZX7tSxhgEqmKTS4TrW2OT3auy4jbYL/RRP0Y1pbw6NEJ/q
         NL2byc4xsf1V+N1R2yZbUdmbsCHtwAHKFqzEyNJycmypt4YTtAvhl/wZX1u14Y6MGbPN
         Itm068c69tSsSmtMwWmNqZufI1G1VjT8IAMwhmNpVjTbVki5BL/acCoHwqA6HNCh0Y+L
         0R52GCgRfZJBlzNS69ZuOFcZREebDKt5CwOh84LWI1hA5q9yJN75OBKXd02WKVsfPHva
         lHIub4AQp93vasgWQskof2muuqAKE4rziT7TPrJofzZgsX/h7Z4O45ZvxM8fWXjGf1ds
         +c3Q==
X-Gm-Message-State: ABy/qLawXVD9E3l3jh8BBZlGsYxG+x8jxgiRJo/fSHCiuTmAs0JIndNi
	qKfvCwr6h4iZRxHKgYmfNg//o8EbS2ZpcBkZayMXkbPliJ490BiA2OUPDZijO3MObSPQA/vNj9R
	e9At5HCCpvg2aLtO20cJSHxzu7IoKNX+2
X-Received: by 2002:a2e:6e11:0:b0:2b9:563b:7e3a with SMTP id j17-20020a2e6e11000000b002b9563b7e3amr376807ljc.32.1690336504551;
        Tue, 25 Jul 2023 18:55:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGePGkE9JcftKxT8qFEJKD005x07vC0fBPJh6B4t54XQVLeK2VokVl+UKA76A5++jaxgO3jPiakibc6Rmslffg=
X-Received: by 2002:a2e:6e11:0:b0:2b9:563b:7e3a with SMTP id
 j17-20020a2e6e11000000b002b9563b7e3amr376799ljc.32.1690336504212; Tue, 25 Jul
 2023 18:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725072049.617289-1-jasowang@redhat.com> <20230725035120-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230725035120-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 09:54:52 +0800
Message-ID: <CACGkMEszSRxefFqfoDzpyUV2b6+zKKotXKVUOgxpihDyfk9FgQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 3:53=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jul 25, 2023 at 03:20:49AM -0400, Jason Wang wrote:
> > A race were found where set_channels could be called after registering
> > but before virtnet_set_queues() in virtnet_probe(). Fixing this by
> > moving the virtnet_set_queues() before netdevice registering. While at
> > it, use _virtnet_set_queues() to avoid holding rtnl as the device is
> > not even registered at that time.
> >
> > Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> stable material I guess?

Yes it is.

Thanks

>
> > ---
> >  drivers/net/virtio_net.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0db14f6b87d3..1270c8d23463 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4219,6 +4219,8 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >       if (vi->has_rss || vi->has_rss_hash_report)
> >               virtnet_init_default_rss(vi);
> >
> > +     _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > +
> >       /* serialize netdev register + virtio_device_ready() with ndo_ope=
n() */
> >       rtnl_lock();
> >
> > @@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >               goto free_unregister_netdev;
> >       }
> >
> > -     virtnet_set_queues(vi, vi->curr_queue_pairs);
> > -
> >       /* Assume link up if device can't report link status,
> >          otherwise get link status from config. */
> >       netif_carrier_off(dev);
> > --
> > 2.39.3
>


