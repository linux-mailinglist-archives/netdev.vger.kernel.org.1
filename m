Return-Path: <netdev+bounces-238625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AAC5C31C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09D8935D54F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF382FF66A;
	Fri, 14 Nov 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1WXPH+5L"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE52F8BD9;
	Fri, 14 Nov 2025 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111335; cv=none; b=GhKVE6QcdOUMs+5ShY1lZznWKTfY/yLON0sbZ9gdk1YRLAZmzoSEAjrbrwp5d57RRKSMms30MPbejMbTr2ean9cxxghlMluj0V0mRauM7VefnWfrl01yy273VuvrmuaZvCHOWmaWOL0NsAcQBBhJJJGV8Ox9nXQ24k4lCzhJ99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111335; c=relaxed/simple;
	bh=+KvKLy6ZX2N9SBJrqsOBtI7nrdVDf1ztN56hv4iJVBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoNN7R2+UhlAzmBfS2vM8VPBkhPKRXPQC0JVARx15/kHCEw+kPiap1rp76wF+5p6K+48DEYsi3or2ph24c+NKJpn1zIS3y2s4OGow2GqhNddaicHIfhoN8xk+5UWadqd2ecDq0KLpQ9zi/4Ys4atfpa/v8ZqcScYjnIGybDrOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1WXPH+5L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ki/jMVU3BMbpxT6ZVLC9uy3wcUBqHRnY25MnPP/wiVs=; b=1WXPH+5LJo1ewUfjZ20O1Xq2Cm
	Zcp2y0yiKzeeTSv7RToaPEAsramB+IMq+y86DUdl1shUvzk/mXaG82gSKYZhq/2SjQ/0XfK1Z0LKe
	i/I4DYhjzjRPTRP6g/uRQYGlgwmp+4cVRI2LWQ/3FucFskh3sydyLfBISTXQGsVh9zliRRUBgSwgY
	1FM/35FJBt8SJgTPiYW337i+wOoHYV2UR8bAU73haW3vEvjm2j+Eo/jX3ZtFOYH6YuTe3AyoS266T
	krgcz151r/N4J8DP7eOlAd8EZJHRpgBtCEfkbMUmfFvyOE3pgGg8R8sj3MC49eZ3YaYkOYevwxEhu
	2HauxGBQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35976)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vJpnP-000000006cV-1G1S;
	Fri, 14 Nov 2025 09:08:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vJpnM-000000005ia-28SJ;
	Fri, 14 Nov 2025 09:08:40 +0000
Date: Fri, 14 Nov 2025 09:08:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
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
Subject: Re: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <aRbxmCPDe5ybYGwO@shell.armlinux.org.uk>
References: <20251114052808.1129942-1-wei.fang@nxp.com>
 <aRbpKcrzF9xMicax@shell.armlinux.org.uk>
 <PAXPR04MB8510007477C858A7E952E8E988CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510007477C858A7E952E8E988CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 14, 2025 at 08:52:07AM +0000, Wei Fang wrote:
> > On Fri, Nov 14, 2025 at 01:28:08PM +0800, Wei Fang wrote:
> > > Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> > > initialized, so these link modes will not work for the fixed-link.
> > 
> > What problem does this cause?
> > 
> 
> Our i.MX943 platform, the switch CPU port is connected to an ENETC
> MAC, the link speed is 2.5Gbps. And one user port of switch is 1Gbps.
> If the flow-control of internal link is not enabled, we can see the iperf
> performance of TCP packets is very low. Because of the congestion
> (ingress speed of CPU port is greater than egress speed of user port) in
> the switch, some TCP packets were dropped, resulting in the packets
> being retransmitted many times.

Please include this in the commit message, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

