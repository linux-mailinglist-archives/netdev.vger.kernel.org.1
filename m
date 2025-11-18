Return-Path: <netdev+bounces-239573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59621C69CD2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D2C332BA91
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87681309F0F;
	Tue, 18 Nov 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Uv0XmdqB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8F3043D1;
	Tue, 18 Nov 2025 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474548; cv=none; b=CSGdk6TZ/qOTg5bMW2Nvl5GYP94XxaU3mdDl5NOygEUB2oef8YP6LEixmmEsKGOZNhf+RpjD/KdQLaDKRZqN1lzB1F6o9wOVX5SZ7aRG6bnP0xMmJSRzZaUIoZexmofpksygYFVYT2ZejLKrq6Q92NIpdJCyVLRvMg6Hc2x3Tyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474548; c=relaxed/simple;
	bh=+KhqY3oB1wgkGc6jzN+UfYOvpqqc60Dgp6JPVcxBT1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXE7y0tEWyqbND+vzGYrwYzfMgezSst+Agr1xP6Ip0pBryZUNsdov9nBnvatIRdipMBKNlAMHy5B8N14W3rSYSwYxYXiFBVFoDJt82kHURFGCW1yJ2LtVBDzRdBMv2RZ5iVX2d8XT4FLFe5iEA+gT+7fPZ5c4FCfQ/YfjvFyLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Uv0XmdqB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dg01KqUntpaFpjCXJtHlRufZ34s60nzPkse3Ae90upo=; b=Uv0XmdqBapCHl4/1aM3xKwbpby
	m739xINTZZujr9WHqEVYit0n8ne2KlWegg8Q1/AiVm07rmj+MUplkUH7Vs0QHzhekb91pQ4jV9iAa
	oMsfnrWvz206steIJdpH/Ek2LQz6TkQva7Okdu9D8pYbAkKDHxsd8Eda9skbMCkhD44iTnQabge1/
	hYMUTL1LSRZQ26f9uEFFW7pWrwGjHzj7a5tnxZWUAFNNeT3FONqRrpGDjJjJGJbd/C3xbn9ObVBv6
	iIT7koyhZp4BH9U4q22aIx2IlYJq/1h8denLX9mNx0DubtV9LT5eTxSmn5vvEeSB5IS6He67Yq46f
	aWp5Havg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50934)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLMHg-000000003Hs-3XN4;
	Tue, 18 Nov 2025 14:02:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLMHe-000000002VP-0rEX;
	Tue, 18 Nov 2025 14:02:14 +0000
Date: Tue, 18 Nov 2025 14:02:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net] net: phylink: add missing supported link modes
 for the fixed-link
Message-ID: <aRx8Zh-7MWeY0iJd@shell.armlinux.org.uk>
References: <20251117102943.1862680-1-wei.fang@nxp.com>
 <aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
 <PAXPR04MB8510A92D5185F67DDC8CC32F88D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <e7222c87-3e4c-4170-993b-dbf5ba26c462@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7222c87-3e4c-4170-993b-dbf5ba26c462@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 18, 2025 at 03:00:00PM +0100, Andrew Lunn wrote:
> > > > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link
> > > > configuration")
> > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > 
> > > NAK. I give up.
> > > 
> > 
> > Sorry, could you please tell me what the reason is?
> 
> I think Russell is referring to the commit message, and how you only
> quoted a little section of his explanation. There is no limit to
> commit messages, they don't need to be short. It is actually better if
> they are long. So you could use his whole explanation. And then you
> don't need the link.

Worse than that. I gave my reviewed-by, which seems to have been a waste
of time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

