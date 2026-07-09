Return-Path: <netdev+bounces-306368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vlCZAjoEUGqkrwIAu9opvQ
	(envelope-from <netdev+bounces-306368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44577735566
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:27:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=vKIM8EkH;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=qMUGXDVP;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306368-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306368-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E12A3037E7F
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1C3A2E0A;
	Thu,  9 Jul 2026 20:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-17.smtp-out.amazonses.com (a9-17.smtp-out.amazonses.com [54.240.9.17])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513A3806CD;
	Thu,  9 Jul 2026 20:26:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628771; cv=none; b=nQS14iiPD3WnXKOJYI7u9hJuWmRs5Frp+ILaLfBc4tw2Z9SVljBWeMe3N1eGPLfYP0YXSj56LgcbvWmOlAOHx0WyC+94Q6c49Yh9gEwlmpGIpWYezxKwOqAwCXbRXJdntKg9WjEwPj4PlBuNyR4HhTQre29YqYs+Mo7/7DiLwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628771; c=relaxed/simple;
	bh=qwFP1auDPRk+rHcQ0AZfOsBkyB2GwtEOPBov2/E+ktU=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=lQ2est7pQeBUwfeSDMQXY7GayKZOdUxKRNeKvLNfgPS2vVOpJrnH52r6YHSzNzBAWTaEZYXXrAtH92coFBJuCYqwR4ThFVyjzCEYMZvbV6f4kQkzS23cdNrUeapd70tUw7SJvJ30766Gz9XK5mQajf4sEYqBG/ksAH6egj1lOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=vKIM8EkH; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=qMUGXDVP; arc=none smtp.client-ip=54.240.9.17
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1783628768;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=qwFP1auDPRk+rHcQ0AZfOsBkyB2GwtEOPBov2/E+ktU=;
	b=vKIM8EkH0oe6FsC/8dOd7pb3Y5GXngWnJjYCs5cfh2FgNwEXe55m/tokSs0y/4I3
	Z40Rj+y/QeErbh/N6lbVcMbfAGkVo7NIWjkNAviTqr2CeWn5xl1e9II2Yn3uaLj7vvo
	o2ZUxjicjarGc6FnzEm8+thuhCrksomRfvGoLqV4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1783628768;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=qwFP1auDPRk+rHcQ0AZfOsBkyB2GwtEOPBov2/E+ktU=;
	b=qMUGXDVP6tC3c5uZUH5wkBZxLhfHzdWowN3fFG0VfQLMr5PsE8WREAa9BV4qAbi0
	3HdMQMCZSIkTzwfCWITM06vQtSk9ZIYy+7ao+WQ4IMNeX57CG8Gjw+eVRcKXp4Cf9Fd
	sk0gR4ZXJzdYDn65rGjTGYiv26hoDpcARPx6887E=
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709202531.17166-1-contact@c127.dev>
References: <20260709202531.17166-1-contact@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk
Cc: luizluca@gmail.com, maxime.chevallier@bootlin.com, namiltd@yahoo.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	contact@c127.dev
Subject: [PATCH net-next v5 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
Message-ID: <0100019f488f22c0-116c36b1-929d-456b-b6b5-b6343a47a301-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 9 Jul 2026 20:26:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.07.09-54.240.9.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:luizluca@gmail.com,m:maxime.chevallier@bootlin.com,m:namiltd@yahoo.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	DMARC_NA(0.00)[c127.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306368-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,yahoo.com,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amazonses.com:dkim,email.amazonses.com:mid,c127.dev:from_mime,c127.dev:email,c127.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44577735566

In addition to SGMII, the RTL8367S SerDes also supports HSGMII, which
carries 2.5 Gbps with the same signaling as SGMII at 2.5x clock rate.
The chip info table already declares HSGMII as a supported interface
mode for external interface 1.

Extend the SerDes PCS to handle HSGMII, =
which phylink represents as
2500base-x:

 - Select the HSGMII SerDes tuning=
 parameters and external interface
   mode, and mux the SerDes to MAC8 in =
HSGMII mode, from pcs_config()
   according to the interface. The =
parameters are again lifted from the
   GPL-licensed Realtek rtl8367c =
vendor driver, and again only cover
   the tuning variant for a non-zero =
chip option, so the mode is gated
   on the option probed at setup.

 - Advertise 2500base-x and MAC_2500FD on ports whose external
   interface supports HSGMII.

 - Accept SPEED_2500 in the forced link =
configuration. The MAC speed
   field has no 2.5 Gbps value: the rate is =
determined by the HSGMII
   SerDes configuration, and the vendor driver =
programs the 1 Gbps
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

Tested on a Mercusys MR80X=
 v2.20, where the RTL8367S is connected to
the SoC over HSGMII.

Link: https://github.com/openwrt/openwrt/pull/19445#issuecomment-4505613294=
 [1]
Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 134 ++++++++++++++++++++---
 1 file changed, 118 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c =
b/drivers/net/dsa/realtek/rtl8365mb_main.c
index ea03c42d0f1a..d1ba0cc9426f=
 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -40,8 +40,8 @@
  * driver has only been tested with a fixed-link, but in principle it =
should not
  * matter.
  *
- * NOTE: Currently, only the RGMII and SGMII =
interfaces are implemented in this
- * driver.
+ * NOTE: Currently, only =
the RGMII, SGMII and HSGMII interfaces are implemented
+ * in this driver.
  *
  * The interrupt line is asserted on link UP/DOWN events. The driver =
creates a
  * custom irqchip to handle this interrupt and demultiplex the =
events by reading
@@ -251,6 +251,18 @@
 #define RTL8365MB_BYPASS_LINE_RATE_=
REG		0x03F7
 #define RTL8365MB_BYPASS_LINE_RATE_MASK(_port)	BIT((_port) - =
5)
=20
+/* Port 6 ingress and egress rate limiter registers. Each limit is =
a 19-bit
+ * value in units of 8 Kbps, split across a 16-bit LSB register =
(CTRL0) and a
+ * 3-bit MSB field (CTRL1). The chip resets them to 0x1FFFF;=
 see
+ * rtl8365mb_sds_raise_rate_limits().
+ */
+#define =
RTL8365MB_INGRESSBW_PORT6_RATE_CTRL0_REG	0x00CF
+#define =
RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_REG	0x00D0
+#define   =
RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_MASK	0x0007
+#define =
RTL8365MB_PORT6_EGRESSBW_CTRL0_REG		0x0398
+#define =
RTL8365MB_PORT6_EGRESSBW_CTRL1_REG		0x0399
+#define   =
RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK		0x0007
+
 /* SerDes indirect access =
registers */
 #define RTL8365MB_SDS_INDACS_CMD_REG		0x6600
 #define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	0x0100
@@ -637,6 +649,18 @@ static const struct rtl8365mb_jam_tbl_entry =
rtl8365mb_sds_jam_sgmii[] =3D {
 	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
 };
=20
+/* HSGMII SerDes tuning parameters, lifted from the vendor driver =
sources. As
+ * with the SGMII table, the vendor driver keeps several =
variants and selects
+ * one based on the chip option register; these are =
the values for a non-zero
+ * option, which is what RTL8367S parts seen so =
far report. See
+ * rtl8365mb_sds_probe_option().
+ */
+static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] =3D=
 {
+	{ 0x0500, 0x82F0 }, { 0x0501, 0xF195 }, { 0x0502, 0x31A2 },
+	{ 0x0503, 0x7960 }, { 0x0504, 0x9728 }, { 0x0423, 0x9D85 },
+	{ 0x0424, 0xD810 }, { 0x0001, 0x0F80 }, { 0x002E, 0x83F2 },
+};
+
 enum rtl8365mb_phy_interface_mode {
 	RTL8365MB_PHY_INTERFACE_MODE_INVAL =
=3D 0,
 	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL =3D BIT(0),
@@ -1242,20 +1266,70 @@ static int rtl8365mb_sds_probe_option(struct =
realtek_priv *priv)
 	return 0;
 }
=20
+/* The vendor driver raises the =
port 6 ingress and egress rate limiters to
+ * their maximum in its switch =
init, unconditionally for the whole chip
+ * family. The chip reset in =
rtl8365mb_setup() puts them back to their reset
+ * default of 0x1FFFF, a =
~1.048 Gbps limit which caps the aggregate
+ * throughput of an HSGMII CPU =
port at roughly 1 Gbps. The vendor
+ * documentation describes the reset =
default as disabling the limiter, but
+ * the cap has been observed on =
hardware. Raise them likewise, to 0x7FFFF
+ * (~4.19 Gbps, above the HSGMII=
 line rate). The related HSGMII scheduler
+ * line rate register =
(LINE_RATE_HSG_H, 0x03FA) is already set to its
+ * maximum by the common =
init jam table.
+ */
+static int rtl8365mb_sds_raise_rate_limits(struct =
realtek_priv *priv)
+{
+	int ret;
+
+	ret =3D regmap_write(priv->map, =
RTL8365MB_INGRESSBW_PORT6_RATE_CTRL0_REG,
+			   0xFFFF);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_update_bits(priv->map,
+				 RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_REG,
+				 =
RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_MASK,
+				 RTL8365MB_INGRESSBW_PORT6_=
RATE_CTRL1_MASK);
+	if (ret)
+		return ret;
+
+	ret =3D =
regmap_write(priv->map, RTL8365MB_PORT6_EGRESSBW_CTRL0_REG,
+			   0xFFFF);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->map, =
RTL8365MB_PORT6_EGRESSBW_CTRL1_REG,
+				  RTL8365MB_PORT6_EGRESSBW_CTRL1_M=
ASK,
+				  RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK);
+}
+
 static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int =
neg_mode,
 				phy_interface_t interface,
 				const unsigned long =
*advertising,
 				bool permit_pause_to_mac)
 {
+	const struct =
rtl8365mb_jam_tbl_entry *sds_jam;
 	const int id =3D =
RTL8365MB_SDS_EXT_INTERFACE_ID;
 	struct rtl8365mb *mb =3D =
pcs_to_rtl8365mb(pcs);
 	struct realtek_priv *priv;
+	size_t sds_jam_size;
+	u32 mode;
 	u16 val;
 	int ret;
 	int i;
=20
 	priv =3D mb->priv;
=20
+	if (interface =3D=3D PHY_INTERFACE_MODE_2500BASEX) {
+		sds_jam =3D rtl8365mb_sds_jam_hsgmii;
+		sds_jam_size =3D =
ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
+		mode =3D RTL8365MB_EXT_PORT_MODE_H=
SGMII;
+	} else {
+		sds_jam =3D rtl8365mb_sds_jam_sgmii;
+		sds_jam_size =3D ARRAY_SIZE(rtl8365mb_sds_jam_sgmii);
+		mode =3D RTL8365MB_EXT_PORT_MODE_SGMII;
+	}
+
 	/* Hold the embedded =
DW8051 microcontroller in reset and keep it
 	 * disabled. The vendor =
driver loads firmware into it to manage the
 	 * SerDes link, but the =
firmware only duplicates work that phylink
@@ -1283,24 +1357,24 @@ static =
int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		return ret;
=20
 	/* Tune the SerDes with vendor-prescribed parameters =
*/
-	for (i =3D 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
-		ret =3D rtl8365mb_sds_write(priv,
-					  rtl8365mb_sds_jam_sgmii[i].reg=
,
-					  rtl8365mb_sds_jam_sgmii[i].val);
+	for (i =3D 0; i < =
sds_jam_size; i++) {
+		ret =3D rtl8365mb_sds_write(priv, sds_jam[i].reg,
+					  sds_jam[i].val);
 		if (ret)
 			return ret;
 	}
=20
-	/* Mux the SerDes to MAC8 in SGMII mode */
+	/* Mux the SerDes to MAC8 in=
 the requested mode */
 	ret =3D regmap_update_bits(priv->map, =
RTL8365MB_SDS_MISC_REG,
 				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
 					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
-				 =
RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK);
+				 mode =3D=3D =
RTL8365MB_EXT_PORT_MODE_SGMII ?
+					 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MA=
SK :
+					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK);
 	if (ret)
 		return ret;
=20
-	val =3D RTL8365MB_EXT_PORT_MODE_SGMII
-	      << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
+	val =3D mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 	ret =3D regmap_update_bits(priv->map,
 				 RTL8365MB_DIGITAL_INTERFACE_S=
ELECT_REG(id),
 				 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
@@ -1346,7 +1420,8 @@ static int rtl8365mb_pcs_config(struct phylink_pcs =
*pcs, unsigned int neg_mode,
=20
 static bool rtl8365mb_interface_is_serdes=
(phy_interface_t interface)
 {
-	return interface =3D=3D =
PHY_INTERFACE_MODE_SGMII;
+	return interface =3D=3D =
PHY_INTERFACE_MODE_SGMII ||
+	       interface =3D=3D =
PHY_INTERFACE_MODE_2500BASEX;
 }
=20
 static unsigned int =
rtl8365mb_pcs_inband_caps(struct phylink_pcs *pcs,
@@ -1401,7 +1476,9 @@ =
static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
=20
 	switch (FIELD_GET(RTL8365MB_SDS_MISC_SGMII_SPD_MASK, val)) {
 	case RTL8365MB_PORT_SPEED_1000M:
-		state->speed =3D SPEED_1000;
+		state->speed =3D
+			state->interface =3D=3D PHY_INTERFACE_MODE_2500BASE=
X ?
+				SPEED_2500 : SPEED_1000;
 		break;
 	case RTL8365MB_PORT_SPEED_100=
M:
 		state->speed =3D SPEED_100;
@@ -1426,7 +1503,11 @@ static void =
rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	u32 r_speed;
 	int ret;
=20
-	if (speed =3D=3D SPEED_1000) {
+	/* The speed field has no value for =
2.5 Gbps: the rate is determined by
+	 * the HSGMII SerDes configuration, =
and the vendor driver programs the
+	 * 1 Gbps value here.
+	 */
+	if (speed =3D=3D SPEED_2500 || speed =3D=3D SPEED_1000) {
 		r_speed =3D RTL8365MB_PORT_SPEED_1000M;
 	} else if (speed =3D=3D =
SPEED_100) {
 		r_speed =3D RTL8365MB_PORT_SPEED_100M;
@@ -1486,7 +1567,11 @@ static int rtl8365mb_ext_config_forcemode(struct =
realtek_priv *priv, int port,
 		r_rx_pause =3D rx_pause ? 1 : 0;
 		r_tx_pause =3D tx_pause ? 1 : 0;
=20
-		if (speed =3D=3D SPEED_1000) {
+		/* The speed field has no value for 2.5 Gbps: the rate is
+		 * determined by the HSGMII SerDes configuration, and the
+		 * vendor driver programs the 1 Gbps value here.
+		 */
+		if (speed =3D=3D SPEED_2500 || speed =3D=3D SPEED_1000) {
 			r_speed =3D RTL8365MB_PORT_SPEED_1000M;
 		} else if (speed =3D=3D =
SPEED_100) {
 			r_speed =3D RTL8365MB_PORT_SPEED_100M;
@@ -1569,6 +1654,13 @@ static void rtl8365mb_phylink_get_caps(struct =
dsa_switch *ds, int port,
 	    mb->sds_supported)
 		=
__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
+
+	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_HSGMII &&
+	    mb->sds_supported) {
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |=3D =
MAC_2500FD;
+	}
 }
=20
 static struct phylink_pcs *
@@ -1610,8 +1702,8 @@ static void rtl8365mb_phylink_mac_config(struct =
phylink_config *config,
 		return;
 	}
=20
-	/* SGMII is handled by the =
SerDes PCS, configured through the
-	 * phylink_pcs ops, so there is =
nothing to do here for it.
+	/* SGMII and 2500base-x are handled by the =
SerDes PCS, configured
+	 * through the phylink_pcs ops, so nothing to do =
here for them.
 	 */
 	if (rtl8365mb_interface_is_serdes(state->interface))
 		return;
@@ -2940,6 +3032,16 @@ static int rtl8365mb_setup(struct =
dsa_switch *ds)
 		goto out_error;
 	}
=20
+	if (mb->sds_supported) {
+		ret =3D rtl8365mb_sds_raise_rate_limits(priv);
+		if (ret) {
+			dev_err(priv->dev,
+				"failed to raise port rate limits: %pe\n",
+				ERR_PTR(ret));
+			goto out_error;
+		}
+	}
+
 	/* Set up cascading =
IRQs */
 	ret =3D rtl8365mb_irq_setup(priv);
 	if (ret =3D=3D =
-EPROBE_DEFER)
--=20
2.55.0


