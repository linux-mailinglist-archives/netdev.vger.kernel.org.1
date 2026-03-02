Return-Path: <netdev+bounces-262942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHKzFjwdpmmeKQAAu9opvQ
	(envelope-from <netdev+bounces-262942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:29:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB47C1E6A5A
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EF983182284
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD03909B4;
	Mon,  2 Mar 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="V4gGn0eK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVSYh9SH"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B80310655
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492586; cv=none; b=Vix/swLyqhbGhiEOO/WAlqH5PmCtPK7S3iFYNccpdchwt7SP6OAe1CwvnMUcitCyCUOMS3Z+RHvoh0J5AWnKNUOr1URVVcD/Cb509mIla5twtI7ISspI/K0UyfMOoAAJNEaR1LpRxcAynj8/BKE9RI6cSuH4+LiHOAL2bY0Z1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492586; c=relaxed/simple;
	bh=Jl89p1g5deJ0BXo7cTwKx0SWo+WzWGXfgTQWbcvYZ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVV2PH7C/gZ2HZTR2/UnKWax5KamZmHkpya6AtLv+N1sw1YcQJwyhufVcWnKV8MlO9ybFS9ErSAi/Fp8taCJYw4bTqMf/Z5xFA9u0jBAz3N0pp7qgqAcspyN2/CZnJnSJi1hAX/BXFYb4g56AnXEpGYfvlWge8c5kN1O2LoGiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=V4gGn0eK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FVSYh9SH; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24DCF7A01C3;
	Mon,  2 Mar 2026 18:03:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 18:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772492581; x=1772578981; bh=Tf/E0lUFZL9XqTFLgQtRGMwHnbNMh8k3
	KpbNkpldS9M=; b=V4gGn0eKwVRqh/qgNJpUSs+36kX5n7liW9F25dzaLLjZXu/p
	ZYKXP/29zExLMOVGnFQIxc6Wmm7JFsg99sX9qH9WCq9Fi8Mmhd01JoNPU9xZCbTO
	pgRu70+7f0stsrvK0c96bA+8wn6QbBlXtBO0lgZT2AF0ZX2WorAyYQeS6W6QYrT4
	eQVyfhq4fG84Z2mq7PVsmx4ntos0Q3fCAnH1ClJYXD6RGsh25F1Ky2dKNkV/0aeV
	Witd2UrPJb30fotvyFTxFdv9SThzH2DbqCb7Pz8BFpnOfDH4jLPpMGAmA1vOyZ/z
	d/tP+ZBPygBuf3DL6Kc9YHAY8WMMEF+didi5tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772492581; x=
	1772578981; bh=Tf/E0lUFZL9XqTFLgQtRGMwHnbNMh8k3KpbNkpldS9M=; b=F
	VSYh9SHwLYq+dbhVAKj86LOwkEkZQNw1LRsSv7nak058qHoD5tstvrag0gXrAgrZ
	QE2eKUw07hsIwviveIIC6Xfwt6sODxNI3LWwUvZra77tV4avnM69HDidDcThiip6
	mPVc2sysHSD2SmL+12N+g8ukNo36GiIcUP++P2iM8VQXZOxy/0hxgnrcIuMJaYdi
	JzRnDsePvG/33oJqNLq3QeLAjfYZyEQK/eiNtUt7nAdZ5goQrLsuWggiGwoUSXmZ
	0wDGiK1++u1LmYfEo4IvQN4JsO8l81qIWClEC4EYj8DJipQn7jNFYr6/rjqusf9k
	9lu2mw8tqnkbj2B8mOLYw==
X-ME-Sender: <xms:JBemacasNzLVwPggI293aF9Kn8O9MGN_Jw-1mWMnFABPalM2H6xpEg>
    <xme:JBemacm79pGeDOk-0yfe9KMyA44wEEHBpc7G-EkMHtO4mxPoBTAajvHM1QEQi88rG
    BRRU33U8haN5gA8C31Q7qPOQfMNVpQ02mFF3agz5A6F9B5k7pa_C1vz>
X-ME-Received: <xmr:JBemaaUSe1361TqOoAzCwAHU9A6E2WIIQueFiwTUiYvBP1zDaH1jXQLiiTLK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfmhgrnhgtvghrrgesshhushgvrdguvg
    dprhgtphhtthhopehiughoshgthhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrihgughgvse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhoohhprgestghumhhulhhu
    shhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmh
    gvpdhrtghpthhtohepphgvthhrmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohephhho
    rhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgriihorhessghlrggtkhifrg
    hllhdrohhrgh
X-ME-Proxy: <xmx:JBemaWJtYUT9UkxxG95zXarAoETWAkeR_25YB6kfVN6PnTm4lKqcrw>
    <xmx:JBemaSsylVru43Fy8UzTocZz94BfGJlimhh6My_9WR8CqFuzFUnFQA>
    <xmx:JBemaT1-HWcVN0l81fUXWU9pAl6mqqZD4vAc5LGYMVEHlDzX5NbBjA>
    <xmx:JBemaSMf8e8qsi8Z8dAeXzqwM9OFIDnzMk-UWmKV-E0istGTgi3RiQ>
    <xmx:JRemacOnQPr-qCSmHnf5uwK-90goHkQn3AiMMh7gZ7VTDNB6Nsh7Rgg4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 18:03:00 -0500 (EST)
Date: Tue, 3 Mar 2026 00:02:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, roopa@cumulusnetworks.com, sdf@fomichev.me,
	petrm@nvidia.com, horms@kernel.org, razor@blackwall.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch
Subject: Re: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when
 IPv6 is disabled
Message-ID: <aaYXIkHH4xsP_YDx@krikkit>
References: <20260302140847.5941-1-fmancera@suse.de>
 <20260302140847.5941-2-fmancera@suse.de>
 <aaWiH5KBf-n1NxAR@krikkit>
 <c2e08123-9338-4836-82e7-f47eb344f41f@suse.de>
 <20260302163643.GA971179@shredder>
 <fd8370d6-b163-45ac-9e6c-24046f46539e@suse.de>
 <853cf5a5-1c4e-43e5-b1fb-38c986488ba8@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <853cf5a5-1c4e-43e5-b1fb-38c986488ba8@suse.de>
X-Rspamd-Queue-Id: CB47C1E6A5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262942-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Action: no action

2026-03-02, 19:04:14 +0100, Fernando Fernandez Mancera wrote:
> On 3/2/26 6:44 PM, Fernando Fernandez Mancera wrote:
> > On 3/2/26 5:36 PM, Ido Schimmel wrote:
> > > On Mon, Mar 02, 2026 at 04:13:14PM +0100, Fernando Fernandez Mancera
> > > wrote:
> > > > On 3/2/26 3:43 PM, Sabrina Dubroca wrote:
> > > > > 2026-03-02, 15:08:47 +0100, Fernando Fernandez Mancera wrote:
> > > > > > When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> > > > > > initialized because inet6_init() exits before ndisc_init() is called
> > > > > > which initializes it. If an IPv6 packet is injected into
> > > > > > the interface,
> > > > > > route_shortcircuit() is called and a NULL pointer
> > > > > > dereference happens on
> > > > > > neigh_lookup().
> > > > > 
> > > > > VXLAN can be built-in even when IPv6 is built as a module, and then
> > > > > ipv6_mod_enabled can't be used in VXLAN:
> > > > > 
> > > > > ld: drivers/net/vxlan/vxlan_core.o: in function `route_shortcircuit':
> > > > > drivers/net/vxlan/vxlan_core.c:2133:(.text+0x116e0):
> > > > > undefined reference to `ipv6_mod_enabled'
> > > > > 
> > > > > 
> > > > > GENEVE has a Kconfig tweak to prevent this since 094be0927ff3
> > > > > ("geneve: fix build with modular IPV6"):
> > > > > 
> > > > >       depends on IPV6 || !IPV6
> > > > > 
> > > > > but VXLAN doesn't.
> > > > > 
> > > > 
> > > > Ugh, good catch. Thanks Sabrina.
> > > > 
> > > > > But then I think we don't need to use ipv6_stub at all.
> > > > 
> > > > If we enforce "depends on IPV6 || IPV6=n" on VXLAN we could get rid of
> > > > ipv6_stub completely and use direct calls instead.
> > > 
> > > I just noticed that this is already enforced for the bridge, so maybe
> > > you can just remove ipv6_stub in patch #1?
> > > 
> > 
> > Yes, after Sabrina mentioned it that was what I planned to do. But on
> > VXLAN I want to avoid such patch for net tree as a fix. Instead I
> > propose to use the __in6_dev_get() check as neigh_reduce() does.

I'm not convinced __in6_dev_get() makes more sense. It's also pretty
much a random NULL check to me, and at least with checking nd_tbl
directly it's clearly related to the code that follows.

In neigh_reduce(), __in6_dev_get() seems to have been present from the
start, and back then in6_dev was used in the function. Now, it might
easily be removed by a clean-up patch that doesn't notice it's useful.


Should there be a helper ipv6_mod_available() (or a better name) in
net/ipv6/addrconf_core.c (so always available) to wrap those checks in
a way that doesn't rely on Kconfig magic nor non-obvious NULL checks?
(maybe even replacing ipv6_mod_enabled()?)

> > Later,
> > do a follow-up patch on net-next tree removing ipv6_stub and enforcing
> > "depends on IPV6 || IPV6=n".
> > 
> 
> FWIW; removing the ipv6_stub won't keep us from checking ipv6_mod_enabled()
> as ipv6.disable=1 can still be set at booting time and therefore nd_tbl will
> still be non-initialized because ndisc_init() and neigh_table_init() are
> never called.

Ok.

-- 
Sabrina

