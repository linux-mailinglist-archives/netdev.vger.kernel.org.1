Return-Path: <netdev+bounces-296049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nTFhOIK0I2pAxQEAu9opvQ
	(envelope-from <netdev+bounces-296049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D26864CA4A
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:47:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=dPCbdQJ9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296049-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296049-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1E23062ABE
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 05:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2583195FB;
	Sat,  6 Jun 2026 05:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FC309EEC;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724570; cv=none; b=E4vqe3pHGJJu8O/p6Lwb/+Lq/Cg7Y9emzqhLDaLvR34qj3dSRQ0kxKZ4VfoCCVdGBhV7bdmwrmIyBn1n15pnWMswOC2lVoz8bxu1qeS9ODulpNCeJjIeIyKf7ZeETn6peU+KA9ZtheBCNWV9wGiYW2+4w6s6BcYJA8ct/8tECDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724570; c=relaxed/simple;
	bh=QD/tMI+3HqbXuI+rJJGENkSbFca+vBGc5G87cC7Xw1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1PsSXVcJn4KEHiYNDYfskoRPnFT5LKWs1IadEG7BE6vu0a8Vza/jUb1ryTi/JGbLWxsq+7IjPLTUSM4nbzwL1aKe1lXYxugsHqWWPL3WeGfyPkJI0z49LNDOEgKkyBv35TI55+QB0SYX4Oc3VLBGZ6d5X13wsD2YFHXkI96YWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPCbdQJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2F73C2BCC4;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724569;
	bh=QD/tMI+3HqbXuI+rJJGENkSbFca+vBGc5G87cC7Xw1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dPCbdQJ95r/5VeuZmiKDz8lzo5wWhaYcCHH/trBKizueNx4Mr1wkCyAtBxB6yqrqT
	 bZ772j/XnY/Wmv+lkLqsrUvdCTKKqxhdmBls1m6pBNkBn3VBHNv5TfzlFolBBAtWyK
	 3D6zuFYWEGAyReZjWHw9HjvEJAWvZZy9NGEuJNZ+9JALt6piBbbol/ieZQiuOSNZZB
	 YBJHIJ1BfZ8ha+NIvi4GJUDiug3pKdkeSXN8xfZeMamFGZqWMeTJ4fgqYix8McJMDC
	 N4AkIK8L9RGLcHhlO+SbO/uVWppSToBJEPdKIe6vqSppR855Y9pAHumeUmXaKuOYU/
	 aLpOtUaV73gbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D7FCD8C8E;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:41 -0700
Subject: [PATCH net-next v4 10/16] net: phy: ncn26000: Support for onsemi's
 S2500 internal phy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-s2500-mac-phy-support-v4-10-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=4175;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=cRnAyVwtbp6ha34dqi6BLuh05VYIe+6qSsKj5F4v594=;
 b=9pcj2s+nevdqnX8fMX3H39qoe3+BHUqO8Q2u8KjotAnPpi4Nb3ANCvuu9gRkLP7Puz3Z7xyxY
 /i1nSngu+DkDXLZUOuKwqc3wL78rZDOFT/wo8MG7LDQqnwAp7fKr3n0
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296049-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:mid,onsemi.com:url,onsemi.com:email,onsemi.com:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D26864CA4A

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adding support for internal PHY of the integrated
media access controller S2500. PLCA tx opportunity timer's
default value is correct in this device, compared to
NCN26000.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 MAINTAINERS                |  3 ++-
 drivers/net/phy/ncn26000.c | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63b71197d385..98334235c924 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19971,7 +19971,8 @@ S:	Maintained
 F:	arch/mips/boot/dts/ralink/omega2p.dts
 
 ONSEMI ETHERNET PHY DRIVERS
-M:	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
+M:	Piergiorgio Beruto <pier.beruto@onsemi.com>
+M:	Selva Rajagopal <selvamani.rajagopal@onsemi.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.onsemi.com
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index cabdd83c614f..2c8601c3f94a 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -2,7 +2,7 @@
 /*
  *  Driver for the onsemi 10BASE-T1S NCN26000 PHYs family.
  *
- * Copyright 2022 onsemi
+ * Copyright 2026 onsemi
  */
 #include <linux/kernel.h>
 #include <linux/bitfield.h>
@@ -14,6 +14,7 @@
 
 #include "mdio-open-alliance.h"
 
+#define PHY_ID_S2500			0x180FF411
 #define PHY_ID_NCN26000			0x180FF5A1
 
 #define NCN26000_REG_IRQ_CTL            16
@@ -37,13 +38,18 @@
 
 static int ncn26000_config_init(struct phy_device *phydev)
 {
+	int ret = 0;
+
 	/* HW bug workaround: the default value of the PLCA TO_TIMER should be
 	 * 32, where the current version of NCN26000 reports 24. This will be
 	 * fixed in future PHY versions. For the time being, we force the
 	 * correct default here.
 	 */
-	return phy_write_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_TOTMR,
-			     TO_TMR_DEFAULT);
+	if (phy_id_compare_model(phydev->drv->phy_id, PHY_ID_NCN26000))
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    MDIO_OATC14_PLCA_TOTMR,
+				    TO_TMR_DEFAULT);
+	return ret;
 }
 
 static int ncn26000_config_aneg(struct phy_device *phydev)
@@ -117,8 +123,8 @@ static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 
 static int ncn26000_config_intr(struct phy_device *phydev)
 {
-	int ret;
 	u16 irqe;
+	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		// acknowledge IRQs
@@ -141,6 +147,26 @@ static int ncn26000_config_intr(struct phy_device *phydev)
 }
 
 static struct phy_driver ncn26000_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_S2500),
+		.name                  = "S2500",
+		.features              = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init           = ncn26000_config_init,
+		.config_intr           = ncn26000_config_intr,
+		.config_aneg           = ncn26000_config_aneg,
+		.read_status           = ncn26000_read_status,
+		.handle_interrupt      = ncn26000_handle_interrupt,
+		.set_plca_cfg          = genphy_c45_plca_set_cfg,
+		.get_plca_cfg          = genphy_c45_plca_get_cfg,
+		.get_plca_status       = genphy_c45_plca_get_status,
+		.soft_reset            = genphy_soft_reset,
+		.get_sqi               = genphy_c45_oatc14_get_sqi,
+		.get_sqi_max           = genphy_c45_oatc14_get_sqi_max,
+		.read_mmd              = genphy_phy_read_mmd,
+		.write_mmd             = genphy_phy_write_mmd,
+		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
+		.cable_test_start      = genphy_c45_oatc14_cable_test_start,
+	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
 		.name			= "NCN26000",
@@ -161,11 +187,13 @@ module_phy_driver(ncn26000_driver);
 
 static const struct mdio_device_id __maybe_unused ncn26000_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(mdio, ncn26000_tbl);
 
-MODULE_AUTHOR("Piergiorgio Beruto");
+MODULE_AUTHOR("Piergiorgio Beruto <pier.beruto@onsemi.com>");
+MODULE_AUTHOR("Selva Rajagopal <selvamani.rajagopal@onsemi.com>");
 MODULE_DESCRIPTION("onsemi 10BASE-T1S PHY driver");
 MODULE_LICENSE("Dual BSD/GPL");

-- 
2.43.0



