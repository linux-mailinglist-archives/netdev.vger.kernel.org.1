Return-Path: <netdev+bounces-238701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA19C5E2C7
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92972383EF6
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06120331A7A;
	Fri, 14 Nov 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u2yNHz/q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CBE329E62
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134130; cv=none; b=E2D3F6W5KUvFb/hYzOpFOaiXImhYT1REGH8gGtEEip2FiX3daEoWlMrjr8/zYpeqDYEP1qClQpsY3xyhLZAtMWLmpy0VpYIdRJKdf3niM0iwFfZMY211PnkJmnGJyKBLd/2IMbm3Xl6lzJUNTh7KO31wmC0/5Mw1SK7DbsAOAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134130; c=relaxed/simple;
	bh=I9QG56zXjoqQ+t4lCqEDnlL7qm9RDAyD8G8PJPnqwF0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OCE+A7vKfvexRqYDKjBZSF+n5OAW/GbU5HMfojRMXWx/CVA96RHOzI3pIb8zWGjHK45X/kSdmQj9JQB1HaVZ7zU6AAflUbwi6iJDIdv6AukuDT4IfPdL6ceMMe2CziPApOpgyVA8utAVroaQOf1NIn+ABEa7zFUMOV+M6LHKHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=u2yNHz/q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3Zo0wqdJY+ScSIlzBR4O8yuxNiqj6xUhwLDvxRVLdrw=; b=u2yNHz/qzn4LhQd8rJ6TAvhvYO
	C3xkFHyhsr0YIkRgxv2zhseETImIIQXSrekl7UQzTt3p94dWp+gkeIFTjSwAAiLOSuQgYfSSXtpuS
	rHNSo00AsJYWs6kcQVGtb1jx5hZqoguM9l1ZUfTH65CHoEmU/fGAjOiaEk10koWrFCdo9Z2TgcF2F
	bSyOxaTRxUqikMvOuSmQrWmMbQ3ct6/XLr1Uh8208tIdos1ifjWOpWavxUVcS2KcnBzVmN1mtjQyy
	Em8uwtFHoWLB7fz1BmAwqAaMv2o6cxMpSpnU2W7nq9UBze5BRPWBaRdVHW5pZahICNUVhOwDqjMDQ
	4vBAB2SA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53644 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJvj7-0000000076v-0LYC;
	Fri, 14 Nov 2025 15:28:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJvj5-0000000EVji-2EYA;
	Fri, 14 Nov 2025 15:28:39 +0000
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
Subject: [PATCH net-next 04/11] net: stmmac: move initialisation of maxmtu to
 stmmac_plat_dat_alloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJvj5-0000000EVji-2EYA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Nov 2025 15:28:39 +0000

Move the default initialisation of plat_dat->maxmtu to JUMBO_LEN to
stmmac_plat_dat_alloc().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c     | 6 ------
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c  | 3 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c      | 6 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 -----
 5 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 7e56fbc3e141..cf69e659c415 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -576,9 +576,6 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
-	/* Set the maxmtu to a default of JUMBO_LEN */
-	plat->maxmtu = JUMBO_LEN;
-
 	/* Set default number of RX and TX queues to use */
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
@@ -712,9 +709,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
-	/* Set the maxmtu to a default of JUMBO_LEN */
-	plat->maxmtu = JUMBO_LEN;
-
 	plat->flags |= STMMAC_FLAG_VLAN_FAIL_Q_EN;
 
 	/* Use the last Rx queue */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 8593411844bc..89232c788c61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -101,9 +101,6 @@ static void loongson_default_data(struct pci_dev *pdev,
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
-	/* Set the maxmtu to a default of JUMBO_LEN */
-	plat->maxmtu = JUMBO_LEN;
-
 	/* Disable Priority config by default */
 	plat->tx_queues_cfg[0].use_prio = false;
 	plat->rx_queues_cfg[0].use_prio = false;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a36e8a90fcaa..0763ed06715e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7566,9 +7566,11 @@ struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
 	/* Set the defaults:
 	 * - phy autodetection
 	 * - determine GMII_Address CR field from CSR clock
+	 * - allow MTU up to JUMBO_LEN
 	 */
 	plat_dat->phy_addr = -1;
 	plat_dat->clk_csr = -1;
+	plat_dat->maxmtu = JUMBO_LEN;
 
 	return plat_dat;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index b981a9dd511d..b0b4358e0adf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -34,9 +34,6 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
-	/* Set the maxmtu to a default of JUMBO_LEN */
-	plat->maxmtu = JUMBO_LEN;
-
 	/* Set default number of RX and TX queues to use */
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
@@ -87,9 +84,6 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
-	/* Set the maxmtu to a default of JUMBO_LEN */
-	plat->maxmtu = JUMBO_LEN;
-
 	/* Set default number of RX and TX queues to use */
 	plat->tx_queues_to_use = 4;
 	plat->rx_queues_to_use = 4;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index fe3d95274fd6..81a599475577 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -508,11 +508,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->flags |= STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 	}
 
-	/* Set the maxmtu to a default of JUMBO_LEN in case the
-	 * parameter is not present in the device tree.
-	 */
-	plat->maxmtu = JUMBO_LEN;
-
 	/* Set default value for multicast hash bins */
 	plat->multicast_filter_bins = HASH_TABLE_SIZE;
 
-- 
2.47.3


