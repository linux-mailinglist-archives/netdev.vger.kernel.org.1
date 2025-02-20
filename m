Return-Path: <netdev+bounces-168181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E064A3DEC8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C13618916C3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6C1FA84F;
	Thu, 20 Feb 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="AG6GnDh9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkWnMGz8"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1941F8917;
	Thu, 20 Feb 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065841; cv=none; b=OCfeymr0PlSWKmqR8DQ05hpuCz4JukEsersMAEuCWIYvBdsKcwGx4fFdCAyo1wFG4UCE60+pkQXyFqH9m7gpQpHr5CtletfiVfzhrfq0OFg/5wmkf7XDugPlBALjfJ+pMW88uDrVzR+um+vioQGVp0ZPEbeIqVQqtFOEiADQZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065841; c=relaxed/simple;
	bh=q/nUEhrNJ5UehSYMlQVLloZA8WLnpE2yUxDeRzb4+bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3aBono3gmAbrkzyFHmeb6ErneLZejLzyPAaMc6XT1fau8nu9k+YhewRWbH/VTk3jwN9C6scqaNCUEE7Kl0LnPQIRtXyz3lwjs2kmZ2nDCaRcSpkYMhkBHhzKjFKrbHA+8dJAbX19IDYt9kgGxE2xD143QuxDznLc3OaX1BwBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=AG6GnDh9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkWnMGz8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EB4125401BC;
	Thu, 20 Feb 2025 10:37:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Feb 2025 10:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740065837;
	 x=1740152237; bh=B1UvY1IYtLyNW497kJtzd+CU1PZEN0eP92ThkOskQZM=; b=
	AG6GnDh935gzeROMsbH8bh1b58R6MrOvUbP6DFQqZ/7MyHr7GhkS5vTIVUaLTCrA
	MZSv/P0QDZW/aBPlNpduoDFjn1sfyM6RhzcB1be6aEGX5MC+GkWokLDR+V2mAr1O
	BZai20tx0Wxqg6jugGHBCLaRQNfK6WLEVYEhCXuAUvn9mCt/XIY9mP3CUBYO82ui
	giEp/wcmNa9Qfrezn3MNn+wNV82VZqrSMeyi8Grt/GgwzMCYidGQca0TF0Vtc4Iq
	Juch4IofrEsf7qQS9JpG233Sq6sYu8YIiyJJvnco/I9jBH7acM9zUWqU3yaO2Gbd
	VlABO80D4MUy9Xtua/gWDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1740065837; x=
	1740152237; bh=B1UvY1IYtLyNW497kJtzd+CU1PZEN0eP92ThkOskQZM=; b=F
	kWnMGz8Ky8UX7cDYCksEyFgOEdTRn9ipY7nVDupjN5GenCG62SwuJeShLvIkkv+9
	uTwQtA0hz45FstHYiYg5RFQ+H5PyW8qfaOfgFv3vLQckch1urBwXUq/54OW2lvR3
	+8PcFEKLa01sf4qZSVlQJ5QXwrMYdfXoI9s/DoPekLyB60JfWt6SPWiB5NwOrFSQ
	JMHyvA9GnMNuK6Bute0UPUsrRxnwf+CQiwbmjK7a70BOv34Ym6kuqGmInHtzgxMj
	yhXidSSncHE9bjD14UUJXtMFxSzpyC2wrSUKO4dnHFughLvaaCeYW/Q7OLw9S/C8
	enrW0ht6CJ8/7Hc+EOnEg==
X-ME-Sender: <xms:LEy3Z3NwJ60q0mBtlt6AsG-AXzZ00fupoVnmzLMCPb6-UN6XR1R3eQ>
    <xme:LEy3Zx9PzNTcOCy5Szm5xYP6RGhcYbDh_mZ9Q2A4lHSTI80PmaBLXzVyGtEOnVNPi
    -4u967icwjvftlix14>
X-ME-Received: <xmr:LEy3Z2TiB_RTxzdE8wTF16qRf7YLHgMdXVOBXwFghGe9g25snup1HcZMWWpeGTbYjULlSICWYnu0YlEdA6Ri8UogTMievzSe2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheppfhikhhlrghsucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsoh
    guvghrlhhunhguodhrvghnvghsrghssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgr
    thhtvghrnhepffekgfdukeeghffhjeetvdeitdegteeikeffieduhfegveetjeevtdffvd
    ekffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnug
    dorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtphhtthhopeduvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughimhgrrdhfvggurhgruhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthho
    pehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigse
    grrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghn
    ihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhrvghgohhrrdhhvghrsghurhhgvg
    hrsegvfidrthhqqdhgrhhouhhprdgtohhm
X-ME-Proxy: <xmx:LEy3Z7uo1K0UTq276H62J9YqfOlKpR2AP1T5y1p2JmtDWEHVDovP-Q>
    <xmx:LEy3Z_edywU1rN6U_Du7pnqd7BBlfp8l7pwDa_Bzd2UJBkiXXtjR_Q>
    <xmx:LEy3Z33IOLoXI_uyYoZBtN1tI7L_BrRnQIIj1Isx0_9DZevfNzC_Jg>
    <xmx:LEy3Z788J_pt7_gxpFGC0yHQvrYf2VYs-rbopmmg5tdCZebJHqJ_Mw>
    <xmx:LUy3Z93qp58PZirZY1VH53MHHE7eh96Dlv0XTqZ_cPHS07enjbIUc2m6>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 10:37:16 -0500 (EST)
Date: Thu, 20 Feb 2025 16:37:13 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: marvell-88q2xxx: enable
 temperature sensor in mv88q2xxx_config_init
Message-ID: <20250220153713.GE515486@ragnatech.se>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-3-71d67c20f308@gmail.com>
 <20250214175938.GE2392035@ragnatech.se>
 <20250214194526.GB244828@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214194526.GB244828@debian>

Hi,

On 2025-02-14 20:45:26 +0100, Dimitri Fedrau wrote:
> Hi Niklas,
> 
> Am Fri, Feb 14, 2025 at 06:59:38PM +0100 schrieb Niklas Söderlund:
> > Hi Dimitir,
> > 
> > Thanks for your work.
> > 
> > On 2025-02-14 17:32:05 +0100, Dimitri Fedrau wrote:
> > > Temperature sensor gets enabled for 88Q222X devices in
> > > mv88q222x_config_init. Move enabling to mv88q2xxx_config_init because
> > > all 88Q2XXX devices support the temperature sensor.
> > 
> > Is this true for mv88q2110 devices too? The current implementation only 
> > enables it for mv88q222x devices. The private structure is not even 
> > initialized for mv88q2110, and currently crashes. I have fixed that [1], 
> > but I'm not sure if that should be extended to also enable temperature 
> > sensor for mv88q2110?
> > 
> Yes, according to the datasheet. I don't have a mv88q2110 device, so I
> can't test it. I would like to see it enabled. So if you can test it and
> it works why not enabling it. Thanks for finding this.

Thanks for confirming. I will attempt to test and enable this once as 
soon as I can.

> > > 
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > 
> > In either case with [1] for an unrelated fix this is tested on 
> > mv88q2110.
> > 
> > Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > 
> > 1.  https://lore.kernel.org/all/20250214174650.2056949-1-niklas.soderlund+renesas@ragnatech.se/
> >
> [...]
> 
> Best regards,
> Dimitri Fedrau

-- 
Kind Regards,
Niklas Söderlund

