Return-Path: <netdev+bounces-219570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D3B41F6E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648547B441C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608F2FE590;
	Wed,  3 Sep 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j5APxs9d"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082B2FD7BD
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903219; cv=none; b=Mrz4rhtEMibfunTjofNU32gbK0Cs4Wja89HdgiC3aktJWsBOaUZ8ku923P4zlCmUZ1vXVkBqX7RNUjivxT+hfc5ZILtIZI8QOBvVt+jJt0QX77QMYBra+FzjQ3bymR9crxLjhWU1+BRKDa3zrfXwLM1f/nw7LUsdPP91l8ND2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903219; c=relaxed/simple;
	bh=3+4M4hdzg4oCaVIWDDEowklQxQjzTHFK6hpnuCAwQUk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=N6VjVwIF3eGK3yYBHkcMS0waZIktYQmsReO4R9HP3WMTa5EtjGmg9kP8R6WSZRKClXm8Wy/rGEzbOEcOYoR+j/Px1xRybecQk2DBGyt1GsuBLZ1iQRtlAl8jGYaGVXUZ5Wd/hb8tosIXTdpqtuo3r9g+eCh1FiVAfNBCr56ZZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j5APxs9d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R+OIhPT15cRLCNkKMY1zwgni+1n9JXivTyEzbTPisXU=; b=j5APxs9d1R7JNWgFSfjgGtXVre
	mizQZQPdTsVJRgovGuNWKsTzbRmqQqsWSyHpVAxdoe/aAGWlyHzMlS4jQ4i4JcQEB+TLzgieCoNy6
	QQb3lgb8mKUVEwOUDWgx9pjBAxnPJlqzjPkKCGckaiLqgckK5ZDQbuy/EhlGQX5h0b8nkma2f/ZAG
	oX6GupfEodkkk+xu/TMln2+lndJ6KctkhgiYldKYI3nvznHy99NW6K9EMlDdYZ1vX14gZQw3DULGv
	6YQUSckgatlQsFXcZY6yOWsoxrNeagt/NqZ8fQwEb/6x7lqekI3Hih7W20+XPDxOENr8oYOyJ6+G0
	zjdbkA4A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56278 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmmZ-000000000XR-0BSS;
	Wed, 03 Sep 2025 13:40:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmmY-00000001s13-0v5M;
	Wed, 03 Sep 2025 13:40:10 +0100
In-Reply-To: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 11/11] net: stmmac: use STMMAC_CSR_xxx definitions in
 platform glue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1utmmY-00000001s13-0v5M@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:40:10 +0100

Use the STMMAC_CSR_xxx definitions to initialise plat->clk_csr in the
platform glue drivers to make the integer values meaningful.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c    | 5 +++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c     | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 3fac3945cbfa..d900b93f46ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -566,7 +566,8 @@ static int intel_mac_finish(struct net_device *ndev,
 
 static void common_default_data(struct plat_stmmacenet_data *plat)
 {
-	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
+	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
+	plat->clk_csr = STMMAC_CSR_20_35M;
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
 
@@ -613,7 +614,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	plat->pdev = pdev;
 	plat->phy_addr = -1;
-	plat->clk_csr = 5;
+	plat->clk_csr = STMMAC_CSR_250_300M;
 	plat->has_gmac = 0;
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 6fca0fca4892..dd82dc2189e9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -90,7 +90,8 @@ static void loongson_default_data(struct pci_dev *pdev,
 	/* Get bus_id, this can be overwritten later */
 	plat->bus_id = pci_dev_id(pdev);
 
-	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
+	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
+	plat->clk_csr = STMMAC_CSR_20_35M;
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index e6a7d0ddac2a..4e3aa611fda8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -21,7 +21,8 @@ struct stmmac_pci_info {
 
 static void common_default_data(struct plat_stmmacenet_data *plat)
 {
-	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
+	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
+	plat->clk_csr = STMMAC_CSR_20_35M;
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
 
@@ -74,7 +75,7 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 {
 	int i;
 
-	plat->clk_csr = 5;
+	plat->clk_csr = STMMAC_CSR_250_300M;
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 1;
 	plat->flags |= STMMAC_FLAG_TSO_EN;
-- 
2.47.2


