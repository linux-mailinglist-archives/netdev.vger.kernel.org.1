Return-Path: <netdev+bounces-302730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nU1eFyurQmrr/QkAu9opvQ
	(envelope-from <netdev+bounces-302730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:28:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE26DDB9D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:28:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=htvSUxew;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302730-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302730-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB4EA309DCFC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4D447887A;
	Mon, 29 Jun 2026 17:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DD46AF06;
	Mon, 29 Jun 2026 17:23:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753836; cv=none; b=oC7BpcEU87zs57T88jTbEMsrMF+23qf8xHgpvRONDwj5RZauMkDOzxysHdlQFCOoWGA989zT60Oe2Q6oqvBQV4VjgA/VdlCoWbKu+sZFpD7wFrHWYTrJ1haHa7KwIaorNDMmtUkY0k4cMBhmpkB5iYoFUufpZzhJdMFJCJUNuqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753836; c=relaxed/simple;
	bh=xr+1MTEsHtupxHIorHt6YA/WSwTphSl6baEnc7npzyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BtN1VDOCof1UBY2lHUx94jOY885RywUCD7ZHyrygfHBFBBy81U2/kOGyUnrf4W/kAWtksnYJ9MxjOXtBn9mTgCn958ibQXqQ6XB8dNbiQcKmUJg5kwL5sRq5PSNiEHpXoBSbXOBhmawSrWktmSPJ40c8uyXG+ssrF/4EwGT6iRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htvSUxew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09CE6C32781;
	Mon, 29 Jun 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782753836;
	bh=xr+1MTEsHtupxHIorHt6YA/WSwTphSl6baEnc7npzyA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=htvSUxewUPJXjsISEAPctJabwwXE/Cf7b0YEdTrQ2QMjNA8LrqzOFmssMtkmIhoGB
	 zFlY0+Rx0c2x/Uen7LGgADx+EePuo3mV18K4ohDGABIAK/an4ZW8JCaYG64yThyIKA
	 DC61IebR1+PraohxEGz3GFRZ1OS6BTj5yRHlBvyF0+mMWM4h8lXeNWH/dppYrCDzPt
	 YhkC/Ec92c4z8trpLCyUL/82VRUoWv1DMwH8TkVF5Yir3Qw1D77RrflQpAj2WroPtm
	 aRESgFwHaua/rOy8YgCpzP3lpOtJFDdEvYVAnSJCoRRowTpZiWbRUiWEvzFhyGIWCO
	 Dg9QOdSZ6V1lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0141DC43327;
	Mon, 29 Jun 2026 17:23:56 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 29 Jun 2026 10:23:38 -0700
Subject: [PATCH net-next v6 08/15] net: ethernet: oa_tc6: read, write
 interface with MMS option
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-s2500-mac-phy-support-v6-8-18ce79500371@onsemi.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
In-Reply-To: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753817; l=13366;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=DqRvoYJeVGLyi9f/FhCxD6qe+rDtRMGt3PLeqzNPoNQ=;
 b=7bkf99qdUa78xR6wgJ/VJqO2Jwsv8jLiELJnjHrP35u63sFv+yN9PPEFf/NT2nba6huxK7WqW
 1JPNi9n4Q1VAZPG6R0FnN9i1JFJj3pIcNk2JBOiorMeeE17GSuMNlA9
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302730-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:replyto,onsemi.com:email,onsemi.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8EE26DDB9D

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Vendors are allowed to use any memory map selector that
is between 10 and 15.

Current read/write API interface expects register address with
the value of MMS (memory map selector) embedded in it.

This requires vendors to encoding the address whenever the call
to read/write register is made. To avoid this extra step, and
to bring consistency in usage of the API by different vendors,
new APIs have been added to write and read registers with
MMS as one of the parameters.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - New API added to take MMS as a parameter to avoid need for
    read/write calls to encode MMS to the address.
  - first patch
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 61 +++++++++------
 drivers/net/ethernet/oa_tc6/oa_tc6.c             | 97 +++++++++++++++++++++---
 include/linux/oa_tc6.h                           |  8 ++
 3 files changed, 131 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 0277d9737369..3b555ee69804 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -13,27 +13,27 @@
 #define DRV_NAME			"lan8650"
 
 /* MAC Network Control Register */
-#define LAN865X_REG_MAC_NET_CTL		0x00010000
+#define LAN865X_REG_MAC_NET_CTL		0x0
 #define MAC_NET_CTL_TXEN		BIT(3) /* Transmit Enable */
 #define MAC_NET_CTL_RXEN		BIT(2) /* Receive Enable */
 
 /* MAC Network Configuration Reg */
-#define LAN865X_REG_MAC_NET_CFG		0x00010001
+#define LAN865X_REG_MAC_NET_CFG		0x1
 #define MAC_NET_CFG_PROMISCUOUS_MODE	BIT(4)
 #define MAC_NET_CFG_MULTICAST_MODE	BIT(6)
 #define MAC_NET_CFG_UNICAST_MODE	BIT(7)
 
 /* MAC Hash Register Bottom */
-#define LAN865X_REG_MAC_L_HASH		0x00010020
+#define LAN865X_REG_MAC_L_HASH		0x20
 /* MAC Hash Register Top */
-#define LAN865X_REG_MAC_H_HASH		0x00010021
+#define LAN865X_REG_MAC_H_HASH		0x21
 /* MAC Specific Addr 1 Bottom Reg */
-#define LAN865X_REG_MAC_L_SADDR1	0x00010022
+#define LAN865X_REG_MAC_L_SADDR1	0x22
 /* MAC Specific Addr 1 Top Reg */
-#define LAN865X_REG_MAC_H_SADDR1	0x00010023
+#define LAN865X_REG_MAC_H_SADDR1	0x23
 
 /* MAC TSU Timer Increment Register */
-#define LAN865X_REG_MAC_TSU_TIMER_INCR		0x00010077
+#define LAN865X_REG_MAC_TSU_TIMER_INCR		0x77
 #define MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS	0x0028
 
 struct lan865x_priv {
@@ -49,7 +49,8 @@ static int lan865x_set_hw_macaddr_low_bytes(struct oa_tc6 *tc6, const u8 *mac)
 
 	regval = (mac[3] << 24) | (mac[2] << 16) | (mac[1] << 8) | mac[0];
 
-	return oa_tc6_write_register(tc6, LAN865X_REG_MAC_L_SADDR1, regval);
+	return oa_tc6_write_register_mms(tc6, LAN865X_REG_MAC_L_SADDR1,
+					 OA_TC6_PHY_C45_MAC_MMS1, regval);
 }
 
 static int lan865x_set_hw_macaddr(struct lan865x_priv *priv, const u8 *mac)
@@ -65,8 +66,8 @@ static int lan865x_set_hw_macaddr(struct lan865x_priv *priv, const u8 *mac)
 
 	/* Prepare and configure MAC address high bytes */
 	regval = (mac[5] << 8) | mac[4];
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_SADDR1,
-				    regval);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_H_SADDR1,
+					OA_TC6_PHY_C45_MAC_MMS1, regval);
 	if (!ret)
 		return 0;
 
@@ -146,14 +147,16 @@ static int lan865x_set_specific_multicast_addr(struct lan865x_priv *priv)
 	}
 
 	/* Enabling specific multicast addresses */
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, hash_hi);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_H_HASH,
+					OA_TC6_PHY_C45_MAC_MMS1, hash_hi);
 	if (ret) {
 		netdev_err(priv->netdev, "Failed to write reg_hashh: %d\n",
 			   ret);
 		return ret;
 	}
 
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, hash_lo);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_L_HASH,
+					OA_TC6_PHY_C45_MAC_MMS1, hash_lo);
 	if (ret)
 		netdev_err(priv->netdev, "Failed to write reg_hashl: %d\n",
 			   ret);
@@ -166,16 +169,16 @@ static int lan865x_set_all_multicast_addr(struct lan865x_priv *priv)
 	int ret;
 
 	/* Enabling all multicast addresses */
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH,
-				    0xffffffff);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_H_HASH,
+					OA_TC6_PHY_C45_MAC_MMS1, 0xffffffff);
 	if (ret) {
 		netdev_err(priv->netdev, "Failed to write reg_hashh: %d\n",
 			   ret);
 		return ret;
 	}
 
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH,
-				    0xffffffff);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_L_HASH,
+					OA_TC6_PHY_C45_MAC_MMS1, 0xffffffff);
 	if (ret)
 		netdev_err(priv->netdev, "Failed to write reg_hashl: %d\n",
 			   ret);
@@ -187,14 +190,16 @@ static int lan865x_clear_all_multicast_addr(struct lan865x_priv *priv)
 {
 	int ret;
 
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_H_HASH, 0);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_H_HASH,
+					OA_TC6_PHY_C45_MAC_MMS1, 0);
 	if (ret) {
 		netdev_err(priv->netdev, "Failed to write reg_hashh: %d\n",
 			   ret);
 		return ret;
 	}
 
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_L_HASH, 0);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_L_HASH,
+					OA_TC6_PHY_C45_MAC_MMS1, 0);
 	if (ret)
 		netdev_err(priv->netdev, "Failed to write reg_hashl: %d\n",
 			   ret);
@@ -235,7 +240,8 @@ static void lan865x_multicast_work_handler(struct work_struct *work)
 		if (lan865x_clear_all_multicast_addr(priv))
 			return;
 	}
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CFG, regval);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_NET_CFG,
+					OA_TC6_PHY_C45_MAC_MMS1, regval);
 	if (ret)
 		netdev_err(priv->netdev, "Failed to enable promiscuous/multicast/normal mode: %d\n",
 			   ret);
@@ -260,12 +266,14 @@ static int lan865x_hw_disable(struct lan865x_priv *priv)
 {
 	u32 regval;
 
-	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+	if (oa_tc6_read_register_mms(priv->tc6, LAN865X_REG_MAC_NET_CTL,
+				     OA_TC6_PHY_C45_MAC_MMS1, &regval))
 		return -ENODEV;
 
 	regval &= ~(MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN);
 
-	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+	if (oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_NET_CTL,
+				      OA_TC6_PHY_C45_MAC_MMS1, regval))
 		return -ENODEV;
 
 	return 0;
@@ -291,12 +299,14 @@ static int lan865x_hw_enable(struct lan865x_priv *priv)
 {
 	u32 regval;
 
-	if (oa_tc6_read_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, &regval))
+	if (oa_tc6_read_register_mms(priv->tc6, LAN865X_REG_MAC_NET_CTL,
+				     OA_TC6_PHY_C45_MAC_MMS1, &regval))
 		return -ENODEV;
 
 	regval |= MAC_NET_CTL_TXEN | MAC_NET_CTL_RXEN;
 
-	if (oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_NET_CTL, regval))
+	if (oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_NET_CTL,
+				      OA_TC6_PHY_C45_MAC_MMS1, regval))
 		return -ENODEV;
 
 	return 0;
@@ -359,8 +369,9 @@ static int lan865x_probe(struct spi_device *spi)
 	 * stamping at the end of the Start of Frame Delimiter (SFD) and set the
 	 * Timer Increment reg to 40 ns to be used as a 25 MHz internal clock.
 	 */
-	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_TSU_TIMER_INCR,
-				    MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS);
+	ret = oa_tc6_write_register_mms(priv->tc6, LAN865X_REG_MAC_TSU_TIMER_INCR,
+					OA_TC6_PHY_C45_MAC_MMS1,
+					MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to config TSU Timer Incr reg: %d\n",
 			ret);
diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
index 0b8e29bbd703..818eb28c1b2d 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -383,6 +383,83 @@ int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_read_register);
 
+/**
+ * oa_tc6_read_registers_mms - function for reading multiple consecutive
+ * registers for the given address, memory map selector pair.
+ * @tc6: oa_tc6 struct.
+ * @address: address of the first register to be read in the MAC-PHY.
+ * @mms: Memory map selector for the registers to be read.
+ * @value: values to be read from the starting register address @address.
+ * @length: number of consecutive registers to be read from @address.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_read_registers_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			      u32 value[], u8 length)
+{
+	u32 mms_addr = (u32)mms << 16 | (u32)address;
+
+	return oa_tc6_read_registers(tc6, mms_addr, value, length);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_read_registers_mms);
+
+/**
+ * oa_tc6_read_register_mms - function for reading a MAC-PHY register
+ * for the given address, memory map selector pair.
+ * @tc6: oa_tc6 struct.
+ * @address: register address of the MAC-PHY to be read.
+ * @mms: Memory Map Selector for the given address
+ * @value: value read from the @address register address of the MAC-PHY.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_read_register_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			     u32 *value)
+{
+	return oa_tc6_read_registers_mms(tc6, address, mms, value, 1);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_read_register_mms);
+
+/**
+ * oa_tc6_write_registers_mms - function for writing multiple consecutive
+ * registers for the given address, memory map selector pair.
+ * @tc6: oa_tc6 struct.
+ * @address: address of the first register to be written in the MAC-PHY.
+ * @mms: memory map Selector for the given register.
+ * @value: values to be written from the starting register address @address.
+ * @length: number of consecutive registers to be written from @address.
+ *
+ * Maximum of 128 consecutive registers can be written starting at @address.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_write_registers_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			       u32 value[], u8 length)
+{
+	u32 mms_addr = (u32)mms << 16 | (u32)address;
+
+	return oa_tc6_write_registers(tc6, mms_addr, value, length);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_write_registers_mms);
+
+/**
+ * oa_tc6_write_register_mms - function for writing a MAC-PHY register
+ * associated with the given memory map selector.
+ * @tc6: oa_tc6 struct.
+ * @address: register address of the MAC-PHY to be written.
+ * @mms: memory map selector for the given register.
+ * @value: value to be written in the @address register address of
+ * the MAC-PHY.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_write_register_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			      u32 value)
+{
+	return oa_tc6_write_registers_mms(tc6, address, mms, &value, 1);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_write_register_mms);
+
 /**
  * oa_tc6_write_registers - function for writing multiple consecutive registers.
  * @tc6: oa_tc6 struct.
@@ -496,14 +573,14 @@ static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 				   int regnum)
 {
 	struct oa_tc6 *tc6 = bus->priv;
+	int mms, ret;
 	u32 regval;
-	int ret;
 
-	ret = oa_tc6_get_phy_c45_mms(tc6, devnum);
-	if (ret < 0)
-		return ret;
+	mms = oa_tc6_get_phy_c45_mms(tc6, devnum);
+	if (mms < 0)
+		return mms;
 
-	ret = oa_tc6_read_register(tc6, (ret << 16) | regnum, &regval);
+	ret = oa_tc6_read_register_mms(tc6, (u16)regnum, (u16)mms, &regval);
 	if (ret)
 		return ret;
 
@@ -514,13 +591,13 @@ static int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 				    int regnum, u16 val)
 {
 	struct oa_tc6 *tc6 = bus->priv;
-	int ret;
+	int mms;
 
-	ret = oa_tc6_get_phy_c45_mms(tc6, devnum);
-	if (ret < 0)
-		return ret;
+	mms = oa_tc6_get_phy_c45_mms(tc6, devnum);
+	if (mms < 0)
+		return mms;
 
-	return oa_tc6_write_register(tc6, (ret << 16) | regnum, val);
+	return oa_tc6_write_register_mms(tc6, (u16)regnum, (u16)mms, val);
 }
 
 static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index a89151267713..3d50971f0f5b 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -37,6 +37,14 @@ int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
 int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
+int oa_tc6_write_registers_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			       u32 value[], u8 length);
+int oa_tc6_write_register_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			      u32 value);
+int oa_tc6_read_registers_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			      u32 value[], u8 length);
+int oa_tc6_read_register_mms(struct oa_tc6 *tc6, u16 address, u16 mms,
+			     u32 *value);
 int oa_tc6_ptp_register(struct oa_tc6 *tc6, struct ptp_clock_info *info);
 int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int cmd);
 int oa_tc6_get_ts_info(struct oa_tc6 *tc6,

-- 
2.43.0



