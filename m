Return-Path: <netdev+bounces-168858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0925A4108E
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384FF3B308C
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0677104;
	Sun, 23 Feb 2025 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A+c6bIUT"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96DB8494;
	Sun, 23 Feb 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740332911; cv=none; b=C9k2HsvQciNZw9jeSy4trg9ohv7EPJWSCWZTdTbt6+r0LHVYuOQNqpmydaueqR/qhDoIJ+Jy+msRB9dOFsB/KGxoELnbgHA/wJlBiKNvdGFhfpACkpi0UtCZazKXlf/ofLtEZkV0mkUd/+VzkCRRwAcZ4VgdCRMc3OBus+oJGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740332911; c=relaxed/simple;
	bh=4UfjUJVL6EGOGnDUASk7Nk6gGEAoFTxt9I7cD5xuAAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewOtT35QfryLimUJrH4JlHnfYUyXc2GMF3/CfDQAIgHr/xOx22G4AM+eW8oooIC9OUJcYoXri7FMC5imlwEYtluFieuBQmZmhasdxZTWPIR3xrvRUa8KpzW+ZVKoIf3AzbVfCRb1JWnG651SVSpXUMII8Y4K8xmPLTzs/UcPoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A+c6bIUT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62C27442F5;
	Sun, 23 Feb 2025 17:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740332901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8SI281pF8B6bZMdoiNrxB/0tFzMYpuiEuhF5KU39lQ=;
	b=A+c6bIUTGIy2tZN6SLMAazGaMk5mxEQeuxJurJ8N8SKOFW1gexpDjxUXoVp5vHsiq+Wsvv
	bfvQHGVWzdRlp7tVdpJpvkWKax8tWZ9c56EVek/uI2riSEw8HlvxRtL3Z1dbRXruX+trkk
	7rtHQl/eQCm1K+RhrJDcVIUGvETWKmHV6OStyfx8v/1gSlRSI+txzY+/QADJNz6htWfUwq
	e1/GSMCPP+OtuTUr7oSFAvlfvxNafxZ2Q3qnRBz39DcUXYeLVPc2lxqd8QpHc/FNlSQPyo
	ilr5B0UvXL/v+7lzdi6EnP7dReKuuX6cgflTnU40BXhiGBPf8l2xZimmqPHVmQ==
Date: Sun, 23 Feb 2025 18:48:18 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Simon Horman
 <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>, Antoine
 Tenart <atenart@kernel.org>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <20250223184818.1d3f7e7b@fedora.home>
In-Reply-To: <Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejieegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtt
 hhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell

On Sun, 23 Feb 2025 17:40:37 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Sun, Feb 23, 2025 at 06:28:45PM +0100, Maxime Chevallier wrote:
> > Hi everyone,
> > 
> > Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" designed to
> > access SFP modules downstream. These controllers are actually SMBus controllers
> > that can only perform single-byte accesses for read and write.  
> 
> This goes against SFF-8472, and likely breaks atomic access to 16-bit
> PHY registers.
> 
> For the former, I quote from SFF-8472:
> 
> "To guarantee coherency of the diagnostic monitoring data, the host is
> required to retrieve any multi-byte fields from the diagnostic
> monitoring data structure (e.g. Rx Power MSB - byte 104 in A2h, Rx
> Power LSB - byte 105 in A2h) by the use of a single two-byte read
> sequence across the 2-wire interface."
> 
> So, if using a SMBus controller, I think we should at the very least
> disable exporting the hwmon parameters as these become non-atomic
> reads.

That makes sense to me, it's best-effort at that point :)

> Whether PHY access works correctly or not is probably module specific.
> E.g. reading the MII_BMSR register may not return latched link status
> because the reads of the high and low bytes may be interpreted as two
> seperate distinct accesses.
> 
> In an ideal world, I'd prefer to say no to hardware designs like this,
> but unfortunately, hardware designers don't know these details of the
> protocol, and all they see is "two wire, oh SMBus will do".

On that particular PHY I'm mentionning, the feature really is advertised
to HW designers as "you connect that TWI to your SFP cage and you're
good". I was very surprised as well when digging deeper and figuring
that not only it's SMBus, and worse, 1-byte accesses only... However
there are already some HW out there with this feature in use. If this
is OK for you to accept that as a "best effort, degraded mode as
there's no hwmon", that's already great :)

Thanks for being so quick !

Maxime


