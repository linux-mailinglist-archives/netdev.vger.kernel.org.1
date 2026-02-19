Return-Path: <netdev+bounces-259519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBq/DT5Cl2lXwAIAu9opvQ
	(envelope-from <netdev+bounces-259519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:02:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD743160E5A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2059301C179
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6962E324B10;
	Thu, 19 Feb 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ujzCkrDB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB434AB15;
	Thu, 19 Feb 2026 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520558; cv=none; b=Q39vXVHT+lwp1kDuCLC9rBJJfk7hs0oXHfn5t3dH/WcX52NdJlkqIXQGQtd0uDuTFuFzIYokM725O4lNsvM3hH+ejU5PBwDO45qxZGDwJi9aqm3V691Xp69BRUVKv0akHmyvjBahDa8W9g752qcbHZLJtDRupwtQW9Gx7jN7FaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520558; c=relaxed/simple;
	bh=tK9oUw37tl8bcDx5v1E2uHW4GSg73UR/kLtsPDpxe88=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SfdsaLXkFmS5Ba17ZbAIDjhYaXS24DnhJl7gpyvZoSa5XLhk3CVVYd+kMzvzl6m0A+TxwQ1sGMw4ffSdWKAVAuaOOdFi4j8GgGvS+Q2zv4swR1oYtUud/QXNunb0I5didrOWuHsmA1WdvkUOCLOfcd1R0+pgQPh5PrSiF+713NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ujzCkrDB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771520555; x=1803056555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tK9oUw37tl8bcDx5v1E2uHW4GSg73UR/kLtsPDpxe88=;
  b=ujzCkrDBjiTPwEBuOZdw06KCMUQ5vPB6anxvUD7cNVqqYJ9Q3Z39VVqT
   YMdxKCDPex86XOldUQbEcd+99ywfguznrXReyeaCIhEyxWlBoyYJVqsi+
   xK127MvxjUqgbzyBngAPnsN26BRZCfplx+IK82Q4iimWPv+pKJielfKZy
   upbyi3TvWHwGYH5/M9wOgSCwin66VAj5ap07QV98J+X+b2B3BJqntKsNb
   m2b1b6EtTejZPdz3ACDoiop2gKtYIRLl/4tkY5K/yy2hOZlmE+4QvJDZ+
   z7hS2r7Zev1YosSgS5H+Z8yMZroZBgnr86onnOGa5suZOQmq7PdS/O/v5
   A==;
X-CSE-ConnectionGUID: g/UMbC71R82XW/PMs8a7JA==
X-CSE-MsgGUID: ZPNa1s6nREuF93CuXvv55w==
X-IronPort-AV: E=Sophos;i="6.21,300,1763449200"; 
   d="scan'208";a="52867983"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:02:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Feb 2026 10:01:39 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 19 Feb 2026 10:01:47 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Sean Anderson <sean.anderson@linux.dev>, Charles Perry
	<charles.perry@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/2] net: macb: fix SGMII with inband aneg disabled
Date: Thu, 19 Feb 2026 09:01:11 -0800
Message-ID: <20260219170113.1774090-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259519-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD743160E5A
X-Rspamd-Action: no action

Make it possible to connect a PHY which does not use inband
autoneg to a gem MAC using phylink's information.

The previous implementation relied on whether or not the link
was a fixed-link to disable SGMII autoneg. This commit extend
this to all link which are not configured for inband
autonegotiation.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---

Notes:
    I'm testing with a VSC8574 PHY which phylink can configure in outband mode
    or in inband,an-enabled mode if I add a managed = "in-band-status" property
    in the device tree.
    
    The link can work with or without autoneg, as long as the MAC and the PHY
    are configured the same way. This doesn't work with the current MAC driver
    because the MAC inband autoned is always enabled.
    
    This is based on code written by Sean Anderson [1]. Let me know if I
    should add a From: or Co-developed-by: tag.
    
    [1]: https://lore.kernel.org/all/20250610233547.3588356-1-sean.anderson@linux.dev/

 drivers/net/ethernet/cadence/macb_main.c | 35 +++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f72270a39d25..5002087cda09 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -574,6 +574,25 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
 			   const unsigned long *advertising,
 			   bool permit_pause_to_mac)
 {
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	unsigned long flags;
+	u32 old, new;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	old = gem_readl(bp, PCSANADV);
+	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
+	if (new != -EINVAL && old != new)
+		gem_writel(bp, PCSANADV, new);
+
+	old = gem_readl(bp, PCSCNTRL);
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		new = old | BMCR_ANENABLE;
+	else
+		new = old & ~BMCR_ANENABLE;
+	if (old != new)
+		gem_writel(bp, PCSCNTRL, new);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
 	return 0;
 }
 
@@ -628,22 +647,6 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	if (old_ncr ^ ncr)
 		macb_or_gem_writel(bp, NCR, ncr);
 
-	/* Disable AN for SGMII fixed link configuration, enable otherwise.
-	 * Must be written after PCSSEL is set in NCFGR,
-	 * otherwise writes will not take effect.
-	 */
-	if (macb_is_gem(bp) && state->interface == PHY_INTERFACE_MODE_SGMII) {
-		u32 pcsctrl, old_pcsctrl;
-
-		old_pcsctrl = gem_readl(bp, PCSCNTRL);
-		if (mode == MLO_AN_FIXED)
-			pcsctrl = old_pcsctrl & ~GEM_BIT(PCSAUTONEG);
-		else
-			pcsctrl = old_pcsctrl | GEM_BIT(PCSAUTONEG);
-		if (old_pcsctrl != pcsctrl)
-			gem_writel(bp, PCSCNTRL, pcsctrl);
-	}
-
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
-- 
2.47.3


