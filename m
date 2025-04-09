Return-Path: <netdev+bounces-180828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCCA829E4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA9218932DA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6EF266B4F;
	Wed,  9 Apr 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eHbAXIt0"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7719ADA4;
	Wed,  9 Apr 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211468; cv=none; b=pKVOAyZ1FFxa27Ed+0plt5S7bGY85agw9vuGAoWxtwzLKfQ5qXY1XMWm+M+jMkcmOF1mwlAtyfXjl7WpMI0fyqdqVdJjm0isuyBVLLTUwTjfsxE7/tOEquD+kSaFBo7asLJMhNNe1FIczc3XIKb4Gzx+2ypAX4qcm/ilIVxwopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211468; c=relaxed/simple;
	bh=/9MNo/b3aUMSZDOA5cxzOGNwbKfQ6+ukMR7jtjZC6RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUkWaulPHjVzqzi/2Bxx0LdmaTq7ThoAp7IZqkkvym2K0j9+xfZGr8Dz6mwbbX+vyWNlG96LKI8t2XlgrCI4xop4MlPCOGpJkzzRlMv7PJdbm3uSCb+pluqoTx5zBDhwAX/mcavY6QOHyd9hDW0+yKhsYIbX8oFeQTHDXcvaCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eHbAXIt0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73E85442C9;
	Wed,  9 Apr 2025 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744211462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ItW3vIShknOIc1VpsRjD/4TB14rmx7VFYiWFY7Boh0=;
	b=eHbAXIt0rXPJr6xrZCtPWry/QZ5KgBztqYxtAaUATqrBOIR8PIh1RqdEv+Zk10dcKAxTV3
	zN6epN90bTiZHzMdlkZXtPXM896b7GQS7p2kWcob4udD3+Rrrk7Sr7Ec/J6zsWrC4ssRvf
	9XK/GLCt3Im7eWVDQAFU5KiCs1hlvFV73lMuyyQiThQmnbQ5VjRwdiMJho0kgs+51asBqY
	671w+/pUL6co9kHCONtz7gA9wCsnOIFsNtf8zZEErR4el2XLmbIlwQQw4rz/baHPSlEgov
	+OYg50cu4RG+LTYc+mRbMfmW2ByEY0iJsMUGhIgbynpjYEQKb8IEDKMfG5sGMg==
Date: Wed, 9 Apr 2025 17:10:55 +0200
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
Message-ID: <20250409171055.43e51012@fedora.home>
In-Reply-To: <20250409164920.5fbc3fd1@kmaincent-XPS-13-7390>
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
	<20250409144654.67fae016@fedora.home>
	<20250409164920.5fbc3fd1@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeifedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrt
 ghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 9 Apr 2025 16:49:20 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 9 Apr 2025 14:46:54 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
> > On Wed, 9 Apr 2025 14:23:09 +0200
> > Kory Maincent <kory.maincent@bootlin.com> wrote:
> >   
> > > On Wed, 9 Apr 2025 10:29:52 +0100
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > >     
> > > > On Wed, Apr 09, 2025 at 10:46:37AM +0200, Kory Maincent wrote:      
> >  [...]    
> > >     
> >  [...]  
> >  [...]    
> > > > 
> > > > How do I know that from the output? Nothing in the output appears to
> > > > tells me which PTP implementation will be used.
> > > > 
> > > > Maybe you have some understanding that makes this obvious that I don't
> > > > have.      
> > > 
> > > You are right there is no report of the PTP source device info in ethtool.
> > > With all the design change of the PTP series this has not made through my
> > > brain that we lost this information along the way.
> > > 
> > > You can still know the source like that but that's not the best.
> > > # ls -l /sys/class/ptp
> > > 
> > > It will be easy to add the source name support in netlink but which names
> > > are better report to the user?
> > > - dev_name of the netdev->dev and phydev->mdio.dev?
> > >   Maybe not the best naming for the phy PTP source
> > >   (ff0d0000.ethernet-ffffffff:01)
> > > - "PHY" + the PHY ID and "MAC" string?    
> > 
> > How about an enum instead of a string indicating the device type, and if
> > PHY, the phy_index ? (phy ID has another meaning :) )  
> 
> This will raise the same question I faced during the ptp series mainline
> process. In Linux, the PTP is managed through netdev or phylib API.
> In case of a NIC all is managed through netdev. So if a NIC has a PTP at the PHY
> layer how should we report that? As MAC PTP because it goes thought netdev, as
> PHY PTP but without phyindex?

Are you referring to the case where the PHY is transparently handled by
the MAC driver (i.e. controlled through a firmware of some sort) ?

In such case, how do you even know that timestamping is done in a PHY,
as the kernel doesn't know the PHY even exists ? The
HWTSTAMP_SOURCE_XXX enum either says it's from PHYLIB or NETDEV. As
PHYs handled by firmwares don't go through phylib, I'd say reporting
"PHY with no index" won't be accurate.

In such case I'd probably expect the NIC driver to register several
hwtstamp_provider with different qualifiers

> That's why maybe using netlink string could assure we won't have UAPI breakage
> in the future due to weird cases.
> What do you think?

Well I'd say this is the same for enums, nothing prevents you from
adding more values to your enum ?

Maxime

