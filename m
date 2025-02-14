Return-Path: <netdev+bounces-166367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE6EA35BB1
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED471659E8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64724A062;
	Fri, 14 Feb 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Azw2+unw"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF4204F6E;
	Fri, 14 Feb 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529784; cv=none; b=kXrPfAfFauVLaaB7rAEDtIFmEdDWdTzocw4RwTWw0TeP48rEAbyDN11UsdhCyqhvq9D4Vh5DZh1gRCfmCINnn/WDxq643RdhNh0LbXuzCmlD7AXSHHzgt6puyJR/Qq8VeHU0lsKh5aedzkDJ6TscdYcbtbW9FjC5YdYc5FNt6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529784; c=relaxed/simple;
	bh=8CpuiP9EBQQ9L4hI9DboeB9GoBT6BwMTwHBnbXh4lVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOLkd+jfK8CqniEopHY00GPoFLJFDeMTNFoWKg1raBK+doe7zJK2q4wySkGwHNMWz+8iMNdNLVzpB/D+QtwL5xPGvNTeytqmzrtgYq20yR1BCYbzOAfPNPi2kx+jzya/gPEGfkSe/pWqzAF0c9rWdf0qzTZ5PZouPAlSwYHnWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Azw2+unw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BB4443345;
	Fri, 14 Feb 2025 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739529779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5v7dMykohPWvYReY6PT9eMfYXTFzMIXPQR50pzZiNhA=;
	b=Azw2+unwqmYrX6Fe4aiTuDCnijRpXZC2gemIE33lO3W2x9OCmnqOEyn3U+VUtwmhgc1cj3
	cLY2Cak6FdMwbc64Xq42rOvw3TX3Ef0Gi2Ynz15ZDaVTIiFy1sM1nbgUwuKfhsYfSUnohR
	EZ8RA+F+9RqhkJIdRgGrVLolsSxeqtnk1n0/3RrMq8EJb5udYubIsT0MqlocXZkO23zeJf
	lVB0Imds2cmzYZGUNitfYfonfCbIWj8GJIGOfDYY8osv18tlVOPWRjHgu5kJFaAZcX3ngK
	MSDMVcsY30YA9zg85azXweEyqlJJvgUUPL/60EHyw7PEDQWXOtJozXJAnpVMlw==
Date: Fri, 14 Feb 2025 11:42:54 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: net: phy: Elaborate on RGMII
 delay handling
Message-ID: <20250214114254.0b57693b@fedora.home>
In-Reply-To: <Z68WDG_OzTDOBGY-@shell.armlinux.org.uk>
References: <20250214094414.1418174-1-maxime.chevallier@bootlin.com>
	<Z68WDG_OzTDOBGY-@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Fri, 14 Feb 2025 10:08:12 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Feb 14, 2025 at 10:44:13AM +0100, Maxime Chevallier wrote:
> > @@ -73,8 +73,16 @@ The Reduced Gigabit Medium Independent Interface (RGMII) is a 12-pin
> >  electrical signal interface using a synchronous 125Mhz clock signal and several
> >  data lines. Due to this design decision, a 1.5ns to 2ns delay must be added
> >  between the clock line (RXC or TXC) and the data lines to let the PHY (clock
> > -sink) have a large enough setup and hold time to sample the data lines correctly. The
> > -PHY library offers different types of PHY_INTERFACE_MODE_RGMII* values to let
> > +sink) have a large enough setup and hold time to sample the data lines correctly.
> > +
> > +The device tree property phy-mode describes the hardware. When used  
> 
> Please don't make this document device-tree centric - it isn't
> currently, and in fact phylink can be used with other implementations
> even statically defined. Nothing about the phy mode is device-tree
> centric.

Would "firmware" be more appropriate, or do you want to simply drop the
whole thing ?

> 
> > +with RGMII, its value indicates if the hardware, i.e. the PCB,
> > +provides the 2ns delay required for RGMII. A phy-mode of 'rgmii'
> > +indicates the PCB is adding the 2ns delay. For other values, the
> > +MAC/PHY pair must insert the needed 2ns delay, with the strong
> > +preference the PHY adds the delay.  
> 
> This gets confusing. The documentation already lists each RGMII mode
> describing each in detail in terms of the PHY. I'm not sure we need to
> turn it on its head and start talking about "it's the PCB property".

What I'm trying to convey here is that this description in terms of
PHY-side perspective leads people (me included, but not only) to
wrongly assume that if the phy-mode passed by the firmware is "rgmii",
then MAC inserts the delays, and if it's "rgmii-[tx|rx]id", then the
PHY inserts them.

Which, as you state later, is wrong as "rgmii" means "No need for delay
insertion in either MAC of PHY" and the other modes means "MAC or PHY
needs to insert the 2ns delay".

> > +
> > +The PHY library offers different types of PHY_INTERFACE_MODE_RGMII* values to let
> >  the PHY driver and optionally the MAC driver, implement the required delay. The
> >  values of phy_interface_t must be understood from the perspective of the PHY
> >  device itself, leading to the following:
> > @@ -106,14 +114,22 @@ Whenever possible, use the PHY side RGMII delay for these reasons:
> >    configure correctly a specified delay enables more designs with similar delay
> >    requirements to be operated correctly
> >  
> > -For cases where the PHY is not capable of providing this delay, but the
> > -Ethernet MAC driver is capable of doing so, the correct phy_interface_t value
> > -should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
> > -configured correctly in order to provide the required transmit and/or receive
> > -side delay from the perspective of the PHY device. Conversely, if the Ethernet
> > -MAC driver looks at the phy_interface_t value, for any other mode but
> > -PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
> > -disabled.
> > +The MAC driver may fine tune the delays. This can be configured
> > +based on firmware "rx-internal-delay-ps" and "tx-internal-delay-ps"
> > +properties. These values are expected to be small, not the full 2ns
> > +delay.
> > +
> > +A MAC driver inserting these fine tuning delays should always do so
> > +when these properties are present and non-zero, regardless of the
> > +RGMII mode specified.
> > +
> > +For cases where the PHY is not capable of providing the 2ns delay,
> > +the MAC must provide it,  
> 
> No, this is inaccurate. One may have a PHY that is not capable of
> providing the delay, but the PCB does. 

Sure thing, I can add a mention of the fact that this whole logic of
'who gets to insert the delay' only applies when the firmware phy-mode
isn't rgmii.

> It also brings up the question "how does the MAC know that the PHY
> isn't capable of providing the delay" and "how does the MAC know that
> the PCB is not providing the delay". This is a can of worms...

Agreed, but indeed that's a whole can of worms with so much users than
It's hard to introduce some proper support for that without breaking
existing setups.

> > if the phy-mode indicates the PCB is not
> > +providing the delays. The MAC driver must adjust the
> > +PHY_INTERFACE_MODE_RGMII_* mode it passes to the connected PHY
> > +device (through :c:func:`phy_connect <phy_connect>` for example) to
> > +account for MAC-side delay insertion, so that the PHY device
> > +does not add additional delays.  
> 
> The intention of the paragraph you're trying to clarify (but I'm not
> sure it is any clearer) is:
> 
> - If the MAC driver is providing the delays, it should pass
>   PHY_INTERFACE_MODE_RGMII to phylib. It should interpret the
>   individual RGMII modes for its own delay setting.
> 
> - If the MAC driver is not providing the delays, it should pass
>   the appropriate PHY_INTERFACE_MODE_RGMII* to phylib so the PHY
>   can add the appropriate delays (which will depend on the PCB and
>   other design parameters.) The MAC driver must *not* interpret the
>   individual RGMII modes for its own delay setting.

That's indeed what I'm trying to say :)
 
> In both cases, the MAC can fine-tune the delays using whatever mechanism
> it sees fit.
>
> Whether the PHY is capable of providing the delay or not is up to the
> board designer and up to the author providing the RGMII configuration
> (e.g. board firmware (DT / ACPI) to sort out.) There is no mechanism
> in the kernel that the MAC can discover whether the PHY its going to
> connect to supports any particular RGMII delay setting.

Just to clarify, do you see that patch as useful ? seems to me like the
original version is clear enough to you

Thanks for reviewing,

Maxime

