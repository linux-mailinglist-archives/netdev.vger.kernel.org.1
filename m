Return-Path: <netdev+bounces-271171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BBfJOa9wmlflQQAu9opvQ
	(envelope-from <netdev+bounces-271171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:37:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6B319203
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2C8306901D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C9B3E9F6F;
	Tue, 24 Mar 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IRY1ekvd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2D37B3F1
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369462; cv=pass; b=npCI5BfRUNiyTA1JJ5q+CVP3oM6bE4Or2KXADK2s+H1MGZWitOtk/vLjjORHP80ZN9BZZYy2RStXkaZzAgwY+ba34CVle5lHIz86AsgLVN8wuJ7EyirV9COZohLnDbGrbI6BkzQxhCZxKhYsWFladcddbCuWXpD4oS/7yxm3hjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369462; c=relaxed/simple;
	bh=owmKa2NWMECuhSOYxtiVMhvYzifA8hvg8IzSt+NC+e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9YjXAPvZwDttMgwfI/mrLm1L/kjBeEKMmfGznYm5oCSZmRA0wzVSB8aSf1gVakh+sC9+0HnD1W4+h07z3CGxhTA9t6ijMsbVvrqouLucmrjR6+gPDX2PocKQ839oQ5V+XX0ksLPbSgDsOCWyo/b0RNtwpNzNJ7Usslkm5eyR3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IRY1ekvd; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9793fa5371so753112266b.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369458; cv=none;
        d=google.com; s=arc-20240605;
        b=M0AzmUq3TjNjdf5tZmXqu1sTmGaQqweYd+w2EDnOOprErEP6v/POPLvmeKX99kdv0q
         AF7RMvkAbHNhyPzt4UlUMll3XKrg5i7BzGj1mezQ6jJ/7ylY+LcFjAL9LICalqe2XxwZ
         nHIdCeiin5cQpjp9SUpNDj6WKDf0z1yXfPhm5NGfMSJhMvbi2/YyN5wNXf3KYdtuaIH1
         apcUTkT6M8+53F4mcpUbJRWTdlPjfe8aASOTb5wg4/u4wOUkEcO9jOfW1oNPA9z9LTEG
         SbO8b05Ja6io4xfXCoB2ist38DPOBwtU7M+zf0CCcEXi81sBoUXqf+AghHF2hzvevv4a
         m/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9mqalPPtNSQFqGhx3UfYVM6jtpaXcHwKNUBjP4Y1Lo0=;
        fh=6onRMPJOFnN+SFYsH7i1T3oxeslPNmAyryxlffkEzvg=;
        b=HX3GzGhP8mMyJZPRTm7pnXmQIWB7SWOzabogZ36DzHOr22O7QtIAXEiW5FXAtbvKLT
         7JyvmMAwk5KCAXNxRhXcJSFMRwFm7ITyivTpurETtWQdaVWVw7GAsga5lrAXOX6/KQkK
         ohjPP5wzOszaMF1h6upIBouOJHO6HUPwjElwHzh+Dr9Il4oDwnlbJoRYRTrMjnRCto3a
         syWgBmFIkfyt5c62wesGQUckoTKkoXT2d9e8DXg46a7lVwdRDSg4ubxaQ8OcbPzONtj3
         +fuFsNbu8HMO5SgG342GlezyfOHtrPLkO8haMUP1xW1ndy1WnyxDzXHVeNhQ/N6vZnh5
         yhHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774369458; x=1774974258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mqalPPtNSQFqGhx3UfYVM6jtpaXcHwKNUBjP4Y1Lo0=;
        b=IRY1ekvdEq5L8gDWr5I95XvwslnTNoPoEZYd6vHldeQO+qtIj0OfJtKPgTRqN7mNHV
         5Y3wEOlB+xD4sCS9uKFiqGQcyMIhJi8kACE2+QORtEUDB8uUPlGk9cU8fKPID49+pvqy
         7fYEX9MQDGMSSIYC81EqMCdSgQrZ2jEa0dagiIIf8U7wWFmfnnf6/oMmy3DfId3PYVo4
         lJc9oVfK4GehV6JGd51A4gWJl2Wp6EhRafFGq58nQ0p4h6wxMV8O1vP7JAANiwP+ctO+
         ywQWh1ACL4Bzu3zzHdf/w9VwJJIJpdxtGZ3VtTLMd6qS+H1yPusAENUgTJExFM7WbIEg
         t4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369458; x=1774974258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mqalPPtNSQFqGhx3UfYVM6jtpaXcHwKNUBjP4Y1Lo0=;
        b=bBntOsV/oq/a+4qnZn00jNqtNR44wyV21ENuASDviMbZYL4ZlN0BYKiZc4t2yiD2zg
         94UfOw3qi8tox+wdrnozifWdl3wN6/KXrPhU6+Ga4nJU3aOL09K79Nn5hJS2Er5xHfaT
         5F0ZGRFMULPGaO6uz6iQSqyHGoYIifKcb2c5iI1J5D19d7M7hNequT56E5BdHV8IVvSB
         3i61p6aE1Q1v0FBSBmfO+pyBN8jArkIUuFsm2el/Jtfuc9XJ5BrpkIIaHsjga+bVc1pj
         +NxROgubgSA9PL7N3s0iKiY6aY73aWBW9IiFsspNh+jygvNJkhafOACUEFYr4erW8JTF
         Px8Q==
X-Gm-Message-State: AOJu0Yy3+kIlQdrfK2KtuzbQxsvNtlVr6DVq1jZLLOuqC+ktTnnIvcnR
	yWBvTwQJQj64vdhFMoSUkQ8SuqzuQm+uZicI1MzskoAq88TLBhQwzKNqTogpJ+NtMWokiRIIamn
	bVtc5XdjR0Ho8xMGgbICN52i7im1woZvjLxxiBb2eyw==
X-Gm-Gg: ATEYQzwTbWpXS547pV1H/56wPZ3iZxK78z9uWuHz/Cv/zFfe1Nn1uRiwh2j68DKKepk
	uq55C1USeaJSuKomrrilzfwaixwt8rftLlWE6sTybnlc1IN8a0tfCqrC1f+Bdi5pIMxNm9gqND+
	qJf1b0OR0Gp01BsMEwjJrEgFFPeDICiIfXLdBrGebiET8k1Bn0rB87ymTazQ52YTX4E5NzDZKib
	1IsQ9yVt7Q9p4hDcXNc0om4uf49NngxEToO39rkf9QIeEXmN8JioqD312u1DAQoP5O0N/4KQ6dv
	HDosGvaL1I+uhij1z1/cyCIOn6j6SZCPRNPrKQpqxQ==
X-Received: by 2002:a17:907:a68a:b0:b98:40a3:aa0c with SMTP id
 a640c23a62f3a-b9a3f1a7e9bmr4356766b.24.1774369457710; Tue, 24 Mar 2026
 09:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <20260322000557.12559-3-andrea.mayer@uniroma2.it> <CAOY2BqyfK_Bb2=NUagK3FG3BkLoaaY9v1JXMZkCU5EHXsNP2ag@mail.gmail.com>
In-Reply-To: <CAOY2BqyfK_Bb2=NUagK3FG3BkLoaaY9v1JXMZkCU5EHXsNP2ag@mail.gmail.com>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Tue, 24 Mar 2026 16:24:06 +0000
X-Gm-Features: AQROBzBbZqqwQsK-IA5tDbAYaCkfSFTWF-pNL7_rxhD2mVT-VrpKO6kJY3Scazo
Message-ID: <CAOY2BqznWu+gf+QmK7nK7OLQaRsYy38KRfeBf-kR6Txp5TpSiA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/3] seg6: add SRv6 L2 tunnel device (srl2)
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, 
	Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271171-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,6wind.com:dkim,6wind.com:email,uniroma2.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arxiv.org:url]
X-Rspamd-Queue-Id: E5E6B319203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 4:08=E2=80=AFPM Justin Iurman <justin.iurman@6wind.=
com> wrote:
>
> On Sun, Mar 22, 2026 at 12:06=E2=80=AFAM Andrea Mayer <andrea.mayer@uniro=
ma2.it> wrote:
> >
> > Introduce srl2, an Ethernet pseudowire device over SRv6. It
> > encapsulates L2 frames in IPv6 with a Segment Routing Header for
> > transmission across an SRv6 network.
> >
> > The encapsulation logic reuses seg6_do_srh_encap() with
> > IPPROTO_ETHERNET. The transmit path uses the standard IPv6 tunnel
> > infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
> >
> > The device is configured with a segment list for point-to-point
> > L2 encapsulation.
> >
> > Usage:
> >
> >   ip link add srl2-0 type srl2 segs fc00::a,fc00::b
> >
> > Co-developed-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> > Signed-off-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> > Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> > ---
> >  include/linux/srl2.h      |   7 +
> >  include/uapi/linux/srl2.h |  20 +++
> >  net/ipv6/Kconfig          |  16 +++
> >  net/ipv6/Makefile         |   1 +
> >  net/ipv6/seg6.c           |   1 +
> >  net/ipv6/srl2.c           | 269 ++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 314 insertions(+)
> >  create mode 100644 include/linux/srl2.h
> >  create mode 100644 include/uapi/linux/srl2.h
> >  create mode 100644 net/ipv6/srl2.c
> >
>
> [snip]
>
> > diff --git a/net/ipv6/srl2.c b/net/ipv6/srl2.c
> > new file mode 100644
> > index 000000000000..66aa5375d218
> > --- /dev/null
> > +++ b/net/ipv6/srl2.c
> > @@ -0,0 +1,269 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  SRv6 L2 tunnel device (srl2)
> > + *
> > + *  A virtual Ethernet device that encapsulates L2 frames in IPv6 with=
 a
> > + *  Segment Routing Header (SRH) for transmission over an SRv6 network=
.
> > + *  On the remote side, a seg6_local behavior such as End.DT2U or End.=
DX2
> > + *  decapsulates the inner Ethernet frame for L2 delivery.
> > + *
> > + *  The encapsulation logic reuses seg6_do_srh_encap() from seg6_iptun=
nel.c
> > + *  with IPPROTO_ETHERNET (143). The transmit path uses the standard I=
Pv6
> > + *  tunnel infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit=
).
> > + *
> > + *  Authors:
> > + *     Andrea Mayer <andrea.mayer@uniroma2.it>
> > + *     Stefano Salsano <stefano.salsano@uniroma2.it>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/etherdevice.h>
> > +#include <net/dst_cache.h>
> > +#include <net/ip6_route.h>
> > +#include <net/ip_tunnels.h>
> > +#include <net/ip6_tunnel.h>
> > +#include <net/seg6.h>
> > +#include <linux/seg6.h>
> > +#include <linux/srl2.h>
> > +
> > +/* Conservative initial estimate for SRH size before newlink provides
> > + * the actual value. 256 bytes accommodates up to 15 SIDs.
> > + */
> > +#define SRL2_SRH_HEADROOM_EST  256
> > +
> > +struct srl2_priv {
> > +       struct ipv6_sr_hdr      *srh;
> > +       struct dst_cache        dst_cache;
> > +};
> > +
> > +/*
> > + * srl2_xmit - encapsulate an L2 frame in IPv6+SRH and transmit
> > + *
> > + * When the bridge (or local stack) sends a frame through this device,
> > + * skb->data points to the inner Ethernet header.  We look up a route
> > + * towards the first SID, prepend the outer IPv6+SRH via
> > + * seg6_do_srh_encap(), and transmit via ip6tunnel_xmit().
> > + *
> > + * The route lookup result is cached per-cpu in dst_cache. Since the
> > + * first SID is constant for the lifetime of the device, the cache
> > + * avoids repeated route lookups in the common case.
> > + */
> > +static netdev_tx_t srl2_xmit(struct sk_buff *skb, struct net_device *d=
ev)
> > +{
> > +       struct srl2_priv *priv =3D netdev_priv(dev);
> > +       struct net *net =3D dev_net(dev);
> > +       struct dst_entry *dst;
> > +       struct flowi6 fl6;
> > +       int err;
> > +
> > +       local_bh_disable();
> > +       dst =3D dst_cache_get(&priv->dst_cache);
> > +       local_bh_enable();
> > +
> > +       if (unlikely(!dst)) {
> > +               memset(&fl6, 0, sizeof(fl6));
> > +               fl6.daddr =3D priv->srh->segments[priv->srh->first_segm=
ent];
> > +
> > +               dst =3D ip6_route_output(net, NULL, &fl6);
> > +               if (dst->error) {
> > +                       dst_release(dst);
> > +                       DEV_STATS_INC(dev, tx_carrier_errors);
> > +                       goto drop;
> > +               }
> > +
> > +               if (dst_dev(dst) =3D=3D dev) {
> > +                       dst_release(dst);
> > +                       DEV_STATS_INC(dev, collisions);
> > +                       goto drop;
> > +               }
> > +
> > +               local_bh_disable();
> > +               /* saddr is unused */
> > +               dst_cache_set_ip6(&priv->dst_cache, dst, &fl6.saddr);
> > +               local_bh_enable();
> > +       }
> > +
> > +       skb_scrub_packet(skb, false);
> > +
> > +       skb_dst_set(skb, dst);
> > +
> > +       err =3D seg6_do_srh_encap(skb, priv->srh, IPPROTO_ETHERNET);
>
> We shouldn't be reusing seg6_do_srh_encap() as it also manages its own
> lwt dst_cache. There's probably a need to rework that part to avoid
> code duplication.

Never mind, it's just that dst_dev_overhead() would be called with a
default (NULL) dst_entry, so I guess we should remove the likely
annotation for perf reasons in this case. FYI, dst_dev_overhead() was
introduced to mitigate a double reallocation in skb's, but I don't
think we should worry about it in this context as it is only triggered
for much more segments (see https://arxiv.org/pdf/2503.14959, and
related commits 0600cf40e9b3 and 40475b63761a).

