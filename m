Return-Path: <netdev+bounces-169597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D450EA44AE1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB83519E1537
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DD1A38E1;
	Tue, 25 Feb 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BPmyylDZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E921207DE0;
	Tue, 25 Feb 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509316; cv=none; b=oEbiHl8HCT89s8w0wOw4MHDvlDpUrepU8Pij0oY0/z5iPL2+BwUUU00iIprxxSitjZx7IN9rYMj3R8I6mUmI1vZ7z/Qon2GRtoGhhVDJ8srS1ew2bdHsLfbxS4izAozzsEOej6dpH6uxNH87FMfj3KLAOzeqEpBnrlhCe2Z/MSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509316; c=relaxed/simple;
	bh=c1AWhEQKXBN0pDxq/6dbjwZZ7dZ8/2abYpSUcIwcCb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7/Qf0lyrBwHazzuBqj5AmsvylCqMxwTGwiMgsPjW83199N8YBorMq4CyL0CHRIFbqzXQcUb3HdIbR3YEV8VYeZ4WQzZeAs7Yd9iME5ToGXm+dan49maKiRDZI2Gr8B7+gKa56veMEXohdMuWQkP++AW4qPgTSL+1X4ST2Q26kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BPmyylDZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48ED54435C;
	Tue, 25 Feb 2025 18:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740509312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8UIDh5lGL3kiPNmlRgHMn2oJTdbmJuHjGWmpptPu70=;
	b=BPmyylDZSev8v1FhSAMvsthjGSDN6XPMp0aVBNKz7Tjpe3glccSjGQErP/eEjpZASoWs/K
	hy+m1IAILfLTeo7gbxC4UC9uAvup77OJ+VYOR6UL1CLVKL/KOasQod0nO2xjV7Cyb0nb3Z
	KRPUReH7Lr2s36jjjSw5vyJP0Ioi9OHRdcStsmiUZyIQ6weKfJL7eeU+AE3KNPGpaK3Bd9
	gqNFT4TxZW3s0usheUBZvd/0F6KMQkilCyhh8Be/Z4D149Ah7pgnB5CD1GzW5fER0VOeud
	PDPGOxKH64rfz3TzBkdOfkuYKW7CUBjBuAwTZHxVTN6NkDUpsPZxKyUzrmfFPg==
Date: Tue, 25 Feb 2025 19:48:29 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Florian
 Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, Romain
 Gantois <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <20250225194829.724eca08@fedora.home>
In-Reply-To: <cd630175-d0e4-41e3-bc4c-41d32647e9ed@linux.dev>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
	<20250225112043.419189-2-maxime.chevallier@bootlin.com>
	<Z74GLblGUPhHID8a@shell.armlinux.org.uk>
	<cd630175-d0e4-41e3-bc4c-41d32647e9ed@linux.dev>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehsvggrnhdrrghnuggvrhhsohhnsehlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtr
 dhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Sean,

On Tue, 25 Feb 2025 13:41:57 -0500
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 2/25/25 13:04, Russell King (Oracle) wrote:
> > On Tue, Feb 25, 2025 at 12:20:39PM +0100, Maxime Chevallier wrote:  
> >> The SFP module's eeprom and internals are accessible through an i2c bus.
> >> However, all the i2c transfers that are performed are SMBus-style
> >> transfers for read and write operations.  
> > 
> > Note that there are SFPs that fail if you access them by byte - the
> > 3FE46541AA locks the bus if you byte access the emulated EEPROM at
> > 0x50, address 0x51. This is documented in sfp_sm_mod_probe().
> > 
> > So there's a very real reason for adding the warning - this module
> > will not work!
> >   
> 
> I had a look at sfp_sm_mod_probe, and from what I can tell the SFP that
> I was having issues with should have been fixed by commit 426c6cbc409c
> ("net: sfp: add workaround for Realtek RTL8672 and RTL9601C chips"). I
> re-tested without this series applied, and the SFP still worked. So I
> guess I don't have an SFP module with the issue this series is trying to
> address after all.

I see, this series actually wasn't supposed to solve that at all (but
it's true that the solution was to fallback to 1-byte access, as
Russell explains on that thread) :)

The use-case for that series is to deal with situations where the Host
(i2c master) is only capable of 1-byte transactions (it's not a true
i2c controller, but rather a very limited smbus controller) :)

Maxime

