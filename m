Return-Path: <netdev+bounces-276445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBm+Gqk11mlZBwgAu9opvQ
	(envelope-from <netdev+bounces-276445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:02:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C93BB0AF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C763009176
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFF264A65;
	Wed,  8 Apr 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VAtsNXg3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgWHGWbI"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F548255F28;
	Wed,  8 Apr 2026 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646100; cv=none; b=gHtRyaMSm0y1CSs08AOz8upjqVJvhf5J5dUKlYp4jdAkPcAR5MQpXgfMoRaEYqxbXzZ2NHNa2nwrfuA4xpF+vrp5CDX9OcEcnuhfBqccnihsYbX7qQXgITbI8HJicn1/4xAFyGlVZFV6ZDgUHaAZUN9u0IIX23Dj9co+85B/xFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646100; c=relaxed/simple;
	bh=rqLHZkSQieoV78ujo4NYYUtMJOxEbCrP/xCVBgUgngI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D59NQ0afA+jrBRx2wSdRPz9nRv9i3si2QkVM00hSd1FWgeQQE362QG4KS9kAkywejrdulzBF9rRrka1HVc7jEyyBzqMu9kvYMwAzNZEguWTwKH4j4YbsuArhDgctgUlNNrkg1o2E2LB+pioEz/5GM+PjfHlTTNnqYqfle/g+M34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VAtsNXg3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgWHGWbI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97A2D7A0032;
	Wed,  8 Apr 2026 07:01:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 08 Apr 2026 07:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1775646095; x=1775732495; bh=/qAIXmolX1JlHIhJFgODJurabtwByrCp
	4xHUFf3leGQ=; b=VAtsNXg3txGInDFnHnzZbR+duJjPTP8xBCUxFy6UK5TwmzCW
	QYtP8cfzwzJtEe6mZdHwxHb2JFyMZWdT1sP4RUp9SLN90zjmJwIGU4LEsY4j7Eo8
	Fb0K1npbl3jA2wD/mvhEGzgKz0vpwmxqrPHSTifaxsT2xd1K+RPnLULOobOSaIlX
	Ag2k5eD6RhH5w5zcmQT0gttOMD36+i2UF/P0PSdrR2wt3JU64fpG70W1tudeFmeU
	5+0MptCiGES+JYOK90ks2/XZZXZiH2pSa4RQtJw/woktwt8pahbHCY57+M51qIRo
	4nS8gLxK7k+32lWyyVk3alzhgSu9r34JfZFLow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775646095; x=
	1775732495; bh=/qAIXmolX1JlHIhJFgODJurabtwByrCp4xHUFf3leGQ=; b=S
	gWHGWbIqd4HvGxrBHOzaFZHBz31AR8pRZozC0GChB22/UTuqFnlrOi5TDAEKzbzH
	F7k7Z7FKO09lWV1FxwKuR4TXc5xVCC3KpxZjAnB/jWoy9fTRF70SYetSAGgZEHAb
	X6erfBKc9tKaJeSwfdwTvan/7hkAUj33/wKiLfRef2ZqgIWAMc8rz5JAswUvuqpW
	E+7xQTE7F47Mufx5Nx2t2yFxWwluZ7KF1ImmOFSAibzPcRLEcNd//oDiZIBuw6el
	NCO1eJSySsErjlXg87p8pjtSxn6z/7lDJJAU4GAIaSVANwbLzqc6U2OWMc9eyE4D
	AaBWp5j/zrCc5qmTx4T+w==
X-ME-Sender: <xms:jjXWaab-CkdCd--7D28i_TpwLye3vTtsg6NVxk5J6CTPQzxGTBk_qQ>
    <xme:jjXWae_NLQjG8zgTOD0E4AsX-51WzxgBMUsAITfhOerVpUa25AmnROOdoImIUTwFx
    NWDP0o_vBoHlQD7Iew-Q9M5w2yqzA5hZ7ehG6js9mwym_ts_9akMYA>
X-ME-Received: <xmr:jjXWaUP_YwNFDFjkyYhPx7npMBhye2IsXJQhXaMvHN32b753BihFoV4bDhyd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgfdvgeeitefffedvgfdutdelgeeihfegueehteevveegveejudelfeff
    ieehledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomh
    dprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigqd
    hkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepught
    rghtuhhlvggrsehnvhhiughirgdrtghomhdprhgtphhtthhopehsughfsehfohhmihgthh
    gvvhdrmhgvpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhm
X-ME-Proxy: <xmx:jjXWaTGzrN8lTs3pbSRn8fAX2Ps0hWkj9VFY_T1LOWrJMhbravhDCw>
    <xmx:jjXWaaxfS94YuZ4tf3oW_eppzE5FEH9Hl71KBldjFKIJuD9A3rCu7w>
    <xmx:jjXWacrCBgsRk69TI9PnGaOeG5b3uom1vLS4tMLs8IoraOhGX5YQSg>
    <xmx:jjXWaYmNCgBUF0jfHi1Rxe8geeq2z97J31JOdgfSlVA50iJGl1xqvg>
    <xmx:jzXWadc5sJc-3j4UByQQo0f_mTp0xXWxe6pD1oR_hWovyGMAGl3S5PeH>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 07:01:33 -0400 (EDT)
Date: Wed, 8 Apr 2026 13:01:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Message-ID: <adY1jEs-oYXPosY8@krikkit>
References: <20260330130130.989236-1-cratiu@nvidia.com>
 <20260330130130.989236-5-cratiu@nvidia.com>
 <ac6BsG4IhAajip1s@krikkit>
 <e2eefeb7033caa859551834d3448a77b7af3c7d4.camel@nvidia.com>
 <adYQ3OMfEEWFTd7X@krikkit>
 <3aab1732c62fa8241ea91f2e26720ba47d646a3a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aab1732c62fa8241ea91f2e26720ba47d646a3a.camel@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276445-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[queasysnail.net:query timed out];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Queue-Id: C47C93BB0AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-08, 10:24:28 +0000, Cosmin Ratiu wrote:
> On Wed, 2026-04-08 at 10:25 +0200, Sabrina Dubroca wrote:
> > 2026-04-07, 15:07:47 +0000, Cosmin Ratiu wrote:
> > > On Thu, 2026-04-02 at 16:48 +0200, Sabrina Dubroca wrote:
> > > > If this happens on a real device, the VLAN filters will be
> > > > broken.
> > > > I'm
> > > > not sure what the right behavior would be:
> > > > 
> > > > 1. reject the request to enable offload
> > > > 2. switch to promiscuous mode
> > > 
> > > I implemented and tested option 1. In the unlikely scenario adding
> > > VLAN
> > > filters prevents offloading
> > 
> > How unlikely is it? Resource allocation, talking to HW, device
> > limits,
> > anything else that could fail?
> > 
> > > , it's better for the driver to be explicit
> > > and let the user turn on promisc mode themselves. Keeping track of
> > > whether VLAN filters failed and promisc was used as a fallback adds
> > > some extra complexity.
> > 
> > If it's indeed (very) unlikely, sure. There's still a bit of a
> > regression/change of behavior for users compared to before the
> > IFF_UNICAST_FLT patch, but I think we can wait until someone
> > complains, and then add the tracking if that happens.
> > 
> > > What would be the point of IFF_UNICAST_FLT then?
> > 
> > The point is that this would just be a fallback.
> > 
> > > Please let me know if you agree with this approach, so I can send
> > > v8
> > > with it.
> > 
> > If you can confirm it's on the "very unlikely" side, yes, this
> > approach sounds ok. Thanks.
> 
> There are many, many drivers which implement .ndo_vlan_rx_add_vid, I
> can't really browse them all and determine overall likelihood of

Sorry, I wasn't requesting that much work, more of a "feeling" based
on your understanding. Anyway for macsec offload we don't have to care
about the vast majority of drivers.

> failure. But presumably there are some memory allocations involved and
> some FW communication to add the new filter.

I guess if FW communication fails we're in trouble anyway [*], and memory
allocation failure is an acceptable reason to reject offloading
anyway.

[*] rolling back the mdo_add_secy could be a problem if we had
difficulties talking to the HW?

> An AI prompt of "Explore implementations of .ndo_vlan_rx_add_vid in
> drivers and classify potential failure sources and their likelihood of
> failure." resulted in (edited for compactness):
> """
> Analyzed 24+ implementations across major drivers. Here's the
> breakdown:  
> Category   Likelihood Drivers                         Typical Error
> HW/FW cmds Low        mlx4, nfp, hinic, qeth, vmxnet3 Device-specific
> Mem alloc  Very Low   bnx2x, qede, virtio_net         -ENOMEM
> Filter add Low-Medium mlx5, mlx4, ice, qede, ocelot   -ENOSPC, -EEXIST
> Locking    Very Low   be2net, mlx4, nfp, hinic        -EBUSY
> Res limit  Medium     qede (quota check)              Promisc fallback
> 
> Three Driver Archetypes  
> 
> 1. Simple bitfield drivers (never fail): e1000, e1000e, ixgbe, igb —
> just set a VFTA bit in hardware registers, always return 0.
> 
> 2. Complex offload drivers (can fail): mlx5 (flow steering rules), mlx4
> (FW VLAN registration), ice (switch rules + promisc management), qede
> (quota-aware with promisc fallback), nfp (mailbox commands), hinic (FW
> commands with rollback).
> 
> 3. Delegation/passthrough drivers (inherit failures): bonding, team,
> hsr, dsa, macvlan, ipvlan, macsec — propagate vlan_vid_add() to lower
> devices with unwind-on-failure patterns.
> """
> 
> So I guess we go with option 1 for now.

ACK

-- 
Sabrina

