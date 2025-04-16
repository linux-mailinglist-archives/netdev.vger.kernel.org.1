Return-Path: <netdev+bounces-183152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73222A8B357
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541723A4D6F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66C26AEC;
	Wed, 16 Apr 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Dhx5jdtU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3465199FAB
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791657; cv=none; b=kkwA4dfY04tYY2GO7nJc7DjvXegFa/eMfFn3HTLfgxe8eiMeF/w/hm4UdA6lDeWP7PyXu8ALvQvDJu+OHTjxLAYRNngVg6Uc6ZHBUF5jUIMul6rjkzbFaxnKatpF2KJtOHI4jiRqhmVfm90ZCmmG2XkfPMLTfweTJGUjUcyvAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791657; c=relaxed/simple;
	bh=3FDmJj1M4qcbECNJRvLs5dFm6VzeOfOqrPS+aE7hkns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTWRGohH8a4UspagTmZdiqSYBYSBzscmyhFNkt3ir5QIOB+NjoRvO7cIwW3Hdfb6zjTlE3yUggR3NW3kwvnjbbO7GuZ+/Hhf1eeqw3vvkb4kcQSy1o9Nzb0XPf0pGcTaI3nld5XqRM3kCv2EOqtBJbZruq622Adz50+b8BPR3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Dhx5jdtU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=URwBuCbS6/neY6AV6CFvJFFAf/PObTEbrh2Q/19p6+0=; b=Dhx5jdtUk0jK2Karpqm4mt9/dP
	ozAsmNP8yHltiUVF1HqvFV+DJ1hNVy7pSEa9SRoRCOjoLJE+rjKQw5Kvuot4psTRt9Jv7ACkmJ9dp
	tqg87Jfh2arIdiureSuR7lKJe6u/SE3S4y1taSx61dIO4TdudScqo4Y5d7lRy5Bebcj65hyxU58Z1
	WvUbymB5Sgu6zqpQBb7DWuqop1+RTIG57QACukwxxHK9TiW7VkuzL640shud4iS5blZGWTtu1f1GB
	U1OQVCEVbH5SvaFawlZi1m/SzLGIgcEgT8NHKh7nsLAqAxplleH4ru+9ijTyJTwAwovAhwBPdP1G6
	FuO3O1ew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38076)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u4y0i-0000uI-1K;
	Wed, 16 Apr 2025 09:20:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u4y0d-0001FI-0V;
	Wed, 16 Apr 2025 09:20:39 +0100
Date: Wed, 16 Apr 2025 09:20:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/5] net: stmmac: socfpga: fix init ordering and
 cleanups
Message-ID: <Z_9oVrAOnInrhb6z@shell.armlinux.org.uk>
References: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
 <20250416095343.1820272f@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416095343.1820272f@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 09:53:43AM +0200, Maxime Chevallier wrote:
> I've given this a try and unfortunately :

Great, someone with hardware, and who responds to patches! :)

> This is only to get the phymode, maybe we should do like dwmac_imx
> and store a pointer to plat_dat into struct dwmac_socfpga, so that we
> can get it back in dwmac_init ? I've tried with the patch below and it
> does solve the issue, but maybe you have a better approach.

Yes, but I don't think we need such a big patch:

 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 8e6d780669b9..59f90b123c5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -50,6 +50,7 @@ struct socfpga_dwmac {
 	u32	reg_offset;
 	u32	reg_shift;
 	struct	device *dev;
+	struct plat_stmmacenet_data *plat_dat;
 	struct regmap *sys_mgr_base_addr;
 	struct reset_control *stmmac_rst;
 	struct reset_control *stmmac_ocp_rst;
@@ -233,10 +234,7 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 
 static int socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 {
-	struct net_device *ndev = dev_get_drvdata(dwmac->dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	return priv->plat->mac_interface;
+	return dwmac->plat_dat->mac_interface;
 }
 
 static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
@@ -490,6 +488,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	 */
 	dwmac->stmmac_rst = plat_dat->stmmac_rst;
 	dwmac->ops = ops;
+	dwmac->plat_dat = plat_dat;
 
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

