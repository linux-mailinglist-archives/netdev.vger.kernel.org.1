Return-Path: <netdev+bounces-262393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFW2EeYypGlwaQUAu9opvQ
	(envelope-from <netdev+bounces-262393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA8B1CF9EF
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1F6F30107E6
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0AF31715F;
	Sun,  1 Mar 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo6tTLWh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538632DB7AB
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368585; cv=none; b=jMEPZzyHqEDr71+vL4RI+ICg00YRw9fPzT2qaHgK0AGgOZN+HY/Prm2fgdvTaWzkcRYb4afBzBOnz6Ue1rZcmeQ0JNsaqRoWAmLlVpGU7OPmFmCVXTN2McaSA8eoAovGene1N9l8ag2UGHwiL1W+dlUEshUxIj8h0mGXcfkVdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368585; c=relaxed/simple;
	bh=huOfMQVPatJlCbX7euB+nE+z4VUdmUaXKkB4ryW0uUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfrQBys1ZMMXL3NS8TitnrL7VKSsBVpDjYl0nnoRrledsJ0mbzmXkfQcPjgomc05HYvZB2fn9Fp0dfiQkIZx/RpTmoF+v3trABCRJfQoidS3F0K8wfX5Tnx77UycUkDADWqZlxGt6ybpK9nFO25SNzMWGiGU9z9INVJCMg9xKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo6tTLWh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806b8fca44so5055145e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772368583; x=1772973383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZnKSViWdAeTx1nOI6Nk8Fsx0srMTiEpyDWcumlzgyQ=;
        b=fo6tTLWhhRKqZYqsB2VvCqzcneYZYhTdvjMMklphFvTiGMKj5sOwuniJZBa9+1ozFG
         lJVDMjvFhIfM2fNdZhBOS/N4tFgl0dpotrMaKG3iicfgrp/W6R5D8mBG6s+gELCopN1r
         hZgLcKn2xnXhY8Vn3WytWMkxSgT20tBNHBRetU89nkRz5mxiLtmhv2D8JSMdOiNORpGK
         QAJw626dnLl6MzlMuykVdZ0B8oGWIiDXPMhyuu6Ng3BOUrAIrlu3V4v09JofNdwSq2Qs
         Hpwh2n6oDaBKulwXH/vCab3NCuGU2ABkuQWw6h7U/gWHOz6SUSoBr8giLxmbkzXydkri
         1Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772368583; x=1772973383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZnKSViWdAeTx1nOI6Nk8Fsx0srMTiEpyDWcumlzgyQ=;
        b=rAFsxaG+H9Mopr5baTdioAfN5yT0+6pCP+raZQRjhFLqwfTseuqkufBMAuAIikr++8
         YsEVvnhepsIRFRlc8yw0DsjO6mOKa+sJtKciMoCXxH0ROjUGnnUucB0Kd0Q0A8kMfSyC
         NXDmQ8UxfWQX1+5MfOOQGhCgXpVFpTkajESj/E4OgzqoctYEKqLthqok67dq4NKivxXx
         Km9kQj2B90RDa1HaUOcSwsTXYzBT4W0wV2JUQ2l7w180O/d0niUfgykUm5q/yNjUR87A
         dWatWnQj8hEmUwc3a9c70rRHohuw9LaPjUUrbgQ/l5gDab5Zm7ZSHl/A4T6RohghL127
         ge6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQFfuUCggBIjAj5+EX55iceKaDi3zZoytzj8ceGjAaT7eF8qA3pP1Se7oZ1oV0eh6gM+EsFfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OLDs8n6LGBXh9sFx6TVk+P6quyhejTF+CSTyA+Iaiowq/vQY
	Fxnf4BlRh/8pFvB1BbbDzhF8OG5Wgeh9bQe5gk8mtZwlL1/5F35LoMAk
X-Gm-Gg: ATEYQzwsJkjSPic8oTT+i28OxH7uDI6y4A0e/4Tpu7oRTG3vSvcjlvpYbOc4MFQV8eK
	thbTTvGwV6qtRydmaEMd3/U/B/7Su3Fxyl5/StwRBSdTsv5UmZpMe3762smaoz28RId9dKYkVGk
	fglMEBdJA4WnyxdkXo/nSd6FOqOnPRHHNEf7Bhcjc56y4hEzTrlvhdjjvNA7KiyzxauWSP1s36Q
	DrBwmn8P8XGDePxXMd9WW6QQ3WZNfIso+TM+huRBSV9NIQUcXnR0uZ4LPEoRcqUCzoaCE4sgo1U
	M6C+5ZiLudC/9fzcNOe9kcop9yE99qrxsuVRZYb9n2MAVRxnArH02ijS1kFuvqzyLaCY2rHaJTD
	B6U3MJPKeCinQHnmOy9YhwOyumJkw5vpPpihLZOZdEjy3YiDhqZXxpOKio9fua8C3x+D+3b1a83
	iwenF2PS9350Yh++NmvMiGXYl09XxCPw==
X-Received: by 2002:a05:600c:1e1d:b0:471:3b6:e24 with SMTP id 5b1f17b1804b1-483c9c3df3bmr79018895e9.8.1772368582417;
        Sun, 01 Mar 2026 04:36:22 -0800 (PST)
Received: from skbuf ([2a02:2f04:d608:3a00:8f4c:42a4:aebb:ef65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ad3daf89sm15619342f8f.20.2026.03.01.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 04:36:21 -0800 (PST)
Date: Sun, 1 Mar 2026 14:36:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Joris Vaisvila <joey@tinyisr.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC 0/2 net-next] net: dsa: MT7628 embedded switch initial
 support
Message-ID: <20260301123619.skschp4ioxnevh3u@skbuf>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228234031.bimzpo4mmu6t5rty@skbuf>
 <aaQqdwNsuwzRb7Xu@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaQqdwNsuwzRb7Xu@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262393-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFA8B1CF9EF
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 12:00:55PM +0000, Daniel Golle wrote:
> On Sun, Mar 01, 2026 at 01:40:31AM +0200, Vladimir Oltean wrote:
> > [...]
> > I looked at arch/mips/boot/dts/ralink/mt7628a.dtsi and found nothing
> > Ethernet-related. So it's a bit hard to comment from me whether this is
> > an instance of mtk_eth_soc.c or something, that is being used as a DSA
> > conduit. Case in which your architectural choice is fine.
> 
> Yes, the SoC Ethernet is supported by mtk_eth_soc.c, the reason why it
> is still missing in mt7628a.dtsi is preceisely because there is no way to
> actually use without a DSA/switch driver.

OK.

In that case I would like to know more about how is VLAN unawareness achieved,
with a concrete example.

In the code, this is attributed to:

	/* set up switch for double tagging to simulate vlan unawareness */
	regmap_set_bits(esw->regmap, MT7628_ESW_REG_POC2,
			MT7628_ESW_POC2_PER_VLAN_UNTAG_EN);

which sets bit 15 (PER_VLAN_UNTAG_EN) of Port Control 2 (POC2),
documented as:

VLAN tag removal option.
0: Use per port UNTAG_EN
1: Use untag enable bitmap in VLAN table

I see a slight discrepancy between what the documentation claims the
hardware does, and what the driver claims it does. The documentation
seems to say that setting this bit is what allows the vlan->untag bits
to take effect.

There does exist a DOUBLE_TAG_EN field in SGC2, which this driver
documents as MT7628_ESW_SGC2_DOUBLE_TAG_EN, but doesn't use. Then it
SGC2 to 0, as part of that "undocumented" stuff.

Assuming that was the intended field to be written, here is how it is
documented:

6:0 DOUBLE_TAG_EN Insert double tag field
When this bit is set, the incoming packet is allowed to insert outer or
double tag.
1: enable double tag field
0: disable the double tag field.
(Note: Port5 funciton is only valid when port 5 Giga MAC is implemented)

The documentation is not specific enough for me to understand what it
does, so I'll give an example.

A VLAN-unaware port means that when an ingress packet comes with 802.1Q
TPID 0x8100 and VID X from the wire, this VLAN header will be ignored by
the switch, and the PVID of the port will be pushed as an outer tag, for
any value of X, regardless of whether it is in the VLAN table or not.
Does it do that?

