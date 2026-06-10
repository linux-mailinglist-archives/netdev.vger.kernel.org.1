Return-Path: <netdev+bounces-297542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b7ObFmYmKWo+RgMAu9opvQ
	(envelope-from <netdev+bounces-297542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F666779B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:55:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=KH8xshjE;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=GG9Rz5ne;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297542-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1CBC3044A4F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA993BA23A;
	Wed, 10 Jun 2026 08:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-1.smtp-out.amazonses.com (a9-1.smtp-out.amazonses.com [54.240.9.1])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD823B95FA;
	Wed, 10 Jun 2026 08:41:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080900; cv=none; b=GrCkBzA7GU7LY5GLCIY8hBWqg/VvfkKnKiVAdDZ0DHK+yIxFbs6TRHo40o8LA1ExAXuI+w5uHkxTSFR4iMCiEO+momRSYW+PRif6bnttqbAUWbFpvjuagXsrNXdtjmr+8gax0WgZRpi5fDM6F14hNHWffXz2qOm4YblMrgMbGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080900; c=relaxed/simple;
	bh=7yuc/FpS9HHAsZARRPbD7CJiSakoOtCY52IpvBIwkyU=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=tLNFHPfcwaqDyPzZLufdlwkpzErVmp49WoONCf77yiER7LT4yA66wK+FbzJ1ubmDGchq1scTGg7ta4eVjwqpZgZHJSBGNOK4Jg2HW6OCvrW4lVjajFUcKKfc8j5MgOjlqXSwzzuIwZ8NvZ0CCFEIvjPA4T3yCyPBu6mwX6Vr4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=KH8xshjE; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=GG9Rz5ne; arc=none smtp.client-ip=54.240.9.1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781080898;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=7yuc/FpS9HHAsZARRPbD7CJiSakoOtCY52IpvBIwkyU=;
	b=KH8xshjE8FO86PoewiOTZa4439cWim6BQX18RIf+LH9wmOTSlAa38yM3Ao2ssrUl
	uO6gpdoUK9aCjssiJdXr83Q8iQP43ysPdkB4X3xMk+HgAI7OumMEo4Ttl1VFXHxKY1O
	w2AB2LphhcF/E0JHG/3pIzPkOId4sG7JoA1gKVSg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781080898;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=7yuc/FpS9HHAsZARRPbD7CJiSakoOtCY52IpvBIwkyU=;
	b=GG9Rz5ne0apdgUEbpF5vtjYaYcrmrSkiYzt1pzX8ITEDz02zz4QSiuMl55cv5w21
	/rS+B9JpmqUqN/rg5o5prVUXLg8Ho6Wu6iywB8qDb+tZ+GOALQLXRbbHFLbbPIaFdzZ
	98fKZWCBjodEBKBwHJVeDsLDkyTymqY7ZYiC9Fl8=
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610084120.1100326-1-contact@c127.dev>
References: <20260610084120.1100326-1-contact@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: netdev@vger.kernel.org
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, contact@c127.dev
Subject: [PATCH net-next v2 2/2] net: dsa: realtek: rtl8365mb: add HSGMII
 support for RTL8367S
Message-ID: <0100019eb0b1b8f6-7794876c-5c9a-443b-815d-402c8b19191d-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 08:41:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.10-54.240.9.1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[c127.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297542-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org,c127.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazonses.com:dkim,email.amazonses.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,c127.dev:dkim,c127.dev:email,c127.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B2F666779B

In addition to SGMII, the RTL8367S SerDes also supports HSGMII, which
carries 2.5 Gbps with the same signaling as SGMII at 2.5x clock rate.
The chip info table already declares HSGMII as a supported interface
mode for external interface 1.

Extend the SGMII configuration path to =
handle HSGMII, which phylink
represents as 2500base-x:

 - Use the HSGMII SerDes tuning parameters and external interface mode,
   and mux the SerDes to MAC8 in HSGMII mode. The parameters are again
   lifted from the GPL-licensed Realtek rtl8367c vendor driver.

 - Advertise 2500base-x and MAC_2500FD on ports whose external
   interface supports HSGMII.

 - Accept SPEED_2500 in the force mode =
configuration. The MAC speed
   field has no 2.5 Gbps value: the rate is =
determined by the HSGMII
   SerDes configuration, and the vendor driver =
programs the 1 Gbps
   value here, so do the same.

Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
the SoC over HSGMII.

Signed-off-by: Johan Alvarado <contact@c127.dev>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 61 +++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/=
rtl8365mb.c
index 13ce8e6f1c72..fd8ec8bd6e55 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl=
8365mb.c
@@ -41,7 +41,7 @@
  * matter.
  *
  * NOTE: Currently, only the =
RGMII interface is implemented in this driver. On
- * the RTL8367S, the =
SGMII interface is also supported.
+ * the RTL8367S, the SGMII and HSGMII =
interfaces are also supported.
  *
  * The interrupt line is asserted on =
link UP/DOWN events. The driver creates a
  * custom irqchip to handle this=
 interrupt and demultiplex the events by reading
@@ -521,6 +521,13 @@ =
static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_sgmii[] =3D {
 	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
 };
=20
+/* HSGMII SerDes tuning =
parameters, lifted from the vendor driver sources */
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
@@ -1128,6 +1135,9 @@ static int rtl8365mb_ext_config_sgmii(struct =
realtek_priv *priv, int port,
 {
 	const struct rtl8365mb_extint *extint =
=3D
 		rtl8365mb_get_port_extint(priv, port);
+	const struct =
rtl8365mb_jam_tbl_entry *sds_jam;
+	size_t sds_jam_size;
+	u32 mode;
 	u16 val;
 	int ret;
 	int i;
@@ -1139,6 +1149,16 @@ static int =
rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port,
 	if (extint->id !=3D 1)
 		return -EOPNOTSUPP;
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
 	/* The vendor driver =
clears the line rate bypass for all interface
 	 * modes except TMII.
 	 */
@@ -1148,28 +1168,28 @@ static int rtl8365mb_ext_config_sgmii(struct =
realtek_priv *priv, int port,
 		return ret;
=20
 	/* Tune the SerDes with =
vendor-prescribed parameters */
-	for (i =3D 0; i < =
ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
-		ret =3D =
rtl8365mb_sds_write(priv, 0,
-					  rtl8365mb_sds_jam_sgmii[i].reg,
-					  rtl8365mb_sds_jam_sgmii[i].val);
+	for (i =3D 0; i < sds_jam_size; =
i++) {
+		ret =3D rtl8365mb_sds_write(priv, 0, sds_jam[i].reg,
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
 	ret =3D regmap_update_bits(
 		priv->map, =
RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
 		RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
-		RTL8365MB_EXT_PORT_MODE_SGMII
-			<< RTL8365MB_DIGITAL_INTERFACE_SELECT_=
MODE_OFFSET(
-				   extint->id));
+		mode << RTL8365MB_DIGITAL_INTERFACE_S=
ELECT_MODE_OFFSET(
+			       extint->id));
 	if (ret)
 		return ret;
=20
@@ -1218,7 +1238,8 @@ static int rtl8365mb_ext_config_sgmii(struct =
realtek_priv *priv, int port,
=20
 static bool rtl8365mb_interface_is_serde=
s(phy_interface_t interface)
 {
-	return interface =3D=3D =
PHY_INTERFACE_MODE_SGMII;
+	return interface =3D=3D =
PHY_INTERFACE_MODE_SGMII ||
+	       interface =3D=3D =
PHY_INTERFACE_MODE_2500BASEX;
 }
=20
 static int rtl8365mb_sds_config_force=
mode(struct realtek_priv *priv, bool link,
@@ -1234,7 +1255,11 @@ static =
int rtl8365mb_sds_config_forcemode(struct realtek_priv *priv, bool link,
 	u32 r_speed;
=20
 	if (link) {
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
@@ -1286,7 +1311,11 @@ static int rtl8365mb_ext_config_forcemode(struct =
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
@@ -1366,6 +1395,12 @@ static void rtl8365mb_phylink_get_caps(struct =
dsa_switch *ds, int port,
 	if (extint->supported_interfaces & =
RTL8365MB_PHY_INTERFACE_MODE_SGMII)
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
+
+	if (extint->supported_interfaces &=
 RTL8365MB_PHY_INTERFACE_MODE_HSGMII) {
+		__set_bit(PHY_INTERFACE_MODE_250=
0BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities =
|=3D MAC_2500FD;
+	}
 }
=20
 static void rtl8365mb_phylink_mac_config(struc=
t phylink_config *config,
--=20
2.54.0


