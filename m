Return-Path: <netdev+bounces-271158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO4NLo26wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:23:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE146318EF4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFB5E30C79CC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654E397E9A;
	Tue, 24 Mar 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Yso2oqF9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAA37B3F1
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368498; cv=pass; b=VAADs5ZZpSLxaOPVfrDTkdTefNFRU6QW+F9TkD+3nvSObCQhzwXG4Q4KhJdQ2vB6KFkGWobZFQYIno8jFchFGKh30NbE02GpG3nAlzKyBsR+YHF2l/Wr/FejaxbXHtIOkIx28BS1y0p044skP4J5mcyelbU3D2no6O+x/c1OV1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368498; c=relaxed/simple;
	bh=yTE53L70Mcc/Sf88kY21YSR/oIFc52KwMPcPwaLn0dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq1mNoPNjwLONa9rVOtxmO8FBvbttCTWApIkL6GOkWFSkOtJhw/ht2j666RvRa+ZO8QT31mjEp4XGngJboFaNQrMinoJoWT1UdzhwBwmftdnjc72RyZt6D8EE1nx9lgu95NEk1dQCZUjs8O/di9rCfRMzDCXOMWrLtt8tZbZKCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Yso2oqF9; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b982b0889d8so208643066b.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774368494; cv=none;
        d=google.com; s=arc-20240605;
        b=c/8sxZVrO1vxKbbkkJLNnhhdbowSTZ9k23Ve+LjjNyNVgQcCiZg7Iz8F5X01Pfq8A1
         3S1maCxN8VJZom+AE1u2X6pbLuMBF80PN6WnVjbyq7IKQBo/mZmnxiy7S9EW1wFJZ+O4
         o8xL1kelaGjOAdPDUV3IXZ6n199NMlW0C9mu05ooauLgOjNzMOZ27pswEebtRF7AKqV3
         3UbA5zM63UpefaaqSjSSiD80wG8+wt47rAQDTvk0UGCt9KZPEUhmSduPN5lRv3acYLsj
         ft++utq9b/zv7hecWKS4So0eVVEvrKmq/0uab0Ht4wEgH421wA0OGRAlfrZ9RgbD6vEX
         CmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgxJd69APQYyR/2yO/PNJ/PWlxMDYYndTvCiYToiJxU=;
        fh=6onRMPJOFnN+SFYsH7i1T3oxeslPNmAyryxlffkEzvg=;
        b=beUDryKIcyicOPS8UQhfTQwDPhUdo52hJfVFK56mjzMLsGB2eCxVDyxMYvNVXCHmRd
         nAASMreQkriGlR/sYkjPkqv01mPWlUJ3hk9AvkKs0VSWJpyW2UhO5/tKz6go1zJ1EX3N
         6/rI1wOu9NzypTdBe/TdTinS9lSApjSjNTh0CK9Wqqaf5FVaYw9tYHugAl+mCyMBoYPI
         H7sh82dA6lPU/Tv2mSTm+Mtm+a9zw3VzrblZ0qrasK2xMcRAUlOOdp48+ullFDQFzQAI
         beJ53LxTmqHc0L3bvz0cftKQfDl1GFQFT2slkm+rO6r1tPz1KB4W1kgZT55jSbxvGTlf
         Pglw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774368494; x=1774973294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgxJd69APQYyR/2yO/PNJ/PWlxMDYYndTvCiYToiJxU=;
        b=Yso2oqF9FCniBOjLutWP7eIAU7Wuho8KWmabIvRsZCSxmypxujedk5/8apAtJZBvWk
         IM4oraUq70LGxd7AWWglXeo0DSM4Xe3MPcMt/FTaWs8DVWEnfpcpGXgv9TvUPHSxb84O
         JInNt8TSIIuj1HqBR7sjhzASMZbkWFmqn4Igdm/ngQ0dJLIcfCcQqyhV2pD63uOrRu/S
         RVrWfLb7CNSBamZ4qJ/9Z+MMNBohQeLNZuNccjCHHNUeES0Og9pXQBWJHMoJd7Dm39fU
         2W6Lj1T7M08YNafw6JMLr/TCSSxXFP01w22D70Ygs1xpZBnla/ONxdV3bTKzvpJXMvBh
         Sm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368494; x=1774973294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgxJd69APQYyR/2yO/PNJ/PWlxMDYYndTvCiYToiJxU=;
        b=Ia2yOEuNC2wX1KzruuNwCQJuyYE3zFYPEPLplachHKZebON8WYYyX1sWxSx1crYACV
         Wf1FHdmoiPyVBuUKDeUaExsv1o3TrarDwz78fJePbLeReDfKevFLE3/nv4qgaqByp0Wk
         FdYJFuSnXUln4iaJHgD43YIcKGmSZEezFaWHlB2G22SURA7ZtO91j1hr0DTkDY2zKxh7
         p60vdEq2IuZg1uwe/tc/wmYG62ocKRQ3k6It4G8NmbWPTRkpbqXdhqtL3jAwy7IwK8sU
         f5WSoXZtDMtRfN/RorAoRE3R817re3lP2dojllvJiukjoVcnFp/M3Dim98U2GbJMUHo/
         f5Cw==
X-Gm-Message-State: AOJu0YzyxLjNJz5aSlTld7wQyHTMAR3TtEDR6XvT3jsbU9zcPZ8ng0bE
	mvpFFSWXVIcXPUGe0SH6AWd2kXpBw99jCig+IBpCnwRnld6Uo3ig6khuyZv95L8jl5ANNSq21K3
	0YSHPkaphAEnvqVpeVTiqJdtok5xEL8IPZ/B02fbmYw==
X-Gm-Gg: ATEYQzwY2w3F0vCrUi23yjzry5tnqfYh8IUvDFhRGMGQqbso/yLYxbrSYKDghcK6x3n
	XHDhLJo4h3PndPvCr5f+ziGHGY4BbxSmDp1B0t2kWLGM1nkK7BwlywsMfoiEWKx18ucIzn1H++w
	oczussYjISMXXBaTUzVzcU/eDjtx5b8l+/UPhNUZ3N15Wkjbz+h4HNyEMzNIy9AgDMty5spOI4f
	SSt2mV+aPkS+I1vX52AYxUjVhiQ7T5iSwayKLSZlpgLdsTJJ57okpZT7Hm/OTJi8HuhS1t/3Zy+
	8iJ8aVHw2izihalF0m6cwhz03puf034MxNAbkQojwg==
X-Received: by 2002:a17:907:9607:b0:b98:3e7a:22c2 with SMTP id
 a640c23a62f3a-b983e7a2362mr1184123766b.31.1774368493870; Tue, 24 Mar 2026
 09:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it> <20260322000557.12559-3-andrea.mayer@uniroma2.it>
In-Reply-To: <20260322000557.12559-3-andrea.mayer@uniroma2.it>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Tue, 24 Mar 2026 16:08:02 +0000
X-Gm-Features: AQROBzD2gpWqFRG9w607YocotENBeSisfVDtGru3X_mHbj1EL0iW7_nJBFn9GaI
Message-ID: <CAOY2BqyfK_Bb2=NUagK3FG3BkLoaaY9v1JXMZkCU5EHXsNP2ag@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271158-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,6wind.com:dkim,uniroma2.it:email]
X-Rspamd-Queue-Id: BE146318EF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:06=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma=
2.it> wrote:
>
> Introduce srl2, an Ethernet pseudowire device over SRv6. It
> encapsulates L2 frames in IPv6 with a Segment Routing Header for
> transmission across an SRv6 network.
>
> The encapsulation logic reuses seg6_do_srh_encap() with
> IPPROTO_ETHERNET. The transmit path uses the standard IPv6 tunnel
> infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
>
> The device is configured with a segment list for point-to-point
> L2 encapsulation.
>
> Usage:
>
>   ip link add srl2-0 type srl2 segs fc00::a,fc00::b
>
> Co-developed-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> Signed-off-by: Stefano Salsano <stefano.salsano@uniroma2.it>
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  include/linux/srl2.h      |   7 +
>  include/uapi/linux/srl2.h |  20 +++
>  net/ipv6/Kconfig          |  16 +++
>  net/ipv6/Makefile         |   1 +
>  net/ipv6/seg6.c           |   1 +
>  net/ipv6/srl2.c           | 269 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 314 insertions(+)
>  create mode 100644 include/linux/srl2.h
>  create mode 100644 include/uapi/linux/srl2.h
>  create mode 100644 net/ipv6/srl2.c
>

[snip]

> diff --git a/net/ipv6/srl2.c b/net/ipv6/srl2.c
> new file mode 100644
> index 000000000000..66aa5375d218
> --- /dev/null
> +++ b/net/ipv6/srl2.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  SRv6 L2 tunnel device (srl2)
> + *
> + *  A virtual Ethernet device that encapsulates L2 frames in IPv6 with a
> + *  Segment Routing Header (SRH) for transmission over an SRv6 network.
> + *  On the remote side, a seg6_local behavior such as End.DT2U or End.DX=
2
> + *  decapsulates the inner Ethernet frame for L2 delivery.
> + *
> + *  The encapsulation logic reuses seg6_do_srh_encap() from seg6_iptunne=
l.c
> + *  with IPPROTO_ETHERNET (143). The transmit path uses the standard IPv=
6
> + *  tunnel infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
> + *
> + *  Authors:
> + *     Andrea Mayer <andrea.mayer@uniroma2.it>
> + *     Stefano Salsano <stefano.salsano@uniroma2.it>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <net/dst_cache.h>
> +#include <net/ip6_route.h>
> +#include <net/ip_tunnels.h>
> +#include <net/ip6_tunnel.h>
> +#include <net/seg6.h>
> +#include <linux/seg6.h>
> +#include <linux/srl2.h>
> +
> +/* Conservative initial estimate for SRH size before newlink provides
> + * the actual value. 256 bytes accommodates up to 15 SIDs.
> + */
> +#define SRL2_SRH_HEADROOM_EST  256
> +
> +struct srl2_priv {
> +       struct ipv6_sr_hdr      *srh;
> +       struct dst_cache        dst_cache;
> +};
> +
> +/*
> + * srl2_xmit - encapsulate an L2 frame in IPv6+SRH and transmit
> + *
> + * When the bridge (or local stack) sends a frame through this device,
> + * skb->data points to the inner Ethernet header.  We look up a route
> + * towards the first SID, prepend the outer IPv6+SRH via
> + * seg6_do_srh_encap(), and transmit via ip6tunnel_xmit().
> + *
> + * The route lookup result is cached per-cpu in dst_cache. Since the
> + * first SID is constant for the lifetime of the device, the cache
> + * avoids repeated route lookups in the common case.
> + */
> +static netdev_tx_t srl2_xmit(struct sk_buff *skb, struct net_device *dev=
)
> +{
> +       struct srl2_priv *priv =3D netdev_priv(dev);
> +       struct net *net =3D dev_net(dev);
> +       struct dst_entry *dst;
> +       struct flowi6 fl6;
> +       int err;
> +
> +       local_bh_disable();
> +       dst =3D dst_cache_get(&priv->dst_cache);
> +       local_bh_enable();
> +
> +       if (unlikely(!dst)) {
> +               memset(&fl6, 0, sizeof(fl6));
> +               fl6.daddr =3D priv->srh->segments[priv->srh->first_segmen=
t];
> +
> +               dst =3D ip6_route_output(net, NULL, &fl6);
> +               if (dst->error) {
> +                       dst_release(dst);
> +                       DEV_STATS_INC(dev, tx_carrier_errors);
> +                       goto drop;
> +               }
> +
> +               if (dst_dev(dst) =3D=3D dev) {
> +                       dst_release(dst);
> +                       DEV_STATS_INC(dev, collisions);
> +                       goto drop;
> +               }
> +
> +               local_bh_disable();
> +               /* saddr is unused */
> +               dst_cache_set_ip6(&priv->dst_cache, dst, &fl6.saddr);
> +               local_bh_enable();
> +       }
> +
> +       skb_scrub_packet(skb, false);
> +
> +       skb_dst_set(skb, dst);
> +
> +       err =3D seg6_do_srh_encap(skb, priv->srh, IPPROTO_ETHERNET);

We shouldn't be reusing seg6_do_srh_encap() as it also manages its own
lwt dst_cache. There's probably a need to rework that part to avoid
code duplication.

