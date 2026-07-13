Return-Path: <netdev+bounces-307288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iPdoKIhaVWocnQAAu9opvQ
	(envelope-from <netdev+bounces-307288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:37:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28D74F4B7
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:37:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MAxdTrOn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307288-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307288-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E490730285E6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F7F360EDC;
	Mon, 13 Jul 2026 21:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8435E1B5
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:37:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978629; cv=none; b=uA9DyslO0dtTAayA6UFlxhFkoGjed0IvH44+rYCosHVbt4dlQDVeapHdm7LYC9BlPo0yoPIU0vyCv3QGoeFz7PxV0Xz9pcnKYiH9ZpF9QJ7RDStc/VD4dJkS5DXb+WINmYf6mpPFW9I9v7nm1Z0+tkEKffMOzfMSxpziOYvjB54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978629; c=relaxed/simple;
	bh=pkkipRXB4vj3yiwDAjdxncf0VuKYLA3vSbGWEP/PV2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNGhnwvtBXvwQIPMMvFH7MvxucYgdXYPfpLYx6ANyhBO/mUSGBz5s+pY+j3NOZGhA7TfcVtPIb/SiwJuav6uGPp4e6B6GKS4TBbzZpf95eGSMu9qqZsDD6L+muVjtkJAyKrsU6IHO5IpxRHb62/MJCI72xo1ghs1FzP8w2WiXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAxdTrOn; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47debaa89cfso261766f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783978627; x=1784583427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KFg02OlTkf2Yn/CkP+xFl6ERBV7PQVQSfXTqSOnpsLE=;
        b=MAxdTrOnTxSjniqa0rD5zSi4thLPyLfudkS4W/w7KvMDm7F3ga+cgyVMfoXZQbeHL2
         TiGhTVjs+nh64brMeCulIosK4UpMNHRfIfjGizJss6eRL5twOUYy7u9rvYX8q6QrKMF6
         hrPb8IYIwT17TX9c5GOojdFg/j4xCBuuo5OzM8QfmDBXa3k5mEXsJo7JVVqYl3poVHmX
         /e3PJzgI1EN35nhV4/eii1E2SUzl8S9hUyXpnTkdtV07T9ulSlS/sQYFEMwcqzlizOOp
         3gbqIksItik3o3fC8AFdLG/o2gRV7kAuc4hySXZYWCv7yiEoICWdN7EjLodmTnFnnFrW
         hLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978627; x=1784583427;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFg02OlTkf2Yn/CkP+xFl6ERBV7PQVQSfXTqSOnpsLE=;
        b=Ta3ZOw4l6ttSMDqgloDHb2YYA11KcAu5A8IFQ2l9j2ftZvfxibSJOYsnc8cRlQpk7a
         kP+XxJKVl0AkXqB6HD3GwVEBbe4d006kdrQC+NNnTjuynZlOgEHfY+O+R8H7bcG73j8A
         diRiukGDQtuupmmz+0/J5F+BZczw5angV/7jRsy1DaHi9QB0TjxlD44EN1DhrHXw01YP
         D3lOEe3p3qAxadGAXMre3ZiI+rqTMQb3555qSbQkh7LTrSTTRb3FHPUv+Bu1iueEzDMT
         USPPXT3BcNNeSLOSbbTgNV0AerW3HYyNBqtZM6s0AQKMh+DX4J7MscH5BJvsheRkWmf8
         VJqA==
X-Forwarded-Encrypted: i=1; AHgh+RpXXdMuLAmi5gb/ZZo7dlw8h1c1oPLqcTseNBuy3mnfIn6+YZTnWR+CsJuppJXLtFGddoAhxSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLt4UuBI8GAFlOHZGBOIe48lVRM9/aEE94KzW3s8PJmEqV3QpC
	x+CHNIv9JU5QGSLn1VSGsOeVXwSqa5wMHRvR4KrBLcPUcmTez0Vw9WKU
X-Gm-Gg: AfdE7cm9PnOAHqmw5sSLZq1rYjEfOgNYQgMkF2moEG6oVCtqMCirz4BxvgRC4zzh7Nh
	DAXvXIV+fjOwYawL+VZaK4sBAbuFnXU+O26eVdlUlHn7IBm53u3TkoZMnRZS2k87WksKnJkQOAZ
	/9kJyYgo2z617MGK5ha3fFngekWjStFpxwW9Qc96K/kzdsQrgqvcWuUwdGVuV1eW43HCdVWkpAX
	gwJPJoWJ3lOrzY0E0LSYrjcnm3awZSXQLcR/FCbulWAox4lRgj/iygVrON5ZOWn255hdvruFB8v
	qXn2NCHGG+JcKiFdqr5FvFOMeqm/fSn8vr/euj2YoTZdUfiZwu763cvQ3wFZ984oCl2wYC6Z8KF
	+jea97IX46uHpnYuXXou5MpEud0wONpb0A1F0f1TBB571BvO5RVMwukDsdz+MeZvbDYQ4V3FUhJ
	m8QxzX
X-Received: by 2002:a05:6000:1843:b0:47d:ed40:a913 with SMTP id ffacd0b85a97d-47f2dd21ae8mr7457545f8f.7.1783978626485;
        Mon, 13 Jul 2026 14:37:06 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:d8f0:7a38:1703:914b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c25b2sm2173077f8f.30.2026.07.13.14.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:37:05 -0700 (PDT)
Date: Tue, 14 Jul 2026 00:37:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Doruk (0sec)" <doruk@0sec.ai>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset
 MAC header on transmit
Message-ID: <20260713213702.3kjamxnto2bciqak@skbuf>
References: <20260713194010.54642-1-doruk@0sec.ai>
 <20260713194010.54642-2-doruk@0sec.ai>
 <20260713200417.dghlrj4ca27b6nd4@skbuf>
 <CAPdMp1qf4q42MAaRqqzYnhYyU9KvdryGQR+TWsFNvJ1oCTnPKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPdMp1qf4q42MAaRqqzYnhYyU9KvdryGQR+TWsFNvJ1oCTnPKw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:andrew+netdev@lunn.ch,m:f.fainelli@gmail.com,m:woojung.huh@microchip.com,m:nnac123@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:sd@queasysnail.net,m:arun.ramadoss@microchip.com,m:UNGLinuxDriver@microchip.com,m:mpe@ellerman.id.au,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,microchip.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.ozlabs.org,queasysnail.net,ellerman.id.au];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B28D74F4B7

On Mon, Jul 13, 2026 at 04:12:20PM -0500, Doruk (0sec) wrote:
> Hi Vladimir,
> 
> Thanks for the review.
> 
> I checked the DSA cases with CONFIG_NET_DSA_LOOP=y. Since dsa_loop
> normally uses DSA_TAG_PROTO_NONE, I used a local repro-only override
> of dsa_loop_get_protocol() to select the relevant tagger, then sent an
> AF_PACKET/SOCK_RAW frame with PACKET_QDISC_BYPASS and
> sll_protocol=ETH_P_IP through lan1.
> 
> That leaves skb->mac_header unset (65535) on the direct-xmit path.
> 
> For tag_ocelot_8021q, the eth_hdr(skb) version reproduces as:
> 
>   BUG: KASAN: slab-out-of-bounds in ocelot_xmit()
> 
> Switching that site to skb_eth_hdr(skb) makes the same reproducer run clean.
> 
> I also checked the LAN937X path the same way by forcing
> DSA_TAG_PROTO_LAN937X. The eth_hdr(skb) version reproduces as:
> 
>   BUG: KASAN: slab-out-of-bounds in lan937x_xmit()
> 
> and the skb_eth_hdr(skb) version runs clean with the same packet sender.
> 
> So yes, for these DSA TX paths this is a real bug on the
> PACKET_QDISC_BYPASS path, not just a future-proofing cleanup. I have
> not yet checked ibmveth with a pseries/ibmveth setup.

Thanks for clarifying your testing procedure (and please do not top-post
replies).

Yes, manually editing dsa_loop_get_protocol() is the current state of
the art technology.

> For the older DSA commits you listed, I think they should be treated
> as stable candidates if they remove eth_hdr()/skb_mac_header() use
> from the same TX path. I can go through those individually and send a
> follow-up with the exact stable list if that would be useful.

Since skb_mac_header() in TX paths is the real problem, I now think
those commits should need backporting too. I only reworked the
first-order callers of skb_mac_header(), not realizing that eth_hdr()
needs rework too - and not having a clear testing procedure at the time.

I think it would be great if you could prepare an email to the stable
mailing list and to the maintainers.

