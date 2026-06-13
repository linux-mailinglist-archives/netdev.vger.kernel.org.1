Return-Path: <netdev+bounces-299090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ScKFIUHmLWqXmQQAu9opvQ
	(envelope-from <netdev+bounces-299090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:22:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCE68007A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:22:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b=wqlqgFNG;
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=JIZVU2Iy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299090-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299090-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 155F8300D853
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9155F38911F;
	Sat, 13 Jun 2026 23:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-24.smtp-out.amazonses.com (a9-24.smtp-out.amazonses.com [54.240.9.24])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5E37CD21;
	Sat, 13 Jun 2026 23:22:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781392927; cv=none; b=ecFmIV0wZdVJuu2ZEPMl6CzSwHfzhjsMECEaiHEUBSzU/qLPR5PZHsOGb32fvdGO2KjTWE+RmoN5iv+lY+fUA0uIs6saV499ZPMAcBMzvIu6HUclvFYMbB+4jFfXUulogAX8UXjA0Yc/qvxJGvJSxXztZB1udcVDyr7VKQJUT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781392927; c=relaxed/simple;
	bh=sm8077J9CJBw9peqMbccNVEftI227EHRewKbIm6667g=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=JMtDJssDW6dVcnmXSfB6Y5Z0x5TEA9d8WWsVPgDno1fFxXYMktFYK4/Dedqvf3rzpAXmlGq3uyWejfkesEI+6oRY7sUJeIAzgfenthXZdNfacK+WcVmua45Ls9MQ8yFvK7mvQmmnn9/thsTaCmwXGsGivh1/YtlNn4mZbm1iU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=wqlqgFNG; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=JIZVU2Iy; arc=none smtp.client-ip=54.240.9.24
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781392924;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=sm8077J9CJBw9peqMbccNVEftI227EHRewKbIm6667g=;
	b=wqlqgFNGQzyCO0N5Jtyolb3PlwNsxud3Y6z/BBU+cvRV8PwtlEra9WqPhDCgXtbT
	MY2D1uFT4jzSXXWtpTtYscGFSLL/h0PbgQvWxDzNAerUjlL3Dz0xGN8Bd1cJ3A5AGLx
	iJXjuUe6BnRRATtTUhWUHQx+rHxarB4TihdC3U1Y=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781392924;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=sm8077J9CJBw9peqMbccNVEftI227EHRewKbIm6667g=;
	b=JIZVU2IylxLLcyvqQU6piuFyeKW0zcj4ki/ZJKOrT5/1zupSGHATvUyc3wE5CkXY
	ACn1xlyZz7NskQD1R1vaGe7XJclPV29ArPyNVzMwT96NuQ7BEYhuhlOugmJWnKOo85S
	WrykMEUrueQ6JLrxgMT3xbR66gkvUUJ5WhhiespE=
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613232136.24246-1-contact@c127.dev>
References: <20260613232136.24246-1-contact@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, namiltd@yahoo.com, luizluca@gmail.com, 
	linux-kernel@vger.kernel.org, contact@c127.dev
Subject: [PATCH net-next v3 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
Message-ID: <0100019ec34adee6-37e8121b-823b-460e-b6bf-98588994adc8-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 23:22:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.13-54.240.9.24
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[c127.dev:s=resend,amazonses.com:s=224i4yxa5dv7c2xz3womw6peuasteono];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[c127.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299090-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:+,amazonses.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[armlinux.org.uk,yahoo.com,gmail.com,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c127.dev:dkim,c127.dev:email,c127.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazonses.com:dkim,vger.kernel.org:from_smtp,email.amazonses.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4CCE68007A

The RTL8367S can mux its embedded SerDes to external interface 1,
which is typically used to connect the switch to a CPU port. The chip
info table already declares SGMII as a supported interface mode for
this chip, but the driver only implements RGMII so far.

Implement SGMII support, with the configuration sequence derived from
the GPL-licensed Realtek rtl8367c vendor driver as distributed in the
Mercusys MR80X GPL code drop:

 - Add accessors for the SerDes indirect =
access registers (SDS_INDACS),
   through which the SerDes internal =
registers are reached.

 - Keep the embedded DW8051 microcontroller in =
reset and disabled. The
   vendor driver loads firmware into it to manage =
the SerDes link, but
   analysis of that firmware shows it only duplicates =
the link
   management phylink already performs: it polls the port status =
and
   writes the external interface force registers behind the driver's
   back.

 - Clear the line rate bypass bit for the external interface, =
tune the
   SerDes with the vendor-prescribed parameters, mux the SerDes to=
 MAC8
   in SGMII mode and only then take the SerDes out of reset, as the
   vendor driver does.

 - After deasserting the SerDes reset, reset the =
SerDes data path via
   the SerDes BMCR register to flush the FIFOs and =
resync the PLL.
   This mirrors what the vendor firmware does right after =
deasserting
   the SerDes reset, and ensures a clean link state from cold =
boot.

 - Force the SGMII link parameters (link, speed, duplex, flow =
control)
   in the SDS_MISC register from the phylink mac_link_up/down
   operations, in addition to the usual external interface force
   configuration. SGMII in-band autonegotiation is disabled, so only
   fixed-link and conventional PHY setups are supported, just like
   RGMII.

Tested on a Mercusys MR80X v2.20, where the RTL8367S is =
connected to
the SoC over SGMII.

Suggested-by: Luiz Angelo Daros de Luca =
<luizluca@gmail.com>
Signed-off-by: Johan Alvarado <contact@c127.dev>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 298 ++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c =
b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 5ac091bf93c9..89b7608aaa3a=
 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -40,7 +40,8 @@
  * driver has only been tested with a fixed-link, but in principle it =
should not
  * matter.
  *
- * NOTE: Currently, only the RGMII interface is=
 implemented in this driver.
+ * NOTE: Currently, only the RGMII interface =
is implemented in this driver. On
+ * the RTL8367S, the SGMII interface is =
also supported.
  *
  * The interrupt line is asserted on link UP/DOWN =
events. The driver creates a
  * custom irqchip to handle this interrupt =
and demultiplex the events by reading
@@ -129,6 +130,7 @@
=20
 /* Chip reset register */
 #define RTL8365MB_CHIP_RESET_REG	0x1322
+#define RTL8365MB_CHIP_RESET_DW8051_MASK	0x0010
 #define =
RTL8365MB_CHIP_RESET_SW_MASK	0x0002
 #define RTL8365MB_CHIP_RESET_HW_MASK	=
0x0001
=20
@@ -238,6 +240,49 @@
 #define   RTL8365MB_EXT_RGMXF_RXDELAY_MASK=
	0x0007
 #define   RTL8365MB_EXT_RGMXF_TXDELAY_MASK	0x0008
=20
+/* External interface line rate bypass register - one bit per interface */
+#define RTL8365MB_BYPASS_LINE_RATE_REG	0x03F7
+
+/* SerDes indirect access=
 registers */
+#define RTL8365MB_SDS_INDACS_CMD_REG		0x6600
+#define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	0x0080
+#define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	0x0040
+#define   =
RTL8365MB_SDS_INDACS_CMD_INDEX_MASK	0x0007
+#define =
RTL8365MB_SDS_INDACS_ADR_REG		0x6601
+#define RTL8365MB_SDS_INDACS_DATA_REG=
		0x6602
+
+/* SerDes miscellaneous configuration register */
+#define RTL8365MB_SDS_MISC_REG				0x1D11
+#define   =
RTL8365MB_SDS_MISC_SGMII_RXFC_MASK		0x4000
+#define   =
RTL8365MB_SDS_MISC_SGMII_TXFC_MASK		0x2000
+#define   =
RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK	0x0800
+#define   =
RTL8365MB_SDS_MISC_SGMII_FDUP_MASK		0x0400
+#define   =
RTL8365MB_SDS_MISC_SGMII_LINK_MASK		0x0200
+#define   =
RTL8365MB_SDS_MISC_SGMII_SPD_MASK		0x0180
+#define   =
RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	0x0040
+
+/* SerDes internal =
registers, accessed via the SDS_INDACS registers. The
+ * BMCR data path reset values set BMCR_ANENABLE | BMCR_ISOLATE (0x1400),
+ * and toggling the vendor-specific low bits from 0x1 to 0x3 triggers a
+ * data path reset and PLL resync.
+ */
+#define RTL8365MB_SDS_REG_BMCR			=
0x0000
+#define   RTL8365MB_SDS_BMCR_DPRST_PHASE1	0x1401
+#define   RTL8365MB_SDS_BMCR_DPRST_PHASE2	0x1403
+#define =
RTL8365MB_SDS_REG_NWAY			0x0002
+#define   RTL8365MB_SDS_NWAY_EN_MASK		=
0x0200
+#define   RTL8365MB_SDS_NWAY_RESTART_MASK	0x0100
+#define RTL8365MB_SDS_REG_RESET			0x0003
+#define   =
RTL8365MB_SDS_RESET_DEASSERT		0x7106
+
+/* Embedded DW8051 microcontroller =
control registers. The microcontroller
+ * can run firmware to manage the =
SerDes link, but this driver keeps it in
+ * reset and disabled: phylink =
already performs the link management that
+ * the firmware would otherwise =
do.
+ */
+#define RTL8365MB_MISC_CFG0_REG			0x130C
+#define   =
RTL8365MB_MISC_CFG0_DW8051_EN_MASK	0x0020
+
 /* External interface port =
speed values - used in DIGITAL_INTERFACE_FORCE */
 #define =
RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
@@ -551,6 +596,13 @@ static const struct rtl8365mb_jam_tbl_entry =
rtl8365mb_init_jam_common[] =3D {
 	{ 0x1D32, 0x0002 },
 };
=20
+/* SGMII SerDes tuning parameters, lifted from the vendor driver sources =
*/
+static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_sgmii[] =
=3D {
+	{ 0x0480, 0x04D7 }, { 0x0481, 0xF994 }, { 0x0482, 0x2420 },
+	{ 0x0483, 0x6960 }, { 0x0484, 0x9728 }, { 0x0423, 0x9D85 },
+	{ 0x0424, 0xD810 }, { 0x002E, 0x83F2 },
+};
+
 enum =
rtl8365mb_phy_interface_mode {
 	RTL8365MB_PHY_INTERFACE_MODE_INVAL =3D 0,
 	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL =3D BIT(0),
@@ -1042,6 +1094,212 @@ static int rtl8365mb_ext_config_rgmii(struct =
realtek_priv *priv, int port,
 	return 0;
 }
=20
+static int =
rtl8365mb_sds_write(struct realtek_priv *priv, int sds, u16 addr,
+			       u16 data)
+{
+	u32 val;
+	int ret;
+
+	ret =3D =
regmap_write(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, data);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR=
_REG, addr);
+	if (ret)
+		return ret;
+
+	val =3D RTL8365MB_SDS_INDACS_CMD=
_RUN_MASK |
+	      RTL8365MB_SDS_INDACS_CMD_WR_MASK |
+	      FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK, sds);
+	ret =3D regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG, val);
+	if (ret)
+		return ret;
+
+	/* The vendor driver does not poll for =
completion, but a short delay
+	 * is needed before issuing the next =
command.
+	 */
+	usleep_range(10, 50);
+
+	return 0;
+}
+
+static int rtl8365mb_sds_read(struct realtek_priv *priv, int sds, u16 addr=
,
+			      u16 *data)
+{
+	u32 val;
+	int ret;
+
+	ret =3D =
regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR_REG, addr);
+	if (ret)
+		return ret;
+
+	val =3D RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+	      FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK, sds);
+	ret =3D regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG, val);
+	if (ret)
+		return ret;
+
+	usleep_range(10, 50);
+
+	ret =3D regmap_read(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, &val);
+	if (ret)
+		return ret;
+
+	*data =3D val;
+
+	return 0;
+}
+
+static int rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port)
+{
+	const struct rtl8365mb_extint *extint =3D
+		rtl8365mb_get_port_extint=
(priv, port);
+	u16 val;
+	int ret;
+	int i;
+
+	if (!extint)
+		return -ENODEV;
+
+	/* The SerDes can only be muxed to external =
interface 1 */
+	if (extint->id !=3D 1)
+		return -EOPNOTSUPP;
+
+	/* Hold the embedded DW8051 microcontroller in reset and keep it
+	 * disabled. The vendor driver loads firmware into it to manage the
+	 * SerDes link, but the firmware only duplicates work that phylink
+	 * already does: it polls the port status and forces the external
+	 * interface configuration in the very registers this driver manages.
+	 * Letting it run would race with phylink.
+	 */
+	ret =3D =
regmap_update_bits(priv->map, RTL8365MB_CHIP_RESET_REG,
+				 RTL8365MB_CHIP_RESET_DW8051_MASK,
+				 RTL8365MB_CHIP_RESET_DW8051_M=
ASK);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_update_bits(priv->map, =
RTL8365MB_MISC_CFG0_REG,
+				 RTL8365MB_MISC_CFG0_DW8051_EN_MASK, 0);
+	if (ret)
+		return ret;
+
+	/* The vendor driver clears the line rate =
bypass for all interface
+	 * modes except TMII.
+	 */
+	ret =3D regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
+				 BIT(extint->id), 0);
+	if (ret)
+		return ret;
+
+	/* Tune the SerDes with vendor-prescribed parameters */
+	for (i =3D 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
+		ret =3D rtl8365mb_sds_write(priv, 0,
+					  rtl8365mb_sds_jam_sgmii[i].=
reg,
+					  rtl8365mb_sds_jam_sgmii[i].val);
+		if (ret)
+			return ret;
+	}
+
+	/* Mux the SerDes to MAC8 in SGMII mode */
+	ret =3D =
regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
+				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
+					 =
RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
+				 RTL8365MB_SDS_MISC_MAC8_SEL_=
SGMII_MASK);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_update_bits(
+		priv->map, RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
+		RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
+		RTL8365MB_EXT_PORT_MODE_SGMII
+			<< RTL8365MB_DIGITAL_INTERFACE_SELECT_=
MODE_OFFSET(
+				   extint->id));
+	if (ret)
+		return ret;
+
+	/* Take the SerDes out of reset. The vendor driver does this only
+	 * after the SerDes mux and the interface mode are configured.
+	 */
+	ret =3D rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_RESET,
+				  RTL8365MB_SDS_RESET_DEASSERT);
+	if (ret)
+		return ret;
+
+	/* Reset the SerDes data path and resync its PLL, mirroring what the
+	 * vendor firmware does right after deasserting the SerDes reset.
+	 * This flushes the FIFOs and ensures a clean state for the link,
+	 * preventing silent drops and CRC errors.
+	 */
+	ret =3D =
rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_BMCR,
+				  RTL8365MB_SDS_BMCR_DPRST_PHASE1);
+	if (ret)
+		return ret;
+
+	ret =3D rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_BMCR,
+				  RTL8365MB_SDS_BMCR_DPRST_PHASE2);
+	if (ret)
+		return ret;
+
+	/* Disable SGMII in-band autonegotiation: the link parameters are
+	 * forced in rtl8365mb_phylink_mac_link_up.
+	 */
+	ret =3D rtl8365mb_sds_read(priv, 0, RTL8365MB_SDS_REG_NWAY, &val);
+	if (ret)
+		return ret;
+
+	val &=3D ~RTL8365MB_SDS_NWAY_EN_MASK;
+	val |=3D RTL8365MB_SDS_NWAY_RESTART_MASK;
+
+	return =
rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_NWAY, val);
+}
+
+static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
+{
+	return interface =3D=3D PHY_INTERFACE_MODE_SGMII;
+}
+
+static int rtl8365mb_sds_config_forcemode(struct realtek_priv *priv, bool =
link,
+					  int speed, int duplex, bool tx_pause,
+					  bool rx_pause)
+{
+	u32 mask =3D RTL8365MB_SDS_MISC_SGMII_RXFC_MASK |
+		   RTL8365MB_SDS_MISC_SGMII_TXFC_MASK |
+		   RTL8365MB_SDS_MISC_SGMII_F=
DUP_MASK |
+		   RTL8365MB_SDS_MISC_SGMII_LINK_MASK |
+		   RTL8365MB_SDS_MISC_SGMII_SPD_MASK;
+	u32 val =3D 0;
+	u32 r_speed;
+
+	if (link) {
+		if (speed =3D=3D SPEED_1000) {
+			r_speed =3D =
RTL8365MB_PORT_SPEED_1000M;
+		} else if (speed =3D=3D SPEED_100) {
+			r_speed =3D RTL8365MB_PORT_SPEED_100M;
+		} else if (speed =3D=3D =
SPEED_10) {
+			r_speed =3D RTL8365MB_PORT_SPEED_10M;
+		} else {
+			dev_err(priv->dev, "unsupported port speed %s\n",
+				phy_speed_to_str(speed));
+			return -EINVAL;
+		}
+
+		val |=3D RTL8365MB_SDS_MISC_SGMII_LINK_MASK;
+		val |=3D =
FIELD_PREP(RTL8365MB_SDS_MISC_SGMII_SPD_MASK, r_speed);
+
+		if (duplex =3D=3D DUPLEX_FULL)
+			val |=3D RTL8365MB_SDS_MISC_SGMII_FDU=
P_MASK;
+
+		if (tx_pause)
+			val |=3D RTL8365MB_SDS_MISC_SGMII_TXFC_MASK;
+
+		if (rx_pause)
+			val |=3D RTL8365MB_SDS_MISC_SGMII_RXFC_MASK;
+	}
+
+	return regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG, mask,
+				  val);
+}
+
 static int rtl8365mb_ext_config_forcemode(struct =
realtek_priv *priv, int port,
 					  bool link, int speed, int duplex,
 					  bool tx_pause, bool rx_pause)
@@ -1141,6 +1399,10 @@ static void =
rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
=20
 	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII)
 		phy_interface_set_rgmii(config->supported_interfaces);
+
+	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII)
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
 }
=20
 static void rtl8365mb_phylink_mac_config(struct phylink_config =
*config,
@@ -1168,6 +1430,15 @@ static void rtl8365mb_phylink_mac_config(st=
ruct phylink_config *config,
 		return;
 	}
=20
+	if =
(rtl8365mb_interface_is_serdes(state->interface)) {
+		ret =3D rtl8365mb_ext_config_sgmii(priv, port);
+		if (ret)
+			dev_err(priv->dev,
+				"failed to configure SGMII mode on port %d: =
%d\n",
+				port, ret);
+		return;
+	}
+
 	/* TODO: Implement MII and RMII =
modes, which the RTL8365MB-VC also
 	 * supports
 	 */
@@ -1188,7 +1459,8 @@ static void rtl8365mb_phylink_mac_link_down(struct =
phylink_config *config,
 	p =3D &mb->ports[port];
 	=
cancel_delayed_work_sync(&p->mib_work);
=20
-	if (phy_interface_mode_is_rgm=
ii(interface)) {
+	if (phy_interface_mode_is_rgmii(interface) ||
+	    rtl8365mb_interface_is_serdes(interface)) {
 		ret =3D =
rtl8365mb_ext_config_forcemode(priv, port, false, 0, 0,
 						     false, false);
 		if (ret)
@@ -1196,6 +1468,15 @@ static void =
rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 				"failed to reset forced mode on port %d: %pe\n",
 				port, ERR_PTR(ret));
=20
+		if (rtl8365mb_interface_is_serdes(interfac=
e)) {
+			ret =3D rtl8365mb_sds_config_forcemode(priv, false, 0, 0,
+							     false, false);
+			if (ret)
+				dev_err(priv->dev,
+					"failed to reset forced SGMII link on port %d: %d\n",
+					port, ret);
+		}
+
 		return;
 	}
 }
@@ -1218,7 +1499,8 @@ static =
void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 	p =3D &mb->ports[port];
 	schedule_delayed_work(&p->mib_work, 0);
=20
-	if (phy_interface_mode_is_rgmii(interface)) {
+	if =
(phy_interface_mode_is_rgmii(interface) ||
+	    rtl8365mb_interface_is_ser=
des(interface)) {
 		ret =3D rtl8365mb_ext_config_forcemode(priv, port, =
true, speed,
 						     duplex, tx_pause,
 						     rx_pause);
@@ -1227,6 +1509,16 @@ static void rtl8365mb_phylink_mac_link_up(struct =
phylink_config *config,
 				"failed to force mode on port %d: %pe\n", port=
,
 				ERR_PTR(ret));
=20
+		if (rtl8365mb_interface_is_serdes(interface)) =
{
+			ret =3D rtl8365mb_sds_config_forcemode(priv, true, speed,
+							     duplex, tx_pause,
+							     rx_pause);
+			if (ret)
+				dev_err(priv->dev,
+					"failed to force SGMII link on port %d: %d\n"=
,
+					port, ret);
+		}
+
 		return;
 	}
 }

base-commit: =
8f4695fb67b259b2cae0be1eef55859bfc559058
--=20
2.54.0


