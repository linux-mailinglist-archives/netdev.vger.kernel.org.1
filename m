Return-Path: <netdev+bounces-238702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83788C5E61B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDF80366C58
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CE3321A8;
	Fri, 14 Nov 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TVzOHbal"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543A23E355
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134137; cv=none; b=ur/U+fqrjwqWcmCVrc7ZMYoWsh65+m4gf4b1dgQ2VAySdrt6D3TheXvMAqA3VAl+2OxeMme8X/ZJLTEslqa2uYoXLo99BcDL3wrvKa0kA/GQBKSxdpudZNuxp25FxUOAU04c8W0p5Y6rLU5iVy5IoBYxcWk9vvQJ/bGmkXgZmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134137; c=relaxed/simple;
	bh=mBgbhjOm1iS8uHqzaIq/XmUFTLbEwNfgH6Nvm/62o+I=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DXphe0cd7eLs4aXc5Gm85t9uIRLT3oSflw1wpk+pjzOH1f/dNwhD1fW6Z368O3NFTxG7wpyKFbiju5xQmH3/1wtKJF7sKeQuRNsoQm0BzvRSLyeUdTSoGffECDNiw8DSJyyt/oeW/qIRkyWG/quO1rXLGG1NYX4xHXViF2X8bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TVzOHbal; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B+QC+EYDY+L5i93+N9MqrB+wbSBfnqqFhJme+PoyS54=; b=TVzOHbaltwteVhc8t/q4YerACL
	M4gTxnVwG0y4EUFmosGwFT220v3JI/mJ5um/IQYqmnox282+3TdB0FNcSJFz905TlzmbxhLldZ25V
	0cF5yLAnZJoQMrf8NbBY6MfGtNYlWQAFAQvPoa79fAdSkMYuaoa5cdeBBSkvrS2Ju69Q0CieM8rRF
	F7i7OteKHP9gP2L5FPmwqdZUDgcwdyK/sNuUMO04jkTO3DMXXslsdn/P7zE8v7AOSN/JCPrn7JY5M
	s6LMzeFm0Tzn7IHTtbffba7c4aMfOSKERgem+5eL/Q12+NeR7tBCRjY9tKzMrRtAwr22nBv+sfvpT
	Xqzmk7cw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53654 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJvjB-0000000077L-3OLm;
	Fri, 14 Nov 2025 15:28:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJvjA-0000000EVjo-2qVn;
	Fri, 14 Nov 2025 15:28:44 +0000
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
Subject: [PATCH net-next 05/11] net: stmmac: move initialisation of
 multicast_filter_bins to stmmac_plat_dat_alloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJvjA-0000000EVjo-2qVn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Nov 2025 15:28:44 +0000

Move the default initialisation of plat_dat->multicast_filter_bins to
HASH_TABLE_SIZE to stmmac_plat_dat_alloc(). This means platform glue
only needs to override this if different.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c     | 6 ------
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c      | 6 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ---
 5 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index cf69e659c415..a4ef3ec070e2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -570,9 +570,6 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 
 	plat->mdio_bus_data->needs_reset = true;
 
-	/* Set default value for multicast hash bins */
-	plat->multicast_filter_bins = HASH_TABLE_SIZE;
-
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
@@ -703,9 +700,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	plat->ptp_clk_freq_config = intel_mgbe_ptp_clk_freq_config;
 
-	/* Set default value for multicast hash bins */
-	plat->multicast_filter_bins = HASH_TABLE_SIZE;
-
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 89232c788c61..cfdda9e82a19 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -95,7 +95,7 @@ static void loongson_default_data(struct pci_dev *pdev,
 	plat->core_type = DWMAC_CORE_GMAC;
 	plat->force_sf_dma_mode = 1;
 
-	/* Set default value for multicast hash bins */
+	/* Increase the default value for multicast hash bins */
 	plat->multicast_filter_bins = 256;
 
 	/* Set default value for unicast filter entries */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0763ed06715e..a7393a3e792f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7567,10 +7567,12 @@ struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
 	 * - phy autodetection
 	 * - determine GMII_Address CR field from CSR clock
 	 * - allow MTU up to JUMBO_LEN
+	 * - hash table size
 	 */
 	plat_dat->phy_addr = -1;
 	plat_dat->clk_csr = -1;
 	plat_dat->maxmtu = JUMBO_LEN;
+	plat_dat->multicast_filter_bins = HASH_TABLE_SIZE;
 
 	return plat_dat;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index b0b4358e0adf..0c65b24480ae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -28,9 +28,6 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 
 	plat->mdio_bus_data->needs_reset = true;
 
-	/* Set default value for multicast hash bins */
-	plat->multicast_filter_bins = HASH_TABLE_SIZE;
-
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
@@ -78,9 +75,6 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
 
-	/* Set default value for multicast hash bins */
-	plat->multicast_filter_bins = HASH_TABLE_SIZE;
-
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 81a599475577..9982aaa19519 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -508,9 +508,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->flags |= STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 	}
 
-	/* Set default value for multicast hash bins */
-	plat->multicast_filter_bins = HASH_TABLE_SIZE;
-
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
-- 
2.47.3


