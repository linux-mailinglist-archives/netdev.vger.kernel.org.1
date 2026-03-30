Return-Path: <netdev+bounces-273199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L1xMuV/ymnX9QUAu9opvQ
	(envelope-from <netdev+bounces-273199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C8E35C595
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FD6F303DAC7
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3E3D413D;
	Mon, 30 Mar 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r4A/csC6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78D1DF748;
	Mon, 30 Mar 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878207; cv=none; b=khLdJHRzw/CBzmPeUp6VxwuP0kBCZVZFeK5lIULChWdoqmpU27SRMFl7GMtrnA24p5BWP3+t0599YY8CDpma1W5o/Am9IwBHmDndxHEGu7tKI8ya5CijXaF73rByBiqDQ5I/1RCLZF4xT8DKPh0p62Apmkac73mVxJEH6wmmlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878207; c=relaxed/simple;
	bh=Ua/CS7JSTaBw57q2Xy8om4sgLy5xGdPQuWt0BaCxUu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3qeZ+/nIIXft50esXQxoQf1uWoAS9HTUWP0h2y31NNjeI5f8FRlnlVUir31zFlmRwX+Cu0gjM16y9MlpVbZE3WVcCMDD6l0X3mt4aeKI0UHl7Bz+koOS+z80yvTHWvjaQSq02lGw0tj4GnVVo4GH3gFVt9gBHhOakyhHaN3+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r4A/csC6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774878207; x=1806414207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ua/CS7JSTaBw57q2Xy8om4sgLy5xGdPQuWt0BaCxUu0=;
  b=r4A/csC6qcD9ddg0smIPUP1TTlzsAChqhom9laORvBsdMS0z7RCD/HwJ
   vr8LuYCqtaWBvwJPhgqZqzDJMTSXiUb9tPMnrvuvVUe4irbEZ8PVTmXp9
   m1ViL77jdnDmlegVbK8K89LAuLfhf7gLc4h0eDFg/jqf+UkG76X0QbhdI
   cFXxdmwJOHlh0gRF5WTEWV6DKuYiFwaQDnGXbUbDpaZetC9sDev+LUbX4
   JLXqthy4D/cpxWOKzddcRaLtamynsa5ch4sI4KfX7ZPTHXChC3fPfFZE8
   wwfGEL7X54Kf0xkpbhhUjBo1QbBn9Tb5kMVry5O4T3j98XWnhUg0Xbq5v
   w==;
X-CSE-ConnectionGUID: A9xejRTGSYmPSBxKzhOiXw==
X-CSE-MsgGUID: Uq+W3AQNQWeCGgey0L8Khw==
X-IronPort-AV: E=Sophos;i="6.23,150,1770620400"; 
   d="scan'208";a="286780759"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2026 06:43:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 30 Mar 2026 06:42:39 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 30 Mar 2026 06:42:35 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <parthiban.veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH net-next 2/3] net: phy: microchip_t1s: add suspend and WOL support for LAN867x Rev.D0
Date: Mon, 30 Mar 2026 19:12:21 +0530
Message-ID: <20260330134222.67597-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273199-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parthiban.veerasooran@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: 31C8E35C595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The LAN867x Rev.D0 PHY supports OATC10-compliant sleep and wake
functionality, which can be used for system suspend and wake-up via
MDI Wake-up Pulse (WUP).

Add suspend/resume handling and basic Wake-on-LAN support using
WAKE_PHY, enabling WUP as a wake source via the Sleep Control 0
register. The driver configures MDI wake before entering suspend
and reports/enables the wake source through ethtool WOL callbacks.

Also adjust the Rev.D0 configuration path to avoid checking the reset
completion status when resuming from suspend, as the reset status is
only valid after an explicit PHY reset and not after sleep.

This allows LAN867x Rev.D0 systems to reliably wake from suspend via
MDI activity while preserving correct initialization behavior.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 67 +++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index e601d56b2507..6b158ae5fb16 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -38,6 +38,10 @@
 #define LINK_STATUS_CONFIGURATION	GENMASK(12, 11)
 #define LINK_STATUS_SEMAPHORE		BIT(0)
 
+/* Sleep Control 0 Register */
+#define LAN867X_REG_SLEEP_CTRL0		0x0080
+#define SLEEP_CTRL0_MDI_WAKEUP_EN	BIT(14)
+
 /* Link Status Configuration */
 #define LINK_STATUS_CONFIG_PLCA_STATUS	0x1
 #define LINK_STATUS_CONFIG_SEMAPHORE	0x2
@@ -472,9 +476,14 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
 {
 	int ret;
 
-	ret = lan867x_check_reset_complete(phydev);
-	if (ret)
-		return ret;
+	/* Reset status is only valid after an explicit PHY reset, it is not set
+	 * when the PHY resumes from suspend/sleep state.
+	 */
+	if (!phydev->suspended) {
+		ret = lan867x_check_reset_complete(phydev);
+		if (ret)
+			return ret;
+	}
 
 	for (int i = 0; i < ARRAY_SIZE(lan867x_revd0_fixup_regs); i++) {
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
@@ -491,6 +500,53 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
 	return lan867x_revd0_link_active_selection(phydev, false);
 }
 
+static int lan867x_revd0_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Configure WUP as wake source for system suspend */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
+			       LAN867X_REG_SLEEP_CTRL0,
+			       SLEEP_CTRL0_MDI_WAKEUP_EN);
+	if (ret)
+		return ret;
+
+	return genphy_c45_oatc10_suspend(phydev);
+}
+
+static int lan867x_revd0_set_wol(struct phy_device *phydev,
+				 struct ethtool_wolinfo *wol)
+{
+	/* Only support WAKE_PHY via WUP (Wake-up Pulse) */
+	if (wol->wolopts & ~WAKE_PHY)
+		return -EOPNOTSUPP;
+
+	if (wol->wolopts & WAKE_PHY) {
+		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2,
+					LAN867X_REG_SLEEP_CTRL0,
+					SLEEP_CTRL0_MDI_WAKEUP_EN);
+	} else {
+		/* Disable WUP wake source */
+		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
+					  LAN867X_REG_SLEEP_CTRL0,
+					  SLEEP_CTRL0_MDI_WAKEUP_EN);
+	}
+}
+
+static void lan867x_revd0_get_wol(struct phy_device *phydev,
+				  struct ethtool_wolinfo *wol)
+{
+	int ret;
+
+	wol->supported = WAKE_PHY;
+	wol->wolopts = 0;
+
+	/* Check if WUP wake source is currently enabled */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_SLEEP_CTRL0);
+	if (ret >= 0 && (ret & SLEEP_CTRL0_MDI_WAKEUP_EN))
+		wol->wolopts = WAKE_PHY;
+}
+
 static int lan86xx_read_status(struct phy_device *phydev)
 {
 	/* The phy has some limitations, namely:
@@ -569,6 +625,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVD0),
 		.name               = "LAN867X Rev.D0",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.flags              = PHY_ALWAYS_CALL_SUSPEND,
 		.config_init        = lan867x_revd0_config_init,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
@@ -577,6 +634,10 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
 		.get_sqi            = genphy_c45_oatc14_get_sqi,
 		.get_sqi_max        = genphy_c45_oatc14_get_sqi_max,
+		.suspend            = lan867x_revd0_suspend,
+		.resume             = genphy_c45_oatc10_resume,
+		.get_wol	    = lan867x_revd0_get_wol,
+		.set_wol	    = lan867x_revd0_set_wol,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
-- 
2.34.1


