Return-Path: <netdev+bounces-148592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76129E27AA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771AE286940
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12A1F8AD4;
	Tue,  3 Dec 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ftom6kRc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259C1F76BC;
	Tue,  3 Dec 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243847; cv=none; b=Muw6qKKPdOjZ6t1L6tAye/y6/rQW91F7tmqpL1cVLahdw1A8Jqx57bQmtyvToXKf8I97ezwgn50y2dvDYndymzlIHEcsj8eGrI2zCeZC/KtiXqu9L29WBlJ9PqgswY89bHsc0kRKEZWariznQSrxvgh6q1KmjuFDRedAtS0sIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243847; c=relaxed/simple;
	bh=G7HyrFe72+oitC4q4Te/YLaHT49oETpwcd2VcnKylhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbf4f4jpGFQjVhAAODvmnD2zwXKSx5NIx7nDSyFOC8wdGhmqY4yU7CezF7tyEDwvtF2akHlfsUtJAJwcQwj+JDSYFKliWWHjWOcTvNE1YpPiJvOgSB8zy/Ymhe7DUieH8soK5ahVWJJG92v3G9AN8U8nRWodVZZtN/66GxrKKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ftom6kRc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vtg5kgR3ORav6GpvoI4HJZs080IrHQwvmLbc1RQ21fQ=; b=ftom6kRcfoNNnL7M3OobZtc2wW
	IL6jehD17o658D1VERtVxcVeJaVpojtp0qxgdUGm8PFI2NMw/+uZ1ewKSM9DKzJE5RP4sarkT16J8
	zV5TjMJhphX+KKLqSrSehiv6St1X79/44h45k5zOzlSbzapyBfodQkeAPUznNdsHwtmtyJYkzTYVx
	eAi4E8f4SqfYkwsWiEA0QyuOA4xm91LnyP0MpbpEs69PJ/cSxkwCPWniu+EW+pwi+iL9WExlB949B
	LpwhqTen0RKe8c1rFixbZFcid6L9TICWPFHsNVTBvB+YMsEeZSE3zYwt2p4wNwQcaYbUU8+j59mwN
	y8jqHFAg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIVtj-0002E3-08;
	Tue, 03 Dec 2024 16:37:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIVte-0004h5-2z;
	Tue, 03 Dec 2024 16:37:11 +0000
Date: Tue, 3 Dec 2024 16:37:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	"nikita.yoush" <nikita.yoush@cogentembedded.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <Z08ztsAG8x8uqCwJ@shell.armlinux.org.uk>
References: <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
 <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
 <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
 <TYCPR01MB1047854DA050E52CADB04393A8E362@TYCPR01MB10478.jpnprd01.prod.outlook.com>
 <1ff52755-ef24-4e4b-a671-803db37b58fc@lunn.ch>
 <Z08h95dUlS7zacTY@shell.armlinux.org.uk>
 <20241203165147.4706cc3b@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203165147.4706cc3b@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 03, 2024 at 04:51:47PM +0100, Maxime Chevallier wrote:
> Hi Andrew,
> 
> On Tue, 3 Dec 2024 15:21:27 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> 
> > On Tue, Dec 03, 2024 at 03:45:09PM +0100, Andrew Lunn wrote:
> > > On Tue, Dec 03, 2024 at 02:05:07PM +0000, Dennis Ostermann wrote:  
> > > > Hi,
> > > > 
> > > > according to IEE 802.3-2022, ch. 125.2.4.3, Auto-Negotiation is optional for 2.5GBASE-T1
> > > >   
> > > > > 125.2.4.3 Auto-Negotiation, type single differential-pair media
> > > > > Auto-Negotiation (Clause 98) may be used by 2.5GBASE-T1 and 5GBASE-T1 devices to detect the
> > > > > abilities (modes of operation) supported by the device at the other end of a link segment, determine common
> > > > > abilities, and configure for joint operation. Auto-Negotiation is performed upon link startup through the use
> > > > > of half-duplex differential Manchester encoding.
> > > > > The use of Clause 98 Auto-Negotiation is optional for 2.5GBASE-T1 and 5GBASE-T1 PHYs  
> > > > 
> > > > So, purposed change could make sense for T1 PHYs.  
> > > 
> > > The proposed change it too liberal. We need the PHY to say it supports
> > > 2.5GBASE-T1, not 2.5GBASE-T. We can then allow 2.5GBASE-T1 to not use
> > > autoneg, but 2.5GBASE-T has to use autoneg.  
> > 
> > I'm wondering whether we should add:
> > 
> > 	__ETHTOOL_DECLARE_LINK_MODE_MASK(requires_an);
> > 
> > to struct phy_device, and have phylib populate that by default with all
> > base-T link modes > 1G (which would be the default case as it is now.)
> > Then, PHY drivers can change this bitmap as they need for their device.
> > After the PHY features have been discovered, this should then get
> > AND-ed with the supported bitmap.
> 
> If the standards says that BaseT4 >1G needs aneg, and that we can't
> have it for baseT1, couldn't we just have some lookup table for each
> mode indicating if they need or support aneg ?

When operating in !AN mode, all that the ethtool API passes is the
speed and duplex, with a guess at the advertising mask (which doesn't
take account of the PHY's supported ethtool link modes.)

If e.g. we have a PHY that supports 1000base-T and 1000base-X, and the
user attempts to disable AN specifying speed 1000 duplex full, we don't
know whether the user means 1000base-T (which actually requires AN, but
we work around that *) or 1000base-X without AN.

Specifying speed + duplex for !AN is nice for humans, but ambiguous
for computers.

* - the workaround adopted is to do what Marvell PHYs internally do but
in phylib code, which is to accept the request to disable AN and
operate at the specified speed, but actually program AN to be enabled
with only a single speed/duplex that can be negotiated. Without this,
we end up with hacks in MAC drivers because the PHY they're paired with
doesn't support AN being disabled at 1G speed. See
__genphy_config_aneg(). Note: this is probably going to interact badly
with the baseT1 case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

