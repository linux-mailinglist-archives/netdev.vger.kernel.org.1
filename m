Return-Path: <netdev+bounces-286949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIIYO0uuAmpTvgEAu9opvQ
	(envelope-from <netdev+bounces-286949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:36:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD45199BA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE4FA30599D8
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9333DEE1;
	Tue, 12 May 2026 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b/AiPDwz"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF5133AD8C;
	Tue, 12 May 2026 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560435; cv=none; b=QLWz1NBdG1cvplpGY+Nx1Gw01k5wY9zvhzIDxF43K8i6XFUGGxgOSp3NpN8S4rXLGVUK9D0j6hvqtU/q1UW41A2opLPP4p/2/1SrEICZL4z2PmgsrXDHDMyCGbCx1E1zuKweaj3oCen0ZKDpEY11hhdUSDBMNVU08OD0nPnfE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560435; c=relaxed/simple;
	bh=a59kRVQiR8XH63n+a6PWRw2wkz0pqXohRFcy4+WfMmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXd2bfqYh2shj74523tEn7+VO7sXIqK875VryerkF6Zu7KbXCH9wgPaPfhjkq5Me9fkExyGhqZWilhR6o+KdljSzhyEqTP9/POCLMSoT92g8y414isJO41UV/NTjMgI6QYcQrCbZtLSE/wTpr3Qblesm/l76Ab6ppaTcdfgBqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b/AiPDwz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778560431;
	bh=a59kRVQiR8XH63n+a6PWRw2wkz0pqXohRFcy4+WfMmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b/AiPDwz/H8nhUEcZUFOUKdq9VoDHlyM1RJ960APHAJ2wte21R6dqQiK5l8WTNOIx
	 BAGI+zNQGU3A3ox0R7WYmciLud1rxmAYFcHfY++hI8wlDK0FJVMmC5GNEtmfBnxh2X
	 hu/FyNA8HXiwu6pdX7zX2oo0rcmX8YKC/8jbtRNAAYb2ENrzT2oa4oa8NpjVTPPwO4
	 DoCNzQFQUVPSNEq1ssGScUjalVcK3rm7hJHXJvY5kiOoXiOCNvM7nCRiKsiR7QfMxL
	 l8y6jpNUF9u76bQcuGIXlgVEtydX3+fF70InxWiNOhl8098oENr9Wgo0a8oQmFleNu
	 5vGNIca4O2Y0Q==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8857817E15E3;
	Tue, 12 May 2026 06:33:50 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 12 May 2026 06:33:21 +0200
Subject: [PATCH net-next v3 4/6] net: phy: Rename Airoha common BuckPBus
 register accessors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-airoha-an8801-support-v3-4-1edb34e363ae@collabora.com>
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
In-Reply-To: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778560425; l=13313;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=a59kRVQiR8XH63n+a6PWRw2wkz0pqXohRFcy4+WfMmI=;
 b=eHuw3edwJpGLASeuGugjuJjL2mAfLlfZKF/KzuF3jvv/dOEvl9I525KCrFvVkVsPdloAmc1yy
 iZjb1qbL0YeBIwoRdhrQqSFbZTV8Xqz7x1/AetmRVVkH42vNSwdRpvr
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Queue-Id: 8DDD45199BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286949-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,100.64.0.131:received,148.251.105.195:received];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:mid,collabora.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Rename the BuckPBus register accessors functions present in air_phy_lib
and their calls in air_en8811h driver, so all exported functions start
with the same prefix.

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
index 687c59197b16..1212dd0a37b7 100644
--- a/drivers/net/phy/air_phy_lib.c
+++ b/drivers/net/phy/air_phy_lib.c
@@ -136,8 +136,8 @@ static int __air_buckpbus_reg_modify(struct phy_device *phydev,
 	return 0;
 }
 
-int air_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
-			  u32 *pbus_data)
+int air_phy_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
+			      u32 *pbus_data)
 {
 	int saved_page;
 	int ret = 0;
@@ -153,10 +153,10 @@ int air_buckpbus_reg_read(struct phy_device *phydev, u32 pbus_address,
 
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
@@ -173,10 +173,10 @@ int air_buckpbus_reg_write(struct phy_device *phydev, u32 pbus_address,
 
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
@@ -193,7 +193,7 @@ int air_buckpbus_reg_modify(struct phy_device *phydev, u32 pbus_address,
 
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


