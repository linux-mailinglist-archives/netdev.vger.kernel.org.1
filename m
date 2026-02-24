Return-Path: <netdev+bounces-260641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIYoCkgKnmnkTAQAu9opvQ
	(envelope-from <netdev+bounces-260641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:30:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2218C60D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C2B830B2403
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786F33A71B;
	Tue, 24 Feb 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lCo6yPtQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013F33A010;
	Tue, 24 Feb 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964990; cv=none; b=KOXZeMf3NiSUJNPRsu7kaMN5s+0F3hLJnxhsR2WsRAVNgsliAEXtk1ZMYDa6wPj37LmFsOPHo75wSmuvDyTOv9GlOX+qf3VBf/szcxFC2sDa3g9XIOqeyBAz9hyNz6MlSJiNK1/jzw7lbafp7oBw1YRiBLqIuXCnCEOO0+o8HEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964990; c=relaxed/simple;
	bh=1VEm0arbUZfxX0v/fT6FqQBpqJKnwvcYGvUGlchmwxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y97r6vVdjg6CIuL2gP5ZyhKca9T650XJAciCI70l7GEWI49bxhF62n3B3SVRFyK2hPj03aSAvD0udb+4Z0xDvKrx4DXVvU0BvrMPoM3Y8PPaVNulckeHcj68DlFUyFsckzlY9eLXdTT+HBVFFVAsGAxtwcYBmmpS0nZZWwy+LJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lCo6yPtQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771964987; x=1803500987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1VEm0arbUZfxX0v/fT6FqQBpqJKnwvcYGvUGlchmwxo=;
  b=lCo6yPtQOpCE0XNolJDqT5+bRSDsDpYYjln4TUfzOhQBm8rETf+E1jYg
   I7mMqEXDdFCdk0RqNJwZ5/DDJj53rFDs0blOHIWKE1OcH0sXGjjfSqaCR
   5cQa1GheacooHhhgLOMhO+56XOt3Mi3uXISCOliDKVIrWLQEpE6VV7nZT
   eFiGwOePv4ZAyubeRCA9k883y1cQZ8kHTMspfc82ZxeCADYmjHE0447Wd
   W8Nn+yiplUMjIapn3MpdLlFk4JFBGNadm0n6D2cN6gXdSnRaufz0F0Gx0
   zYqevSOBEt/7yE/1SyuZ+OLr5T2v/6hhOlLVMFYVb2el9sFHh6Ai28tkL
   w==;
X-CSE-ConnectionGUID: CU6nEk3VSSKbTSpVLGI17Q==
X-CSE-MsgGUID: cIybErY6RLa4XitBa8VsTQ==
X-IronPort-AV: E=Sophos;i="6.21,309,1763449200"; 
   d="scan'208";a="54233071"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:29:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 13:29:30 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 24 Feb 2026 13:29:28 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Sean Anderson
	<sean.anderson@linux.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg disabled
Date: Tue, 24 Feb 2026 12:28:52 -0800
Message-ID: <20260224202854.112813-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224202854.112813-1-charles.perry@microchip.com>
References: <20260224202854.112813-1-charles.perry@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260641-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: 96B2218C60D
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
    Changes in v2:
      * Move my notes to the cover letter
      * Remove the spinlock in macb_pcs_config
      * Keep the comment about the PCSSEL register

 drivers/net/ethernet/cadence/macb_main.c | 36 +++++++++++++-----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f72270a39d25..f4250e76cef0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -574,6 +574,26 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
 			   const unsigned long *advertising,
 			   bool permit_pause_to_mac)
 {
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	u32 old, new;
+
+	old = gem_readl(bp, PCSANADV);
+	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
+	if (new != -EINVAL && old != new)
+		gem_writel(bp, PCSANADV, new);
+
+	/* Disable AN if it's not to be used, enable otherwise.
+	 * Must be written after PCSSEL is set in NCFGR which is done in
+	 * macb_mac_config(), otherwise writes will not take effect.
+	 */
+	old = gem_readl(bp, PCSCNTRL);
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		new = old | BMCR_ANENABLE;
+	else
+		new = old & ~BMCR_ANENABLE;
+	if (old != new)
+		gem_writel(bp, PCSCNTRL, new);
+
 	return 0;
 }
 
@@ -628,22 +648,6 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
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


