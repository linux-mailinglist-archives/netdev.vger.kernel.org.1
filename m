Return-Path: <netdev+bounces-161395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE6A20EA2
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648907A2E7C
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1241DE4C5;
	Tue, 28 Jan 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CIC+imA5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AB1DE3D6;
	Tue, 28 Jan 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081947; cv=none; b=neMFKJPG4neYyxkhkVqi1aoECTVQheg1zWH/OMToTGFw14eOTkZUdLz77YsTqey0l63Fk431gW9AizyZU95Pep3S+dPd/1pGblBEWDf60PC+6CG8/oYPPnOsSrMAR7Ats/4giKCAOLg1m1EzCXpCTmV/MeQaiOt0SR8VPkdxiCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081947; c=relaxed/simple;
	bh=QtHvsJjZ7QxNIZ1SXB/444BY4v4g0ky8bprkBlrEpN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXd+5PRWLkpod4+w3rgnTuTFQkijCg8NQPgOGm/ZwWJ4natf005ofiH//dwHuUQF7+yo1Y7AAiX3GyWOFPaSewLWJitaMSpOJBAZb1Z7TenN/AZCUl8/34r/tvSFJ2AvA07S89SHUA/YtW7jUG5LFPgP02AQaluaNT/J10DuPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CIC+imA5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yL1fK2nTJPYp1w26Ib1wtTlGVYi51YwH3nZezu81Cvg=; b=CIC+imA5nIk3vQZvFVSuiB/DOu
	OvYjQTJfciDD+qwZLzOgCJZRoeI2AALXlFqDWGYh4EZR4sWGDZRRKpys5fwYSNP225P1yu8e+BHeg
	TiMGPxYo7wEYKvbTVuFTIKDrMwAzb17C5vh7pw0kpvaQrl8u0QZf8/h67uTc9c7+FCA+5weiplxgU
	E3hxl/qGN84WT66ueGstLQ3W1Nh7hyhd9mVHRLBH03UAILwSb/oGClPU2KM3uK+iyHTF/skkPylJK
	kYFBZV4nOJTI2k3g5zUycSr2xrppDceB0a5Dz9i/riDFYn39Hs+dsQNIdNu4X/6v2OYy2S95ZOCo1
	txj30CiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50786)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tcoVX-0007eZ-1x;
	Tue, 28 Jan 2025 16:32:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tcoVT-0002n8-2p;
	Tue, 28 Jan 2025 16:32:07 +0000
Date: Tue, 28 Jan 2025 16:32:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5kGhzWr2ZSxGdlX@shell.armlinux.org.uk>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128152324.3p2ccnxoz5xta7ct@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 28, 2025 at 05:23:24PM +0200, Vladimir Oltean wrote:
> On Tue, Jan 28, 2025 at 12:33:11PM +0000, Russell King (Oracle) wrote:
> > I wonder what the original Synopsys documentation says about the AN
> > control register.
> 
> My private XPCS databook 2017-12.pdf, the applicability of which I cannot
> vouch for, has a section with programming guidelines for SGMII
> Auto-Negotiation. I quote:

Thanks for this, most useful.

> | Clause 37 auto-negotiation can be performed in the SGMII mode by
> | programming various registers as follows:
> | 
> | 1. In configurations with both 10G and 1G mode speed mode, switch
> |    DWC_xpcs to 1G speed mode by following the steps described in
> |    "Switching to 1G or KX Mode and 10 or 100 Mbps SGMII Speed".
> | 
> | 2. In Backplane Ethernet PCS configurations, program bit[12] (AN_EN) of
> |    SR_AN_CTRL Register to 0 and bit[12] (CL37_BP) of VR_XS_PCS_DIG_CTRL1
> |    Register to 1.
> | 
> | 3. Disable Clause 37 auto-negotiation by programming bit [12]
> |    (AN_ENABLE) of SR_MII_CTRL Register to 0 (in case it is already
> |    enabled).
> | 
> | 4. Program various fields of VR_MII_AN_CTRL Register appropriately as
> |    follows:
> |    - Program PCS_MODE to 2’b10
> |    - Program TX_CONFIG to 1 (PHY side SGMII) or 0 (MAC side SGMII) based
> |      on your requirement
> |    - Program MII_AN_INTR_EN to 1, to enable auto-negotiation complete
> |      interrupt
> |    - If TX_CONFIG is set to 1 and bit[0] of VR_MII_DIG_CTRL1 Register is
> |      set to 0, program SGMII_LINK_STS to indicate the link status to the
> |      MAC side SGMII.
> |    - Program MII_CTRL to 0 or 1, as per your requirement.
> | 
> | 5. If DWC_xpcs is configured as PHY-side SGMII in the above step, you
> |    can program bit [0] of VR_MII_DIG_CTRL1 Register to 1, if you wish to
> |    use the values of the xpcs_sgmii_link_sts_i input ports.
> |    xpcs_sgmii_full_duplex_i and xpcs_sgmii_link_speed_i as the
> |    transmitted configuration word.
> | 
> | 6. If DWC_xpcs is configured as PHY-side SGMII and if bit[0] of
> |    VR_MII_DIG_CTRL1 Register is set to 0,
> |    - Program SS13 and SS6 bits of SR_MII_CTRL Register to the required
> |      SGMII Speed
> |    - Program bit [5] (FD) of SR_MII_AN_ADV to the desired mode. This
> |      step is mandatory even if you wish to leave the FD register bit to
> |      its default value.

I suspect this is where the requirement comes from in the KSZ9477
documentation - and it's been "translated" badly. I note that in the
KSZ9477 documentation, bit[0] of VR_MII_DIG_CTRL1 is marked as
"reserved" and takes the value zero, so in the case of PHY-side SGMII,
(6) always applies to KSZ9477 and (5) never does.

This also solves my concern about 2a22b7ae2fa3 ("net: pcs: xpcs: adapt
Wangxun NICs for SGMII mode"), because there (5) would apply.

> | 
> | 7. If DWC_xpcs is configured as MAC-side SGMII in step 4, program bit[9]
> |    of VR_MII_DIG_CTRL1 Register to 1, for DWC_xpcs to automatically
> |    switch to the negotiated link-speed, after the completion of
> |    auto-negotiation.
> | 
> | 8. Enable CL37 Auto-negotiation, by programming bit[12] of the
> |    SR_MII_CTRL Register to 1.
> 
> In my reading of these steps, writing to DW_VR_MII_AN_CTRL does not
> depend on a subsequent write to SR_MII_AN_ADV to take effect.
> But there is this additional note in the databook:
> 
> | If TX_CONFIG=1 and Bit[0] (SGMII_PHY_MODE_CTRL) of VR_MII_DIG_CTRL1 = 0,
> | program the SR_MII_AN_ADV only after programming 'SGMII_LINK_STS' bit
> | (of VR_MII_AN_CTRL) and SS13 and SS6 bits (of SR_MII_CTRL)
> 
> So my understanding is that SR_MII_AN_ADV needs to be written only if
> TX_CONFIG=1 (SJA1105 calls this AUTONEG_CONTROL[PHY_MODE]).

Yes, agreed. Thankfully, SJA1105 sets PHY_MODE/TX_CONFIG=0 and leaves
SGMII_PHY_MODE_CTRL unaltered. TXGBE sets TX_CONFIG=1 but sets
SGMII_PHY_MODE_CTRL=1 which also avoids this requirement.

> That's quite
> different, and that will make sense when you consider that there's also
> a table with the places the autoneg code word gets its info from:
> 
> Config_Reg Bits in the 1000BASE-X and SGMII Mode
> 
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | Config_Reg bit | 1000Base-X mode   | SGMII mode value   | SGMII mode value                           |
>  |                |                   | when TX_CONFIG = 0 | when TX_CONFIG = 1                         |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 15             | Next page support | 0                  | Link up or down.                           |
>  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
>  |                |                   |                    | this bit is derived from Bit 4             |
>  |                |                   |                    | (SGMII_LINK_STS) of the VR_MII_AN_CTRL.    |
>  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
>  |                |                   |                    | this bit is derived from the input port    |
>  |                |                   |                    | 'xpcs_sgmii_link_sts_i'                    |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 14             | ACK               | 1                  | 1                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 13             | RF[1]             | 0                  | 0                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 12             | RF[0]             | 0                  | FULL_DUPLEX                                |
>  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
>  |                |                   |                    | this bit is derived from Bit 5 (FD) of     |
>  |                |                   |                    | the SR_MII_AN_ADV.                         |
>  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
>  |                |                   |                    | this bit is derived from the input port    |
>  |                |                   |                    | 'xpcs_sgmii_full_duplex_i'                 |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 11:10          | Reserved          | 0                  | SPEED                                      |
>  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 0, |
>  |                |                   |                    | these bits are derived from Bit 13 (SS13)  |
>  |                |                   |                    | and Bit 6 (SS6) of the SR_MII_CTRL.        |
>  |                |                   |                    | If DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL == 1, |
>  |                |                   |                    | this bit is derived from the input port    |
>  |                |                   |                    | 'xpcs_sgmii_link_speed_i[1:0]'             |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 9              | Reserved          | 0                  | 0                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 8:7            | PAUSE[1:0]        | 0                  | 0                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 6              | HALF_DUPLEX       | 0                  | 0                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 5              | FULL_DUPLEX       | 0                  | 0                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 4:1            | Reserved          | 0                  | 0                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
>  | 0              | Reserved          | 1                  | 1                                          |
>  +----------------+-------------------+--------------------+--------------------------------------------+
> 
> I haven't figured out either what might be going on with the KSZ9477
> integration, I just made a quick refresher and I thought this might be
> useful for you as well, Russell. I do notice Tristram does force
> TX_CONFIG=1 (DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII), but I don't understand
> what's truly behind that. Hopefully just a misunderstanding.

If you want to peek at the KSZ9477 documentation, what I'm looking at is
available from here:
https://www.microchip.com/en-us/product/ksz9477#Documentation

Interestingly, there are a number of errata:

Module 7 - SGMII auto-negotiation does not set bit 0 in the
auto-negotiation code word
Basically requires MII_ADVERTISE to be written as 0x1a0, and is only
needed after power-up or reset.

Module 8 - SGMII port link details from the connected SGMII PHY are not
passed properly to the port 7 GMAC
Basically, AUTONEG_INTR_STATUS needs to be read, and the PCS
manually programmed for the speed.

Module 15 - SGMII registers are not initialized by hardware reset
Requires that bit 15 of BASIC_CONTROL is set to reset the registers.

All three are not scheduled to be fixed, apparently.

There seems to be no information listed there regarding the requirement
for SGMII PHY mode.

> Tristram, why do you set this field to 1? Linux only supports the
> configuration where a MAC behaves like a MAC. There needs to be an
> entire discussion if you want to configure a MAC to be a SGMII autoneg
> master (like a PHY), how to model that.

(Using SJA1105 register terminology...)

Looking at the patch, Tristram is setting PHY_MODE=1 and SGMII_LINK=1
not when configuring for SGMII, but when configuring for 1000base-X.

This is reflected in the documentation for KSZ9477 - which states that
both these bits need to be set in "SerDes" aka 1000base-X mode. The
question is... where did that statement come from, and should we be
doing that for 1000base-X mode anyway?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

