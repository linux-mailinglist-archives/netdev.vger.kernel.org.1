Return-Path: <netdev+bounces-243028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED61BC985A1
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 17:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5303A3217
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C330F92B;
	Mon,  1 Dec 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C8T5cUb/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4212DA742;
	Mon,  1 Dec 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607706; cv=none; b=kKEf49ZVzchc+SY2XgraQneXCHP29KkPmISVV4SR73inM+SK9aNljh0rdEYRLHT5XBYuJM2rQ3Jb2fgQwP8boSY4orZPSr68i4ojR7fatzU/IN0m9TPM8vGnAMnICL9RXPWcbtcaY0QLqRfQ6zLW8X/8H1BFTBXBGWhuKWCAc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607706; c=relaxed/simple;
	bh=dL9yfUlfS0GcMHCrcNS4j9aMiHSeMQzo13nqSkhsESQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPABc47dX76uc/S8rgQeEXJjpYHWD+M8GB5/kFnEVk+hvoIjfEh7cnv+HwzFhSN55f0fOxQZVhjJEYRnTb3J/62Vfeo7xdAnhZJQTGNAkReHkRkosKGLRF+aEC/9lweUBx1SynikM2HNMng3esL4j/b2l3PFjIA2Sz3ixYIGEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=C8T5cUb/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SA6dnTrNj4LIhw4ryXUxa69r4owI88jPXlo37BXLqtg=; b=C8T5cUb/szz2tMJ4Qp4JAcSZ4k
	xJJIYwHNe6ZDlMr1yRJzF6B8/T75gKPmC0P7wucNEoxSSoIoc0RA0HWZtCxEJTqPzO0CgcB0d1RUg
	6PA7qJoxqGQp83nckIIkQVTKWhWTkJFpHTdChAUxpYo/hPa5SXxRQ8eefWAeCRCmio3v/VVPBUT3A
	5ulFJ11ZzZVgKiWS0tsxCBhFgiJVk7QCaXFbRysK8RczUDhx1aatAXSgn9uOmKXBJERgv9SFGdtYc
	UUrKDXDYME7+omjKwj/GdFGESAs02cZ+0V+kiffVy6YGXZKnUJrykZrxs8Z02HB9jGIV+yzZUf4ls
	LQ3w1nhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56048)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQ74R-000000000qs-1xaO;
	Mon, 01 Dec 2025 16:48:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQ74O-000000006cs-44eQ;
	Mon, 01 Dec 2025 16:48:12 +0000
Date: Mon, 1 Dec 2025 16:48:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org
Subject: Re: [PATCH 1/4] net: stmmac: s32: use the syscon interface
 PHY_INTF_SEL_RGMII
Message-ID: <aS3GzJljbfp2xJmW@shell.armlinux.org.uk>
References: <cover.1764592300.git.dan.carpenter@linaro.org>
 <6275e666a7ef78bd4c758d3f7f6fb6f30407393e.1764592300.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6275e666a7ef78bd4c758d3f7f6fb6f30407393e.1764592300.git.dan.carpenter@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 01, 2025 at 04:08:20PM +0300, Dan Carpenter wrote:
> On the s32 chipset the GMAC_0_CTRL_STS register is in GPR region.
> Originally, accessing this register was done in a sort of ad-hoc way,
> but we want to use the syscon interface to do it.
> 
> This is a little bit uglier because we to maintain backwards compatibility
> to the old device trees so we have to support both ways to access this
> register.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 5a485ee98fa7..20de761b7d28 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -11,12 +11,14 @@
>  #include <linux/device.h>
>  #include <linux/ethtool.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_mdio.h>
>  #include <linux/of_address.h>
>  #include <linux/phy.h>
>  #include <linux/phylink.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/stmmac.h>
>  
>  #include "stmmac_platform.h"
> @@ -32,6 +34,8 @@
>  struct s32_priv_data {
>  	void __iomem *ioaddr;
>  	void __iomem *ctrl_sts;
> +	struct regmap *sts_regmap;
> +	unsigned int sts_offset;
>  	struct device *dev;
>  	phy_interface_t *intf_mode;
>  	struct clk *tx_clk;
> @@ -40,7 +44,10 @@ struct s32_priv_data {
>  
>  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
>  {
> -	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	if (gmac->ctrl_sts)
> +		writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	else
> +		regmap_write(gmac->sts_regmap, gmac->sts_offset, PHY_INTF_SEL_RGMII);

Sorry, but even if that regmap_write() is targetting the exact same
register, these are not identical.

S32_PHY_INTF_SEL_RGMII, which is a S32-specific value, takes the value 2.
PHY_INTF_SEL_RGMII is the dwmac specific value, and takes the value 1.

If this targets the same register, then by writing PHY_INTF_SEL_RGMII,
you are in effect writing the equivalent of S32_PHY_INTF_SEL_SGMII to
it. This seems like a bug.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

