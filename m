Return-Path: <netdev+bounces-145355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87039CF397
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C050B3772B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C01D5ABF;
	Fri, 15 Nov 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ehg5mtzN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4017BB38;
	Fri, 15 Nov 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693072; cv=none; b=P+E1EBR4ntuQKcYfumLGgN35xuokm1oVC/05fL4T8nWf+k6/QASSNIFYVZ5DZfw57CWX4V8aNBnA2oEX0D/xRLsBUkdWTq9+KesjC6ytFACXpXwWFDJZL0x+mS7yJif5E0Cp7Ks308AXCnq9SXMQc2HeDBrqnYMeQWblelThuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693072; c=relaxed/simple;
	bh=uJgYjJE0jR1lchCHkVbwdJluL2aX0+r1z+kOxGVkbHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU03d7znpczkfw6hmK4mDTLRa2/q9cnid2+dAnJGKKYvLQ8RfoeYsd8OfRYTSUvMb/WimuRbNheqWwxGtSpL4J/yHHLpUdYP2Wz3ChGNyzR+w39RjAdrCkB1mLUQqYJuayGkOMI0jbE6DaXv6cPX55TU+3uwZAsHej4MQX6UZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ehg5mtzN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GYQEl1wUEVXzOH0/nz8Ab4ikFSAxUZbnN5Q7yZ/M1Rs=; b=ehg5mtzNUmZnnTL99vDMrVL9ql
	0+X3kc11AJyC6U7ptYtxyJfmF8Tx3t/YdXLcg/9nT+xqyXrOxs2plmE5Ea6ykEGlKbM7VIYtWP9hG
	IDc6qv5bve8eijwyxeoLW0fe5qJyhMRdcOfjhn2ncyoTa1BEtCAwVdsJetgQ6Lxr/stQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tC0TE-00DRrf-U8; Fri, 15 Nov 2024 18:51:00 +0100
Date: Fri, 15 Nov 2024 18:51:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: Re: [PATCH net-next] net: phylink: improve phylink_sfp_config_phy()
 error message with empty supported
Message-ID: <26b6ff38-68b2-4c9a-be20-99769cba07c4@lunn.ch>
References: <20241114165348.2445021-1-vladimir.oltean@nxp.com>
 <54332f43-7811-426a-a756-61d63b54c725@lunn.ch>
 <ZzZCXMFRP5ulI1AD@shell.armlinux.org.uk>
 <20241115161401.2pfnbnsl2zv3euap@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115161401.2pfnbnsl2zv3euap@skbuf>

On Fri, Nov 15, 2024 at 06:14:01PM +0200, Vladimir Oltean wrote:
> On Thu, Nov 14, 2024 at 06:33:00PM +0000, Russell King (Oracle) wrote:
> > On Thu, Nov 14, 2024 at 06:38:13PM +0100, Andrew Lunn wrote:
> > > > [   64.738270] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) supports no link modes. Maybe its specific PHY driver not loaded?
> > > > [   64.769731] sfp sfp: sfp_add_phy failed: -EINVAL
> > > > 
> > > > Of course, there may be other reasons due to which phydev->supported is
> > > > empty, thus the use of the word "maybe", but I think the lack of a
> > > > driver would be the most common.
> > > 
> > > I think this is useful.
> > > 
> > > I only have a minor nitpick, maybe in the commit message mention which
> > > PHY drivers are typically used by SFPs, to point somebody who gets
> > > this message in the right direction. The Marvell driver is one. at803x
> > > i think is also used. Are then any others?
> > 
> > bcm84881 too. Not sure about at803x - the only SFP I know that uses
> > that PHY doesn't make the PHY available to the host.
> 
> So which Kconfig options should I put down for v2? CONFIG_BCM84881_PHY
> and CONFIG_MARVELL_PHY?
> 
> To avoid this "Please insert the name of your sound card" situation
> reminiscent of the 90s, another thing which might be interesting to
> explore would be for each PHY driver to have a stub portion always built
> into the kernel, keeping an association between the phy_id/phy_id_mask
> and the Kconfig information associated with it (Kconfig option, and
> whether it was enabled or not).

This might be useful in other ways, if we can make it work for every
driver. genphy somewhat breaks the usual device model, and that causes
us pain at times. fw_devlink gets confused by genphy, and users as
well. We have the issue of not knowing if genphy is to be used, or we
should wait around longer for the correct driver to load.

So i can see three use cases:

1) There is a driver for this hardware, it is just not being built

2) There is a driver for this hardware, it is being built, it has not
loaded yet.

3) There is no driver for this hardware, genphy is the fallback.

I would actually say 1) is not something we should solve at the PHY
driver layer, it is a generic problem for all drivers. We want some
Makefile support for extracting the MODULE_DEVICE_TABLE() for modules
which are not enabled, and some way to create a modules.disabled.alias
which module loading can look at and issue a warning. 2) i also think
is a generic problem. 3) is probably PHY specific, because i don't
know of any other case where there is a fallback driver.

	Andrew

