Return-Path: <netdev+bounces-187233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B17FAA5DF6
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3D41BC597B
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14B2222A7;
	Thu,  1 May 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GhZhaaV9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21533086
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746099966; cv=none; b=hy3q0O4DX+QoyU1mteM4f1CV2HKc3Bz8j+Kh+Q9LDtRSdTtFk2SkTBHYAHMAK6RCQS2iYVvXfm1YNtD0+74y9I4JqTmN7j/6CCw4FdPVxbYqgcUPTVb1H7Zye5A/dMxNSzdLuCJy1Q8I0AO0Q9S9Ih/JIuIiGi84/Dk+xMxNr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746099966; c=relaxed/simple;
	bh=M6GC5VLrs9ZubG8qysyHgfZx4VcnIzuBM46V0taifBU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Jt2yVwVUVadlehA89Gzd8DgESwxms52S3pGyvbrgJ3TQbrV7GI/pDtcan8UTQO4J541mzvJiEE+3gi962ON3HOvreDB0mSm1/Wut7Ol7TiC88ZsjoSbJdeEk+lWkmExOaR+tPpYdX2XdQu+BmwkJMGDth1Wi2N4wz6DsKMY5uOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GhZhaaV9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OdA8agaxPzxQIQQWrn0uJEVFsTc/quCaDXwb7JdYp+k=; b=GhZhaaV9+W8BpvPOukv6nuhPQ2
	R1EdMDq+xyWD6dnRoviKN/PtC7Q8Jap0ahR/qhJ7jNbYTooTuk05IeKxFb4ntHf6/fVSddInWyCbr
	XCIKgJ3yUvMk0x0usONd+pxQuCx1o2Qklcva7kNXOBwlQvo9Bp6yp/RRplBEKKLGXCzWLeOosO8oJ
	2b4h8KX5iCJH9hpYKTlLCXXVHbYj3xUIBVugFifx3UiQ2zi+FlUpzsVPlrCoCYawJ1W6o0efCEzH9
	0USk2ThGk/a4VgZ69qw92D+xe6+PwXN8OW0HGvyqNDdJS87ji/P1Erh1KenXoW2KeMy+JwslKJiwE
	xIwDLumQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59062 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uASMV-00005H-0T;
	Thu, 01 May 2025 12:45:55 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uASLs-0021Qk-Qt; Thu, 01 May 2025 12:45:16 +0100
In-Reply-To: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/6] net: stmmac: intel: move phy_interface init to
 tgl_common_data()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uASLs-0021Qk-Qt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 01 May 2025 12:45:16 +0100

Move the initialisation of plat->phy_interface to tgl_common_data()
as all callers set this same interface mode. This moves it to a
single location to make the change to get_interfaces() more obvious.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 96c893dd262f..4b263a3c65a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -929,6 +929,7 @@ static int tgl_common_data(struct pci_dev *pdev,
 	plat->rx_queues_to_use = 6;
 	plat->tx_queues_to_use = 4;
 	plat->clk_ptp_rate = 204800000;
+	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	plat->speed_mode_2500 = intel_speed_mode_2500;
 
 	plat->safety_feat_cfg->tsoee = 1;
@@ -948,7 +949,6 @@ static int tgl_sgmii_phy0_data(struct pci_dev *pdev,
 			       struct plat_stmmacenet_data *plat)
 {
 	plat->bus_id = 1;
-	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	return tgl_common_data(pdev, plat);
@@ -962,7 +962,6 @@ static int tgl_sgmii_phy1_data(struct pci_dev *pdev,
 			       struct plat_stmmacenet_data *plat)
 {
 	plat->bus_id = 2;
-	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	return tgl_common_data(pdev, plat);
@@ -976,7 +975,6 @@ static int adls_sgmii_phy0_data(struct pci_dev *pdev,
 				struct plat_stmmacenet_data *plat)
 {
 	plat->bus_id = 1;
-	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 
 	/* SerDes power up and power down are done in BIOS for ADL */
 
@@ -991,7 +989,6 @@ static int adls_sgmii_phy1_data(struct pci_dev *pdev,
 				struct plat_stmmacenet_data *plat)
 {
 	plat->bus_id = 2;
-	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 
 	/* SerDes power up and power down are done in BIOS for ADL */
 
-- 
2.30.2


