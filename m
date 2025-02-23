Return-Path: <netdev+bounces-168857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0285A41087
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 18:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD679173281
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D0142903;
	Sun, 23 Feb 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CE3fL50F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F1A95C;
	Sun, 23 Feb 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740332453; cv=none; b=G9B1ytcK/6BugBOCBcWa7LyJq94RRk5WOeIdUuIPkuM1+CyaL9HOOpw8JTQ0RVfXZacpE0f747CvK5MQZF5G5Uo1nnUutI94cI7v8c2XGDyV6uAX6jM9aW/DN5ix5MrQCmft8Tz0pfkV8uLmU7DNllVFhwawDhL4sKjWOwaK4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740332453; c=relaxed/simple;
	bh=0+pak3Wc6pxZcsmj/iYEn4UcN835LNASJKuqfMubFsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiwx0q3OhRkP5MuUJ8T1Sl2X5Z9fGqRlwUwk8XJ4eqC5oZfRO1Hph6XK9Kxqq/ExNSG2qBKAuidVs1p6XG3GbgEjGctIR6g1NozMjQ0TAw3u+9hztaLVvqD5OULdJYw5jrovBVFasvvvGG5MwXE3VQtIsXxO1YeMO0rKyDQq9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CE3fL50F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0iNFIrb2QkfLvHmeZSAzyRRdfOTZD7hIHYVlu83O1xk=; b=CE3fL50F0JyA086RS6aS8EfJym
	6Frf1jk05XL2ekvkiTH+hbRgZrPXQ7/waMlfjoFe1VMmNscjQ9p4khnZJ/yS9PIG44xJwUeMXAssI
	WnK+FqBdI17jsMOvBvTInGLgXffZpHdMV4B9e9WYR5tNt6x4nLfhd81n5HP7/lJTyONTnoB5fYOVF
	ljIgr37j+xsYaX6yxlBA5bWBUhdG6zpPFtwbUOLEX4nrkW3gyIYXYMPkAuaKdkqtaCWLQjxYjhvY8
	M0OfaRWXHYLSob5q6DNytyTDyQS8WPGCmYzapWO24wEH8NzlwZ7f0N8BFrq9PV6NMeksXvmQBZ7Gx
	aj8h6t0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52820)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmFy5-0003cr-2g;
	Sun, 23 Feb 2025 17:40:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmFy1-0004AN-2j;
	Sun, 23 Feb 2025 17:40:37 +0000
Date: Sun, 23 Feb 2025 17:40:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 23, 2025 at 06:28:45PM +0100, Maxime Chevallier wrote:
> Hi everyone,
> 
> Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" designed to
> access SFP modules downstream. These controllers are actually SMBus controllers
> that can only perform single-byte accesses for read and write.

This goes against SFF-8472, and likely breaks atomic access to 16-bit
PHY registers.

For the former, I quote from SFF-8472:

"To guarantee coherency of the diagnostic monitoring data, the host is
required to retrieve any multi-byte fields from the diagnostic
monitoring data structure (e.g. Rx Power MSB - byte 104 in A2h, Rx
Power LSB - byte 105 in A2h) by the use of a single two-byte read
sequence across the 2-wire interface."

So, if using a SMBus controller, I think we should at the very least
disable exporting the hwmon parameters as these become non-atomic
reads.

Whether PHY access works correctly or not is probably module specific.
E.g. reading the MII_BMSR register may not return latched link status
because the reads of the high and low bytes may be interpreted as two
seperate distinct accesses.

In an ideal world, I'd prefer to say no to hardware designs like this,
but unfortunately, hardware designers don't know these details of the
protocol, and all they see is "two wire, oh SMBus will do".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

