Return-Path: <netdev+bounces-132778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC3993215
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6ED3B233E8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93A1D9A4C;
	Mon,  7 Oct 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s/whtzDI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A81D9678;
	Mon,  7 Oct 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316428; cv=none; b=PcuP611Ps3EJ+G7pMXtTpO0jUNfFnNjH2dnmlzNMXiMjT6AsI361q8zB/v3elvrUziCDX5hgE8+y5ZKElKmI78fNlCc/soRGeb8S2ilK3PgnIm2O8zCvNJ1pIkbDxc/A1InyzNOSO1i9c0rduYgXOqjJ9SbYBSx/Vg3KvFpW9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316428; c=relaxed/simple;
	bh=cIMV19T/3lFlhqobVozq0VLwjOer2cPU9m9G7YWkwzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLwNdQaIsGl/wePO0fXccbL1YpIu/+XoJ8QFWEAPzjXbRKc1sln9C0/Dy4Ww907/0v2xTOwHwQZIJ0k9ER8d4Qyafm6883vSVZjsFplQ/Ozr8iM+57L8JjGnpJGZb7+5rU7fjc+cN9F1Gx8R+Emvg1JKvX3M87SptPSgF9Kwb20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=s/whtzDI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1W2GwgW+APmUS4pvv9gMoyqqnk6ovxCaiwBqGyMOiNA=; b=s/whtzDI77U86sqcQklzx7Vjyl
	Y3WDSHSOBwI1j+QSp0hsq1SIo/i+VW98U3RTEvrdsHV0P3qYMuetVPuEMv6O8pyFyzDpoec9c4jll
	U709R1dpaDCQFfSvpWYc8eMnGE++0QsvUHHnc13TcwYDS98nZ4hCZbBOYWlfDdQRrGRp8JyeaYd/p
	Oc6lqFcoHDzRJXrS75CB8rrPenvtSvKGTqQpsIptzgHO8l68eh7Dd8vU9kad5uCUmsuRZn26POhSs
	NoNULtNO9MhtScqXpmF+EiswXQO0i7+rdupBt4DEyL3p8UiT2nXwjyyYAhGluNJa1u+XgqqyAoT2g
	djExF07Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56788)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sxq3G-0005zY-1F;
	Mon, 07 Oct 2024 16:53:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sxq3B-0004KC-07;
	Mon, 07 Oct 2024 16:53:33 +0100
Date: Mon, 7 Oct 2024 16:53:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 0/9] Allow isolating PHY devices
Message-ID: <ZwQD_ByawFLEQ1MZ@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <ZwAfoeHUGOnDz1Y1@shell.armlinux.org.uk>
 <20241007122513.4ab8e77b@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007122513.4ab8e77b@device-21.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 07, 2024 at 12:25:13PM +0200, Maxime Chevallier wrote:
> Hello Russell
> 
> On Fri, 4 Oct 2024 18:02:25 +0100
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > I'm going to ask a very basic question concerning this.
> > 
> > Isolation was present in PHYs early on when speeds were low, and thus
> > electrical reflections weren't too much of a problem, and thus star
> > topologies didn't have too much of an effect. A star topology is
> > multi-drop. Even if the PCB tracks go from MAC to PHY1 and then onto
> > PHY2, if PHY2 is isolated, there are two paths that the signal will
> > take, one to MAC and the other to PHY2. If there's no impediance match
> > at PHY2 (e.g. because it's in high-impedance mode) then that
> > transmission line is unterminated, and thus will reflect back towards
> > the MAC.
> > 
> > As speeds get faster, then reflections from unterminated ends become
> > more of an issue.
> > 
> > I suspect the reason why e.g. 88x3310, 88E1111 etc do not support
> > isolate mode is because of this - especially when being used in
> > serdes mode, the topology is essentially point-to-point and any
> > side branches can end up causing data corruption.
> 
> I suspect indeed that this won't work on serdes interfaces. I didn't
> find any reliable information on that, but so far the few PHYs I've
> seen seem to work that way.
> 
> The 88e1512 supports that, but I was testing in RGMII.

Looking at 802.3, there is no support for isolation in the clause 45
register set - the isolate bit only appears in the clause 22 BMCR.
Clause 22 registers are optional for clause 45 PHYs.

My reading of this is that 802.3 has phased out isolation support on
the MII side of the PHY on more modern PHYs, so this seems to be a
legacy feature.

Andrew has already suggested that we should default to isolate not
being supported - given that it's legacy, I agree with that.

> > So my questions would be, is adding support for isolation mode in
> > PHYs given todays network speeds something that is realistic, and
> > do we have actual hardware out there where there is more than one
> > PHY in the bus. If there is, it may be useful to include details
> > of that (such as PHY interface type) in the patch series description.
> 
> I do have some hardware with this configuration (I'd like to support
> that upstream, the topology work was preliminary work for that, and the
> next move would be to send an RFC for these topolopgies exactly).
> 
> I am working with 3 different HW platforms with this layout :
> 
>       /--- PHY
>       |
> MAC  -|  phy_interface_mode == MII so, 100Mbps Max.
>       |
>       \--- PHY
> 
> and another that is similar but with RMII. I finally have one last case
> with MII interface, same layout, but the PHYs can't isolate so we need
> to make sure all but one PHYs are powered-down at any given time.

You have given further details in other response to Andrew. I'll
comment further there.

> I will include that in the cover.

Yes, it would be good to include all these details in the cover message
so that it isn't spread out over numerous replies.

> Could we consider limiting the isolation to non-serdes interfaces ?
> that would be :
> 
>  - MII
>  - RMII
>  - GMII
>  - RGMII and its -[TX|RX] ID flavours
>  - TBI and RTBI ?? (I'm not sure about these)
> 
> Trying to isolate a PHY that doesn't have any of the interfaces above
> would result in -EOPNOTSUPP ?

I think the question should be: which MII interfaces can electrically
support multi-drop setups.

22.2.4.1.6 describes the Clause 22 Isolate bit, which only suggests
at one use case - for a PHY connected via an 802.3 defined connector
which shall power up in isolated state "to avoid the possibility of
having multiple MII output drivers actively driving the same signal
path simultaneously". This connector only supports four data signals
in each direction, which precludes GMII over this defined connector.

However, it talks about isolating the MII and GMII signals in this
section.

Putting that all together, 802.3 suggests that it is possible to
have multiple PHYs on a MII or GMII (which in an explanatory note
elsewhere, MII means 100Mb/s, GMII for 1Gb/s.) However, it is
vague.

Now... I want to say more, but this thread is fragmented and the
next bit of the reply needs to go elsewhere in this thread,
which is going to make reviewing this discussion later on rather
difficult... but we're being drip-fed the technical details.


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

