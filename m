Return-Path: <netdev+bounces-305924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KjlOGOKFTmoUOgIAu9opvQ
	(envelope-from <netdev+bounces-305924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:16:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B97C72915A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=pysQ1x8u;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305924-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305924-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2F3C3025CEA
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DBB4D8D81;
	Wed,  8 Jul 2026 17:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF54C8FF4;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530757; cv=none; b=lt3thWRd3/WQnnDYYBeieX3O/Vktg55a8xkksB+IBeqPuCL2svCeRn2C7F1PgZrU2ZaiGeIDhHUc/cIflZtwQWS4RlMWTB68yl5+3vkpJMcGzU9E9N0QZpbHdZaYJ9VnD5QMBisDQm90GMQON2LinTtLQeNG8AEK9GeNnACs52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530757; c=relaxed/simple;
	bh=UQ81Hj84qm5mNJjl97nFlLex4yFCmbsGhvCZ2CelVHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwRd4IUZSsZiw4fzSeC50vtur9+f2ugYfK/huCmG0Z6El8o7xXOTH46yVRpYy+V0pJnWm2Ju4E1P7N191dB3uMYlAKiJT57IdYIJae7U9ZCXXOcXW++E68y+x04YKRFGFWDA8i4UTPGDUdHgs9x+DIHxuvwWolWlMoOjrLYX2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pysQ1x8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B2BEC4AF0D;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530757;
	bh=UQ81Hj84qm5mNJjl97nFlLex4yFCmbsGhvCZ2CelVHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pysQ1x8uRrguzlI051Dl40NdCEiad9tu4b0Cv3QJLEMTZ+150URN8HiHvUybTvGKG
	 ejEmaO6CwqgmYLOA8XFx/dm/aST1ydUjYx/cPOuc6+XL4C0U6adrCjvioUCwNZyk3O
	 eBmrPe7lIIpgn3p5ZXSJcH1xKuzcuX7rQVrE1VcPDJGsGNTuUe/TGk2NZrQxLWw9TY
	 r9K3KZKN5hm7os6kwOVNT+G9pUFGkLbjHGMwnLY6/q3qlBbduM8/nTlXCY00Xemmlg
	 BoiGrlwutFmpm0zUOgWkxIqRdtbiemBUa9ceIM3n1qZsjjAUHxE4s87HQXJg4hwMtL
	 qfGiEPXf219kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18519C43458;
	Wed,  8 Jul 2026 17:12:37 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:42 -0700
Subject: [PATCH net-next v7 12/15] net: phy: ncn26000: Enable enhanced
 noise immunity
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-s2500-mac-phy-support-v7-12-478c877aa1a9@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=2614;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=tbI3JXJvdBaPKVCalTJamcVK1qltAzJPOHUnbQU9jD4=;
 b=SMxuoT6A5UNtNJSn/N/UBAztPuz3lX0tECevdKLHuT6t8hmt4m7r5hbHU02WBqHFcYHQFv1DZ
 5obWk/v4kVpA5sTUEZcB9G1YFGXG9orLyQSPWZdT0rQ+mX8EyUeEYg0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305924-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B97C72915A

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

By setting ENI bit, noise immunity is improved and it is
specifically meant for PLCA enabled nodes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No changes
changes in v4
  - No changes
changes in v3
  - Moved as a separate patch
---
 drivers/net/phy/ncn26000.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index 2c8601c3f94a..c3a34b2c524d 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -36,6 +36,10 @@
 
 #define TO_TMR_DEFAULT			32
 
+#define NCN26000_REG_PHYCFG1		0x8001
+#define NCN26000_PHYCFG1_ENI		BIT(7)
+#define NCN26000_PHYCFG1_ENI_MASK	BIT(7)
+
 static int ncn26000_config_init(struct phy_device *phydev)
 {
 	int ret = 0;
@@ -106,6 +110,24 @@ static int ncn26000_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+/* Intercept PLCA enable/disable request to
+ * set the proprietary, ENI mode accordingly
+ */
+static int ncn26000_c45_plca_set_cfg(struct phy_device *phydev,
+				     const struct phy_plca_cfg *plca_cfg)
+{
+	int ret = genphy_c45_plca_set_cfg(phydev, plca_cfg);
+	u16 eni_cfg = 0;
+
+	if (ret || plca_cfg->enabled < 0)
+		return ret;
+
+	eni_cfg = (plca_cfg->enabled) ? NCN26000_PHYCFG1_ENI : 0;
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			      NCN26000_REG_PHYCFG1,
+			      NCN26000_PHYCFG1_ENI_MASK, eni_cfg);
+}
+
 static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 {
 	int ret;
@@ -156,7 +178,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.config_aneg           = ncn26000_config_aneg,
 		.read_status           = ncn26000_read_status,
 		.handle_interrupt      = ncn26000_handle_interrupt,
-		.set_plca_cfg          = genphy_c45_plca_set_cfg,
+		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
 		.get_plca_cfg          = genphy_c45_plca_get_cfg,
 		.get_plca_status       = genphy_c45_plca_get_status,
 		.soft_reset            = genphy_soft_reset,
@@ -177,7 +199,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.read_status		= ncn26000_read_status,
 		.handle_interrupt       = ncn26000_handle_interrupt,
 		.get_plca_cfg		= genphy_c45_plca_get_cfg,
-		.set_plca_cfg		= genphy_c45_plca_set_cfg,
+		.set_plca_cfg		= ncn26000_c45_plca_set_cfg,
 		.get_plca_status	= genphy_c45_plca_get_status,
 		.soft_reset             = genphy_soft_reset,
 	},

-- 
2.43.0



