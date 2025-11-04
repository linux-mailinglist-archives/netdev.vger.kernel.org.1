Return-Path: <netdev+bounces-235467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD76C311B4
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B24574E0552
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0A1E7C18;
	Tue,  4 Nov 2025 13:04:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A434D3B5
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261470; cv=none; b=n+lAz+p2NRaawjrDgoW1mFkHAYh0jVSlg9S13iS0GKzPisFN1DjaFlp+ZILlclbO0fWBmZarz6DUy3lBd55VrsVMMejK6rgnCFueRau5O6v3OL082VAS7sAbkFt58JHuOLLb5SfqHPxUPwTkzpoEAo3yd05TiX/I7VJoMgHEBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261470; c=relaxed/simple;
	bh=AGyEpwYEioYBmSj9xKbMDznM0ls2s0eCibPm8Q1dRP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyuNqxsEzOd2q16NQbAeAYktNgI05SdZ/aF0cxXpZFE8V6+9TNCm58tAXXqDtZNFKi1ubQDtQE2u7Jyz3BCnoiMqh19kYWoKIid2qoD5leAsaWnRGGMfpfq78CAEwGReyjvcPncQxp73+67pO2RU7blffffXBPGMK90G9G4eklc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B59C81A0A39;
	Tue,  4 Nov 2025 14:04:25 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A77171A09FE;
	Tue,  4 Nov 2025 14:04:25 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 08A68202E8;
	Tue,  4 Nov 2025 14:04:25 +0100 (CET)
Date: Tue, 4 Nov 2025 14:04:25 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 02/11] net: stmmac: s32: move PHY_INTF_SEL_x
 definitions out of the way
Message-ID: <aQn52d7B6HfVSS22@lsv051416.swis.nl-cdc01.nxp.com>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
 <E1vFt4S-0000000ChoS-2Ahi@rmk-PC.armlinux.org.uk>
 <aQnJRgJqFY99kDUj@lsv051416.swis.nl-cdc01.nxp.com>
 <aQnNjWuytebZpZyW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQnNjWuytebZpZyW@shell.armlinux.org.uk>
X-Virus-Scanned: ClamAV using ClamSMTP

On Tue, Nov 04, 2025 at 09:55:25AM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 04, 2025 at 10:37:10AM +0100, Jan Petrous wrote:
> > On Mon, Nov 03, 2025 at 11:50:00AM +0000, Russell King (Oracle) wrote:
> > >  /* SoC PHY interface control register */
> > > -#define PHY_INTF_SEL_MII	0x00
> > > -#define PHY_INTF_SEL_SGMII	0x01
> > > -#define PHY_INTF_SEL_RGMII	0x02
> > > -#define PHY_INTF_SEL_RMII	0x08
> > > +#define S32_PHY_INTF_SEL_MII	0x00
> > > +#define S32_PHY_INTF_SEL_SGMII	0x01
> > > +#define S32_PHY_INTF_SEL_RGMII	0x02
> > > +#define S32_PHY_INTF_SEL_RMII	0x08
> > 
> > Reviewed-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> 
> Thanks. One question: is it possible that bits 3:1 are the dwmac
> phy_intf_sel_i inputs, and bit 0 selects an external PCS which
> is connected to the dwmac using GMII (and thus would be set bits
> 3:1 to zero) ?

I guess so, as the S32G3 Reference Manual says regarding
GMAC_0_CTRL_STS register bits the following:

[3-1] PHY_INTF_SEL: PHY Interface Select
      Selects the PHY interface. These values are valid only
      for PHY_MODE=0.

      000b - MII
      001b - RGMII
      100b - RMII

[0-0] PHY_MODE: Select the PHY mode.
      Selects the PHY mode.

      0b - Other PHY modes (for ex. RGMII, RMII, ...)
      1b - SGMII mode

> 
> It's not really relevant as the driver only appears to support
> RGMII.

Yes. The RGMII was the simplest way to upstream review, so
I decided to stick on it.

The SGMII support is ongoing.

/Jan


