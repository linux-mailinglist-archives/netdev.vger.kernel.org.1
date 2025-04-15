Return-Path: <netdev+bounces-182801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD6A89ED5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD7916F553
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F62973B9;
	Tue, 15 Apr 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ViuqtjcQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A32973A2
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721937; cv=none; b=VRufd6yfpHjOPXYmAPyXxzdYSKVAX57zXHDGRc5Ks9UDDLGwl8ko65RZ9mtykJXCTlPXX6AZsAWoayteUCRgxb2VpxXfPl0P1GsxNyLIymEpU1ufkgIXdyUG+rF+qG25vhMr+fpHqq7/fCh8lx/grlbOLESK7lujKK1BuwOovho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721937; c=relaxed/simple;
	bh=JxaPe3f3t1vHjvdHGUFo/vJS8a9KXNds7bF+Z4G5Fe4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=VIu57ntNCCqOMis28UOtdft2BRBilFQvvh67RERX89EPO3Z3oJzal1x0oj23Oju5s4vt3BUzSpif6L2vfPJZAqsdwoHvExW3VjMuKLSW5gDbCajYex4gmDomkDv5XAkW+HeJP38T1egsDd+2puv9IotASdil5zu3KUAvphoKFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ViuqtjcQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OqLXDGv3Fls4ysUHHIvC7QJrCvpDtEPwNQhSDZ3sDJ4=; b=ViuqtjcQbaHZXdfHO3285BRbUz
	AbwRA36/hCCqufNfw6WB3lJKwWDm2445K9WaduGMmu0GVCiB8Z0PtmgVY0l4iXUYsfaEVvRu0dWK+
	PWvKM/i6KX1WNJg0dhc+NhStQ1R0FNKb8Zkhx3m8o8R0rLwoSrDSOXvyrROnJSueQNDU6YYc5lNfI
	aUGnXjCjQQ33mYVtWF99qr7lgVQrIXssuLzBOlqgAMASApczkFyQGRJE560LoyCipkI6IgX8unPY1
	t/L8hbaEMHMs9Fm9Zm3cuY4AvKjx7yHuPu2B/n66Hauj11C4ZPRmCtQ/N2l65UPqQ+CDFnagVfIDg
	L7SgmtpA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55888 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4fsG-0008CS-0W;
	Tue, 15 Apr 2025 13:58:48 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4fre-000nMr-FT; Tue, 15 Apr 2025 13:58:10 +0100
In-Reply-To: <Z_5WT_jOBgubjWQg@shell.armlinux.org.uk>
References: <Z_5WT_jOBgubjWQg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next 3/3] net: stmmac: sunxi: use
 devm_stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4fre-000nMr-FT@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 13:58:10 +0100

Using devm_stmmac_pltfr_probe() simplifies the probe function. This
will not only call plat_dat->init (sun7i_dwmac_init), but also
plat_dat->exit (sun7i_dwmac_exit) appropriately if stmmac_dvr_probe()
fails. This results in an overall simplification of the glue driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 665eab1d3409..1eadcf5d1ad6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -144,7 +144,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	plat_dat->tx_fifo_size = 4096;
 	plat_dat->rx_fifo_size = 16384;
 
-	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id sun7i_dwmac_match[] = {
@@ -155,7 +155,6 @@ MODULE_DEVICE_TABLE(of, sun7i_dwmac_match);
 
 static struct platform_driver sun7i_dwmac_driver = {
 	.probe  = sun7i_gmac_probe,
-	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "sun7i-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.30.2


