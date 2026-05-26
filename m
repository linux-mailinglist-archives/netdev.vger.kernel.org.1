Return-Path: <netdev+bounces-291735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAdyKpS7FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BFF5D8ACE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D357310533A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72945421F1E;
	Tue, 26 May 2026 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RLrXaFgN"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572C41C311;
	Tue, 26 May 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807567; cv=none; b=Y3/pFv4YYuSoE8vY+oknSU/GINuPkgmWRpVpuMwr7gRHqTUH20AXlCt0hIbgZ5aeyexXPmdHWiVBH+Lm2uzLBTbTp1HXMWSb+izM+qlXV4VVfrcIi8NzibtfZfspzvKQW2mBm1zckFjk026e6zQy5TEQMVL/God4GhIn9mzNIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807567; c=relaxed/simple;
	bh=ET2I3+lfoBkM0vWRX1UaWCbkopH2M3jyubM2in/C+LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaeILNQb9WqIXif5tlGxZj6bsj3EUA8jtkOIwvOFH0TuN1Pf5qwzvV+72fhPobOX4tEY3mz1s5BM5gEskG4/NPdEeh3Cc5RiwHdykb5CRU/xK1ga8dcT5NLdZHhyUN/FGAdBBMEZTqT2TaqzhvHTv64Xb+c90yYOfF2p6jwxI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RLrXaFgN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779807563;
	bh=ET2I3+lfoBkM0vWRX1UaWCbkopH2M3jyubM2in/C+LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RLrXaFgN6UtFAr+PXzK6oC0izEutaan4xcNFP3LnE+xVQFtYqpj2XKbOGkV3BurJQ
	 VdX1DxvNZ5DuQXtGdiqqEwQrhKfyWoZeOaI/w8VSkrA+8wSwxn0cjt/YVYWk9gTGG4
	 TmLBcSM33+JOy8eVmvfetfxWEBhEapXyEaoYe68oQiMZRaaBQghia5bBOhZXwZDvun
	 vDATnoJD0WthipS/i3wI5K9YfNwzlCja2CgxUa+I4Rly6+kWOtwEmr8OOFjGuN2cX4
	 fNIowDt6x435hfTrGzn+uxLAZ0dd6NhXZUL/D1jT/Ocl9b5F6NUhOaVl7K0no5AJiF
	 Wrlj75U4SGung==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F7D417E141E;
	Tue, 26 May 2026 16:59:22 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 26 May 2026 16:58:09 +0200
Subject: [PATCH net-next v5 4/6] net: phy: Rename Airoha common BuckPBus
 register accessors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-add-airoha-an8801-support-v5-4-01aea8dee69b@collabora.com>
References: <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
In-Reply-To: <20260526-add-airoha-an8801-support-v5-0-01aea8dee69b@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779807555; l=13356;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=ET2I3+lfoBkM0vWRX1UaWCbkopH2M3jyubM2in/C+LY=;
 b=CswV/uNLtvQvcaKrB/kN948jsYGLfZBpjSQxkx4z4UIZ78wbSLwry7IwRwMW3CjWdhOU9srPH
 /cQ7IEIDWhxC8mDPUGpq4/oED45oh6x4KV//Duc8s0QY5sL+Lf9Viyj
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291735-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:mid,collabora.com:dkim,lunn.ch:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 65BFF5D8ACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename the BuckPBus register accessors functions present in air_phy_lib
and their calls in air_en8811h driver, so all exported functions start
with the same prefix.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/net/phy/air_en8811h.c | 110 +++++++++++++++++++++---------------------
 drivers/net/phy/air_phy_lib.c |  18 +++----
 drivers/net/phy/air_phy_lib.h |  12 ++---
 3 files changed, 71 insertions(+), 69 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 2498bd3f7993..a42898ae4135 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -287,8 +287,8 @@ static int en8811h_wait_mcu_ready(struct phy_device *phydev)
 {
 	int ret, reg_value;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_FINISH);
+	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					 EN8811H_FW_CTRL_1_FINISH);
 	if (ret)
 		return ret;
 
@@ -313,28 +313,29 @@ static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
 	int ret;
 
 	/* Configure CRC */
-	ret = air_buckpbus_reg_modify(phydev, set1,
-				      AN8811HB_CRC_RD_EN,
-				      AN8811HB_CRC_RD_EN);
+	ret = air_phy_buckpbus_reg_modify(phydev, set1,
+					  AN8811HB_CRC_RD_EN,
+					  AN8811HB_CRC_RD_EN);
 	if (ret < 0)
 		return ret;
-	air_buckpbus_reg_read(phydev, set1, &pbus_value);
+	air_phy_buckpbus_reg_read(phydev, set1, &pbus_value);
 
 	do {
 		msleep(300);
-		air_buckpbus_reg_read(phydev, mon2, &pbus_value);
+		air_phy_buckpbus_reg_read(phydev, mon2, &pbus_value);
 
 		/* We do not know what errors this check is supposed
 		 * catch or what to do about a failure. So print the
 		 * result and continue like the vendor driver does.
 		 */
 		if (pbus_value & AN8811HB_CRC_ST) {
-			air_buckpbus_reg_read(phydev, mon3, &pbus_value);
+			air_phy_buckpbus_reg_read(phydev, mon3, &pbus_value);
 			phydev_dbg(phydev, "CRC Check %s!\n",
 				   pbus_value & AN8811HB_CRC_CHECK_PASS ?
 					"PASS" : "FAIL");
-			return air_buckpbus_reg_modify(phydev, set1,
-						       AN8811HB_CRC_RD_EN, 0);
+			return air_phy_buckpbus_reg_modify(phydev, set1,
+							   AN8811HB_CRC_RD_EN,
+							   0);
 		}
 	} while (--retry);
 
@@ -346,8 +347,8 @@ static void en8811h_print_fw_version(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
 
-	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
-			      &priv->firmware_version);
+	air_phy_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
+				  &priv->firmware_version);
 	phydev_info(phydev, "MD32 firmware version: %08x\n",
 		    priv->firmware_version);
 }
@@ -372,8 +373,8 @@ static int an8811hb_load_firmware(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_START);
+	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					 EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
 		return ret;
 
@@ -414,14 +415,14 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto en8811h_load_firmware_rel1;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_START);
+	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					 EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-				      EN8811H_FW_CTRL_2_LOADING,
-				      EN8811H_FW_CTRL_2_LOADING);
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+					  EN8811H_FW_CTRL_2_LOADING,
+					  EN8811H_FW_CTRL_2_LOADING);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
@@ -433,8 +434,8 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
-				      EN8811H_FW_CTRL_2_LOADING, 0);
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
+					  EN8811H_FW_CTRL_2_LOADING, 0);
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
@@ -460,8 +461,8 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
-				     EN8811H_FW_CTRL_1_START);
+	ret = air_phy_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
+					 EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
 		return ret;
 
@@ -755,7 +756,7 @@ static unsigned long an8811hb_clk_recalc_rate(struct clk_hw *hw,
 	u32 pbus_value;
 	int ret;
 
-	ret = air_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -767,9 +768,9 @@ static int an8811hb_clk_enable(struct clk_hw *hw)
 	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
 	struct phy_device *phydev = priv->phydev;
 
-	return air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
-				       AN8811HB_CLK_DRV_CKO_MASK,
-				       AN8811HB_CLK_DRV_CKO_MASK);
+	return air_phy_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+					   AN8811HB_CLK_DRV_CKO_MASK,
+					   AN8811HB_CLK_DRV_CKO_MASK);
 }
 
 static void an8811hb_clk_disable(struct clk_hw *hw)
@@ -777,8 +778,8 @@ static void an8811hb_clk_disable(struct clk_hw *hw)
 	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
 	struct phy_device *phydev = priv->phydev;
 
-	air_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
-				AN8811HB_CLK_DRV_CKO_MASK, 0);
+	air_phy_buckpbus_reg_modify(phydev, AN8811HB_CLK_DRV,
+				    AN8811HB_CLK_DRV_CKO_MASK, 0);
 }
 
 static int an8811hb_clk_is_enabled(struct clk_hw *hw)
@@ -788,7 +789,7 @@ static int an8811hb_clk_is_enabled(struct clk_hw *hw)
 	u32 pbus_value;
 	int ret;
 
-	ret = air_buckpbus_reg_read(phydev, AN8811HB_CLK_DRV, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_CLK_DRV, &pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -854,7 +855,7 @@ static unsigned long en8811h_clk_recalc_rate(struct clk_hw *hw,
 	u32 pbus_value;
 	int ret;
 
-	ret = air_buckpbus_reg_read(phydev, EN8811H_HWTRAP1, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, EN8811H_HWTRAP1, &pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -866,9 +867,9 @@ static int en8811h_clk_enable(struct clk_hw *hw)
 	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
 	struct phy_device *phydev = priv->phydev;
 
-	return air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
-				       EN8811H_CLK_CGM_CKO,
-				       EN8811H_CLK_CGM_CKO);
+	return air_phy_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+					   EN8811H_CLK_CGM_CKO,
+					   EN8811H_CLK_CGM_CKO);
 }
 
 static void en8811h_clk_disable(struct clk_hw *hw)
@@ -876,8 +877,8 @@ static void en8811h_clk_disable(struct clk_hw *hw)
 	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
 	struct phy_device *phydev = priv->phydev;
 
-	air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
-				EN8811H_CLK_CGM_CKO, 0);
+	air_phy_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				    EN8811H_CLK_CGM_CKO, 0);
 }
 
 static int en8811h_clk_is_enabled(struct clk_hw *hw)
@@ -887,7 +888,7 @@ static int en8811h_clk_is_enabled(struct clk_hw *hw)
 	u32 pbus_value;
 	int ret;
 
-	ret = air_buckpbus_reg_read(phydev, EN8811H_CLK_CGM, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, EN8811H_CLK_CGM, &pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -998,9 +999,9 @@ static int an8811hb_probe(struct phy_device *phydev)
 		return ret;
 
 	/* Configure led gpio pins as output */
-	ret = air_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
-				      AN8811HB_GPIO_OUTPUT_345,
-				      AN8811HB_GPIO_OUTPUT_345);
+	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+					  AN8811HB_GPIO_OUTPUT_345,
+					  AN8811HB_GPIO_OUTPUT_345);
 	if (ret < 0)
 		return ret;
 
@@ -1039,9 +1040,9 @@ static int en8811h_probe(struct phy_device *phydev)
 		return ret;
 
 	/* Configure led gpio pins as output */
-	ret = air_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
-				      EN8811H_GPIO_OUTPUT_345,
-				      EN8811H_GPIO_OUTPUT_345);
+	ret = air_phy_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
+					  EN8811H_GPIO_OUTPUT_345,
+					  EN8811H_GPIO_OUTPUT_345);
 	if (ret < 0)
 		return ret;
 
@@ -1061,9 +1062,9 @@ static int an8811hb_config_serdes_polarity(struct phy_device *phydev)
 		return ret;
 	if (pol == PHY_POL_NORMAL)
 		pbus_value |= AN8811HB_RX_POLARITY_NORMAL;
-	ret = air_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
-				      AN8811HB_RX_POLARITY_NORMAL,
-				      pbus_value);
+	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_RX_POLARITY,
+					  AN8811HB_RX_POLARITY_NORMAL,
+					  pbus_value);
 	if (ret < 0)
 		return ret;
 
@@ -1074,9 +1075,9 @@ static int an8811hb_config_serdes_polarity(struct phy_device *phydev)
 	pbus_value = 0;
 	if (pol == PHY_POL_NORMAL)
 		pbus_value |= AN8811HB_TX_POLARITY_NORMAL;
-	return air_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
-				       AN8811HB_TX_POLARITY_NORMAL,
-				       pbus_value);
+	return air_phy_buckpbus_reg_modify(phydev, AN8811HB_TX_POLARITY,
+					   AN8811HB_TX_POLARITY_NORMAL,
+					   pbus_value);
 }
 
 static int en8811h_config_serdes_polarity(struct phy_device *phydev)
@@ -1110,9 +1111,10 @@ static int en8811h_config_serdes_polarity(struct phy_device *phydev)
 	if (pol == PHY_POL_NORMAL)
 		pbus_value |= EN8811H_POLARITY_TX_NORMAL;
 
-	return air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
-				       EN8811H_POLARITY_RX_REVERSE |
-				       EN8811H_POLARITY_TX_NORMAL, pbus_value);
+	return air_phy_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
+					   EN8811H_POLARITY_RX_REVERSE |
+					   EN8811H_POLARITY_TX_NORMAL,
+					   pbus_value);
 }
 
 static int an8811hb_config_init(struct phy_device *phydev)
@@ -1264,8 +1266,8 @@ static int en8811h_read_status(struct phy_device *phydev)
 				 val & MDIO_AN_10GBT_STAT_LP2_5G);
 	} else {
 		/* Get link partner 2.5GBASE-T ability from vendor register */
-		ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA,
-					    &pbus_value);
+		ret = air_phy_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA,
+						&pbus_value);
 		if (ret < 0)
 			return ret;
 		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
index aba4f95fe9e6..859fa41406d1 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -137,8 +137,8 @@ static int __air_buckpbus_reg_modify(struct phy_device *phydev,
 	return 0;
 }
 
-int air_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
-			  u32 *pbus_data)
+int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
+			      u32 *pbus_data)
 {
 	int saved_page;
 	int ret = 0;
@@ -154,10 +154,10 @@ int air_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
 
 	return phy_restore_page(phydev, saved_page, ret);
 }
-EXPORT_SYMBOL_GPL(air_buckpbus_reg_read);
+EXPORT_SYMBOL_GPL(air_phy_buckpbus_reg_read);
 
-int air_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
-			   u32 pbus_data)
+int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
+			       u32 pbus_data)
 {
 	int saved_page;
 	int ret = 0;
@@ -174,10 +174,10 @@ int air_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
 
 	return phy_restore_page(phydev, saved_page, ret);
 }
-EXPORT_SYMBOL_GPL(air_buckpbus_reg_write);
+EXPORT_SYMBOL_GPL(air_phy_buckpbus_reg_write);
 
-int air_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
-			    u32 mask, u32 set)
+int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
+				u32 mask, u32 set)
 {
 	int saved_page;
 	int ret = 0;
@@ -194,7 +194,7 @@ int air_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
 
 	return phy_restore_page(phydev, saved_page, ret);
 }
-EXPORT_SYMBOL_GPL(air_buckpbus_reg_modify);
+EXPORT_SYMBOL_GPL(air_phy_buckpbus_reg_modify);
 
 int air_phy_read_page(struct phy_device *phydev)
 {
diff --git a/drivers/net/phy/air_phy_lib.h b/drivers/net/phy/air_phy_lib.h
index b637f3e0f2d5..a2f8b3725761 100644
--- a/drivers/net/phy/air_phy_lib.h
+++ b/drivers/net/phy/air_phy_lib.h
@@ -27,12 +27,12 @@
 #define AIR_BPBUS_RD_DATA_HIGH		0x17
 #define AIR_BPBUS_RD_DATA_LOW		0x18
 
-int air_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
-			    u32 mask, u32 set);
-int air_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
-			  u32 *pbus_data);
-int air_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
-			   u32 pbus_data);
+int air_phy_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
+				u32 mask, u32 set);
+int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
+			      u32 *pbus_data);
+int air_phy_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
+			       u32 pbus_data);
 int air_phy_read_page(struct phy_device *phydev);
 int air_phy_write_page(struct phy_device *phydev, int page);
 

-- 
2.54.0


