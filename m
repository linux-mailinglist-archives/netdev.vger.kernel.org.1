Return-Path: <netdev+bounces-176787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD0A6C22D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BE84827D9
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95041E7C25;
	Fri, 21 Mar 2025 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UDGkLwOJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF113C695;
	Fri, 21 Mar 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580940; cv=none; b=RhO0DwKpUGuzSK7j2V3d5x8jmWJwxmAxl7Wjb+GZpuDfP9Xk4BFocl6rfjsv47uTFt3zLFM862SogQdiazseyFw5o/ILaW6Q65ifX2+XgarENgOSv5q+SgXaFQeFYdYsjCWTPmCBJ01Q55Wt0UEcJnIFjKQEExr/Th/KBdQzLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580940; c=relaxed/simple;
	bh=iAq4y/BTk/MAEwUl7X+7XcMLVXDWQGMRVeU3Cnms5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1Bb3Wa2GvjYTyaxbMwZvdAaTL4DRftjpyHHLNnydl0uuQQ3VRcOqkpQ+uMlS29m1ZaRe+b9ppi6sw88Uw4dgF4uCnR0J0iXseoh2bvnxH9VXd2/Ifr0h0bmiIBE4o8OBRKfrtOGXtp+nDsYV8i4PNrejMNPbPSA4rW2VvKiFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UDGkLwOJ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 309B2442C9;
	Fri, 21 Mar 2025 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742580936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9i89mOUewMbia4ZPRxR3kcufVYyKXRfB/Vul82O5Bbs=;
	b=UDGkLwOJHkLDgxwCxRitwd7kkWi0RaDTLb3Wx9JrIe3eq/TKlDlSjMKhD2YIy4ELuc1bDi
	kahWsSTPhwb0wN3kZx25zZMrOVEPyxh0Ob6lvnXGLVPYIOR6V9pnA76Gs87c6PgAmb4mwK
	bz7s8VdunP4FdVY0Xc8+tmZExUrjhcbZcW2VB7bSUX+w4yuhhhonl0P92IQxef9a7ogUqf
	StLBBBPbPzls3iVnNjaf/uIKcIK6aqUQGEhV7uWJmFxhbe+7mzXqg0jzQvuN8Yr2/I2PJa
	dUB8qBoKnNcEDVSyg6sd9mhb3tEbno4v1juAC9pzm48t5BQwodhph9xwy/0SGw==
Date: Fri, 21 Mar 2025 19:15:34 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman
 <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Antoine
 Tenart <atenart@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>
Subject: Re: [PATCH net-next v3 2/2] net: mdio: mdio-i2c: Add support for
 single-byte SMBus operations
Message-ID: <20250321191534.39e00de3@fedora.home>
In-Reply-To: <20250314162319.516163-3-maxime.chevallier@bootlin.com>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
	<20250314162319.516163-3-maxime.chevallier@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedujeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 14 Mar 2025 17:23:18 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> PHYs that are within copper SFP modules have their MDIO bus accessible
> through address 0x56 (usually) on the i2c bus. The MDIO-I2C bridge is
> desgned for 16 bits accesses, but we can also perform 8bits accesses by
> reading/writing the high and low bytes sequentially.
> 
> This commit adds support for this type of accesses, thus supporting
> smbus controllers such as the one in the VSC8552.
> 
> This was only tested on Copper SFP modules that embed a Marvell 88e1111
> PHY.

As a side note, it's kind of a strange coincidence but I just had
access to a weird SGMII to 100BaseFX module (so with a PHY), and from
my tests the PHY only responds to single-byte MDIO accesses !

Trying to access the PHY with word transactions on 0x56 actually causes
the i2c bus to lock-up...

For the curious the module is a CISCO-PROLABS   GLC-GE-100FX-C, and the
PHY id indicates it embeds a Broadcom BCM5461, probably strapped in
SGMII to 100FX mode.

The EEPROM reports strange things though, and I can't get that module to
work at all, the SGMII autoneg appears to go wrong and I get link
up/down events all over the place without anything ever going through,
so I don't think I'll upstream the fixups for the module. Still it
may be another use-case for single-byte mdio-smbus.

Maxime

