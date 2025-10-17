Return-Path: <netdev+bounces-230376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7BABE74D8
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B700E4E647D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2529ACC2;
	Fri, 17 Oct 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ihl7Vd4y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029923BF91;
	Fri, 17 Oct 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691357; cv=none; b=iBhqFEbLc5b9h9Wn3zOuXln6t1gFjUXTbVj6YjZjAwbAisMRzg2BqxZyASBVb3eLE5b/zZibPeNrtPzwpBKAPGxAcZyuGJ4MwhBsqblJMRBhmiabqWRDHzIF36ts6CSJTr8BVq6m9/diYPLH+RuvBu1S15b/yNI52bBesASsx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691357; c=relaxed/simple;
	bh=5CYZwx/a1OxgqMzNWAcRcMEUX43wyamtGHKc+Ke4MYI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=n3xjityk8crZ52T4pUGSgm/VE7ztq0nJoWz4G7jH2ALhJsbmx8c3xil0JPqQwemBXGLPnia/89ZCC2rXAnHbIET4st4fcAumlmEibwOdkBfW7p3cDfc10LPtOQlzsJKRpIGPHtHxHVOFSE4AdyDtgxbLuXHC2cSqC3CKj2zCmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ihl7Vd4y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pTw19dwjjVeRMi7oZL0H9g9jPS6KnvMK3gpsYNWW2Bo=; b=ihl7Vd4yWKfi7xutKpRMyet8Qf
	0vVIDHl5E71ilKg24cMDIg+HFEIJ0PpfLEVV6fEGSdJ1e1TxIjpu5iCufVMuNqnVZCszGz4aeaLvS
	r2k6fUYN+RVtv/QYNjCTV+gvycNEKixgFqNsSw/+WfnxXA5xoDJGfO478oIjh3j3v4gBkvA/ROe94
	8xUEPl2GA1+LPtDJK+/Svd1pFBUOhr92vZ2tBTz3/PrWz0l7/cpX2orQ0ZyirbSX6JQldMFHmxMrO
	5Nj8WWTxqM45rpNDWhHflyn+nwqe+0qc2qTIK69jX19zYESur0QNpSRA7fkNpunhMTmCPGiO5YKP9
	rlt0v4Lg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44918 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v9gFJ-000000007Vh-3kcy;
	Fri, 17 Oct 2025 09:55:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v9gFI-0000000Azbb-44bh;
	Fri, 17 Oct 2025 09:55:33 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	s32@nxp.com,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next] net: stmmac: replace has_xxxx with core_type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v9gFI-0000000Azbb-44bh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 17 Oct 2025 09:55:32 +0100

Replace the has_gmac, has_gmac4 and has_xgmac ints, of which only one
can be set when matching a core to its driver backend, with an
enumerated type carrying the DWMAC core type.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  5 ++
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  5 +-
 .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   |  2 +-
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c    | 73 +++++++------------
 .../net/ethernet/stmicro/stmmac/stmmac_est.c  |  4 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 13 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 +++++----
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 14 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  |  4 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  9 +--
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  4 +-
 include/linux/stmmac.h                        | 11 ++-
 21 files changed, 93 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 8f34c9ad457f..23ec3a59ca8f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -43,6 +43,11 @@
 #define DWXGMAC_ID		0x76
 #define DWXLGMAC_ID		0x27
 
+static inline bool dwmac_is_xmac(enum dwmac_core_type core_type)
+{
+	return core_type == DWMAC_CORE_GMAC4 || core_type == DWMAC_CORE_XGMAC;
+}
+
 #define STMMAC_CHAN0	0	/* Always supported and default for all chips */
 
 /* TX and RX Descriptor Length, these need to be power of two.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index f1c2e35badf7..c7cd6497d42d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -109,7 +109,7 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 	}
 
 	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
-	plat_dat->has_gmac4 = 1;
+	plat_dat->core_type = DWMAC_CORE_GMAC4;
 	plat_dat->dma_cfg->aal = 1;
 	plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	plat_dat->pmt = 1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index e74d00984b88..b2194e414ec1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -565,7 +565,7 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 {
 	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->clk_csr = STMMAC_CSR_20_35M;
-	plat->has_gmac = 1;
+	plat->core_type = DWMAC_CORE_GMAC;
 	plat->force_sf_dma_mode = 1;
 
 	plat->mdio_bus_data->needs_reset = true;
@@ -612,8 +612,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->pdev = pdev;
 	plat->phy_addr = -1;
 	plat->clk_csr = STMMAC_CSR_250_300M;
-	plat->has_gmac = 0;
-	plat->has_gmac4 = 1;
+	plat->core_type = DWMAC_CORE_GMAC4;
 	plat->force_sf_dma_mode = 0;
 	plat->flags |= (STMMAC_FLAG_TSO_EN | STMMAC_FLAG_SPH_DISABLE);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index ca4035cbb55b..c05f85534f0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -473,7 +473,7 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	plat_dat->has_gmac = true;
+	plat_dat->core_type = DWMAC_CORE_GMAC;
 	plat_dat->bsp_priv = gmac;
 	plat_dat->set_clk_tx_rate = ipq806x_gmac_set_clk_tx_rate;
 	plat_dat->multicast_filter_bins = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 592aa9d636e5..2a3ac0136cdb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -92,7 +92,7 @@ static void loongson_default_data(struct pci_dev *pdev,
 
 	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->clk_csr = STMMAC_CSR_20_35M;
-	plat->has_gmac = 1;
+	plat->core_type = DWMAC_CORE_GMAC;
 	plat->force_sf_dma_mode = 1;
 
 	/* Set default value for multicast hash bins */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 2562a6d036a2..6fffc9dfbae5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -41,7 +41,7 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
-	plat_dat->has_gmac = true;
+	plat_dat->core_type = DWMAC_CORE_GMAC;
 
 	reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
 	if (IS_ERR(reg)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index d8fd4d8f6ced..0831e32b08cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -848,7 +848,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->fix_mac_speed = ethqos_fix_mac_speed;
 	plat_dat->dump_debug_regs = rgmii_dump;
 	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
-	plat_dat->has_gmac4 = 1;
+	plat_dat->core_type = DWMAC_CORE_GMAC4;
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 51ea0caf16c1..9b92f4d335cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1750,8 +1750,8 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	/* If the stmmac is not already selected as gmac4,
 	 * then make sure we fallback to gmac.
 	 */
-	if (!plat_dat->has_gmac4) {
-		plat_dat->has_gmac = true;
+	if (plat_dat->core_type != DWMAC_CORE_GMAC4) {
+		plat_dat->core_type = DWMAC_CORE_GMAC;
 		plat_dat->rx_fifo_size = 4096;
 		plat_dat->tx_fifo_size = 2048;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 221539d760bc..ee095ac13203 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -146,7 +146,7 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 	gmac->ioaddr = res.addr;
 
 	/* S32CC core feature set */
-	plat->has_gmac4 = true;
+	plat->core_type = DWMAC_CORE_GMAC4;
 	plat->pmt = 1;
 	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
 	plat->rx_fifo_size = 20480;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 354f01184e6c..2ff5db6d41ca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -497,7 +497,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
-	plat_dat->has_gmac = true;
+	plat_dat->core_type = DWMAC_CORE_GMAC;
 
 	plat_dat->riwt_off = 1;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 1eadcf5d1ad6..7f560d78209d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -136,7 +136,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	/* platform data specifying hardware features and callbacks.
 	 * hardware features were copied from Allwinner drivers. */
 	plat_dat->tx_coe = 1;
-	plat_dat->has_gmac = true;
+	plat_dat->core_type = DWMAC_CORE_GMAC;
 	plat_dat->bsp_priv = gmac;
 	plat_dat->init = sun7i_gmac_init;
 	plat_dat->exit = sun7i_gmac_exit;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index dc903b846b1b..d765acbe3754 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -308,7 +308,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 		goto disable_clks;
 	}
 
-	plat->has_xgmac = 1;
+	plat->core_type = DWMAC_CORE_XGMAC;
 	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
 	plat->bsp_priv = mgbe;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 3f7c765dcb79..00083ce52549 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -106,9 +106,7 @@ int stmmac_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 }
 
 static const struct stmmac_hwif_entry {
-	bool gmac;
-	bool gmac4;
-	bool xgmac;
+	enum dwmac_core_type core_type;
 	u32 min_id;
 	u32 dev_id;
 	const struct stmmac_regs_off regs;
@@ -127,9 +125,7 @@ static const struct stmmac_hwif_entry {
 } stmmac_hw[] = {
 	/* NOTE: New HW versions shall go to the end of this table */
 	{
-		.gmac = false,
-		.gmac4 = false,
-		.xgmac = false,
+		.core_type = DWMAC_CORE_MAC100,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
@@ -146,9 +142,7 @@ static const struct stmmac_hwif_entry {
 		.setup = dwmac100_setup,
 		.quirks = stmmac_dwmac1_quirks,
 	}, {
-		.gmac = true,
-		.gmac4 = false,
-		.xgmac = false,
+		.core_type = DWMAC_CORE_GMAC,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC3_X_OFFSET,
@@ -165,9 +159,7 @@ static const struct stmmac_hwif_entry {
 		.setup = dwmac1000_setup,
 		.quirks = stmmac_dwmac1_quirks,
 	}, {
-		.gmac = false,
-		.gmac4 = true,
-		.xgmac = false,
+		.core_type = DWMAC_CORE_GMAC4,
 		.min_id = 0,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -187,9 +179,7 @@ static const struct stmmac_hwif_entry {
 		.setup = dwmac4_setup,
 		.quirks = stmmac_dwmac4_quirks,
 	}, {
-		.gmac = false,
-		.gmac4 = true,
-		.xgmac = false,
+		.core_type = DWMAC_CORE_GMAC4,
 		.min_id = DWMAC_CORE_4_00,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -210,9 +200,7 @@ static const struct stmmac_hwif_entry {
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
-		.gmac = false,
-		.gmac4 = true,
-		.xgmac = false,
+		.core_type = DWMAC_CORE_GMAC4,
 		.min_id = DWMAC_CORE_4_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -233,9 +221,7 @@ static const struct stmmac_hwif_entry {
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
-		.gmac = false,
-		.gmac4 = true,
-		.xgmac = false,
+		.core_type = DWMAC_CORE_GMAC4,
 		.min_id = DWMAC_CORE_5_10,
 		.regs = {
 			.ptp_off = PTP_GMAC4_OFFSET,
@@ -256,9 +242,7 @@ static const struct stmmac_hwif_entry {
 		.setup = dwmac4_setup,
 		.quirks = NULL,
 	}, {
-		.gmac = false,
-		.gmac4 = false,
-		.xgmac = true,
+		.core_type = DWMAC_CORE_XGMAC,
 		.min_id = DWXGMAC_CORE_2_10,
 		.dev_id = DWXGMAC_ID,
 		.regs = {
@@ -280,9 +264,7 @@ static const struct stmmac_hwif_entry {
 		.setup = dwxgmac2_setup,
 		.quirks = NULL,
 	}, {
-		.gmac = false,
-		.gmac4 = false,
-		.xgmac = true,
+		.core_type = DWMAC_CORE_XGMAC,
 		.min_id = DWXLGMAC_CORE_2_00,
 		.dev_id = DWXLGMAC_ID,
 		.regs = {
@@ -308,20 +290,18 @@ static const struct stmmac_hwif_entry {
 
 int stmmac_hwif_init(struct stmmac_priv *priv)
 {
-	bool needs_xgmac = priv->plat->has_xgmac;
-	bool needs_gmac4 = priv->plat->has_gmac4;
-	bool needs_gmac = priv->plat->has_gmac;
+	enum dwmac_core_type core_type = priv->plat->core_type;
 	const struct stmmac_hwif_entry *entry;
 	struct mac_device_info *mac;
 	bool needs_setup = true;
 	u32 id, dev_id = 0;
 	int i, ret;
 
-	if (needs_gmac) {
+	if (core_type == DWMAC_CORE_GMAC) {
 		id = stmmac_get_id(priv, GMAC_VERSION);
-	} else if (needs_gmac4 || needs_xgmac) {
+	} else if (dwmac_is_xmac(core_type)) {
 		id = stmmac_get_id(priv, GMAC4_VERSION);
-		if (needs_xgmac)
+		if (core_type == DWMAC_CORE_XGMAC)
 			dev_id = stmmac_get_dev_id(priv, GMAC4_VERSION);
 	} else {
 		id = 0;
@@ -331,14 +311,16 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	priv->synopsys_id = id;
 
 	/* Lets assume some safe values first */
-	priv->ptpaddr = priv->ioaddr +
-		(needs_gmac4 ? PTP_GMAC4_OFFSET : PTP_GMAC3_X_OFFSET);
-	priv->mmcaddr = priv->ioaddr +
-		(needs_gmac4 ? MMC_GMAC4_OFFSET : MMC_GMAC3_X_OFFSET);
-	if (needs_gmac4)
+	if (core_type == DWMAC_CORE_GMAC4) {
+		priv->ptpaddr = priv->ioaddr + PTP_GMAC4_OFFSET;
+		priv->mmcaddr = priv->ioaddr + MMC_GMAC4_OFFSET;
 		priv->estaddr = priv->ioaddr + EST_GMAC4_OFFSET;
-	else if (needs_xgmac)
-		priv->estaddr = priv->ioaddr + EST_XGMAC_OFFSET;
+	} else {
+		priv->ptpaddr = priv->ioaddr + PTP_GMAC3_X_OFFSET;
+		priv->mmcaddr = priv->ioaddr + MMC_GMAC3_X_OFFSET;
+		if (core_type == DWMAC_CORE_XGMAC)
+			priv->estaddr = priv->ioaddr + EST_XGMAC_OFFSET;
+	}
 
 	/* Check for HW specific setup first */
 	if (priv->plat->setup) {
@@ -355,16 +337,12 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	for (i = ARRAY_SIZE(stmmac_hw) - 1; i >= 0; i--) {
 		entry = &stmmac_hw[i];
 
-		if (needs_gmac ^ entry->gmac)
-			continue;
-		if (needs_gmac4 ^ entry->gmac4)
-			continue;
-		if (needs_xgmac ^ entry->xgmac)
+		if (core_type != entry->core_type)
 			continue;
 		/* Use synopsys_id var because some setups can override this */
 		if (priv->synopsys_id < entry->min_id)
 			continue;
-		if (needs_xgmac && (dev_id ^ entry->dev_id))
+		if (core_type == DWMAC_CORE_XGMAC && (dev_id ^ entry->dev_id))
 			continue;
 
 		/* Only use generic HW helpers if needed */
@@ -400,6 +378,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 	}
 
 	dev_err(priv->device, "Failed to find HW IF (id=0x%x, gmac=%d/%d)\n",
-			id, needs_gmac, needs_gmac4);
+		id, core_type == DWMAC_CORE_GMAC,
+		core_type == DWMAC_CORE_GMAC4);
 	return -EINVAL;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index 4b513d27a988..afc516059b89 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -53,7 +53,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	}
 
 	ctrl = readl(est_addr + EST_CONTROL);
-	if (priv->plat->has_xgmac) {
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
 		ctrl &= ~EST_XGMAC_PTOV;
 		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_XGMAC_PTOV_MUL) <<
 			 EST_XGMAC_PTOV_SHIFT;
@@ -148,7 +148,7 @@ static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 	}
 
 	if (status & EST_BTRE) {
-		if (priv->plat->has_xgmac) {
+		if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
 			btrl = FIELD_GET(EST_XGMAC_BTRL, status);
 			btrl_max = FIELD_MAX(EST_XGMAC_BTRL);
 		} else {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 39fa1ec92f82..b8885e345966 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -303,9 +303,10 @@ static void stmmac_ethtool_getdrvinfo(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (priv->plat->has_gmac || priv->plat->has_gmac4)
+	if (priv->plat->core_type == DWMAC_CORE_GMAC ||
+	    priv->plat->core_type == DWMAC_CORE_GMAC4)
 		strscpy(info->driver, GMAC_ETHTOOL_NAME, sizeof(info->driver));
-	else if (priv->plat->has_xgmac)
+	else if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		strscpy(info->driver, XGMAC_ETHTOOL_NAME, sizeof(info->driver));
 	else
 		strscpy(info->driver, MAC100_ETHTOOL_NAME,
@@ -406,9 +407,9 @@ static int stmmac_ethtool_get_regs_len(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (priv->plat->has_xgmac)
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		return XGMAC_REGSIZE * 4;
-	else if (priv->plat->has_gmac4)
+	else if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		return GMAC4_REG_SPACE_SIZE;
 	return REG_SPACE_SIZE;
 }
@@ -423,12 +424,12 @@ static void stmmac_ethtool_gregs(struct net_device *dev,
 	stmmac_dump_dma_regs(priv, priv->ioaddr, reg_space);
 
 	/* Copy DMA registers to where ethtool expects them */
-	if (priv->plat->has_gmac4) {
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4) {
 		/* GMAC4 dumps its DMA registers at its DMA_CHAN_BASE_ADDR */
 		memcpy(&reg_space[ETHTOOL_DMA_OFFSET],
 		       &reg_space[GMAC4_DMA_CHAN_BASE_ADDR / 4],
 		       NUM_DWMAC4_DMA_REGS * 4);
-	} else if (!priv->plat->has_xgmac) {
+	} else if (priv->plat->core_type != DWMAC_CORE_XGMAC) {
 		memcpy(&reg_space[ETHTOOL_DMA_OFFSET],
 		       &reg_space[DMA_BUS_MODE / 4],
 		       NUM_DWMAC1000_DMA_REGS * 4);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c9fa965c8566..d17400c0580c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -445,7 +445,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 	if (!priv->hwts_rx_en)
 		return;
 	/* For GMAC4, the valid timestamp is from CTX next desc. */
-	if (priv->plat->has_gmac4 || priv->plat->has_xgmac)
+	if (dwmac_is_xmac(priv->plat->core_type))
 		desc = np;
 
 	/* Check if timestamp is available */
@@ -696,7 +696,7 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
 static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 				      u32 systime_flags)
 {
-	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
+	bool xmac = dwmac_is_xmac(priv->plat->core_type);
 	struct timespec64 now;
 	u32 sec_inc = 0;
 	u64 temp = 0;
@@ -745,7 +745,7 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
  */
 static int stmmac_init_timestamping(struct stmmac_priv *priv)
 {
-	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
+	bool xmac = dwmac_is_xmac(priv->plat->core_type);
 	int ret;
 
 	if (priv->plat->ptp_clk_freq_config)
@@ -2397,7 +2397,7 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 		txfifosz = priv->dma_cap.tx_fifo_size;
 
 	/* Split up the shared Tx/Rx FIFO memory on DW QoS Eth and DW XGMAC */
-	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
+	if (dwmac_is_xmac(priv->plat->core_type)) {
 		rxfifosz /= rx_channels_count;
 		txfifosz /= tx_channels_count;
 	}
@@ -4520,7 +4520,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_is_gso(skb) && priv->tso) {
 		if (gso & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
 			return stmmac_tso_xmit(skb, dev);
-		if (priv->plat->has_gmac4 && (gso & SKB_GSO_UDP_L4))
+		if (priv->plat->core_type == DWMAC_CORE_GMAC4 && (gso & SKB_GSO_UDP_L4))
 			return stmmac_tso_xmit(skb, dev);
 	}
 
@@ -5973,7 +5973,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 	u32 queue;
 	bool xmac;
 
-	xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
+	xmac = dwmac_is_xmac(priv->plat->core_type);
 	queues_count = (rx_cnt > tx_cnt) ? rx_cnt : tx_cnt;
 
 	if (priv->irq_wake)
@@ -5987,7 +5987,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		stmmac_fpe_irq_status(priv);
 
 	/* To handle GMAC own interrupts */
-	if ((priv->plat->has_gmac) || xmac) {
+	if (priv->plat->core_type == DWMAC_CORE_GMAC || xmac) {
 		int status = stmmac_host_irq_status(priv, priv->hw, &priv->xstats);
 
 		if (unlikely(status)) {
@@ -6357,7 +6357,7 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		   (priv->dma_cap.mbps_1000) ? "Y" : "N");
 	seq_printf(seq, "\tHalf duplex: %s\n",
 		   (priv->dma_cap.half_duplex) ? "Y" : "N");
-	if (priv->plat->has_xgmac) {
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
 		seq_printf(seq,
 			   "\tNumber of Additional MAC address registers: %d\n",
 			   priv->dma_cap.multi_addr);
@@ -6381,7 +6381,7 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		   (priv->dma_cap.time_stamp) ? "Y" : "N");
 	seq_printf(seq, "\tIEEE 1588-2008 Advanced Time Stamp: %s\n",
 		   (priv->dma_cap.atime_stamp) ? "Y" : "N");
-	if (priv->plat->has_xgmac)
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		seq_printf(seq, "\tTimestamp System Time Source: %s\n",
 			   dwxgmac_timestamp_source[priv->dma_cap.tssrc]);
 	seq_printf(seq, "\t802.3az - Energy-Efficient Ethernet (EEE): %s\n",
@@ -6390,7 +6390,7 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "\tChecksum Offload in TX: %s\n",
 		   (priv->dma_cap.tx_coe) ? "Y" : "N");
 	if (priv->synopsys_id >= DWMAC_CORE_4_00 ||
-	    priv->plat->has_xgmac) {
+	    priv->plat->core_type == DWMAC_CORE_XGMAC) {
 		seq_printf(seq, "\tIP Checksum Offload in RX: %s\n",
 			   (priv->dma_cap.rx_coe) ? "Y" : "N");
 	} else {
@@ -7242,8 +7242,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	 * has to be disable and this can be done by passing the
 	 * riwt_off field from the platform.
 	 */
-	if (((priv->synopsys_id >= DWMAC_CORE_3_50) ||
-	    (priv->plat->has_xgmac)) && (!priv->plat->riwt_off)) {
+	if ((priv->synopsys_id >= DWMAC_CORE_3_50 ||
+	     priv->plat->core_type == DWMAC_CORE_XGMAC) &&
+	    !priv->plat->riwt_off) {
 		priv->use_riwt = 1;
 		dev_info(priv->device,
 			 "Enable RX Mitigation via HW Watchdog Timer\n");
@@ -7357,7 +7358,7 @@ static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
 		return -ENODATA;
 
 	/* For GMAC4, the valid timestamp is from CTX next desc. */
-	if (priv->plat->has_gmac4 || priv->plat->has_xgmac)
+	if (dwmac_is_xmac(priv->plat->core_type))
 		desc_contains_ts = ndesc;
 
 	/* Check if timestamp is available */
@@ -7513,7 +7514,7 @@ int stmmac_dvr_probe(struct device *device,
 
 	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
 		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
-		if (priv->plat->has_gmac4)
+		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
 		priv->tso = true;
 		dev_info(priv->device, "TSO feature enabled\n");
@@ -7566,7 +7567,7 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
-	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
+	if (dwmac_is_xmac(priv->plat->core_type)) {
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
@@ -7597,7 +7598,7 @@ int stmmac_dvr_probe(struct device *device,
 
 	/* MTU range: 46 - hw-specific max */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
-	if (priv->plat->has_xgmac)
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		ndev->max_mtu = XGMAC_JUMBO_LEN;
 	else if ((priv->plat->enh_desc) || (priv->synopsys_id >= DWMAC_CORE_4_00))
 		ndev->max_mtu = JUMBO_LEN;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index d62b2870899d..6b03ea98dced 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -301,7 +301,7 @@ static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 cmd;
 
-	if (priv->plat->has_gmac4)
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		cmd = MII_GMAC4_READ;
 	else
 		cmd = 0;
@@ -344,7 +344,7 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	u32 cmd;
 
-	if (priv->plat->has_gmac4)
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		cmd = MII_GMAC4_WRITE;
 	else
 		cmd = MII_ADDR_GWRITE;
@@ -417,7 +417,7 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 	 * on MDC, so perform a dummy mdio read. To be updated for GMAC4
 	 * if needed.
 	 */
-	if (!priv->plat->has_gmac4)
+	if (priv->plat->core_type != DWMAC_CORE_GMAC4)
 		writel(0, priv->ioaddr + mii_address);
 #endif
 	return 0;
@@ -528,7 +528,7 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 			value = 0;
 	}
 
-	if (priv->plat->has_xgmac) {
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
 		if (clk_rate > 400000000)
 			value = 0x5;
 		else if (clk_rate > 350000000)
@@ -600,7 +600,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 
 	new_bus->name = "stmmac";
 
-	if (priv->plat->has_xgmac) {
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
 		new_bus->read = &stmmac_xgmac2_mdio_read_c22;
 		new_bus->write = &stmmac_xgmac2_mdio_write_c22;
 		new_bus->read_c45 = &stmmac_xgmac2_mdio_read_c45;
@@ -621,7 +621,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 	} else {
 		new_bus->read = &stmmac_mdio_read_c22;
 		new_bus->write = &stmmac_mdio_write_c22;
-		if (priv->plat->has_gmac4) {
+		if (priv->plat->core_type == DWMAC_CORE_GMAC4) {
 			new_bus->read_c45 = &stmmac_mdio_read_c45;
 			new_bus->write_c45 = &stmmac_mdio_write_c45;
 		}
@@ -649,7 +649,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 	}
 
 	/* Looks like we need a dummy read for XGMAC only and C45 PHYs */
-	if (priv->plat->has_xgmac)
+	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
 		stmmac_xgmac2_mdio_read_c45(new_bus, 0, 0, 0);
 
 	/* If fixed-link is set, skip PHY scanning */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 4e3aa611fda8..94b3a3b27270 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -23,7 +23,7 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 {
 	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->clk_csr = STMMAC_CSR_20_35M;
-	plat->has_gmac = 1;
+	plat->core_type = DWMAC_CORE_GMAC;
 	plat->force_sf_dma_mode = 1;
 
 	plat->mdio_bus_data->needs_reset = true;
@@ -76,7 +76,7 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	int i;
 
 	plat->clk_csr = STMMAC_CSR_250_300M;
-	plat->has_gmac4 = 1;
+	plat->core_type = DWMAC_CORE_GMAC4;
 	plat->force_sf_dma_mode = 1;
 	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 27bcaae07a7f..fbb92cc6ab59 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -552,12 +552,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 				&pdev->dev, plat->unicast_filter_entries);
 		plat->multicast_filter_bins = dwmac1000_validate_mcast_bins(
 				&pdev->dev, plat->multicast_filter_bins);
-		plat->has_gmac = 1;
+		plat->core_type = DWMAC_CORE_GMAC;
 		plat->pmt = 1;
 	}
 
 	if (of_device_is_compatible(np, "snps,dwmac-3.40a")) {
-		plat->has_gmac = 1;
+		plat->core_type = DWMAC_CORE_GMAC;
 		plat->enh_desc = 1;
 		plat->tx_coe = 1;
 		plat->bugged_jumbo = 1;
@@ -565,8 +565,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	}
 
 	if (of_device_compatible_match(np, stmmac_gmac4_compats)) {
-		plat->has_gmac4 = 1;
-		plat->has_gmac = 0;
+		plat->core_type = DWMAC_CORE_GMAC4;
 		plat->pmt = 1;
 		if (of_property_read_bool(np, "snps,tso"))
 			plat->flags |= STMMAC_FLAG_TSO_EN;
@@ -580,7 +579,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	}
 
 	if (of_device_is_compatible(np, "snps,dwxgmac")) {
-		plat->has_xgmac = 1;
+		plat->core_type = DWMAC_CORE_XGMAC;
 		plat->pmt = 1;
 		if (of_property_read_bool(np, "snps,tso"))
 			plat->flags |= STMMAC_FLAG_TSO_EN;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 993ff4e87e55..3e30172fa129 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -57,7 +57,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	bool xmac, est_rst = false;
 	int ret;
 
-	xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
+	xmac = dwmac_is_xmac(priv->plat->core_type);
 
 	if (delta < 0) {
 		neg_adj = 1;
@@ -344,7 +344,7 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
-	if (priv->plat->has_gmac4)
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
 	/* Update the ptp clock parameters based on feature discovery, when
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index fa1318bac06c..48e57e187930 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -171,6 +171,13 @@ struct dwmac4_addrs {
 	u32 mtl_low_cred_offset;
 };
 
+enum dwmac_core_type {
+	DWMAC_CORE_MAC100,
+	DWMAC_CORE_GMAC,
+	DWMAC_CORE_GMAC4,
+	DWMAC_CORE_XGMAC,
+};
+
 #define STMMAC_FLAG_HAS_INTEGRATED_PCS		BIT(0)
 #define STMMAC_FLAG_SPH_DISABLE			BIT(1)
 #define STMMAC_FLAG_USE_PHY_WOL			BIT(2)
@@ -187,6 +194,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
 
 struct plat_stmmacenet_data {
+	enum dwmac_core_type core_type;
 	int bus_id;
 	int phy_addr;
 	/* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
@@ -220,7 +228,6 @@ struct plat_stmmacenet_data {
 	struct stmmac_dma_cfg *dma_cfg;
 	struct stmmac_safety_feature_cfg *safety_feat_cfg;
 	int clk_csr;
-	int has_gmac;
 	int enh_desc;
 	int tx_coe;
 	int rx_coe;
@@ -283,10 +290,8 @@ struct plat_stmmacenet_data {
 	struct reset_control *stmmac_rst;
 	struct reset_control *stmmac_ahb_rst;
 	struct stmmac_axi *axi;
-	int has_gmac4;
 	int rss_en;
 	int mac_port_sel_speed;
-	int has_xgmac;
 	u8 vlan_fail_q;
 	struct pci_dev *pdev;
 	int int_snapshot_num;
-- 
2.47.3


