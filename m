Return-Path: <netdev+bounces-270627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDTYBIWGwWn+TgQAu9opvQ
	(envelope-from <netdev+bounces-270627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D12FB4D3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62A6A304C7DD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26103BFE24;
	Mon, 23 Mar 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ZK+Xnnov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MpSTdqOp"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097493C279E;
	Mon, 23 Mar 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286230; cv=none; b=kyHr0v7vjPgv/qt3dQfHUr0Bmyalqe+tx4RarlBVmgH06R05JJ1XhqsZXpOgS48/wVzIAXYNugI5GD22Q15Unrts+aMAm+C3Zh/NL/sYOxXkxd3C7EtGcaK3DmT71Q6Mo/eqdEvnlJmnJaOnhX6STPegxVTsoXoyrIQG5RHiNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286230; c=relaxed/simple;
	bh=MFrZYJpprDoL0spYqxHqSFMH4VKZZi/mvJOw56ruEi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPid03bQrzba6xm12jwRCmY4NR8H+tTfRAP/pHicoVEK1pg67tVWXtIOwURNqZEQEk+w9I2D9vQyczEc/ojsdjOl3EsTEfMLx+8x6ZN+7GHd9fMmxL3jUzjpIKO3svxSremA+Z8ZsqwVYlADZR3v9hcQB5v5DwU+wzHDJkxc0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ZK+Xnnov; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MpSTdqOp; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F36B7A022D;
	Mon, 23 Mar 2026 13:17:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Mar 2026 13:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774286224; x=
	1774372624; bh=CEUxeZYmAiHA8QMMvhe5S1fWFkCW3pXVm0T9S/tFENM=; b=Z
	K+Xnnov7oq0u0ERuJExW4bWxmaVds3AXxZRSx+wL0da1I6lrSkd30r+/x+B/VhOK
	kDK88mKMEAGsIFxGH+mn3/gjAuQtPoDP2Zl6IxLilNtRu5y5e9xceGcrjAblXah+
	YqrvRroDk0QTqtnMn1s/vCqMvA2SKEmK+kbDLruVG7She3eKF838iELq1QaD+QpT
	/mOicFyzaMjeLiIpgF7vuJyt1kUsLNFl6ly8/Q8piF1jvIB/nhtoSw2RDGosYVVX
	aNKMg0W+lhWd1WKBenjvzdyvTUl0i+eKfLpDXlNplDKp5HkdeMXVE5fi3AOqpVWW
	TteZia4X5KaBmc+iakeZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774286224; x=1774372624; bh=CEUxeZYmAiHA8QMMvhe5S1fWFkCW3pXVm0T
	9S/tFENM=; b=MpSTdqOpjxL6BN83BdQ8nWWxejoQudn8DkuaSoWiIL973fHYr/I
	a83OQjhDXSAQ7IWrqI2OgXXrdtYw4RmlhjcCqEB0vf3ype0u9XHmzM4NmkrP9ac3
	EV/Du8LTHvu9SeNZkw0d3tirtIehzIBuq3smZRTaRbqi1TDzhwp0/f24E6zVvufG
	jfecRYAb0F2YeuPfb4z21ExuxnPGKg4iuf09TpNkHy+RZmvBwp5/u5YYei+f12Bw
	UDWpgKGrrhbjGTc9nbw4EsifeNSuwyNWTqVFxr3Qt4UgkI7LTWDSfYa+Deq0BSFf
	+YDaPsYOm9W/M7s58bUGHohuUTMYiR3CEAw==
X-ME-Sender: <xms:j3XBaWAJAkqkCA0bGDLeQ0uSrFbWVN0LpRB1YafIqDE5QekA-x_GfQ>
    <xme:j3XBaTk_P2yH6y6wHujNw6vPWsAFQcnedD8ECXrhZPa_IU_N_XxUOpKitJiXOfsYs
    -K9_KpXr4pvkyx56cfZoaOuZP8C8-a-sD188Modte4L6OnjSDVD>
X-ME-Received: <xmr:j3XBaUP5ZPzI9i2y0EZI2a97ITRi_QVscccqE0UEEzrHFiIDOx2KNDiHS5No>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghnughr
    vgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguthgrthhulhgvrgesnhhvihguih
    grrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvth
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:j3XBaQ_LtuuCLsL8HUr7tfN9zqTEROtuw2WkJDluta4rtXH_noPkXA>
    <xmx:j3XBaWFY2F5K9LdHy_lHl6mQkEoFu_iX5_NQkT1RigM3khHsEPhyFQ>
    <xmx:j3XBafjXYhtCmPOY0oJZk2xvdzyB6DPMgvbweooDsmyai7hEklbWJQ>
    <xmx:j3XBabuGOSm3C6oPAynkSXuY6cQyCXuDE-sGsLbWkFNJsr03rZ03hg>
    <xmx:kHXBaXrDAwklWbA_tkmIC2rzO7b7hPzdzFhz3Puu69SlUEoc5ioy5aaW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 13:17:03 -0400 (EDT)
Date: Mon, 23 Mar 2026 18:17:01 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v5 0/3] macsec: Add support for VLAN filtering in
 offload mode
Message-ID: <acF1jeGLpq7qDKgY@krikkit>
References: <20260323123633.756163-1-cratiu@nvidia.com>
 <acFODtfaa8LCKX4r@krikkit>
 <5ae5d08d578fce1a01a548fad8552a14df8c5679.camel@nvidia.com>
 <acFWIxzM-GxpAhjH@krikkit>
 <20260323093243.17c14edb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323093243.17c14edb@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-270627-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 8B7D12FB4D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-23, 09:32:43 -0700, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 16:02:59 +0100 Sabrina Dubroca wrote:
> > 2026-03-23, 14:42:00 +0000, Cosmin Ratiu wrote:
> > > On Mon, 2026-03-23 at 15:28 +0100, Sabrina Dubroca wrote:  
> > > > Why not? Being able to test without accessing real HW is still
> > > > useful.
> > > >   
> > > The tests now send macsec traffic over VLANs and nsim, it's just that
> > > nsim doesn't deal with VLAN filters at all and there are no stubbed
> > > vlan filters in debugfs, since real hw doesn't have that interface.  
> > 
> > Since netdevsim doesn't deal with VLAN filters at all, the "tests
> > should be written so that they can run both against ``netdevsim`` and
> > a real device" bit of the docs doesn't fully apply here?
> > 
> > Anyway, I think the original tests had value, even if they're more
> > limited in some ways than traffic tests. HW/driver behavior could be
> > hiding problems in the stack with VLAN propagation, those simpler
> > tests don't have that risk.
> 
> To be clear running the HW test without NETIF= should provide
> similar functionality to what the old tests could do. It's entirely
> okay to add netdevsim-specific subtests/test cases or asserts.
>
> Is there anything specific that you'd like to be tested?

In v2/v3, nsim was exposing a debugfs file that contained the list of
VLAN filters on that interface, and the selftest was grepping through
that file to check if the correct entry was added/removed after each
operation. I see that as testing the actual propagation of filters,
while the traffic tests check the visible behavior of stack+driver+HW,
which may not be correlated to actual propagation.

> Let's not make this about HW tests vs nsim-only tests.

That was not my intention. But since nsim doesn't currently implement
VLAN filters, it seems running the HW test on nsim doesn't test
anything at all.

-- 
Sabrina

