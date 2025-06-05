Return-Path: <netdev+bounces-195239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E4CACEF6D
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E243F3ACE90
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9226202F83;
	Thu,  5 Jun 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kxBehvSj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DD1D8A0A;
	Thu,  5 Jun 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127521; cv=none; b=TDqcVtNQ0+E5WJv+utUBKThzV2L3+XNHlBRWpGt8qHjf9pWPdLg0FYo4YZC7PmZL9HA+5voxqh6AuCY+xHSxXgt4pQHkcmdm4/6dIp9dzz8HRbNMdBwBIdlgfrcdEmXDwiujXZ8W/L+tSZkMwu4iuGAlLmVDxS7PQnAAbmrVuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127521; c=relaxed/simple;
	bh=876duFcUVR7+0KAQ6ukxzRWHIerSAdLfmfGb8IxF5Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugPYVQBUwnZxWpbw9Eiy/LVtTLdymFBhNCBIJKkEcU1qKhlR0iLRpzGTXvk0dTmr4zR/YOH/VLx+C5oXEWoOY9WgSoq4dbsbvWDRnAW57bNg/UsSOUAjyHdi6KsQBCSVlWFrdf1AzNqEdIi4i69EOYWnLSdDPWNq0P5yW+J/LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kxBehvSj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mSyAMRzlzNI8j10B10P5gib/izeLj7pMpMECYWU5pTk=; b=kxBehvSjqnApdD5W5sVeB0kXZ4
	Wkj0eg+BgY3CNtLtU7Nn+5shIDEFcXsPD/d2cik5Hu/SlMQxUFWabXTR5ZVeiYhW/oR74g3rSzcCG
	koT17IPfI5v9/eQSOvQilBBJmQgtB5rV9MISu2pLKfnqlKN5wcwSK46tdfGlTWOPBMgQdjrw29VTD
	uBNHUN8AE1qIu2v9VaiuHnQYLrCm7rpTJ4XULVP8X+fpJRWTurjWt1ilBlA2vrq+ZKnexPogtFwsy
	Z6ceNGB44xN2aUQdTq3ji7ysaNXZJuSZ2pEE/KhIYjDPyD94+58ww99zHpOD2XVyDvuo1lFhDgFYJ
	Fl9fDt3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37046)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uN9xv-0008Ap-2B;
	Thu, 05 Jun 2025 13:45:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uN9xo-0002C0-0G;
	Thu, 05 Jun 2025 13:44:56 +0100
Date: Thu, 5 Jun 2025 13:44:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <aEGRR6kTZT_B5oYt@shell.armlinux.org.uk>
References: <20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch>
 <e4db4e6f0a5a42ceacacc925adbe13747a6f948e.camel@icenowy.me>
 <debcb2e1-b7ef-493b-a4c4-e13d4aaf0223@lunn.ch>
 <2e42f2f7985fb036bec6ab085432a49961c8dc42.camel@icenowy.me>
 <aEFmNMSvffMvNA8I@shell.armlinux.org.uk>
 <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84c534f9dbfa7c82300863cd40e5a9b6e6e29411.camel@icenowy.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 05, 2025 at 06:51:43PM +0800, Icenowy Zheng wrote:
> 在 2025-06-05星期四的 10:41 +0100，Russell King (Oracle)写道：
> > On Thu, Jun 05, 2025 at 05:06:43PM +0800, Icenowy Zheng wrote:
> > > In addition, analyzing existing Ethernet drivers, I found two
> > > drivers
> > > with contradition: stmicro/stmmac/dwmac-qcom-ethqos.c and
> > > ti/icssg/icssg_prueth.c .
> > > 
> > > The QCOM ETHQOS driver enables the MAC's TX delay if the phy_mode
> > > is
> > > rgmii or rgmii-rxid, and the PRU ETH driver, which works on some
> > > MAC
> > > with hardcoded TX delay, rejects rgmii and rgmii-rxid, and patches
> > > rgmii-id or rgmii-txid to remove the txid part.
> > 
> > No, this is wrong.
> > 
> > First, it does not reject any RGMII mode. See qcom_ethqos_probe() and
> > the switch() in there. All four RGMII modes are accepted.
> 
> Well my sentence have its subject switched here. I mean the TI PRU ETH
> driver is rejecting modes.
> 
> > 
> > The code in ethqos_rgmii_macro_init() is the questionable bit, but
> > again, does _not_ do any rejection of any RGMII mode. It simply sets
> > the transmit clock phase shift according to the mode, and the only
> > way this can work is if the board does not provide the required
> > delay.
> > 
> > This code was not reviewed by phylib maintainers, so has slipped
> > through the review process. It ought to be using the delay properties
> > to configure the MAC.
> > 
> > > The logic of QCOM ETHQOS clearly follows the original DT binding,
> > > which
> > 
> > Let's make this clear. "original DT binding" - no, nothing has
> > *actually* changed with the DT binding - the meaning of the RGMII
> > modes have not changed. The problem is one of interpretation, and
> > I can tell you from personal experience that getting stuff documented
> > so that everyone gets the same understanding is nigh on impossible.
> > People will pick holes, and deliberately interpret whatever is
> > written
> > in ways that it isn't meant to - and the more words that are used the
> > more this happens.
> 
> Well I am not sure, considering two examples I raised here (please note
> I am comparing QCOM ETHQOS and TI PRUETH two drivers, they have
> contrary handling of RGMII modes, and one matches the old binding
> document, one matches the new one).

Code sometimes sneaks in that hasn't been reviewed by the phylib
maintainers. That seems to be the case with the qcom ethqos driver.
Note the lack of tags from a phylib maintainer. However, I haven't
checked the mailing list history, maybe they put forward a good
reason for the code being as it is.

However, the fundamental fact is that the PHY interface mode is
passed into phylink and phylib unchanged, which instructs the PHY
driver to set the delays at the PHY as per that mode - as per the
phylib documentation.

One reason the code in qcom ethqos may exist is that all boards do
not insert the transmit delay, so the MAC needs to if the PHY
isn't. That may have been covered on the mailing list. I don't
know without checking, and I'm not able to check at the moment.

> > The RGMII modes have been documented in
> > Documentation/networking/phy.rst
> > (Documentation/networking/phy.txt predating) since:
> 
> I checked the document here, and it seems that it's against the changed
> binding document (it matches the original one):

I repeatedly raised the issue that the phylib documentation is the
definitive documentation, and we shouldn't be duplicating it. If you
think that the binding document is contrary to what the phylib doc
says, then the binding document is wrong.

I stand by my comment in the review. We should *not* be documenting
the same thing in two different places. You've proven my point.

I suggest we get rid of the "clarification" in the binding document
because it's just adding to the confusion. Document stuff in one
place, and one place only. Anything else is madness and leads to
exactly this problem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

