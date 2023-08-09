Return-Path: <netdev+bounces-25655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE277507C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B9E28199B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DB624;
	Wed,  9 Aug 2023 01:43:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4D376
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:43:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C742C19AF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691545401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0milLMTfaMNwV+pkxME5lLLZH3Tw9BxNkPloaCPzUwI=;
	b=Wl7wRq8TZyeP99XhOLSuQfYEoBImBPsVcwawKy2CRwneLEPmlBVxidj7JHu7G1CJEy6/Ae
	SgawXUX9khM5ApFqKqcwHVofJ/rPO9POHKk689BT8tHY9lNxKT5ufviTwHMrLCWqD7D0FV
	PDp23RYrL0MVbD6Djz7Hmrt0Stdmj50=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-IpLRrA2ZPC2n-q1YY1hHVQ-1; Tue, 08 Aug 2023 21:43:17 -0400
X-MC-Unique: IpLRrA2ZPC2n-q1YY1hHVQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9bcf13746so66826291fa.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 18:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691545396; x=1692150196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0milLMTfaMNwV+pkxME5lLLZH3Tw9BxNkPloaCPzUwI=;
        b=js6E7zUlZndXQboAgqbtCQWkmxCt6yCiSLPD8mY49Tvm11t65APIzjXt0+s6aEv8U4
         dZjVv5ry1vj+Wyf73HY75TEoAHS+D2FMBqZxYyhWES0t+k5cLTyXWdCvMlBRm2d/p/1F
         rcMGowZoNOwPM8jTbGWP9vgxJ7wXQwFjv4LW9LN1DLzRTgGNPQ8T4UKVmQP6a9PjNpYI
         NrlsHLPM9WL758Qs0HLmEmBZui8uzuD0jE9CMzXIx0MEXpY+bmDOwX9z6TqfuGk1/eHQ
         RVY+OstaLGOCG8PKpUHYPB0GwvA1wboWup9SrHaMJzkktxpAw8dZ/lW/i7ebmFuXKmRg
         OYzg==
X-Gm-Message-State: AOJu0YyX/27pAhKo/Dslv4A5oGqYnufVKEIW6jKSI9F0U8v/ZLsfd2yt
	eQoKIbXDBHHoZ3mos848EpbC2hF8CzYe2Q8Do95Xr7Xoxu+kLsrzLi2NrCzOv7MkdagzAGCgr5Y
	OdzcxGb3kDUQxXAxNDPdWaovKqkX0owX3
X-Received: by 2002:a2e:a0d0:0:b0:2b9:afd1:b77a with SMTP id f16-20020a2ea0d0000000b002b9afd1b77amr781218ljm.0.1691545395933;
        Tue, 08 Aug 2023 18:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF11DqwutQb2zmy1I9zWiJXkEyFGxV+VUJ1RL/ZEvmwVFq1I/11YA4CKyXEynCjNHKyqVxR0nnXTRmIF85/CBg=
X-Received: by 2002:a2e:a0d0:0:b0:2b9:afd1:b77a with SMTP id
 f16-20020a2ea0d0000000b002b9afd1b77amr781206ljm.0.1691545395631; Tue, 08 Aug
 2023 18:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725072049.617289-1-jasowang@redhat.com> <e1fcd1a2ca22bc09387e162e22c61e54fe8c57ca.camel@nvidia.com>
In-Reply-To: <e1fcd1a2ca22bc09387e162e22c61e54fe8c57ca.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Aug 2023 09:43:04 +0800
Message-ID: <CACGkMEunLBK2VPpp_TVn-=SZjt4p3NTx0_iL=nLQz1EmceMWTA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 7:35=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Tue, 2023-07-25 at 03:20 -0400, Jason Wang wrote:
> > A race were found where set_channels could be called after registering
> > but before virtnet_set_queues() in virtnet_probe(). Fixing this by
> > moving the virtnet_set_queues() before netdevice registering. While at
> > it, use _virtnet_set_queues() to avoid holding rtnl as the device is
> > not even registered at that time.
> >
> > Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
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
> >         if (vi->has_rss || vi->has_rss_hash_report)
> >                 virtnet_init_default_rss(vi);
> >
> > +       _virtnet_set_queues(vi, vi->curr_queue_pairs);
> > +
> >         /* serialize netdev register + virtio_device_ready() with ndo_o=
pen()
> > */
> >         rtnl_lock();
> >
> > @@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                 goto free_unregister_netdev;
> >         }
> >
> > -       virtnet_set_queues(vi, vi->curr_queue_pairs);
> > -
> >         /* Assume link up if device can't report link status,
> >            otherwise get link status from config. */
> >         netif_carrier_off(dev);
>
> This change seems to break mlx5_vdpa when using virtio_vdpa.
> _virtnet_set_queues() hangs. Because DRIVER_OK has not yet been set, mlx5=
_vdpa
> cvq kick handler will ignore any commands.
>

Yes, I will post a fix soon.

Thanks


