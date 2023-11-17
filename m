Return-Path: <netdev+bounces-48690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5B7EF40A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49E9280DB9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9005231A97;
	Fri, 17 Nov 2023 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRvQmqdI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B9127
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:08:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so9776a12.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700230128; x=1700834928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KBGDX6j/B/n0nn/41RA87GyPU3EosPCA6wqp7qNWbA=;
        b=uRvQmqdI7KxV9DM8YjaWFwjPiFmgmrpQ66z/hko3aj7XRwm8UnnO3IL6l1fq99eNiF
         J6ULP3WoqIy6bXzM/l8DCvezkAqI+XUs8RNI5XsJANP3DPxr13j1+ADt/hWUXSO3mBYZ
         4EC2ZDPjWWCodjGFcFq7b2Mu2YolV8Dj0dxnZ3ttVZoRtB8VxD0dGzxlfSzsc5kP1BFT
         yXnn2eCGWI9l2kMMPHS0gzSYy7dPnP4WmwH2wIa21RElLcjMxaVq0PFNJqz+36uzLKat
         RIVmtFVZY20qy1GwtPuPzUWeKw0cAJF/UIg7ri8yo2Oqs3iRKb5uOuqC87MRDG2mAZWm
         +6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230128; x=1700834928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KBGDX6j/B/n0nn/41RA87GyPU3EosPCA6wqp7qNWbA=;
        b=aLlSijcLtAQX6YRnIlfMtmJ96gw12EWq1M1uioCDxvnFdwCCVmFxv+o/l+9skqYZV1
         UBB4qVp8zScMCbhK8oVeQeGvZl0PRc4i/hQdNjT5/WCN+jDtUwWBCvxV45vPB8v7sEH7
         WrsYkZI1pU0Tyfru/yXYLkmtT+mcgoUOkNZNIy5degAP4sKJkZUQ6r5/law/kfQ4lDcb
         JWmGwQMnQR6uiPVGvS08h1stcN6bdeBp4O8jCSDJVv34gVC3LJZLFA8OLK0no9jnvl7A
         fF/VF8kvIbaERGy8p08SD7nKdnZ9+3Yo6EOKvel+YxG10Ak3f3LWg0VC8RaBWXnkCU6R
         a1kg==
X-Gm-Message-State: AOJu0Yx6IBGiVRLZTckyXhXxvsRC+Z4JF9SbV3Waz/YQbYmkDKAkjtGr
	2H3eNQ2UID9B1F+OmTP5LQ1nw0yB+J+CUiiCls9meA==
X-Google-Smtp-Source: AGHT+IFmT+fbSR4ajkCsueMkfa15i1sZk+ay1qc0/+xeGtVjugm1myRM2cquESbPiIJF+TR7WQ2q4jNFYvzjln05XVc=
X-Received: by 2002:aa7:c954:0:b0:545:279:d075 with SMTP id
 h20-20020aa7c954000000b005450279d075mr108946edt.1.1700230127528; Fri, 17 Nov
 2023 06:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116100217.2654521-1-edumazet@google.com> <ZVbDN0RPnb/5n/Ka@Laptop-X1>
In-Reply-To: <ZVbDN0RPnb/5n/Ka@Laptop-X1>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Nov 2023 15:08:33 +0100
Message-ID: <CANn89iJkFj8R7V1LOSZnVkhPDNJ5EjM_Djb42LWdUvnfwXHxWw@mail.gmail.com>
Subject: Re: [PATCH net] wireguard: use DEV_STATS_INC()
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 2:34=E2=80=AFAM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> On Thu, Nov 16, 2023 at 10:02:17AM +0000, Eric Dumazet wrote:
> > wg_xmit() can be called concurrently, KCSAN reported [1]
> > some device stats updates can be lost.
> >
> > Use DEV_STATS_INC() for this unlikely case.
> >
> > [1]
> > BUG: KCSAN: data-race in wg_xmit / wg_xmit
> >
> > read-write to 0xffff888104239160 of 8 bytes by task 1375 on cpu 0:
> > wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> > __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> > netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> > xmit_one net/core/dev.c:3543 [inline]
> > dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> > ...
> >
> > read-write to 0xffff888104239160 of 8 bytes by task 1378 on cpu 1:
> > wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
> > __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
> > netdev_start_xmit include/linux/netdevice.h:4932 [inline]
> > xmit_one net/core/dev.c:3543 [inline]
> > dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
> > ...
> >
> > Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  drivers/net/wireguard/device.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/dev=
ice.c
> > index 258dcc1039216f311a223fd348295d4b5e03a3ed..deb9636b0ecf8f47e832a0b=
07e9e049ba19bdf16 100644
> > --- a/drivers/net/wireguard/device.c
> > +++ b/drivers/net/wireguard/device.c
> > @@ -210,7 +210,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, str=
uct net_device *dev)
> >        */
> >       while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PAC=
KETS) {
> >               dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
> > -             ++dev->stats.tx_dropped;
> > +             DEV_STATS_INC(dev, tx_dropped);
> >       }
> >       skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
> >       spin_unlock_bh(&peer->staged_packet_queue.lock);
> > @@ -228,7 +228,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, str=
uct net_device *dev)
> >       else if (skb->protocol =3D=3D htons(ETH_P_IPV6))
> >               icmpv6_ndo_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNR=
EACH, 0);
> >  err:
> > -     ++dev->stats.tx_errors;
> > +     DEV_STATS_INC(dev, tx_errors);
> >       kfree_skb(skb);
> >       return ret;
> >  }
> > --
> > 2.43.0.rc0.421.g78406f8d94-goog
> >
>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
>
> BTW, what about the receive part function wg_packet_consume_data_done(), =
do
> we need to use DEV_STATS_INC()?

You are right, I will send a v2

(wg_packet_purge_staged_packets() also needs to be changed)

