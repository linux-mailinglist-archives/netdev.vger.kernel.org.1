Return-Path: <netdev+bounces-235203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023ADC2D62F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9584E426D2D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B431D378;
	Mon,  3 Nov 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D4ikYTJu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998931AF2D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189366; cv=none; b=Roz67/GaLmmD2BCQ2obxnOpCNeTF6HSvspC4sOS9g3sSNnjYD/EZ//XThb4lAoGRab5wLJcV/3vPOhQLsDnptBYKGwUdNRlFdDmSPna/QHiXyESyFJgsYLGq4KiKPj9FHooxxZ3if/2ycHjG7VHhrq4RHxf9cqfVGJQdkXGEkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189366; c=relaxed/simple;
	bh=xwsJ4KqPB/jhg3e2UyR1yThUSQVrft7/ZDf66DGRU2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFqy4u81v8DyMnG4VeT/8N397HOj3g4PsZ3bDUULuJJg8rhTuYg54lErBOeynC1iDymtxGYDTjCCsEp9WxoU+K8UtofgXTDswRX6/EIRmX1EDEjCXClQGnfse83saYKi+Xv1BU3ZYz+vCMWMYvC+SxeGXptHUthO4nUJfkmm/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D4ikYTJu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0OEHWe0aEX4CL8pwp76r7di9HP/R/Jl+wwruwqA9LqA=; b=D4ikYTJuLxfvbADYfspsJJ1+PR
	G9TIv5Edt/r6/WaJZAMklqrf4uQXnTFghnVtt5e2pEK6hkTK/ovT48QofuyuapGxPChHIdI+l7cAZ
	gPOrF+mElZpbbQ+EvQIPyWkznOrtQKCO+Smfppm2l51XddJEf1qgnAEPWOPhMYtCLXNL0d/3Senen
	UfeLWqnJdFJiV3OCNGv7Gx6uF/nkB58jMALhMUDGIl3CGihzMnKJorDdmXOy7EjSquQEOFZRyzSvO
	7zGAhvP8v5iroVagEKr3iVVtuL68nTw6ENsDAAWUL52866vN9a1vYHVGMNjrUG5zhFBacsisMbZ33
	+AwD+DZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37810)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFxwj-0000000019y-3eQA;
	Mon, 03 Nov 2025 17:02:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFxwf-000000003wv-0J3T;
	Mon, 03 Nov 2025 17:02:17 +0000
Date: Mon, 3 Nov 2025 17:02:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQjgGBGY4T6xbjWr@shell.armlinux.org.uk>
References: <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
 <aQiP46tKUHGwmiTo@oss.qualcomm.com>
 <aQiVWydDsRaMz8ua@shell.armlinux.org.uk>
 <20251103121353.dbnalfub5mzwad62@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103121353.dbnalfub5mzwad62@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 02:13:53PM +0200, Vladimir Oltean wrote:
> > stmmac unfortunately doesn't give access to the raw Cisco SGMII
> > in-band control word. However, reading register 0xf8 bits 31:16 for
> > dwmac4, or register 0xd8 bits 15:0 for dwmac1000 will give this
> > information. In that bitfield, bits 2:1 give the speed. 2 = 1G,
> > 1 = 100M, 0 = 10M.
> 
> It might be Linux who is forcing the AQR115C into the nonsensical
> behaviour of advertising 10M in the SGMII control word while
> simultanously forcing the PHY MII to operate at 1G with flow control
> for the 10M media speed.

There's another factor in play here: the dwmac-qcom-ethqos glue driver
forces the configuration of the stmmac integrated PCS irrespective of
what phylink wants (whether or not patch 1 is being used.) That is,
for 1G, 100M and 10M, the SGMII in-band control word must be sent by
the PHY, and it must accurately indicate the symbol replication via
the speed bits. If this is not the case, then the stmmac PCS block will
not behave correctly.

So, if the PHY says in the SGMII configuration word that its operating
at 10M, but is internally rate-adapting to 1G and sending the packet
with no symbol replication, that is outside what the stmmac PCS block
will cope with.

> We don't control the latter, but we do control the former:
> aqr_gen2_config_inband(), if given modes == LINK_INBAND_ENABLE, will
> enable in-band for all media speeds that use PHY_INTERFACE_MODE_SGMII.
> Regardless of how the PHY was provisioned for each media speed, and
> especially regardless of rate matching settings, this function will
> uniformly set the same in-band enabled/disabled setting for all media
> speeds using the same host interface.
> 
> If dwmac_integrated_pcs_inband_caps(), as per Russell's patch 1/3,
> reports LINK_INBAND_ENABLE | LINK_INBAND_DISABLE, and if
> aqr_gen2_inband_caps() also reports LINK_INBAND_ENABLE | LINK_INBAND_DISABLE,
> then we're giving phylink_pcs_neg_mode() all the tools it needs to shoot
> itself in the foot, and select LINK_INBAND_ENABLE.
> 
> The judgement call in the Aquantia PHY driver was mine, as documented in
> commit 5d59109d47c0 ("net: phy: aquantia: report and configure in-band
> autoneg capabilities"). The idea being that the configuration would have
> been unsupportable anyway given the question that the framework asks:
> "does the PHY use in-band for SGMII, or does it not?"

From the kernel messages provided, the PCS is reporting no
capabilities, but as you say, the PHY is reporting
LINK_INBAND_ENABLE | LINK_INBAND_DISABLE. The mode that phylink is
using is "phy/outband/sgmii" - so what _should_ be no in-band
signalling. However, note what I said above - for 1G, 100M and 10M,
qcom-ethqos does this:

	ethqos_pcs_set_inband(priv, true);

in its fix_mac_speed() hook, which translates to:

	stmmac_pcs_ctrl_ane(priv, true, 0);

which eventually gets through to:

	dwmac_ctrl_ane(priv, offset, true, false);

This sets GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN but not
GMAC_AN_CTRL_SGMRAL. This means "autoneg enable" "restart autoneg" and
!SGMRAL means that the SGMII rate adaption block operates according to
the link speed received from the PHY.

At this point, I'm not sure whether I should just rip out the
stmmac_pcs_ctrl_ane() stuff from dwmac-qcom-ethqos.c - I've been
operating on the assumption that this is working code. Maybe that's
a false assumption, and its been broken since a818bd12538c ("net:
stmmac: dwmac-qcom-ethqos: Add support for 2.5G SGMII").

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

