Return-Path: <netdev+bounces-169560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71562A449DF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D6D3AD202
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26E17E01B;
	Tue, 25 Feb 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c2VUrjAK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DFEEA9;
	Tue, 25 Feb 2025 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506683; cv=none; b=DZswjWd5mO282Q3rOQdLz3lZBfTN+pSy+eMWqvWzOKWglAIi2l1KfY3CVgjATGMiGkVEnU95pcIeo9bt9UkzpThZpq7Al1BrjGRlTjO5JPaQsCDqqjtJDHnVMRYqAVSKiWGH4FRP/dw/dXWmzOw5hqDQR3q/O8kWpysYRru8my8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506683; c=relaxed/simple;
	bh=uAGNTw9u+c7/wxaPrwbYb5Nm/H9qd6k6aOs4QbU97VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvflkLcDYhpZyuoCdun1xwaNAB9TNDGjWYjHCN7IX8hoLPRbQ/lqdRCwadgyS5bcv7POtyhZwAKtsHpRBSlxB8wkBaj2y0dceijMB6TSW3ItUEJDK6CVToso8z/By9AOrm1YZTrYvPCZEfz3D8Wjc/ZAkQOo4qookwJ4JPeNwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c2VUrjAK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lLF7W7sA2DI2XBK/P3p6o4u1V30CWecA16VUNM64diU=; b=c2VUrjAKCe0x2UzyOp0ljW/xam
	pm3vB1ZAZZeBuf55P9uqkmBRm+HQnoyVBIz8l7CITO8pFT12bbw6eS/S1m7UK6TeqIqJg/E8XTWC/
	bXj6Ht6iVPqCu1499OzF+0w/eeYqq3DcAUynOc2UmsxRSsBJF7jPVraKVlvxT5WcI/mILdXwq3fek
	zZ6BjSgW3elhMFOKWBW38fAlsisib8zUxEjNVBNvqtIlDoBPrbh+5fhWJSEd4eQxjxjGMYw9QPmBv
	/phmUQxI0q9zm3TQzlJM8jb3hno1MGH2dDveGW7apO3JbG9xwLeBhRF/z247Tl7qOPHiLjXEHbxpI
	Kex87JAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51990)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmzIH-0002AC-1x;
	Tue, 25 Feb 2025 18:04:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmzIE-0006D2-0O;
	Tue, 25 Feb 2025 18:04:30 +0000
Date: Tue, 25 Feb 2025 18:04:29 +0000
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
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
Message-ID: <Z74GLblGUPhHID8a@shell.armlinux.org.uk>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
 <20250225112043.419189-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225112043.419189-2-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 12:20:39PM +0100, Maxime Chevallier wrote:
> The SFP module's eeprom and internals are accessible through an i2c bus.
> However, all the i2c transfers that are performed are SMBus-style
> transfers for read and write operations.

Note that there are SFPs that fail if you access them by byte - the
3FE46541AA locks the bus if you byte access the emulated EEPROM at
0x50, address 0x51. This is documented in sfp_sm_mod_probe().

So there's a very real reason for adding the warning - this module
will not work!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

