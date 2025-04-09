Return-Path: <netdev+bounces-180744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D78A8252F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D793BF556
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B925F7B7;
	Wed,  9 Apr 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CiCTfqev"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E725D918;
	Wed,  9 Apr 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202820; cv=none; b=cJMswp86pAPEE7FrQnBtU1C6kPgKcsvrRiL6rsyoUWKNjlfFt/fdzm2cxaChqz8jAYfKGBZR6VDubiR6iBGDcsADz4GEz3zBrMMXzkk+CvDvk3TlzGZnb+mXqotrxRurBaK+SIMs1Vln5jbR3vRFWBY5M/upESwvDhclKQD7PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202820; c=relaxed/simple;
	bh=rIgXyEvLCLwUur3A9mieiCA636AMIEFJdwhc2bTEPXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcdtqaRS6CAJklS40l9ooTIZBHj8IWI/rDI4jCkwJYFAlLBHrMdVC20PIufvoWhbuZDYQgyf1YpG3EFuvgindOGenpWvxbG+PEIsb4yPk8RcM34Vg+/DgmpTz+8MDZPX8F0yemH65/jt74QUG2sZI3wixNgoHLwVi5flM1qTfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CiCTfqev; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C2BB44154;
	Wed,  9 Apr 2025 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744202816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FF4tLOudDlWUyIhsXqvwgxpBbK+Z9OKBA6LBsPGjCio=;
	b=CiCTfqevfqWVKVVsNSc630QYRe0CXD+59RQore3LY3/DmxCWQhp0dmoGYdQACE1ijRNVMy
	lD7agIJCvsLuMH7/i/oAs9yERneJJZQs0CH8jmuQayQsCQvFCIt/sC5ZRglnQZVoNBcIcw
	V5lioze/0CccaS38sn6JxRpnhFgSsh/wQjx++8Wtii4hXRxV1tN8pFHLGYrAE9zdFuvQp+
	Cqjeqpsi9bmu3O+8HmCWzIjUeXRk65yrGO1klr314kDTV/25HGNXcb5hY4f1fFbYvhGwRr
	FYwIoZ5XWdkfxVJto/50d5ASlX2S7GrYb8pQv7lAC6lMrKGPShcrHPIf/nkIiA==
Date: Wed, 9 Apr 2025 14:46:54 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVo?=
 =?UTF-8?B?w7pu?= <kabel@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <20250409144654.67fae016@fedora.home>
In-Reply-To: <20250409142309.45cdd62f@kmaincent-XPS-13-7390>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
	<20250407182028.75531758@kmaincent-XPS-13-7390>
	<Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
	<20250407183914.4ec135c8@kmaincent-XPS-13-7390>
	<Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
	<20250409103130.43ab4179@kmaincent-XPS-13-7390>
	<Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
	<20250409104637.37301e01@kmaincent-XPS-13-7390>
	<Z_Y-ENUiX_nrR7VY@shell.armlinux.org.uk>
	<20250409142309.45cdd62f@kmaincent-XPS-13-7390>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeitdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrt
 ghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 9 Apr 2025 14:23:09 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 9 Apr 2025 10:29:52 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Apr 09, 2025 at 10:46:37AM +0200, Kory Maincent wrote:  
> > > On Wed, 9 Apr 2025 09:35:59 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:  
> 
> > > > Right, and that means that the kernel is not yet ready to support
> > > > Marvell PHY PTP, because all the pre-requisits to avoid breaking
> > > > mvpp2 have not yet been merged.    
> > > 
> > > Still I don't understand how this break mvpp2.
> > > As you just tested this won't switch to the PHY PTP implementation.    
> > 
> > How do I know that from the output? Nothing in the output appears to
> > tells me which PTP implementation will be used.
> > 
> > Maybe you have some understanding that makes this obvious that I don't
> > have.  
> 
> You are right there is no report of the PTP source device info in ethtool.
> With all the design change of the PTP series this has not made through my brain
> that we lost this information along the way.
> 
> You can still know the source like that but that's not the best.
> # ls -l /sys/class/ptp
> 
> It will be easy to add the source name support in netlink but which names are
> better report to the user?
> - dev_name of the netdev->dev and phydev->mdio.dev?
>   Maybe not the best naming for the phy PTP source
>   (ff0d0000.ethernet-ffffffff:01)
> - "PHY" + the PHY ID and "MAC" string?

How about an enum instead of a string indicating the device type, and if
PHY, the phy_index ? (phy ID has another meaning :) )

Maxime


