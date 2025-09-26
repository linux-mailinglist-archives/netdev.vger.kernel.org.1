Return-Path: <netdev+bounces-226761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605EBA4D73
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7377C1BC83C8
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FAD279DDA;
	Fri, 26 Sep 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NDfBpBx5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8B27935A;
	Fri, 26 Sep 2025 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909975; cv=none; b=LY3FfarEcxEuGLMRRdpYQWqXos8Bs6BC76WhRjRfiujsgKeBfmF/PhVAl7+nw1WFuR9y9FX9qroLOUUGMgHCWDEeUm4M4HwYk+Q6pN6yzuCke/e4SkU99xVBaa8NTtBzg5vuK7xd4L3dUxsoj2vmzsBmwmZhm3a4N8QrtNYOD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909975; c=relaxed/simple;
	bh=lVdmk24uzZLUpHExk5q0viaUq0wx6COGjXoe/FACEV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9KP3s5SxFu/ZlrW9g5Ny8/jQBCyLtZCRdTeJNvHEj25gUyaRzMe3eGOOhC/miMpYGJBThuTRod2VlgYDHI0YNdIF8nkOLBRZkTliH9pM+6P7tq0z+SLCnYVKb5lMQ2PVX41LepPJDxzap7fRzavwSUVuvWoODKB6rHooeXQ3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NDfBpBx5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mt+qW1w7wIpB1oVj2FllX4x1Q+sVAqzARp1FUOTEHxc=; b=NDfBpBx5Tujso5qbk+gGudcjGO
	LAA8bpUoJGE5k/GIUFDJordr6/LU8IlcSubQo6L+1j2zWT5FteqTuZiTG7V1wHKVXrQdV4dFhevo/
	pIwrQH4uHMsHBQISAGF/3biaiRJvbgpJVSC+3EcG7GR8PiJi9R9h75gCiFdYHZfLTytZ/ru6In+nN
	VbJefM0GmPqftoRwwlQbm2Xpo6cEpyRiXCjC/FxVz9eKjClAdqubJmquEOd8DeEieULAg8uPzkPCV
	hLsolM+af1yegBAxGeUXOcwVjrt9X0pKX1famDnW2ESIkSSgn1uiGiHmkauYiJ2wprVY05cKEVTSs
	f7KhuuIw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33952)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v2Cpe-000000003pM-3Ayh;
	Fri, 26 Sep 2025 19:06:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v2Cpd-000000000s1-10QB;
	Fri, 26 Sep 2025 19:06:09 +0100
Date: Fri, 26 Sep 2025 19:06:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yangfl <mmyangfl@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <aNbWEdabqXIaoo2T@shell.armlinux.org.uk>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-3-mmyangfl@gmail.com>
 <aNQvW54sk3EzmoJp@shell.armlinux.org.uk>
 <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
 <aNREByX9-8VtbH0n@shell.armlinux.org.uk>
 <CAAXyoMPmwvxsk0vMD5aUvx9ajbeAENtengzUgBteV_CFJoqXWg@mail.gmail.com>
 <f7d78131-7425-487f-a8bb-ed747dd9a194@lunn.ch>
 <CAAXyoMM3QG+zWJQ8tAgZfb4R62APgBaqaKDR=151R7+rzzakCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMM3QG+zWJQ8tAgZfb4R62APgBaqaKDR=151R7+rzzakCw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Sep 27, 2025 at 12:28:05AM +0800, Yangfl wrote:
> On Sat, Sep 27, 2025 at 12:09 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > > How does the databook describe reverse SGMII? How does it differ from
> > > > > SGMII?
> > > >
> > > > It doesn't describe "reverse SGMII". Instead, it describes:
> > > >
> > > > 1. The TC bit in the MAC configuration register, which makes the block
> > > >    transmit the speed and duplex from the MAC configuration register
> > > >    over RGMII, SGMII or SMII links (only, not 1000base-X.)
> > > >
> > > > 2. The SGMIIRAL bit in the PCS control register, which switches where
> > > >    the SGMII rate adapter layer takes its speed configuration from -
> > > >    either the incoming in-band tx_config_reg[15:0] word, or from the
> > > >    MAC configuration register. It is explicitly stated for this bit
> > > >    that it is for back-to-back MAC links, and as it's specific to
> > > >    SGMII, that means a back-to-back SGMII MAC link.
> > > >
> > > > Set both these bits while the MAC is configured for SGMII mode, and
> > > > you have a stmmac MAC which immitates a SGMII PHY as far as the
> > > > in-band tx_config_reg[15:0] word is concerned.
> > >
> > > So any conclusion? Should I go on with REV*MII, or wait for (or write
> > > it myself) reverse-mode flag?
> >
> > Sorry, i'm missing some context here.
> >
> > Why do you actually need REVSGMII, or at least the concept?
> >
> > REVMII is used when you connect one MAC to another. You need to
> > indicate one ends needs to play the PHY role. This is generally when
> > you connect a host MAC to an Ethernet switch, and you want the switch
> > to play the PHY role.
> >
> > Now consider SGMII, when connecting a host MAC to a switch. Why would
> > you even use SGMII, 1000BaseX is the more logical choice. You don't
> > want the link to run at 100Mbps, or 10Mbps. The link between the host
> > and the switch should run as fast as possible. And 1000BaseX is
> > symmetrical, you don't need a REV concept.
> >
> > Also, in these cases, stmmmac is on the host, not the switch, so it
> > will have the host role, leaving the switch to play 'PHY'. I'm not
> > sure you could even embedded stmmac in a switch, where it might want
> > to play 'PHY', because stmmac is software driven, where as a switch is
> > all hardware.
> >
> > So the hardware supports reverse SGMII, but it is not clear to me why
> > you would want to use it.
> >
> >         Andrew
> >
> 
> Cause I couldn't make 1000BaseX work with qca-ssdk, so I can only
> confirm and test REVSGMII mode on my device.

I think it would help if you could show what you tried for 1000base-X
in terms of dts fragments for both ends.

Marvell DSA switches support 1000base-X, but it defaults to link-down
and without AN, so expecting in-band to work with it doesn't result
in a working link, but using fixed-link on both ends does.

Maybe qca-ssdk needs that as well? Is that what you tried?

It could also be a buggy MAC driver that doesn't disable in-band AN
for 1000base-X in fixed link mode.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

