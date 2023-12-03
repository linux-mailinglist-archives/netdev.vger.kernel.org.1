Return-Path: <netdev+bounces-53298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02227802076
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 03:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98919B20A6F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C39625;
	Sun,  3 Dec 2023 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AdS/7Vcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE3811A
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 18:50:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a06e59384b6so476347066b.1
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 18:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701571823; x=1702176623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6npRnsWkqBdhZbc6M4dSByEnWkDw3CX1ntQyh6JSYSY=;
        b=AdS/7VcxZKbx5RzVBPV5c6c0Ffp/QG+7hcDVPDyLONNrUV7cx5JYB6b5bCuFiJrrK6
         YygSawS6eE5K+jeEmi0iDgcbciMewPuLekLfCQsx58r833Brjg+TNihge5pOdlhYnG6Z
         x5JN5ol2W6aGTaj/3DJh2VsLsAOYw7VBs+epvoa46jjT53g23Y8mP60ci9IaLlvnJTW7
         uBfK2YIMhbnH/1EBUx8Fwj8Tvq+fGKIiuqRZE6OBHI0rODKZL8D4NwuBybGQVPT2fyz3
         sSbAH3Mk/KpygfcMz/SluGnHYizZhVaWi6HoC68/xCBC1M25UpbDY/34uWQWD6KF1fVa
         +0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701571823; x=1702176623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6npRnsWkqBdhZbc6M4dSByEnWkDw3CX1ntQyh6JSYSY=;
        b=GUgK3QfjO8sJsX3XdA70yq3RNf6eINO2UU/QrM17OXBPiECiEoKGVxOq8Erbj4zS4n
         SEmcJ/9NO2B3BkGTbq2Ll9hY6h6xouNndOt39MgsM8b7MAgmvh2y9at6+J1MJaLr0sNt
         4ZRwRV7zwFpgIkCqU9epPL9vfrEOs1eK6tZy7ultBFWljCG5ea65c4zbJ5ovtF6+VbC7
         QLBAZTEvyZrlEUjDqelUD4cGFYrPiewukvpRWhugSo5QAtWU1M2Hzn5kVa8n9B9BhS6a
         q1c3SAKe15D80k1eEj8NDXmGJ5i1iWh37BMD7f9RQ+84C+PUhSWaXdj8aJwI5zcS0TWd
         8ZvQ==
X-Gm-Message-State: AOJu0YyiKpMHIyQB29I8Bnc1OdOTwNCkkAOFO1pHC9DOuMDbFOBzoY7J
	ONotO07yA6OwAGGvLQHYnMdPX8r3dtvKVGNNFdUX4g==
X-Google-Smtp-Source: AGHT+IHWCKbajPDOzc2EJ1n/RHOirXnZrIM6lY1wrd1As3uj0q5lJQ4NYVZawgsgWNzlvYGzmKItLV0vJmDPjgXNDl8=
X-Received: by 2002:a17:906:265a:b0:9ff:9db9:1dc0 with SMTP id
 i26-20020a170906265a00b009ff9db91dc0mr2116273ejc.62.1701571822752; Sat, 02
 Dec 2023 18:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWomqO8m4vVcW+ro@debian.debian> <656b3a1bcd212_1a6a2c294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <656b3a1bcd212_1a6a2c294db@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Sat, 2 Dec 2023 20:50:11 -0600
Message-ID: <CAO3-PboYVv6pGm6ZhNs4ArK=3W-V4XY6EJxcYXGyX=YHwdHW6g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] packet: add a generic drop reason for receive
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Weongyo Jeong <weongyo.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 8:07=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> > from consume_skb to kfree_skb to improve error handling. However, this
> > could bring a lot of noises when we monitor real packet drops in
> > kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> > can be freed, not actual packets.
> >
> > Adding a generic drop reason to allow distinguish these "clone drops".
> >
> > [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxL=
FUK2Zj08A8MrLk9jzg@mail.gmail.com/
> > Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v2->v3: removed an unused variable
> > v1->v2: fixups suggested by Eric Dumazet
> > v2: https://lore.kernel.org/netdev/ZWobMUp22oTpP3FW@debian.debian/
> > v1: https://lore.kernel.org/netdev/ZU3EZKQ3dyLE6T8z@debian.debian/
> > ---
> >  include/net/dropreason-core.h |  6 ++++++
> >  net/packet/af_packet.c        | 26 +++++++++++++-------------
> >  2 files changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 3c70ad53a49c..278e4c7d465c 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -86,6 +86,7 @@
> >       FN(IPV6_NDISC_NS_OTHERHOST)     \
> >       FN(QUEUE_PURGE)                 \
> >       FN(TC_ERROR)                    \
> > +     FN(PACKET_SOCK_ERROR)           \
> >       FNe(MAX)
> >
> >  /**
> > @@ -378,6 +379,11 @@ enum skb_drop_reason {
> >       SKB_DROP_REASON_QUEUE_PURGE,
> >       /** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
> >       SKB_DROP_REASON_TC_ERROR,
> > +     /**
> > +      * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket erro=
rs
> > +      * after its filter matches an incoming packet.
> > +      */
> > +     SKB_DROP_REASON_PACKET_SOCK_ERROR,
> >       /**
> >        * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> >        * shouldn't be used as a real 'reason' - only for tracing code g=
en
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index a84e00b5904b..933fdfaacc44 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2127,7 +2127,7 @@ static int packet_rcv(struct sk_buff *skb, struct=
 net_device *dev,
> >       u8 *skb_head =3D skb->data;
> >       int skb_len =3D skb->len;
> >       unsigned int snaplen, res;
> > -     bool is_drop_n_account =3D false;
> > +     enum skb_drop_reason drop_reason =3D SKB_CONSUMED;
>
> Reverse xmas tree
>
oh I didn't know we have requirements on variable ordering. Will pay
attention in future.

> >
> >       if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
> >               goto drop;
> > @@ -2161,6 +2161,10 @@ static int packet_rcv(struct sk_buff *skb, struc=
t net_device *dev,
> >       res =3D run_filter(skb, sk, snaplen);
> >       if (!res)
> >               goto drop_n_restore;
> > +
> > +     /* skb will only be "consumed" not "dropped" before this */
> > +     drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
> > +
>
> This can be set in drop_n_account, rather than the common path.
>
> Same in tpacket_rcv.

Sure, let me shoot a v4 to move it.

