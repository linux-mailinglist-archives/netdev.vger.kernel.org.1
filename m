Return-Path: <netdev+bounces-259520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6+/2HVdCl2nzwAIAu9opvQ
	(envelope-from <netdev+bounces-259520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:03:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB631160E77
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BB4E3012A91
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BD34DB66;
	Thu, 19 Feb 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="19c+9LLG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F334CFB9;
	Thu, 19 Feb 2026 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520560; cv=none; b=sMx3+FgMJYA2ymy0oDYzpP0DI1480t6R1YzDEcF8M7rNjf00Q0bffP1oDN5i3UA0tYTja5huSEe+TWlnYphyBXj4pcObXTNe8wFsh6JosF/8ncFqFxgha31gH+9rNx9uZh0EtTFfjhZ0p/0Kt8fJQJeyibfBxQpG67ja/KiyTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520560; c=relaxed/simple;
	bh=8flf7EFVs9ZTZ4hm9nURLAsPdfihLQ8TTV59kXiAR2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfpnIdiaFt3HDMuGFpHod4zI9f3b+EEwbTa8uGv+OwqQdmh67JPFxy6Wsuw8dbV3+XGQPvoezjUyeSnXOneH7b8vUO/nfw0g7SFr55UY2jldSjzxbpkEo3bwW2BnDcPN71kqO03hxAAG2Mj9THJ6gIRoloKVgu/Esaf6wMwqbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=19c+9LLG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771520557; x=1803056557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8flf7EFVs9ZTZ4hm9nURLAsPdfihLQ8TTV59kXiAR2A=;
  b=19c+9LLGD7bQQh03VQx+6PdTRmqOO07w6JobLfRioaoKHyBBhkTUPgtd
   Xic9TyjZ8JV/A0x8n7jCQ5xuVfejWYY/qtuIZvxF6+yfiX3R2X5ob5YvM
   dsm4LP/T/jdhjhJBXCI0kYefQuu+5IMSD7oN6qPmRMtsZbodRjrniEay/
   wvHeIeBe62Pib02+wQuOgfjJPuRXVxKHKLY10PBkANCAnoEZOk5yF1XGT
   rApyHU/3ZyEE+cUktp8yUSb109eXiUh+mg/j5M2cAE3F2/J+85gw1B9CK
   JCKokcLnZo1VgXLf9yBKFTYqj9frD6UeAAZ2PNRav5hGLUoMZBzC1DviK
   A==;
X-CSE-ConnectionGUID: 3VbWF6/lSt2JzyF/sWSomw==
X-CSE-MsgGUID: WQFy2w5ZQySdJU06gFA+RA==
X-IronPort-AV: E=Sophos;i="6.21,300,1763449200"; 
   d="scan'208";a="52867996"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:02:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Feb 2026 10:01:47 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 19 Feb 2026 10:01:54 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Sean Anderson <sean.anderson@linux.dev>, Charles Perry
	<charles.perry@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: macb: add support for reporting SGMII inband link status
Date: Thu, 19 Feb 2026 09:01:12 -0800
Message-ID: <20260219170113.1774090-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219170113.1774090-1-charles.perry@microchip.com>
References: <20260219170113.1774090-1-charles.perry@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259520-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email,p64h:email]
X-Rspamd-Queue-Id: EB631160E77
X-Rspamd-Action: no action

This makes it possible to use in-band autonegotiation with
SGMII.

If using a device tree, this can be done by adding the managed =
"in-band-status" property to the gem node.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---

Notes:
    Logs with inband aneg:
    
    root@p64h:~# ifconfig eth1 up 10.180.59.33
    macb 40004184000.ethernet eth1: PHY 4000c21e000.mdio-mdio:02 doesn't supply possible interfaces
    macb 40004184000.ethernet eth1: PHY [4000c21e000.mdio-mdio:02] driver [Microsemi GE VSC8574 SyncE] (irq=POLL)
    macb 40004184000.ethernet eth1: phy: sgmii setting supported 00000000,00000000,00000000,000042ff advertising 00000000,00000000,00000000,000042ff
    macb 40004184000.ethernet eth1: configuring for inband/sgmii link mode
    macb 40004184000.ethernet eth1: major config, requested inband/sgmii
    macb 40004184000.ethernet eth1: interface sgmii inband modes: pcs=00 phy=03
    pcs_ib_caps=0x0 phy_ib_caps=0x3
    macb 40004184000.ethernet eth1: major config, active inband/inband,an-enabled/sgmii
    macb 40004184000.ethernet eth1: phylink_mac_config: mode=inband/sgmii/none adv=00000000,00000000,00000000,000042ff pause=00
    PCSANADV=0x1 PCSCNTRL=0x1040
    PCSSTS=0x109 PCSANLPBASE=0x1801
    PCSSTS=0x12d PCSANLPBASE=0x1801
    macb 40004184000.ethernet eth1: phy link down sgmii/Unknown/Unknown/none/off/nolpi
    PCSSTS=0x12d PCSANLPBASE=0x1801
    PCSSTS=0x12d PCSANLPBASE=0x1801
    macb 40004184000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/tx/nolpi
    PCSSTS=0x129 PCSANLPBASE=0x9801
    PCSSTS=0x12d PCSANLPBASE=0x9801
    macb 40004184000.ethernet eth1: Link is Up - 1Gbps/Full - flow control tx
    
    Logs without inband aneg:
    
    macb 40004184000.ethernet eth1: PHY 4000c21e000.mdio-mdio:02 doesn't supply possible interfaces
    macb 40004184000.ethernet eth1: PHY [4000c21e000.mdio-mdio:02] driver [Microsemi GE VSC8574 SyncE] (irq=POLL)
    macb 40004184000.ethernet eth1: phy: sgmii setting supported 00000000,00000000,00000000,000042ff advertising 00000000,00000000,00000000,000042ff
    macb 40004184000.ethernet eth1: configuring for phy/sgmii link mode
    macb 40004184000.ethernet eth1: major config, requested phy/sgmii
    macb 40004184000.ethernet eth1: interface sgmii inband modes: pcs=00 phy=03
    macb 40004184000.ethernet eth1: major config, active phy/outband/sgmii
    macb 40004184000.ethernet eth1: phylink_mac_config: mode=phy/sgmii/none adv=00000000,00000000,00000000,00000000 pause=00
    PCSANADV=0x1 PCSCNTRL=0x40
    macb 40004184000.ethernet eth1: phy link down sgmii/Unknown/Unknown/none/off/nolpi
    macb 40004184000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/tx/nolpi
    macb 40004184000.ethernet eth1: Link is Up - 1Gbps/Full - flow control tx

 drivers/net/ethernet/cadence/macb_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5002087cda09..a7a2d7fcb18c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -560,7 +560,12 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
 static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 			       struct phylink_link_state *state)
 {
-	state->link = 0;
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	u16 bmsr, lpa;
+
+	bmsr = gem_readl(bp, PCSSTS);
+	lpa = gem_readl(bp, PCSANLPBASE);
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
 }
 
 static void macb_pcs_an_restart(struct phylink_pcs *pcs)
-- 
2.47.3


