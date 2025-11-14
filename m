Return-Path: <netdev+bounces-238699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D551C5E030
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5A4638622D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A198232E746;
	Fri, 14 Nov 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CoIURsqa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1B32E759
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134119; cv=none; b=cGsUVHdwYRIbqLPkXyO/BNhjJoxAv+9KGRUTlR0OvbkncFBAN/c4fd9+zqBh28deP56lEKnrw8PzCX4s/e9EnXPxQvqIznaZPZhTAuEzyF+9cSNRb9YYxhiZJHXp0pvoasdGXsFth5SymrTFl1v4it7t206ZWCx0PwPK03Kx7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134119; c=relaxed/simple;
	bh=PVr1L0b81HzhBcHzGYnykFnTdu3V0jxtcN4CXQqihHc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RPdft2ZHEDqUmpEnJXaivdihjMvp9d15Jctc3V+YzoUHQIdDJHjoo3MYQe+cHk7GXUEbT0PZ6mMiD20DioJzOjg1s1EPJl/xjv0JNqCk+Fmu8PZvVxL508pW7hQnn3wapILXfko7YC89IM56HFU23XpaEWU0cDI4B4rM1onxH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CoIURsqa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hlhOTxorkK0qWym+ups7Cpvw3GcGPEKIQshOQKtZsh8=; b=CoIURsqaLonDZQIr7hNe5QLTC3
	Zki421bzvxpYIlkPP96GOBXFo1ZjrWQX80V8EgWCwwbS5gdNI91EutnRT0PhAugTq5HnLb1EXJlFY
	cJPTik65dStS/dfMzt9O+cKPqMC17DS2fhheFYfRlDYo6artH0WBjJwQtg4dypAWZ6sVGwKEe7uLD
	9yudhi0e76Q9SngQ4192JV4h/ZL9YZvfF+76c9BgdZsFaWWSPP7EhdeaCBsz7DJpXVG44S3BI7bE9
	rFiO2+cSqFFeYr2SCKUYLgNjE90rmOYqUvxbO9S5JCp+L5392lo5caxR//wG5waRWuXteaqesoDtP
	a20ptMqw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36182 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJviw-0000000076H-16Rl;
	Fri, 14 Nov 2025 15:28:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJviv-0000000EVjV-1CLF;
	Fri, 14 Nov 2025 15:28:29 +0000
In-Reply-To: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
References: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen Wang <unicorn_wang@outlook.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	sophgo@lists.linux.dev
Subject: [PATCH net-next 02/11] net: stmmac: move initialisation of phy_addr
 to stmmac_plat_dat_alloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJviv-0000000EVjV-1CLF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Nov 2025 15:28:29 +0000

Move the default initialisation of plat_dat->phy_addr to
stmmac_plat_dat_alloc().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c  | 3 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 --
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2d803fa37e21..8593411844bc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -114,9 +114,6 @@ static void loongson_default_data(struct pci_dev *pdev,
 	plat->clk_ref_rate = 125000000;
 	plat->clk_ptp_rate = 125000000;
 
-	/* Default to phy auto-detection */
-	plat->phy_addr = -1;
-
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 400b4b955820..1851f7d0702d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7563,6 +7563,11 @@ struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
 	if (!plat_dat)
 		return NULL;
 
+	/* Set the defaults:
+	 * - phy autodetection
+	 */
+	plat_dat->phy_addr = -1;
+
 	return plat_dat;
 }
 EXPORT_SYMBOL_GPL(stmmac_plat_dat_alloc);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 622cdbeca20f..b981a9dd511d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -112,7 +112,6 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	}
 
 	plat->bus_id = 1;
-	plat->phy_addr = -1;
 	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
 
 	plat->dma_cfg->pbl = 32;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 38d574907a04..745032fd46ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -480,8 +480,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->bus_id = ++bus_id;
 	}
 
-	/* Default to phy auto-detection */
-	plat->phy_addr = -1;
 
 	/* Default to get clk_csr from stmmac_clk_csr_set(),
 	 * or get clk_csr from device tree.
-- 
2.47.3


