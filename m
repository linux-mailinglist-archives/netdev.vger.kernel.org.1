Return-Path: <netdev+bounces-306925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UF5EGskYU2pxXAMAu9opvQ
	(envelope-from <netdev+bounces-306925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 06:32:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1DC743E11
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 06:32:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ZnqEtRKQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306925-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306925-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AE923004635
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 04:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835936AB5E;
	Sun, 12 Jul 2026 04:32:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDD21CA13;
	Sun, 12 Jul 2026 04:32:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783830720; cv=none; b=eX0x+dtn4s7qOTXCXgNihwEIcNcgM/ikX1H78Rg9SgfiSQOyweOZ6dkczr1f/p1Mq64v9L5XQCr+c5NXEn1I/AgHUTKyFHGQ2JX9AGxvOLgXokmXWSAxb4C7x9vQn6Qwl7pb3gJEIK/F/gGvBcqti56JOLz6KMzIyCqyXrLnL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783830720; c=relaxed/simple;
	bh=WaYoO+vJprdn7jwuwbQ87IhVIoxfv4yavG+6FNMYwu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1lkF6508rRW6kfVpy+2cdQtcXa0oOb4ueipxq77VR2U/tscZ0vze7FTdsgPy9ZVZT6vZnCc56O+M5dqS78NWLPtOfB3Ine1Acgd70R+lLuIX0mxrqr6as4FhDHoEx2sNVIpEHA2in04NeBL15Tt0wWuq1ESWs7S4kNa+pUkLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnqEtRKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 304ECC2BCF6;
	Sun, 12 Jul 2026 04:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783830720;
	bh=WaYoO+vJprdn7jwuwbQ87IhVIoxfv4yavG+6FNMYwu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZnqEtRKQxWBlnHgkwtF8gXb8qXCz0uAFYNjrN5toemZNMJJ7xeQb8zAyQ4G4UPJOE
	 pUl9M7veUjjzmNr8UhDY2xHdHd6uZd6m45wCiLnqx1WIFRoojGJ04NStjF4RCwMzHh
	 N7/gjmOF0cWv/BC+cHixwTcBEoUuSpvFVjCb1Jf5FrjOkGUYTJVkphrfMHvvlHzN1Z
	 iKJnlfiHSWO194wKRM1Ua0Y4CdirRnz7cpTdCLXr9datHra3uXmB4JFvOgHiUNXZ4H
	 /5WMQPR5Wuf7+wuWZ7/sQkl1rY6uXdSdmXtYGr7PwncTGg+5o3UPeOULJAgRm0jPgX
	 pzo3geA+rxeng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259CC44501;
	Sun, 12 Jul 2026 04:32:00 +0000 (UTC)
From: Johan Alvarado via B4 Relay <devnull+contact.c127.dev@kernel.org>
Date: Sat, 11 Jul 2026 23:31:59 -0500
Subject: [PATCH net-next v6 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-rtl8367s-sgmii-v6-2-88f7944ddca7@c127.dev>
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
In-Reply-To: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Alvarado <contact@c127.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783830718; l=12025;
 i=contact@c127.dev; s=20260711; h=from:subject:message-id;
 bh=fQ/7P44a2m5seFbJb9U+JQqIYjSFtFw2dsWF7H6I0eg=;
 b=/FMhqvp0bEu6u3Xpc1DaIDL1PTDjCNeZEsoCsy6JskTyd8j/Fy64+pJn/MbYj9ttLRX0MwNSV
 TCCDI/8ZGn4DGb47Itir7i4Y5bhg5eo7JcQvtvvpuM+OXQikbaYFcU/
X-Developer-Key: i=contact@c127.dev; a=ed25519;
 pk=ZgvIq3VMEZWi50hs8D+jx3cP3dPdBRYrZZyKEosLfBQ=
X-Endpoint-Received: by B4 Relay for contact@c127.dev/20260711 with
 auth_id=864
X-Original-From: Johan Alvarado <contact@c127.dev>
Reply-To: contact@c127.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:namiltd@yahoo.com,m:maxime.chevallier@bootlin.com,m:luizluca@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306925-lists,netdev=lfdr.de,contact.c127.dev];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[yahoo.com,bootlin.com,gmail.com,vger.kernel.org,c127.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[contact@c127.dev];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D1DC743E11

From: Johan Alvarado <contact@c127.dev>

In addition to SGMII, the RTL8367S SerDes also supports HSGMII, which
carries 2.5 Gbps with the same signaling as SGMII at 2.5x clock rate.
The chip info table already declares HSGMII as a supported interface
mode for external interface 1.

Extend the SerDes PCS to handle HSGMII, which phylink represents as
2500base-x:

 - Select the HSGMII SerDes tuning parameters and external interface
   mode, and mux the SerDes to MAC8 in HSGMII mode, from pcs_config()
   according to the interface. The parameters are again lifted from the
   GPL-licensed Realtek rtl8367c vendor driver, and again only cover
   the tuning variant for a non-zero chip option, so the mode is gated
   on the option probed at setup.

 - Advertise 2500base-x and MAC_2500FD on ports whose external
   interface supports HSGMII.

 - Accept SPEED_2500 in the forced link configuration. The MAC speed
   field has no 2.5 Gbps value: the rate is determined by the HSGMII
   SerDes configuration, and the vendor driver programs the 1 Gbps
   value here, so do the same.

 - Raise the port 6 ingress and egress rate limiters to their maximum
   at setup time, as the vendor switch init does unconditionally for
   the whole chip family. The chip resets them to 0x1FFFF (~1.048 Gbps
   in units of 8 Kbps), which caps the aggregate HSGMII throughput at
   roughly 1 Gbps. The vendor documentation describes the reset
   default as disabling the limiter, but the cap is real: on an
   RTL8367S-based Mercusys MR85X running an OpenWrt backport of this
   series, several clients on 1 Gbps user ports were limited to about
   1.02 Gbps combined across the HSGMII CPU port until these limiters
   were raised, after which throughput reached about 2 Gbps [1]. The
   related HSGMII scheduler line rate (LINE_RATE_HSG_H) is already set
   to its maximum by the common init jam table.

Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
the SoC over HSGMII.

Link: https://github.com/openwrt/openwrt/pull/19445#issuecomment-4505613294 [1]
Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 134 +++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index ea03c42d0f1a..d1ba0cc9426f 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -40,8 +40,8 @@
  * driver has only been tested with a fixed-link, but in principle it should not
  * matter.
  *
- * NOTE: Currently, only the RGMII and SGMII interfaces are implemented in this
- * driver.
+ * NOTE: Currently, only the RGMII, SGMII and HSGMII interfaces are implemented
+ * in this driver.
  *
  * The interrupt line is asserted on link UP/DOWN events. The driver creates a
  * custom irqchip to handle this interrupt and demultiplex the events by reading
@@ -251,6 +251,18 @@
 #define RTL8365MB_BYPASS_LINE_RATE_REG		0x03F7
 #define RTL8365MB_BYPASS_LINE_RATE_MASK(_port)	BIT((_port) - 5)
 
+/* Port 6 ingress and egress rate limiter registers. Each limit is a 19-bit
+ * value in units of 8 Kbps, split across a 16-bit LSB register (CTRL0) and a
+ * 3-bit MSB field (CTRL1). The chip resets them to 0x1FFFF; see
+ * rtl8365mb_sds_raise_rate_limits().
+ */
+#define RTL8365MB_INGRESSBW_PORT6_RATE_CTRL0_REG	0x00CF
+#define RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_REG	0x00D0
+#define   RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_MASK	0x0007
+#define RTL8365MB_PORT6_EGRESSBW_CTRL0_REG		0x0398
+#define RTL8365MB_PORT6_EGRESSBW_CTRL1_REG		0x0399
+#define   RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK		0x0007
+
 /* SerDes indirect access registers */
 #define RTL8365MB_SDS_INDACS_CMD_REG		0x6600
 #define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	0x0100
@@ -637,6 +649,18 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_sgmii[] = {
 	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
 };
 
+/* HSGMII SerDes tuning parameters, lifted from the vendor driver sources. As
+ * with the SGMII table, the vendor driver keeps several variants and selects
+ * one based on the chip option register; these are the values for a non-zero
+ * option, which is what RTL8367S parts seen so far report. See
+ * rtl8365mb_sds_probe_option().
+ */
+static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] = {
+	{ 0x0500, 0x82F0 }, { 0x0501, 0xF195 }, { 0x0502, 0x31A2 },
+	{ 0x0503, 0x7960 }, { 0x0504, 0x9728 }, { 0x0423, 0x9D85 },
+	{ 0x0424, 0xD810 }, { 0x0001, 0x0F80 }, { 0x002E, 0x83F2 },
+};
+
 enum rtl8365mb_phy_interface_mode {
 	RTL8365MB_PHY_INTERFACE_MODE_INVAL = 0,
 	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL = BIT(0),
@@ -1242,20 +1266,70 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
 	return 0;
 }
 
+/* The vendor driver raises the port 6 ingress and egress rate limiters to
+ * their maximum in its switch init, unconditionally for the whole chip
+ * family. The chip reset in rtl8365mb_setup() puts them back to their reset
+ * default of 0x1FFFF, a ~1.048 Gbps limit which caps the aggregate
+ * throughput of an HSGMII CPU port at roughly 1 Gbps. The vendor
+ * documentation describes the reset default as disabling the limiter, but
+ * the cap has been observed on hardware. Raise them likewise, to 0x7FFFF
+ * (~4.19 Gbps, above the HSGMII line rate). The related HSGMII scheduler
+ * line rate register (LINE_RATE_HSG_H, 0x03FA) is already set to its
+ * maximum by the common init jam table.
+ */
+static int rtl8365mb_sds_raise_rate_limits(struct realtek_priv *priv)
+{
+	int ret;
+
+	ret = regmap_write(priv->map, RTL8365MB_INGRESSBW_PORT6_RATE_CTRL0_REG,
+			   0xFFFF);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_REG,
+				 RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_MASK,
+				 RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->map, RTL8365MB_PORT6_EGRESSBW_CTRL0_REG,
+			   0xFFFF);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->map, RTL8365MB_PORT6_EGRESSBW_CTRL1_REG,
+				  RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK,
+				  RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK);
+}
+
 static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				phy_interface_t interface,
 				const unsigned long *advertising,
 				bool permit_pause_to_mac)
 {
+	const struct rtl8365mb_jam_tbl_entry *sds_jam;
 	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;
 	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
 	struct realtek_priv *priv;
+	size_t sds_jam_size;
+	u32 mode;
 	u16 val;
 	int ret;
 	int i;
 
 	priv = mb->priv;
 
+	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
+		sds_jam = rtl8365mb_sds_jam_hsgmii;
+		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
+		mode = RTL8365MB_EXT_PORT_MODE_HSGMII;
+	} else {
+		sds_jam = rtl8365mb_sds_jam_sgmii;
+		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_sgmii);
+		mode = RTL8365MB_EXT_PORT_MODE_SGMII;
+	}
+
 	/* Hold the embedded DW8051 microcontroller in reset and keep it
 	 * disabled. The vendor driver loads firmware into it to manage the
 	 * SerDes link, but the firmware only duplicates work that phylink
@@ -1283,24 +1357,24 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		return ret;
 
 	/* Tune the SerDes with vendor-prescribed parameters */
-	for (i = 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
-		ret = rtl8365mb_sds_write(priv,
-					  rtl8365mb_sds_jam_sgmii[i].reg,
-					  rtl8365mb_sds_jam_sgmii[i].val);
+	for (i = 0; i < sds_jam_size; i++) {
+		ret = rtl8365mb_sds_write(priv, sds_jam[i].reg,
+					  sds_jam[i].val);
 		if (ret)
 			return ret;
 	}
 
-	/* Mux the SerDes to MAC8 in SGMII mode */
+	/* Mux the SerDes to MAC8 in the requested mode */
 	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
 				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
 					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
-				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK);
+				 mode == RTL8365MB_EXT_PORT_MODE_SGMII ?
+					 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK :
+					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK);
 	if (ret)
 		return ret;
 
-	val = RTL8365MB_EXT_PORT_MODE_SGMII
-	      << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
+	val = mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 	ret = regmap_update_bits(priv->map,
 				 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
 				 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
@@ -1346,7 +1420,8 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
 {
-	return interface == PHY_INTERFACE_MODE_SGMII;
+	return interface == PHY_INTERFACE_MODE_SGMII ||
+	       interface == PHY_INTERFACE_MODE_2500BASEX;
 }
 
 static unsigned int rtl8365mb_pcs_inband_caps(struct phylink_pcs *pcs,
@@ -1401,7 +1476,9 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 
 	switch (FIELD_GET(RTL8365MB_SDS_MISC_SGMII_SPD_MASK, val)) {
 	case RTL8365MB_PORT_SPEED_1000M:
-		state->speed = SPEED_1000;
+		state->speed =
+			state->interface == PHY_INTERFACE_MODE_2500BASEX ?
+				SPEED_2500 : SPEED_1000;
 		break;
 	case RTL8365MB_PORT_SPEED_100M:
 		state->speed = SPEED_100;
@@ -1426,7 +1503,11 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	u32 r_speed;
 	int ret;
 
-	if (speed == SPEED_1000) {
+	/* The speed field has no value for 2.5 Gbps: the rate is determined by
+	 * the HSGMII SerDes configuration, and the vendor driver programs the
+	 * 1 Gbps value here.
+	 */
+	if (speed == SPEED_2500 || speed == SPEED_1000) {
 		r_speed = RTL8365MB_PORT_SPEED_1000M;
 	} else if (speed == SPEED_100) {
 		r_speed = RTL8365MB_PORT_SPEED_100M;
@@ -1486,7 +1567,11 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 		r_rx_pause = rx_pause ? 1 : 0;
 		r_tx_pause = tx_pause ? 1 : 0;
 
-		if (speed == SPEED_1000) {
+		/* The speed field has no value for 2.5 Gbps: the rate is
+		 * determined by the HSGMII SerDes configuration, and the
+		 * vendor driver programs the 1 Gbps value here.
+		 */
+		if (speed == SPEED_2500 || speed == SPEED_1000) {
 			r_speed = RTL8365MB_PORT_SPEED_1000M;
 		} else if (speed == SPEED_100) {
 			r_speed = RTL8365MB_PORT_SPEED_100M;
@@ -1569,6 +1654,13 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 	    mb->sds_supported)
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
+
+	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_HSGMII &&
+	    mb->sds_supported) {
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+	}
 }
 
 static struct phylink_pcs *
@@ -1610,8 +1702,8 @@ static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
 		return;
 	}
 
-	/* SGMII is handled by the SerDes PCS, configured through the
-	 * phylink_pcs ops, so there is nothing to do here for it.
+	/* SGMII and 2500base-x are handled by the SerDes PCS, configured
+	 * through the phylink_pcs ops, so nothing to do here for them.
 	 */
 	if (rtl8365mb_interface_is_serdes(state->interface))
 		return;
@@ -2940,6 +3032,16 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 		goto out_error;
 	}
 
+	if (mb->sds_supported) {
+		ret = rtl8365mb_sds_raise_rate_limits(priv);
+		if (ret) {
+			dev_err(priv->dev,
+				"failed to raise port rate limits: %pe\n",
+				ERR_PTR(ret));
+			goto out_error;
+		}
+	}
+
 	/* Set up cascading IRQs */
 	ret = rtl8365mb_irq_setup(priv);
 	if (ret == -EPROBE_DEFER)

-- 
2.55.0



