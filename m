Return-Path: <netdev+bounces-297509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BP+6N6cYKWo/QgMAu9opvQ
	(envelope-from <netdev+bounces-297509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:56:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53969666D41
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:56:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=c127.dev header.s=mail header.b=Nfazk+rg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297509-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297509-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96106304A7BC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB0388E69;
	Wed, 10 Jun 2026 07:54:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from id.d.sender-sib.com (id.d.sender-sib.com [77.32.148.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD353932E0
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:54:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078065; cv=none; b=pQXjEkEG8HEbJj3d/3xEYTABca+BAg88naDr4Hpp2cwvrz/mfq62wOthEu+oUqBqZgAI1a72Yuoi36dKP4W/lbgD7O7rXseOeddfy2U+PjX4u8AEGPkVF5fURrlw9y9P1D7JvfkjQwLqCb1M/wGesf9HmcGcGAiCmJJVobE/x3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078065; c=relaxed/simple;
	bh=slxA15wrpykULaiBwWpbHK/HfgqJtw2hH/MxjN9vFHo=;
	h=Message-Id:To:From:Date:Subject:Cc:References:Mime-Version:
	 In-Reply-To; b=WOlc8nTP6vfwxrmQVA37U3zmNjgXshqKBdS0Hr80GLFkEhPlWZbwewPTfyqJ02nlF3ESUuYQEEvlkwES9tfV6yaxfb1Fq55wY1xAmQ53QlO5Aqe2GxgtfznhZT/v1eb0szbfFIWk3SVVcaqjPfQ9omVVpHMPBmWRCu56pqaLw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=id.d.sender-sib.com; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=Nfazk+rg; arc=none smtp.client-ip=77.32.148.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c127.dev;
 q=dns/txt; s=mail; bh=ew5G/4Zt3N2nEN6JeK7wQjy+KJHqHAI6x17VTwbcKww=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=Nfazk+rgNZwLnjU/agOX63koFEaZw0wWyn5ndsSa3CtfwXx9+oRhOifPZCfrQC5h2CtnML0YYwPn
        kKrOD+F1XvWYYMe7vo49aRMlF9TCuWO6szzcVEPebOVon6/19OpWlzxRRTn3ziYHO7Aik/Q8Fxjb
        VogpsJzV60Fte9poHLs=
Message-Id: <8e70ee0f-5d54-457e-a18f-d5a44dabc85e@smtp-relay.sendinblue.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-CSA-Complaints: csa-complaints@eco.de
To: <netdev@vger.kernel.org>
Origin-messageId: <20260610075241.1069370-3-contact@c127.dev>
Feedback-ID: 77.32.148.56:6940426_-1:6940426:Sendinblue
From: "Johan Alvarado" <contact@c127.dev>
X-Mailin-EID: MjQyODY3MzE0fm5ldGRldkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNjEwMDc1MjQxLjEwNjkzNzAtMy1jb250YWN0QGMxMjcuZGV2Pn5pZC5kLnNlbmRlci1zaWIuY29t
Date: Wed, 10 Jun 2026 02:52:41 -0500
Subject: [PATCH net-next v1 2/2] net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S
X-sib-id: 0NJpQ7MDXNIxVl1gz2l0XkWws6HRE-AdkxhvcFtKR05lobA5wXSKxSYWr7nrCl_S2qcDL9gMF51ujuSd9yVZW6uqaNcSS0uJ1jdSMo5xakYrIrmOYJkhyz4475IyOZk63FWyYzYjzs_KE_oU34IwpP6gorSo0AuF6U5FIc_0XvxyL7Ar
Cc: "Linus Walleij" <linusw@kernel.org>,  Alvin Šipraga <alsi@bang-olufsen.dk>,  "Andrew Lunn" <andrew@lunn.ch>,  "Vladimir Oltean" <olteanv@gmail.com>,  "David S . Miller" <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni" <pabeni@redhat.com>,  "Russell King" <linux@armlinux.org.uk>,  <linux-kernel@vger.kernel.org>,  "Johan Alvarado" <contact@c127.dev>
References: <20260610075241.1069370-1-contact@c127.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610075241.1069370-1-contact@c127.dev>
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	R_DKIM_REJECT(1.00)[c127.dev:s=mail];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[c127.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-297509-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:-];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,c127.dev:from_mime,c127.dev:email,smtp-relay.sendinblue.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53969666D41


In addition to SGMII, the RTL8367S SerDes also supports HSGMII, which
carries 2.5 Gbps with the same signaling as SGMII at 2.5x clock rate.
The chip info table already declares HSGMII as a supported interface
mode for external interface 1.

Extend the SGMII configuration path to handle HSGMII, which phylink
represents as 2500base-x:

 - Use the HSGMII SerDes tuning parameters and external interface mode,
   and mux the SerDes to MAC8 in HSGMII mode. The parameters are again
   lifted from the GPL-licensed Realtek rtl8367c vendor driver.

 - Advertise 2500base-x and MAC_2500FD on ports whose external
   interface supports HSGMII.

 - Accept SPEED_2500 in the force mode configuration. The MAC speed
   field has no 2.5 Gbps value: the rate is determined by the HSGMII
   SerDes configuration, and the vendor driver programs the 1 Gbps
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
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -41,7 +41,7 @@
  * matter.
  *
  * NOTE: Currently, only the RGMII interface is implemented in this driver=
. On
- * the RTL8367S, the SGMII interface is also supported.
+ * the RTL8367S, the SGMII and HSGMII interfaces are also supported.
  *
  * The interrupt line is asserted on link UP/DOWN events. The driver creat=
es a
  * custom irqchip to handle this interrupt and demultiplex the events by r=
eading
@@ -521,6 +521,13 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_=
sds_jam_sgmii[] =3D {
 	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
 };
=20
+/* HSGMII SerDes tuning parameters, lifted from the vendor driver sources =
*/
+static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] =3D=
 {
+	{ 0x0500, 0x82F0 }, { 0x0501, 0xF195 }, { 0x0502, 0x31A2 },
+	{ 0x0503, 0x7960 }, { 0x0504, 0x9728 }, { 0x0423, 0x9D85 },
+	{ 0x0424, 0xD810 }, { 0x0001, 0x0F80 }, { 0x002E, 0x83F2 },
+};
+
 enum rtl8365mb_phy_interface_mode {
 	RTL8365MB_PHY_INTERFACE_MODE_INVAL =3D 0,
 	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL =3D BIT(0),
@@ -1128,6 +1135,9 @@ static int rtl8365mb_ext_config_sgmii(struct realtek_=
priv *priv, int port,
 {
 	const struct rtl8365mb_extint *extint =3D
 		rtl8365mb_get_port_extint(priv, port);
+	const struct rtl8365mb_jam_tbl_entry *sds_jam;
+	size_t sds_jam_size;
+	u32 mode;
 	u16 val;
 	int ret;
 	int i;
@@ -1139,6 +1149,16 @@ static int rtl8365mb_ext_config_sgmii(struct realtek=
_priv *priv, int port,
 	if (extint->id !=3D 1)
 		return -EOPNOTSUPP;
=20
+	if (interface =3D=3D PHY_INTERFACE_MODE_2500BASEX) {
+		sds_jam =3D rtl8365mb_sds_jam_hsgmii;
+		sds_jam_size =3D ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
+		mode =3D RTL8365MB_EXT_PORT_MODE_HSGMII;
+	} else {
+		sds_jam =3D rtl8365mb_sds_jam_sgmii;
+		sds_jam_size =3D ARRAY_SIZE(rtl8365mb_sds_jam_sgmii);
+		mode =3D RTL8365MB_EXT_PORT_MODE_SGMII;
+	}
+
 	/* The vendor driver clears the line rate bypass for all interface
 	 * modes except TMII.
 	 */
@@ -1148,28 +1168,28 @@ static int rtl8365mb_ext_config_sgmii(struct realte=
k_priv *priv, int port,
 		return ret;
=20
 	/* Tune the SerDes with vendor-prescribed parameters */
-	for (i =3D 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
-		ret =3D rtl8365mb_sds_write(priv, 0,
-					  rtl8365mb_sds_jam_sgmii[i].reg,
-					  rtl8365mb_sds_jam_sgmii[i].val);
+	for (i =3D 0; i < sds_jam_size; i++) {
+		ret =3D rtl8365mb_sds_write(priv, 0, sds_jam[i].reg,
+					  sds_jam[i].val);
 		if (ret)
 			return ret;
 	}
=20
-	/* Mux the SerDes to MAC8 in SGMII mode */
+	/* Mux the SerDes to MAC8 in the requested mode */
 	ret =3D regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
 				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
 					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
-				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK);
+				 mode =3D=3D RTL8365MB_EXT_PORT_MODE_SGMII ?
+					 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK :
+					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK);
 	if (ret)
 		return ret;
=20
 	ret =3D regmap_update_bits(
 		priv->map, RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
 		RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
-		RTL8365MB_EXT_PORT_MODE_SGMII
-			<< RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(
-				   extint->id));
+		mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(
+			       extint->id));
 	if (ret)
 		return ret;
=20
@@ -1218,7 +1238,8 @@ static int rtl8365mb_ext_config_sgmii(struct realtek_=
priv *priv, int port,
=20
 static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
 {
-	return interface =3D=3D PHY_INTERFACE_MODE_SGMII;
+	return interface =3D=3D PHY_INTERFACE_MODE_SGMII ||
+	       interface =3D=3D PHY_INTERFACE_MODE_2500BASEX;
 }
=20
 static int rtl8365mb_sds_config_forcemode(struct realtek_priv *priv, bool =
link,
@@ -1234,7 +1255,11 @@ static int rtl8365mb_sds_config_forcemode(struct rea=
ltek_priv *priv, bool link,
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
 		} else if (speed =3D=3D SPEED_100) {
 			r_speed =3D RTL8365MB_PORT_SPEED_100M;
@@ -1286,7 +1311,11 @@ static int rtl8365mb_ext_config_forcemode(struct rea=
ltek_priv *priv, int port,
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
 		} else if (speed =3D=3D SPEED_100) {
 			r_speed =3D RTL8365MB_PORT_SPEED_100M;
@@ -1366,6 +1395,12 @@ static void rtl8365mb_phylink_get_caps(struct dsa_sw=
itch *ds, int port,
 	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII)
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
+
+	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_HSGMII) {
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |=3D MAC_2500FD;
+	}
 }
=20
 static void rtl8365mb_phylink_mac_config(struct phylink_config *config,
--=20
2.54.0




