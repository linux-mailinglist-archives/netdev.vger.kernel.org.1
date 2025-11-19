Return-Path: <netdev+bounces-239917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C1C6DF6E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DEEB383CC7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC972340D87;
	Wed, 19 Nov 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="THEMqB3c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92676346792
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547830; cv=none; b=iN0tp3AZezrZPAftukQvlZmzqJaHTdGyaSOvEgfkXCrabu1zODjzcnX+SIJxHqF0PH3VS2qjTdDaG2hlgSGSfd/EPum87o0lmrVLO1XUAIKOHla0GTkrfLS1zPZJPS3kLK67ZizbuLrq06MOwctqGf2u4xACAMNyK5I6y9nbgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547830; c=relaxed/simple;
	bh=fD0k2RM+53frQXgfoFEB/uqp/aG4datG5CZLLk9Fm+o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=U39zLcShL7lKhy7u9eNelmLjBtCyR0/Uzath3gmqIB+o3HWXmTi717DsgNDOfiORosi8Ed00JUiL7VrDGJgeIeZq6cf94ICVFKtF4snSGflBwqOMsXKhR2OznBQhsvK8P/4bttpjJ0i+USrRj49nDqgs/FdTydrYst72vij4A0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=THEMqB3c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qCSsRQgUhid2ZAy4dbb2n1OSCVDOp4vvBzay6fmrN1s=; b=THEMqB3ciS8GBTu+ZtI3lXsfRy
	YPaEpYCwjdS0tmeEXR/MC/8h7/6Wj0TIoSbwqXoI/irNONSpN9+VPmjutBZ6CnfIzh9rwKLsJcNEe
	jmDw1IgWdNOTc2Tp6cyFRPbRw8wa/pu/mjlXuPkz7TQIK97AYpZRKe8pYnV/Q1d6xm8MgzxiIbEzf
	MjyQSbFgdXe32dkZugHKw4b7CcEc2RrRhb9vf+yvh3qrWt1zDPp5HPTU1s1r5HjJwVbiP86v4nNjK
	aUnldW+Kyq2ZpUu382Y8xRy5PU6ClqO2tszVfmQ8YREMC/Fk4/0tT4sa7S9RrwB+HPD6OYENlw9dZ
	8dG/TtGA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39224 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLfLc-000000004Vj-13IA;
	Wed, 19 Nov 2025 10:23:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLfLb-0000000FMb7-1SgG;
	Wed, 19 Nov 2025 10:23:35 +0000
In-Reply-To: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
References: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 5/6] net: stmmac: move stmmac_axi_blen_to_mask() to
 axi_blen init sites
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLfLb-0000000FMb7-1SgG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 19 Nov 2025 10:23:35 +0000

Move stmmac_axi_blen_to_mask() to the axi->axi_blen array init sites
to prepare for the removal of axi_blen. For sites which initialise
axi->axi_blen with constant data, initialise axi->axi_blen_regval
using the DMA_AXI_BLENx constants.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 3 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c       | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 7 ++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c        | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 1 +
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index e6d5893c5905..bd06f26a27b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -88,6 +88,9 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 		if (burst_map & (1 << bit_index))
 			plat_dat->axi->axi_blen[a_index++] = 4 << bit_index;
 
+	stmmac_axi_blen_to_mask(&plat_dat->axi->axi_blen_regval,
+				plat_dat->axi->axi_blen, a_index);
+
 	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
 	plat_dat->core_type = DWMAC_CORE_GMAC4;
 	plat_dat->dma_cfg->aal = 1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 8938e7a59925..e94605d3d185 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -650,6 +650,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->axi->axi_xit_frm = 0;
 	plat->axi->axi_wr_osr_lmt = 1;
 	plat->axi->axi_rd_osr_lmt = 1;
+	plat->axi->axi_blen_regval = DMA_AXI_BLEN4 | DMA_AXI_BLEN8 |
+				     DMA_AXI_BLEN16;
 	plat->axi->axi_blen[0] = 4;
 	plat->axi->axi_blen[1] = 8;
 	plat->axi->axi_blen[2] = 16;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 99a7d4c463d9..b8a2f450433b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -225,6 +225,7 @@ void stmmac_axi_blen_to_mask(u32 *regval, const u32 *blen, size_t len)
 
 	*regval = FIELD_PREP(DMA_AXI_BLEN_MASK, val);
 }
+EXPORT_SYMBOL_GPL(stmmac_axi_blen_to_mask);
 
 /**
  * stmmac_verify_args - verify the driver parameters.
@@ -3212,12 +3213,8 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	/* DMA Configuration */
 	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
 
-	if (priv->plat->axi) {
-		/* Encode the AXI burst length to a register value */
-		stmmac_axi_blen_to_mask(&priv->plat->axi->axi_blen_regval,
-					priv->plat->axi->axi_blen, AXI_BLEN);
+	if (priv->plat->axi)
 		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
-	}
 
 	/* DMA CSR Channel configuration */
 	for (chan = 0; chan < dma_csr_ch; chan++) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 2fd4660838bb..e1036150fae2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -92,6 +92,8 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	plat->axi->axi_rd_osr_lmt = 31;
 
 	plat->axi->axi_fb = false;
+	plat->axi->axi_blen_regval = DMA_AXI_BLEN4 | DMA_AXI_BLEN8 |
+				     DMA_AXI_BLEN16 | DMA_AXI_BLEN32;
 	plat->axi->axi_blen[0] = 4;
 	plat->axi->axi_blen[1] = 8;
 	plat->axi->axi_blen[2] = 16;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 9015b7f80d1b..656d4adedabe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -118,6 +118,7 @@ static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
 	if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt))
 		axi->axi_rd_osr_lmt = 1;
 	of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
+	stmmac_axi_blen_to_mask(&axi->axi_blen_regval, axi->axi_blen, AXI_BLEN);
 	of_node_put(np);
 
 	return axi;
-- 
2.47.3


