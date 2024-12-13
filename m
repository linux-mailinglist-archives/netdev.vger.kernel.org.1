Return-Path: <netdev+bounces-151647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E19F0734
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF27282A39
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877721AF0C9;
	Fri, 13 Dec 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mBjcJwO0"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5D19AA58;
	Fri, 13 Dec 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080736; cv=none; b=ryBmHxoLGvObCE49AatdoIqFffomYGy9StHVIf4gMVRu71XcaHhsqIQS8xa2fUCyroBZi/+8DqHpuTDUO/hAHp4VtfqZjXhqplQvKolXq9aZ7KortXRaUtIkE+Hd29pbNmr1zP4FjM1T4cVpdjviG/IR8UuVpG0Pob3HhNAinW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080736; c=relaxed/simple;
	bh=PjBNtQtI1GIsHH8PL+ueThE6odOdzV+opW9CKy1Xd5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJpudjcCoS6Rx0cZQArDwDgq+x1p/TktvufpMBR/x8U/8p5kJXWLtSjE4MEO1Gk/wfWiZpHAjQjAn2Mdi7d/I18DZgchk9fyJO2Im08Xw3RVHWr7W8shxPoTYcttReiBPb7BijOiF7ePSgi6oYCQq3qEWy5I+5sEqLGnK29WLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mBjcJwO0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E25651BF204;
	Fri, 13 Dec 2024 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734080731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxM8+Leu8MwruhsMJIlIYRMswoFi1MwEa2tyG0/MFaI=;
	b=mBjcJwO02cTezzCp3XYcoFdJbdVzBVazXlvccMmSiZd4UY/Kkyw+8TbOHO1Q85aXZ2GDXV
	rwd5DBplbdmBg60aSgTT8UExB2pIEAbtVLkhXfkX2h4sJVkhkG9xwdcUTa3IlQ2y9765r0
	aZIDleIr7dVb6VJcdZ3rzPn2gyes+lLphrABQJYTFanWm8xIb4d8buR/xK+ZKzJL23Sy2C
	kSR0L7oj0vd/lM/FAexfIJ6ptBBJVgo03/QAdB2adYYgn207pcviXxf1zuDeTIIj+j4xCt
	Tu6xea8EOQM8K+l11+4dSqBDHFbwKGgq6yXf3+YdVh/SkynlBGWS0qIPD3Kzfg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: stmmac: dwmac-socfpga: Add support for 1000BaseX
Date: Fri, 13 Dec 2024 10:05:24 +0100
Message-ID: <20241213090526.71516-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The dwmac-socfpga found on altera socfpga SoCs can use 1000BaseX or
SGMII. The IP integrates a variation of the Lynx PCS, which the driver
supports well. However, there's some internal circuitry that needs
enabling when using SGMII or 1000BaseX through the "sgmii_adapter" in
the socfpga wrapper. So far, this is only enabled when SGMII is used as
the interface mode. Make so that 1000BaseX also enables that block.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 16020b72dec8..8c7b82d29fd1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -258,6 +258,7 @@ static int socfpga_set_phy_mode_common(int phymode, u32 *val)
 	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_GMII:
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
 		*val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
@@ -300,6 +301,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 	if (dwmac->f2h_ptp_ref_clk ||
 	    phymode == PHY_INTERFACE_MODE_MII ||
 	    phymode == PHY_INTERFACE_MODE_GMII ||
+	    phymode == PHY_INTERFACE_MODE_1000BASEX ||
 	    phymode == PHY_INTERFACE_MODE_SGMII) {
 		regmap_read(sys_mgr_base_addr, SYSMGR_FPGAGRP_MODULE_REG,
 			    &module);
@@ -321,7 +323,8 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 	 */
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
-	if (phymode == PHY_INTERFACE_MODE_SGMII)
+	if (phymode == PHY_INTERFACE_MODE_SGMII ||
+	    phymode == PHY_INTERFACE_MODE_1000BASEX)
 		socfpga_sgmii_config(dwmac, true);
 
 	return 0;
@@ -356,6 +359,7 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 	if (dwmac->f2h_ptp_ref_clk ||
 	    phymode == PHY_INTERFACE_MODE_MII ||
 	    phymode == PHY_INTERFACE_MODE_GMII ||
+	    phymode == PHY_INTERFACE_MODE_1000BASEX ||
 	    phymode == PHY_INTERFACE_MODE_SGMII) {
 		ctrl |= SYSMGR_GEN10_EMACGRP_CTRL_PTP_REF_CLK_MASK;
 		regmap_read(sys_mgr_base_addr, SYSMGR_FPGAINTF_EMAC_REG,
@@ -374,7 +378,8 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 	 */
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
-	if (phymode == PHY_INTERFACE_MODE_SGMII)
+	if (phymode == PHY_INTERFACE_MODE_SGMII ||
+	    phymode == PHY_INTERFACE_MODE_1000BASEX)
 		socfpga_sgmii_config(dwmac, true);
 	return 0;
 }
-- 
2.47.1


