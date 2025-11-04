Return-Path: <netdev+bounces-235423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7EC3053B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75203AB35A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A336306B0D;
	Tue,  4 Nov 2025 09:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134E153BED
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249042; cv=none; b=GrocpDkFj9UXgokLUKFta71hsBpxqRi4mz7UCRqhx1qSDvPttfTWzlGnVum8eIj4uMhaidfXcwRjG+9Ku8UQQMZMzDigv1gXPIf51cPn8UkCrkUv93UziSmueCMNf33BfIeMABmujsRGHSeVTeqWXPctXW9dcWfBgBrMEPNB9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249042; c=relaxed/simple;
	bh=iRvoS7EKii9nQ3eFT/bShvE8cVFKgcD7Qj1aV7DZQCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3TyiIQxepd7QmHrBdDVd7P99RtDNgUjc9IBC7eHZrzV+NQfSlSyN2xbO7W4bB24Vg5be3pOxgmAxwD6BXseH3ldosspLfP+KXaOeH9ap7SOBrCPANnEbhqd7BCzWGhyvTSL3CiDhH0Mg2geE7TuVMBqF6CLF+EXzhSobtClefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E01321A0135;
	Tue,  4 Nov 2025 10:37:10 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D26211A004C;
	Tue,  4 Nov 2025 10:37:10 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 38F12202E8;
	Tue,  4 Nov 2025 10:37:10 +0100 (CET)
Date: Tue, 4 Nov 2025 10:37:10 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Message-ID: <aQnJRgJqFY99kDUj@lsv051416.swis.nl-cdc01.nxp.com>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
 <E1vFt4S-0000000ChoS-2Ahi@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vFt4S-0000000ChoS-2Ahi@rmk-PC.armlinux.org.uk>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Nov 03, 2025 at 11:50:00AM +0000, Russell King (Oracle) wrote:
> S32's PHY_INTF_SEL_x definitions conflict with those for the dwmac
> cores as they use a different bitmapping. Add a S32 prefix so that
> they are unique.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index ee095ac13203..2b7ad64bfdf7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -24,10 +24,10 @@
>  #define GMAC_INTF_RATE_125M	125000000	/* 125MHz */
>  
>  /* SoC PHY interface control register */
> -#define PHY_INTF_SEL_MII	0x00
> -#define PHY_INTF_SEL_SGMII	0x01
> -#define PHY_INTF_SEL_RGMII	0x02
> -#define PHY_INTF_SEL_RMII	0x08
> +#define S32_PHY_INTF_SEL_MII	0x00
> +#define S32_PHY_INTF_SEL_SGMII	0x01
> +#define S32_PHY_INTF_SEL_RGMII	0x02
> +#define S32_PHY_INTF_SEL_RMII	0x08
>  
>  struct s32_priv_data {
>  	void __iomem *ioaddr;
> @@ -40,7 +40,7 @@ struct s32_priv_data {
>  
>  static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
>  {
> -	writel(PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
> +	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
>  
>  	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
>  
> -- 
> 2.47.3
> 

Reviewed-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Thanks.
/Jan


