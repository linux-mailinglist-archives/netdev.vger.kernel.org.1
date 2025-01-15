Return-Path: <netdev+bounces-158439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C5DA11D88
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D0F1883DB9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF261EEA34;
	Wed, 15 Jan 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5Z8LU1F"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6024816B
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933081; cv=none; b=R4w5YgoBA4CfNu0b+qMnS1q4wDq0tpl5l0yi5itBGjnXp7AjtiBPpF6w55QksDxU/iQv9gY1/LrIZxwtPVr84JZnUwxU3RF4jLef/kU/d4hjqfkHGY0Opk+nC6vkuYP2O7/DxjzHa+9ZbjtLFxRNt3KYK+VsD9i/iaPiSHGr4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933081; c=relaxed/simple;
	bh=EEViTpeuQcob1WV5vfj9iH4feXHPCzTxmzRdXZ6qK2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPep4mSVI1eGjZzETWMxbh0eBtK/tIdqXg9e6GDvhEQ8/mpG+whcDhR41L+6hOWXELnKng2aEmxzSa4i/b3INoWb7SYsPtk2QU/QX+QYVUySXYEuhxplcUVopG0HRK7Q8fE/ActZCio8aCVPErYb0X4FhwQPQTlMdoCoUPMUNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5Z8LU1F; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 670881140189;
	Wed, 15 Jan 2025 04:24:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jan 2025 04:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736933078; x=1737019478; bh=yz4wd6ZNf4vtBKWnmJn+G16UtGYC/oB/sxb
	ScU5Qv2Q=; b=m5Z8LU1F1WiQbzuJ8Z2tyt6iezgG0e1lnZH9R6XZhXFSMmDCAYG
	9rTv4Oy6yvB2+m0ZPacBwN4TyJUQC04coG/41ybCiwx9j0YsDjH5x0swKqE+x7A9
	oQOTP5nKfZ6EPP08QCD92n+XNLJMgJiPFQPEjXtH0uzqRAe4Jh6gwpoSG6qLLYLV
	GRLZ3sOxbwYAXbRa/Guit/5i1JVU7DrihV1suMB/g9UwN4Fcfa8JEeJpBT7QkbRJ
	Rwu8c2dZpOOL07NFVE0s4ORpitbTmrgqvC1HtrlQ0dB6aFxY9Uw9CD7rWLSufA18
	g5zFglNGQg2UpM5DAVEHw1ohAHN9nSa36uw==
X-ME-Sender: <xms:1X6HZ_G4RvDKS8CpP2BUMYy-HPw9_3Hggi08iHzOnn3t7PZch5U5zA>
    <xme:1X6HZ8VgZ5yAmUhOCmvsUGlTpwuObZK-ZXhhMf76PpZDh7ktc3ZvJAA17_k7eWQU9
    l-SE89U0vHYKmU>
X-ME-Received: <xmr:1X6HZxKK8Xu772P2SzWSqgmSAhth9fTuAgmgtBMy5EnZ7RWfcdtK3p4wmjO_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehkedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhiivghmhihslhgrfi
    drkhhithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhirhhisehrvghsnhhulhhlihdruhhspdhrtghpthhtoheprghn
    thhhohhnhidrlhdrnhhguhihvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepvgguuh
    hmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1X6HZ9FhX_HqpBMfWcSppTsLSsgx-l63vrR7yBSBHkLA7w6On1l8uw>
    <xmx:1X6HZ1Uwbh7jTV8ijHkcwO6PD2zryXsUwRC9rg1-yUfA3DuL_58bKQ>
    <xmx:1X6HZ4OOmbm4R0CJyyc0BS7rYW0hyAD6_iUA2jjypJVPQ-ndk1AWJQ>
    <xmx:1X6HZ03xzGlNCXlhKduO6fqugkOdlSSTZiG3eZvmtSnwyRLpRSxi-g>
    <xmx:1n6HZ-OBRe265cN26O-JWQjbp4BhL1xpuTNRVNz0P6aTAoSZIlHUlxpI>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 04:24:36 -0500 (EST)
Date: Wed, 15 Jan 2025 11:24:34 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	jiri@resnulli.us, anthony.l.nguyen@intel.com, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jdamato@fastly.com, davem@davemloft.net
Subject: Re: [PATCH net-next v2 01/11] net: add netdev_lock() /
 netdev_unlock() helpers
Message-ID: <Z4d-0sV70xAX0SIz@shredder>
References: <20250115035319.559603-1-kuba@kernel.org>
 <20250115035319.559603-2-kuba@kernel.org>
 <e7479c79-525d-4796-b9ed-7ae2ddb5435b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7479c79-525d-4796-b9ed-7ae2ddb5435b@intel.com>

On Wed, Jan 15, 2025 at 09:36:11AM +0100, Przemek Kitszel wrote:
> On 1/15/25 04:53, Jakub Kicinski wrote:
> > Add helpers for locking the netdev instance, use it in drivers
> > and the shaper code. This will make grepping for the lock usage
> > much easier, as we extend the lock to cover more fields.
> > 
> > Reviewed-by: Joe Damato <jdamato@fastly.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > ---
> > CC: anthony.l.nguyen@intel.com
> > CC: przemyslaw.kitszel@intel.com
> > CC: jiri@resnulli.us
> > ---
> >   include/linux/netdevice.h                   | 23 ++++++-
> >   drivers/net/ethernet/intel/iavf/iavf_main.c | 74 ++++++++++-----------
> >   drivers/net/netdevsim/ethtool.c             |  4 +-
> >   net/shaper/shaper.c                         |  6 +-
> >   4 files changed, 63 insertions(+), 44 deletions(-)
> 
> Thank you,
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> and Ack for iavf too
> 
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index bced03fb349e..891c5bdb894c 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2444,8 +2444,12 @@ struct net_device {
> >   	u32			napi_defer_hard_irqs;
> >   	/**
> > -	 * @lock: protects @net_shaper_hierarchy, feel free to use for other
> > -	 * netdev-scope protection. Ordering: take after rtnl_lock.
> > +	 * @lock: netdev-scope lock, protects a small selection of fields.
> > +	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
> > +	 * Drivers are free to use it for other protection.
> 
> As with devl_lock(), would be good to specify the ordering for those who
> happen to take both. My guess is that devl_lock() is after netdev_lock()

devl_lock() protects the entire devlink instance and net devices are
registered under the instance lock, so I expect the order to be:

devl_lock() -> rtnl_lock() -> netdev_lock()

> 
> > +	 *
> > +	 * Protects: @net_shaper_hierarchy.
> > +	 * Ordering: take after rtnl_lock.
> >   	 */
> >   	struct mutex		lock;
> 
> 

