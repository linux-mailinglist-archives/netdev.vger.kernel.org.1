Return-Path: <netdev+bounces-49150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 300657F0F16
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47EAB20A6F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A2111B8;
	Mon, 20 Nov 2023 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AEdGHCvK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD79C;
	Mon, 20 Nov 2023 01:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B19rE5PxY/d/nMLfXGoR2pQMNPOO+aRK6hidwf9rcN0=; b=AEdGHCvKofLlxtvD+qTRzQsB4/
	EYtDHjAkNTPWOaYQFk7bkp5p9bn+ilMfhXErojKQzD2vhu/1CvpgaD4g0EXG1oOmsTDoP8TFZFyWJ
	EV/O9OmlATs7sfCNFGtB9JhsEep+xIiRZF8jxGdz+Q8X2Rh5CI0cGjnr7YWAh81wj1j2sB3mW8gEH
	zs+aoGQErH3vFpTBhurs032YwfdyRI6KRjnB0uv3jVOCyGPRbl5TivU6wJSCHXxnVvTtj0KOwwa0O
	ao2uhuhq4oYOQEfF8naPt+QeuxFU2dBIvfXWUm9R7pcrKRCfx1+G8bNkCcBYBfgh1awDNAVh/bYA6
	/b56U2KA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49426)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r50bP-0005EY-03;
	Mon, 20 Nov 2023 09:29:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r50bN-00033X-Rw; Mon, 20 Nov 2023 09:29:57 +0000
Date: Mon, 20 Nov 2023 09:29:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
Message-ID: <ZVsnFWzi6KMXpJOj@shell.armlinux.org.uk>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 20, 2023 at 04:49:59PM +0800, Jie Luo wrote:
> 
> 
> On 11/19/2023 4:19 AM, Andrew Lunn wrote:
> > > 10G_QXGMII is defined in the Cisco USXGMII multi-port document as one
> > > of several possibilities for a USXGMII-M link. The Cisco document can
> > > be a little confusing beause it states that 10G_QXGMII supports 10M,
> > > 100M, 1G and 2.5G, and then only talks about a 10G and 100M/1G MAC.
> > > 
> > > For 10G_QXGMII, there are 4 MAC interfaces. These are connected to a
> > > rate "adaption" through symbol replication block, and then on to a
> > > clause 49 PCS block.
> > > 
> > > There is then a port MUX and framing block, followed by the PMA
> > > serdes which communicates with the remote end over a single pair of
> > > transmit/receive serdes lines.
> > > 
> > > Each interface also has its own clause 37 autoneg block.
> > > 
> > > So, for an interface to operate in SGMII mode, it would have to be
> > > muxed to a different path before being presented to the USXGMII-M
> > > block since each interface does not have its own external data lane
> > > - thus that's out of scope of USXGMII-M as documented by Cisco.
> > 
> > Hi Russell
> > 
> > I think it helps.
> > 
> > Where i'm having trouble is deciding if this is actually an interface
> > mode. Interface mode is a per PHY property. Where as it seems
> > 10G_QXGMII is a property of the USXGMII-M link? Should we be
> > representing the package with 4 PHYs in it, and specify the package
> > has a PMA which is using 10G_QXGMII over USXGMII-M? The PHY interface
> > mode is then internal? Its just the link between the PHY and the MUX?
> > 
> > By saying the interface mode is 10G_QXGMII and not describing the PMA
> > mode, are we setting ourselves up for problems in the future? Could
> > there be a PMA interface which could carry different PHY interface
> > modes?
> > 
> > If we decide we do want to use 10G_QXGMII as an interface made, i
> > think the driver should be doing some validation. If asked to do
> > anything else, it should return -EINVAL.
> > 
> > And i don't yet understand how it can also do 1000BaseX and 2500BaseX
> > and SGMII?
> > 
> >      Andrew
> 
> Hi Andrew,
> The interface mode 10G_QXGMII is a type of USXGMII-M, the other modes
> such as 20G-QXGMII, 20G-OXGMII...
> 
> As for the interface mode 10G-QXGMII, there is a multiplexer for 4 PHYs,
> then do 66bit/68bit encode in xpcs and pass to PMA, the link topology:
> quad PHY --- multiplexer ---XPCS --- PMA.
> the 10G-QXGMII interface block includes multiplexer, XPCS and PMA.

Note that phylink_pcs does *not* cover any PCS on the PHY device side
of the link. It only covers a PCS on the MAC side.

> Here is a problem as Russell mentioned earlier, we need to know which PHY
> device is changing the link status when the 10G-QXGMII mode is used,
> since there are 4 PHYs, when one of them has the link change, there is no
> PHY device information passed to the PHYLINK, so the PCS driver don't
> which PHY is changing link status and 10G-QXGMII mode don't know which
> channel(mapped to PHY) should be configured.
> 
> would we add a field such as (int channel) in the struct phy_device?
> so we can pass this information to PCS driver when the PHY link changed.

Nothing in phylink nor phylib is setup to deal with "channels" within
a PHY. The model assumes that a network interface consists of exactly
one MAC associated with one active PHY.

As there are 4 PHYs, phylib will expect there to be four PHY devices,
and there will be expected to be four phylink instances.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

