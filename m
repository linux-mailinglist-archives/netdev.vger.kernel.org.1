Return-Path: <netdev+bounces-193187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664DAC2C98
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF6D4A483A
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 00:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833D81E;
	Sat, 24 May 2025 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s3R3w63k"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE48F66;
	Sat, 24 May 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748045173; cv=none; b=K06syPZ4vWhcTuZqudm+SpuxVw8/AsLgj8nzHeQnOXWa3c8lAm3i9wU6QIvymDOTZFY9/jrGZJQpUbdKYAUt6kdMXycVakz/jHSmqS3h8Xzo99URcjKWK658NlZcHwyQModFjetMBaeBotI1oZVl9skudZGB9ZdnVNfq5QyRxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748045173; c=relaxed/simple;
	bh=d5tUJSTZcL5Tc4PZdJBl8+x39c8Y4r8OKEODz43Oe80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsp+MXBpWSQkafLLTwbH1UIv3h/RMLJ+qXuhyEEGYuumH4IQbdzh4lAc3k0CT3lDpzKHI5VnfYi6M4TcNUepzzKslXzC9aZhA/1AiWBlEYd/r6kGjA6IEeUmXv5QyMo7Ku2oyVkFKRKGFT8/E52yUzcg2KtqOd5gHeRGGTttqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=s3R3w63k; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kJW5yfLMv6KfYajBWSB2+tcy3Ju4PEVFx9kcwqoX2M8=; b=s3R3w63k4JHTq66/JjHB3c/PnR
	vMXzuY6WQj8bpgPt2kJRuib+GLaM3kYRx3NE8wnMhr0hPrJSI1mp7woYJBtv7bu2fASR5Jnf5lqEH
	SCPz3nneg3BV/mGEAywVzBnkUk8RmK38w0kCO17zEmHJnLtDtjn2EqA4t2R88SItIlJkco63+uKFk
	jCn+IGlm5SBzNcb3l+wwDGva82RKj4kWXjHjEm283Om5wVuXxfyCqu0iZ0WciHzyX0fDsXR0339u9
	NUZ068vY9q1JYl7AYdY+CL+/BNF1weL6y/v6WYU5iimdqX+NwQWLoEGDxWs2pyzWALV8gerYDnKXR
	vI+1mGNA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54864)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uIcOm-0004BY-32;
	Sat, 24 May 2025 01:06:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uIcOg-0006Ib-04;
	Sat, 24 May 2025 01:05:54 +0100
Date: Sat, 24 May 2025 01:05:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <aDENYfL7Hstsswml@shell.armlinux.org.uk>
References: <20250523203339.1993685-1-sean.anderson@linux.dev>
 <20250523203339.1993685-6-sean.anderson@linux.dev>
 <a937e728-d911-4fcc-9af1-9ae6130f96c1@gmail.com>
 <3a452864-9d02-4fa7-9d7c-a240b611ee74@linux.dev>
 <e0bd575b-a01b-418f-9d89-b59398e87a48@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0bd575b-a01b-418f-9d89-b59398e87a48@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 23, 2025 at 06:07:16PM -0400, Sean Anderson wrote:
> On 5/23/25 17:39, Sean Anderson wrote:
> > On 5/23/25 17:33, Heiner Kallweit wrote:
> >> On 23.05.2025 22:33, Sean Anderson wrote:
> >>> This converts the lynx PCS driver to a proper MDIO driver.
> >>> This allows using a more conventional driver lifecycle (e.g. with a
> >>> probe and remove). It will also make it easier to add interrupt support.
> >>> 
> >>> The existing helpers are converted to bind the MDIO driver instead of
> >>> creating the PCS directly. As lynx_pcs_create_mdiodev creates the PCS
> >>> device, we can just set the modalias. For lynx_pcs_create_fwnode, we try
> >>> to get the PCS the usual way, and if that fails we edit the devicetree
> >>> to add a compatible and reprobe the device.
> >>> 
> >>> To ensure my contributions remain free software, remove the BSD option
> >>> from the license. This is permitted because the SPDX uses "OR".
> >>> 
> >>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> >>> ---
> >>> 
> >>> Changes in v5:
> >>> - Use MDIO_BUS instead of MDIO_DEVICE
> >>> 
> >>> Changes in v4:
> >>> - Add a note about the license
> >>> - Convert to dev-less pcs_put
> >>> 
> >>> Changes in v3:
> >>> - Call devm_pcs_register instead of devm_pcs_register_provider
> >>> 
> >>> Changes in v2:
> >>> - Add support for #pcs-cells
> >>> - Remove unused variable lynx_properties
> >>> 
> >>>  drivers/net/dsa/ocelot/Kconfig                |   4 +
> >>>  drivers/net/dsa/ocelot/felix_vsc9959.c        |  11 +-
> >>>  drivers/net/dsa/ocelot/seville_vsc9953.c      |  11 +-
> >>>  drivers/net/ethernet/altera/Kconfig           |   2 +
> >>>  drivers/net/ethernet/altera/altera_tse_main.c |   7 +-
> >>>  drivers/net/ethernet/freescale/dpaa/Kconfig   |   2 +-
> >>>  drivers/net/ethernet/freescale/dpaa2/Kconfig  |   3 +
> >>>  .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  11 +-
> >>>  drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
> >>>  .../net/ethernet/freescale/enetc/enetc_pf.c   |   8 +-
> >>>  .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 -
> >>>  .../freescale/enetc/enetc_pf_common.c         |   4 +-
> >>>  drivers/net/ethernet/freescale/fman/Kconfig   |   4 +-
> >>>  .../net/ethernet/freescale/fman/fman_memac.c  |  25 ++--
> >>>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |   3 +
> >>>  .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   6 +-
> >>>  drivers/net/pcs/Kconfig                       |  11 +-
> >>>  drivers/net/pcs/pcs-lynx.c                    | 110 ++++++++++--------
> >>>  include/linux/pcs-lynx.h                      |  13 ++-
> >>>  19 files changed, 128 insertions(+), 110 deletions(-)
> >>> 
> >>> diff --git a/drivers/net/dsa/ocelot/Kconfig b/drivers/net/dsa/ocelot/Kconfig
> >>> index 081e7a88ea02..907c29d61c14 100644
> >>> --- a/drivers/net/dsa/ocelot/Kconfig
> >>> +++ b/drivers/net/dsa/ocelot/Kconfig
> >>> @@ -42,7 +42,9 @@ config NET_DSA_MSCC_FELIX
> >>>  	select NET_DSA_TAG_OCELOT_8021Q
> >>>  	select NET_DSA_TAG_OCELOT
> >>>  	select FSL_ENETC_MDIO
> >>> +	select PCS
> >>>  	select PCS_LYNX
> >>> +	select MDIO_BUS
> >> 
> >> This shouldn't be needed. NET_DSA selects PHYLINK, which selects PHYLIB,
> >> which selects MDIO_BUS. There are more places in this series where the
> >> same comment applies.
> > 
> > select does not transitively enable dependencies. See the note in
> > Documentation/kbuild/kconfig-language.rst for details. Therefore we must
> > select the dependencies of things we select in order to ensure we do not
> > trip sym_warn_unmet_dep.
> 
> OK, I see what you mean here. But of course NET_DSA is missing selects for
> PHYLIB and MDIO_BUS. And PHYLINK is also missing a select for MDIO_BUS. Actually,
> this bug is really endemic. Maybe we should just get rid of PHYLIB as a config
> and just make everything depend on ETHERNET instead.

You're reading the documentation wrongly.

Take this example:

config A
	select B

config B
	select C
	depends on E

config C
	select D

config D

config E

Enabling A leads to B, C and D all being enabled, but it does *not*
lead to E being enabled - kconfig will issue a warning if E is not
already enabled.

E is a dependency of B. There are no other dependencies, but there
are reverse dependencies, and reverse dependencies are propagated.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

