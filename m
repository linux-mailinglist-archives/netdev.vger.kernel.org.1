Return-Path: <netdev+bounces-305925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aMwuDviGTmqQOgIAu9opvQ
	(envelope-from <netdev+bounces-305925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B5A729226
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:20:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=fCQ7BN0M;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305925-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305925-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 739223054688
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388F4D8D84;
	Wed,  8 Jul 2026 17:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC504C77DF;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530757; cv=none; b=Eky57YilUpj4+AcbT+p+6gMShxX1tvghOHngnYaqmcQFXl0lufPnl+/vKNNF8jr2s0PNeo2OoSmVDIE+WTBj2SbcOX40WQPESrT21X+KVtQRO7d2gusQcTqZqB4kk/fKMrqn0Rr8rKBHYQyRPKM8XXsUTjTY+3SO4hsnYPt/3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530757; c=relaxed/simple;
	bh=rGdgNEOa4PRQulmRpv3nlDP3iDULshIMALobzl3Eiv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGaiwJo+L88ax2kjXpzMKDm2cXQP+S0kmYZuggbeNvJggNnwFk7ov6E04zuiLZeNKA8SeUL/2DL+z6gKJdJPypT8Tt7z17Spx2mSSR42QxkCn4dteyaEqLk9oKE+/FsfgYiKrMHOb2rBB7pMf+hEEHvj3L9ZKPWk79p3Dcr1F60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCQ7BN0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC39C2BD05;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530757;
	bh=rGdgNEOa4PRQulmRpv3nlDP3iDULshIMALobzl3Eiv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fCQ7BN0MFioRKnf/0pYuvh2lc6xxRyI2cB9w/LI46+c0QlDhgnkBK4H1NDQATsGs2
	 orrnhB742uQmrkq0TDTKo8gXO5iZcsp+zm1a/VLANhl6kEzhG1T6UAe//X5lhg8aob
	 T7qM4LS0f5OO4wbNIFXuoFbw0TJmecvS2kAbkCOL68BpWmqywf5keRRnhyIzq33u8V
	 qM2QIxwCY6eHJaVAl2jrFurc2oFyeijEvbuE2ZTNKtOrxETInFiVK2DMtOAysAFK7J
	 omNvzsvBEveNf3wHXexI+i9+RbEdTGklOBz83biEOPUBYPV5tBZ3Wowy0vxoZ9TF7Q
	 MYH5KrmXJU+6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FA1C44506;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:41 -0700
Subject: [PATCH net-next v7 11/15] net: phy: ncn26000: Support for onsemi's
 S2500 internal phy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-s2500-mac-phy-support-v7-11-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=4612;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=zPvSwYFIaqDGwtQAiUf+Rz247w3+pRQAfmWgkTH2wJc=;
 b=mUfdkamFBnPg7/diENiQDR6n1PT+VGjnu9cVq4ng/sYErU5KGzlTW0qV+YCJ3xNLSA1TpZWsK
 3/AJsX19ek3ArrUzEyLGY0qwM/CUSOn81Dx/b+DN49WXfAwe2OSVspD
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305925-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,onsemi.com:url,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1B5A729226

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adding support for internal PHY of the integrated
media access controller S2500. PLCA tx opportunity timer's
default value is correct in this device, compared to
NCN26000.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - no change
changes in v3
   added new PHY support separate patch
   changed model comparison to use phy_id_compare_model
changes in v2
   Removed bug fixes. Retained only S2500 specific changes
changes in v1
   Added support for an internal PHY of onsemi's MAC-PHY S2500
---
 MAINTAINERS                |  3 ++-
 drivers/net/phy/ncn26000.c | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb19a6431951..958b9f61e364 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20182,7 +20182,8 @@ S:	Maintained
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



