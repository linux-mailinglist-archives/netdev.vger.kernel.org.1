Return-Path: <netdev+bounces-264252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAO4I8FQqWkj4wAAu9opvQ
	(envelope-from <netdev+bounces-264252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:45:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CBA20ED36
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A21E2305DBA7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F4379964;
	Thu,  5 Mar 2026 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3gUvHqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A233BBAF
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703466; cv=pass; b=aE/BB8Y0Y/uzptC5BABX82+4PboOdOhrr8PTWJ+RY0Iygws4SMDZhkbGmpxH4fNL1RHse4IDxVVHP/weVEbpfu5zJqz2yvkzmPzvRzqZZX2v4dsEwAsCXLfIw+E/FMOG2yqb1ls/c9kObSYLu/FA9uIXF8vOoHtFFlPISv9LYSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703466; c=relaxed/simple;
	bh=h5eoV1IeSL0UsSKft1SpRtMCq7Z2FCkrGpM+M7P/+dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shClBltDV6hyg3vOoUJg1zRroSpR6z1UCHXkfo8IToTWf3fTKIHTUBjGsFLTRJ/FRr4s9wZfwdi7IQcV8BAiz7ZL4KSKj0s4lJQnmI+Hrye/M8wAgZC/9tPRT1p5blq82PYWoBAA1ws5hv/5etFceomumLhHH+0+eUZk5/nw+Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3gUvHqS; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899e87b04d8so81963796d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772703464; cv=none;
        d=google.com; s=arc-20240605;
        b=ZEn0vIiL4s2+PUPWApz4kulDabPJaZNzeFH2EMJrMzXg641tZ4ynFw+SBIRMBGlr0s
         u3sgFA/wHRRQ5cKOqVzOlvxjGOlFr8TU9xu8eepJoz5W4/AJw/jg0UD5Oi2yeScUMq0a
         6o8fDOxe6LpfrSM5JINjO4gNupkI31uHjjlgCpk/xWZStR6y2FmaAwE0OvmgwiihRwin
         FfULwNFU/L2KIZx1+t1thltahfylmeWruGPqwZV1DSNwRrkdCFdPdvQZwzbylqks4ckf
         6FyNu2eMKue0fM7LaLW/omAim/qUdkPQNS54v6b8P3p8oYY2fYs7eYkT9RLUX+ARO87B
         2QJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PkbpS8Iq4rbgggDhjCdFbCKFLCFB7mJRjs8FQj7ZSYU=;
        fh=2EXqOvXa2/k+ikN8aut+i+1p7Y+YHHvRruQfJQzDbRE=;
        b=IAai8r8u/X5o2rKMIFjwHx/jHraZwES5Va1kVatAd6T520evMas/5FQAVTh9BA/7Ft
         qneCNGM2Nfsc8xxdCLAJ5T37m63EvnrhYgwceYzuAVer7webOqLPfgv2kXXFlUcX2ZqZ
         Md7odDwidtNcr4Jogc20AUFBMxzNSlM3C0wYK3sDukcN06E7VNzLaf/c8uxE+RvphsyM
         5D1K23a/K8Y2FqPlKVS2mvDIG0g90005hlMMebuZYk/mUDRVK62s7ezeLsfg8LfOVf+G
         I0EgQm5w4KISgptZelL9KkO6hVZU4lVc0oJPbq3IbX5QUxfMLtwEW8afdfDJ2LlBW2Eo
         Wh6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772703464; x=1773308264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkbpS8Iq4rbgggDhjCdFbCKFLCFB7mJRjs8FQj7ZSYU=;
        b=U3gUvHqSBhzqNdmlZviD1dZD/dsFUNZC+890FzFRGWopJwNoCncwdLhqyMDxBubHDw
         16JUDPWOT4r8u0XeTN4GKGn8qbyJ5+DS9iVv4+XQ+SH5scya8tkGoILOTL0WdCKxEhxr
         6PXc9cwXTQZ4eNt0KoxQVkYBfIIfyPPkR0CJYr5+0Aw9M+5SchGzcGeDjFC7NpqmvzEK
         Ll08zDb3H4z6P8vKmv1Twthc1Zf5eIeQDCIkzK1hsAm36n+Vkq4Kf0IdVQjCdVxU7c/Y
         TjKtXJ04vVDnoe2329pp8/Xf+pZnmgBRkrRrkjL+lkGURpv+iaxUDnrmpzchEK7uyKYN
         Cq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703464; x=1773308264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkbpS8Iq4rbgggDhjCdFbCKFLCFB7mJRjs8FQj7ZSYU=;
        b=VcfTKB2KDSBGm32lrdWU7ZKYbbETxmVcK0BEXh6p8CAWNvUd1pq91zpWZIKix21/qd
         2UzuyZsh642GWMQ3Dw6LYS4qX5jevZ2EwL7i29mLbltovLM3DT8gqagKc7q30FqVqXQk
         29QZ867xaJKt2WkPZhxXLEccKcIgzvuDDEY5GQ0s2CNsz96HaDew3IzRdUJfmf5EkpPe
         l3pQNrQ+rMxdiYz7xLK1UCzRPFrjRw7fV0WQdO8G54ZmDa/iUIx0OopJcw9Nf/FQ5x7C
         aoSUQmFDvhE7hpyDcAtW505gyZv5OrmkYcd0JvFk1KE8Ff8aSOiZEoWlkh+fBGAG2kgW
         DAmg==
X-Forwarded-Encrypted: i=1; AJvYcCUzXhjXa8jJ0tz5nh1Z3zg2088eXMgF9kp2ybQ7LK/ocujIU10Ykfw3rpHaFbm5C+uYtPWKnZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38Knmof9GZUCkva8CmPV6NwUlVhupyaXZ8hHlhikmukKlgZKZ
	Eq9goDMz+gs+LCV8tZSQiV3HKS4Y4dxaJbrkfTmCBgKrwf9yP5LO4WG65Yo/BCYDMKQTVfOcYv4
	L4+p22fbN8UD5xmujeM0mXWDrloIV9QCimwU/jY6c6KqCFKHDzS8wIbBye4s=
X-Gm-Gg: ATEYQzye6lA0twpZbeh5jqGf27fNV8doU+ln+T1sRyqHyL/BKzvpBKxygFi5HaaQg0A
	FAfvIKEUeozSzqSN6JKzrxuEDG8TgrGlCrEujVhCc/cTDIOeUAn07dblt+gcV061JhbQDqpGbO+
	Kn3cLAZFF8N2evZGRIGobCrCx5ILF7wg5TT8oYlbn1ufrxyAHGduFn6leH1cVkrcSQo2OJo1PCA
	oNQtHiPqEiT8kSdKNgpxuTRqcSbeuaA0WLLQViisitjNduN1tZGseI1ulv4CFAYBIz1VWmAnxrk
	FExL6Zg=
X-Received: by 2002:ad4:4ea6:0:b0:899:f2ba:9d7e with SMTP id
 6a1803df08f44-89a19d21b73mr75406456d6.38.1772703463816; Thu, 05 Mar 2026
 01:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com> <20260305092706.145085-3-kota.toda@gmo-cybersecurity.com>
In-Reply-To: <20260305092706.145085-3-kota.toda@gmo-cybersecurity.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Mar 2026 10:37:32 +0100
X-Gm-Features: AaiRm53Vdi26l9lPKD76G6HoI6f1DRss96jaPlzjG_Zyxqxv7PCKBasLiGDqdXY
Message-ID: <CANn89iJtpHAXZevL4b3X2CaEJvcM-fVJRQe2wUYfDrLzbuSKAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: add READ_ONCE for header_ops callbacks
To: Kota Toda <kota.toda@gmo-cybersecurity.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>, linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 90CBA20ED36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264252-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,gmail.com,datenfreihafen.org,bootlin.com,vger.kernel.org,gmo-cybersecurity.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmo-cybersecurity.com:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 10:27=E2=80=AFAM Kota Toda
<kota.toda@gmo-cybersecurity.com> wrote:
>
> Use READ_ONCE when loading header_ops callbacks
> to avoid races with concurrent updates.
>


Same remark than patch 1/2.

Add a Fixes: tag, or explain why you chose to not add one.

One line changelog are ok for really trivial patches.

Here it is unclear why we have either of these pointers being
dynamically changed.

I left further comments, please read them carefully.

> Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> ---
>  include/linux/netdevice.h | 28 +++++++++++++++++++---------
>  include/net/cfg802154.h   |  2 +-
>  net/core/neighbour.c      |  6 +++---
>  net/ipv4/arp.c            |  2 +-
>  net/ipv6/ndisc.c          |  2 +-
>  5 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 77a99c8ab..f50b0a4e8 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3150,35 +3150,44 @@ static inline int dev_hard_header(struct sk_buff =
*skb, struct net_device *dev,
>                                   const void *daddr, const void *saddr,
>                                   unsigned int len)
>  {
> -       if (!dev->header_ops || !dev->header_ops->create)
> +       int (*create)(struct sk_buff *skb, struct net_device *dev,
> +                     unsigned short type, const void *daddr,
> +                     const void *saddr, unsigned int len);
> +       create =3D READ_ONCE(dev->header_ops->create);

If dev->header_ops is NULL, we will crash in the above READ_ONCE()

> +       if (!dev->header_ops || !create)
>                 return 0;
>
> -       return dev->header_ops->create(skb, dev, type, daddr, saddr, len)=
;
> +       return create(skb, dev, type, daddr, saddr, len);
>  }
>
>  static inline int dev_parse_header(const struct sk_buff *skb,
>                                    unsigned char *haddr)
>  {
> +       int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
>         const struct net_device *dev =3D skb->dev;
>
> -       if (!dev->header_ops || !dev->header_ops->parse)
> +       parse =3D READ_ONCE(dev->header_ops->parse);

Same error here.

> +       if (!dev->header_ops || !parse)
>                 return 0;
> -       return dev->header_ops->parse(skb, haddr);
> +       return parse(skb, haddr);
>  }
>
>  static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb=
)
>  {
> +       __be16  (*parse_protocol)(const struct sk_buff *skb);
>         const struct net_device *dev =3D skb->dev;
>
> -       if (!dev->header_ops || !dev->header_ops->parse_protocol)
> +       parse_protocol =3D READ_ONCE(dev->header_ops->parse_protocol);

Same error here.

> +       if (!dev->header_ops || !parse_protocol)
>                 return 0;
> -       return dev->header_ops->parse_protocol(skb);
> +       return parse_protocol(skb);
>  }
>
>  /* ll_header must have at least hard_header_len allocated */
>  static inline bool dev_validate_header(const struct net_device *dev,
>                                        char *ll_header, int len)
>  {
> +       bool    (*validate)(const char *ll_header, unsigned int len);
>         if (likely(len >=3D dev->hard_header_len))
>                 return true;
>         if (len < dev->min_header_len)
> @@ -3189,15 +3198,16 @@ static inline bool dev_validate_header(const stru=
ct net_device *dev,
>                 return true;
>         }
>
> -       if (dev->header_ops && dev->header_ops->validate)
> -               return dev->header_ops->validate(ll_header, len);
> +       validate =3D READ_ONCE(dev->header_ops->validate);
> +       if (dev->header_ops && validate)
> +               return validate(ll_header, len);
>
>         return false;
>  }
>
>  static inline bool dev_has_header(const struct net_device *dev)
>  {
> -       return dev->header_ops && dev->header_ops->create;
> +       return dev->header_ops && READ_ONCE(dev->header_ops->create);
>  }
>
>  /*
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 76d2cd2e2..dec638763 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -522,7 +522,7 @@ wpan_dev_hard_header(struct sk_buff *skb, struct net_=
device *dev,
>  {
>         struct wpan_dev *wpan_dev =3D dev->ieee802154_ptr;
>
> -       return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
> +       return READ_ONCE(wpan_dev->header_ops->create)(skb, dev, daddr, s=
addr, len);
>  }
>  #endif
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 96786016d..ff948e35e 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1270,7 +1270,7 @@ static void neigh_update_hhs(struct neighbour *neig=
h)
>                 =3D NULL;
>
>         if (neigh->dev->header_ops)
> -               update =3D neigh->dev->header_ops->cache_update;
> +               update =3D READ_ONCE(neigh->dev->header_ops->cache_update=
);
>
>         if (update) {
>                 hh =3D &neigh->hh;
> @@ -1540,7 +1540,7 @@ static void neigh_hh_init(struct neighbour *n)
>          * hh_cache entry.
>          */
>         if (!hh->hh_len)
> -               dev->header_ops->cache(n, hh, prot);
> +               READ_ONCE(dev->header_ops->cache)(n, hh, prot);
>
>         write_unlock_bh(&n->lock);
>  }
> @@ -1556,7 +1556,7 @@ int neigh_resolve_output(struct neighbour *neigh, s=
truct sk_buff *skb)
>                 struct net_device *dev =3D neigh->dev;
>                 unsigned int seq;
>
> -               if (dev->header_ops->cache && !READ_ONCE(neigh->hh.hh_len=
))
> +               if (READ_ONCE(dev->header_ops->cache) && !READ_ONCE(neigh=
->hh.hh_len))
>                         neigh_hh_init(neigh);
>
>                 do {
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 7822b2144..421bea6eb 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -278,7 +278,7 @@ static int arp_constructor(struct neighbour *neigh)
>                         memcpy(neigh->ha, dev->broadcast, dev->addr_len);
>                 }
>
> -               if (dev->header_ops->cache)
> +               if (READ_ONCE(dev->header_ops->cache))
>                         neigh->ops =3D &arp_hh_ops;
>                 else
>                         neigh->ops =3D &arp_generic_ops;
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index d961e6c2d..d81f509ec 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -361,7 +361,7 @@ static int ndisc_constructor(struct neighbour *neigh)
>                         neigh->nud_state =3D NUD_NOARP;
>                         memcpy(neigh->ha, dev->broadcast, dev->addr_len);
>                 }
> -               if (dev->header_ops->cache)
> +               if (READ_ONCE(dev->header_ops->cache))
>                         neigh->ops =3D &ndisc_hh_ops;
>                 else
>                         neigh->ops =3D &ndisc_generic_ops;
> --
> 2.53.0
>

