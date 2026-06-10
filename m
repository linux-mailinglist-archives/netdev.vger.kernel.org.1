Return-Path: <netdev+bounces-297540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDzzGR0lKWrVRQMAu9opvQ
	(envelope-from <netdev+bounces-297540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:49:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36766766B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=c127.dev header.s=resend header.b="3R1DMK/E";
	dkim=pass header.d=amazonses.com header.s=224i4yxa5dv7c2xz3womw6peuasteono header.b=RE4hTonu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297540-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297540-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2B131DB69A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A23B42F0;
	Wed, 10 Jun 2026 08:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a9-23.smtp-out.amazonses.com (a9-23.smtp-out.amazonses.com [54.240.9.23])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4C3B47DE;
	Wed, 10 Jun 2026 08:41:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080893; cv=none; b=S0xl2oiI19X+I28MdSWIQvHMxkHpF5xvd9G6RYJTa0/X+T/MiFrbtE5fgayU3ytzwkypeK+8xc2oihBE72H59Xs1jm3dfyz9+Jwtts8am+g6QnYPfx8uQCMUV/z4ZSN6NQVPdnQ7FJii5meymF9ArnW1EHIFIWe1Q+LZpEr9E98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080893; c=relaxed/simple;
	bh=8gdIu8H8cFndSvRV7FKkp/1myCISZd9wBe/dkbYtlX8=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=e2oG/e/03kyJI1Jlfwc2gzNTGSDENzmLknv5c5rCu3DwYDBNMgsPOzYZXD+OXyzceeF+xJahTRW/bv5cmPbMyV+uizbyZKdcGmVMYJsv5YuMT3opAgy3a/IbHkKInpf/zEwlNa9BYgPgEzwWnjvJg8fjtC4j1m+XA0vgg8eqXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=send.c127.dev; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=3R1DMK/E; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=RE4hTonu; arc=none smtp.client-ip=54.240.9.23
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=c127.dev; t=1781080890;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=8gdIu8H8cFndSvRV7FKkp/1myCISZd9wBe/dkbYtlX8=;
	b=3R1DMK/EKfq/zN2m6Knqq+e/GQFjWaZ7TNotATD2STBmG0R/DEm35FMt4kUz+hKM
	7YlJ7UM3vibC4JtCHY0ZaDgoL6Prsb30pLJm33dnRjBxU9yuQjnAWbJJ5LUP94SjuSF
	WcWZwOLXKig9Wkvss4qNlUOwVKpNuVG/efykncsE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1781080890;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=8gdIu8H8cFndSvRV7FKkp/1myCISZd9wBe/dkbYtlX8=;
	b=RE4hTonu9f0ilIgOllmLUfjpJGzUiuqYHGDoKeTZfRUXIsfBtofsATSBf22uGRBI
	stjudKx+KIFYME3jl1xjiSpEiXwp2tgeVdi035eNp9SBaSCN3lsQMJ00CUk/cWjOSw+
	nc/5E7/Atia5Ni8lYCkA0j+2FWtHUDonIdsDGVzA=
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610084120.1100326-1-contact@c127.dev>
References: <20260610084120.1100326-1-contact@c127.dev>
From: Johan Alvarado <contact@c127.dev>
To: netdev@vger.kernel.org
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, contact@c127.dev
Subject: [PATCH net-next v2 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
Message-ID: <0100019eb0b19c71-c9940bf4-4d23-41af-b429-842330edd967-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 08:41:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.z4rHY0qbNtjoW80ZyzVy+DEul17RQEOMT7FC66S60ffkhLWkV35D8ZWXVyxJY1/89bAuLCem4GFJq1VXsxM0u6ZfZbvT1qSjDUeuZG9/Lxk1uINIqi7CenEa93u+fNllqnJMZ0quaBrclhnmtzdFllG4KHSjZOEcaGLa1BWoSpA=:1.us-east-1.epbACCJLarUaEI78XZoGREJ9LamRjxMH5pM2kZb64rA=:AmazonSES
X-SES-Outgoing: 2026.06.10-54.240.9.23
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-297540-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,c127.dev:dkim,c127.dev:email,c127.dev:from_mime,email.amazonses.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazonses.com:dkim,bang-olufsen.dk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA36766766B

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

 - Clear the line rate bypass bit for the external =
interface, tune the
   SerDes with the vendor-prescribed parameters, mux =
the SerDes to MAC8
   in SGMII mode and only then take the SerDes out of =
reset, as the
   vendor driver does.

 - Load firmware into the embedded =
DW8051 microcontroller, which
   performs the remaining SerDes =
initialization. The firmware is
   requested via the firmware API under the=
 name
   realtek/rtl8367s-sgmii.bin.

 - Force the SGMII link parameters =
(link, speed, duplex, flow control)
   in the SDS_MISC register from the =
phylink mac_link_up/down
   operations, in addition to the usual external =
interface force
   configuration. SGMII in-band autonegotiation is disabled=
, so only
   fixed-link and conventional PHY setups are supported, just =
like
   RGMII.

Tested on a Mercusys MR80X v2.20, where the RTL8367S is =
connected to
the SoC over SGMII.

Signed-off-by: Johan Alvarado =
<contact@c127.dev>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 357 =
+++++++++++++++++++++++++++-
 1 file changed, 354 insertions(+), 3 =
deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c =
b/drivers/net/dsa/realtek/rtl8365mb.c
index c35cef01ec26..13ce8e6f1c72 =
100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ =
b/drivers/net/dsa/realtek/rtl8365mb.c
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
@@ -92,6 +93,7 @@
=20
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/mutex.h>
@@ -123,6 +125,7 @@
=20
 /* Chip reset register */
 #define RTL8365MB_CHIP_RESET_REG	0x1322
+#define RTL8365MB_CHIP_RESET_DW8051_MASK	0x0010
 #define =
RTL8365MB_CHIP_RESET_SW_MASK	0x0002
 #define RTL8365MB_CHIP_RESET_HW_MASK	=
0x0001
=20
@@ -232,6 +235,47 @@
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
registers, accessed via the SDS_INDACS registers */
+#define RTL8365MB_SDS_REG_NWAY			0x0002
+#define   =
RTL8365MB_SDS_NWAY_EN_MASK		0x0200
+#define   RTL8365MB_SDS_NWAY_RESTART_MA=
SK	0x0100
+#define RTL8365MB_SDS_REG_RESET			0x0003
+#define   RTL8365MB_SDS_RESET_DEASSERT		0x7106
+
+/* Embedded DW8051 =
microcontroller control registers. The microcontroller
+ * runs firmware which is required to bring up the SerDes for SGMII modes.
+ */
+#define RTL8365MB_MISC_CFG0_REG			0x130C
+#define   =
RTL8365MB_MISC_CFG0_DW8051_EN_MASK	0x0020
+#define RTL8365MB_DW8051_RDY_REG=
		0x1336
+#define   RTL8365MB_DW8051_RDY_IROM_MSB_MASK	0x0004
+#define   RTL8365MB_DW8051_RDY_ACS_IROM_EN_MASK	0x0002
+#define RTL8365MB_IROM_BASE			0xE000
+#define RTL8365MB_IROM_SIZE			0x2000
+
+#define RTL8365MB_DW8051_FW_NAME		"realtek/rtl8367s-sgmii.bin"
+
 /* External interface port speed values - used in DIGITAL_INTERFACE_FORCE =
*/
 #define RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
@@ -470,6 +514,13 @@ static const struct rtl8365mb_jam_tbl_entry =
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
@@ -947,6 +998,271 @@ static int rtl8365mb_ext_config_rgmii(struct =
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
+static int rtl8365mb_dw8051_load_firmware(struct realtek_priv *priv)
+{
+	const struct firmware *fw;
+	int ret;
+	int i;
+
+	ret =3D =
request_firmware(&fw, RTL8365MB_DW8051_FW_NAME, priv->dev);
+	if (ret) {
+		dev_err(priv->dev, "failed to request firmware %s: %d\n",
+			RTL8365MB_DW8051_FW_NAME, ret);
+		return ret;
+	}
+
+	if (fw->size > RTL8365MB_IROM_SIZE) {
+		dev_err(priv->dev, "firmware %s =
too large (%zu bytes)\n",
+			RTL8365MB_DW8051_FW_NAME, fw->size);
+		ret =3D -EFBIG;
+		goto out_release;
+	}
+
+	/* Hold the microcontroller=
 in reset while replacing its program */
+	ret =3D regmap_update_bits(priv-=
>map, RTL8365MB_CHIP_RESET_REG,
+				 RTL8365MB_CHIP_RESET_DW8051_MASK,
+				 RTL8365MB_CHIP_RESET_DW8051_MASK);
+	if (ret)
+		goto out_release;
+
+	ret =3D regmap_update_bits(priv->map, RTL8365MB_MISC_CFG0_REG,
+				 RTL8365MB_MISC_CFG0_DW8051_EN_MASK,
+				 RTL8365MB_MISC_CFG0_DW8051_=
EN_MASK);
+	if (ret)
+		goto out_release;
+
+	/* Map the lower bank of the =
instruction ROM into the switch register
+	 * address space.
+	 */
+	ret =3D regmap_update_bits(priv->map, RTL8365MB_DW8051_RDY_REG,
+				 RTL8365MB_DW8051_RDY_ACS_IROM_EN_MASK,
+				 RTL8365MB_DW8051_RDY_ACS=
_IROM_EN_MASK);
+	if (ret)
+		goto out_release;
+
+	ret =3D =
regmap_update_bits(priv->map, RTL8365MB_DW8051_RDY_REG,
+				 RTL8365MB_DW8051_RDY_IROM_MSB_MASK, 0);
+	if (ret)
+		goto out_release;
+
+	for (i =3D 0; i < fw->size; i++) {
+		ret =3D regmap_write(priv->map, RTL8365MB_IROM_BASE + i,
+				   fw->data[i]);
+		if (ret)
+			goto out_release;
+	}
+
+	ret =3D regmap_update_bits(priv->map, RTL8365MB_DW8051_RDY_REG,
+				 RTL8365MB_DW8051_RDY_ACS_IROM_EN_MASK, 0);
+	if (ret)
+		goto out_release;
+
+	/* Release the microcontroller from reset to run =
the new program */
+	ret =3D regmap_update_bits(priv->map, =
RTL8365MB_CHIP_RESET_REG,
+				 RTL8365MB_CHIP_RESET_DW8051_MASK, 0);
+
+out_release:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int rtl8365mb_ext_config_sgmii(struct realtek_priv *priv, int port,
+				      phy_interface_t interface)
+{
+	const struct rtl8365mb_extint =
*extint =3D
+		rtl8365mb_get_port_extint(priv, port);
+	u16 val;
+	int ret;
+	int i;
+
+	if (!extint)
+		return -ENODEV;
+
+	/* The SerDes can only be =
muxed to external interface 1 */
+	if (extint->id !=3D 1)
+		return -EOPNOTSUPP;
+
+	/* The vendor driver clears the line rate bypass=
 for all interface
+	 * modes except TMII.
+	 */
+	ret =3D =
regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
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
+	/* The embedded microcontroller performs the remaining SerDes
+	 * initialization. Load its firmware and give it some time to bring
+	 * the SerDes up.
+	 */
+	ret =3D rtl8365mb_dw8051_load_firmware(priv);
+	if (ret)
+		return ret;
+
+	msleep(300);
+
+	/* Pause the microcontroller=
 while accessing the SerDes directly */
+	ret =3D regmap_update_bits(priv->=
map, RTL8365MB_MISC_CFG0_REG,
+				 RTL8365MB_MISC_CFG0_DW8051_EN_MASK, 0);
+	if (ret)
+		return ret;
+
+	/* Disable SGMII in-band autonegotiation: the=
 link parameters are
+	 * forced in rtl8365mb_phylink_mac_link_up.
+	 */
+	ret =3D rtl8365mb_sds_read(priv, 0, RTL8365MB_SDS_REG_NWAY, &val);
+	if (ret)
+		return ret;
+
+	val &=3D ~RTL8365MB_SDS_NWAY_EN_MASK;
+	val |=3D RTL8365MB_SDS_NWAY_RESTART_MASK;
+
+	ret =3D =
rtl8365mb_sds_write(priv, 0, RTL8365MB_SDS_REG_NWAY, val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->map, =
RTL8365MB_MISC_CFG0_REG,
+				  RTL8365MB_MISC_CFG0_DW8051_EN_MASK,
+				  RTL8365MB_MISC_CFG0_DW8051_EN_MASK);
+}
+
+static bool =
rtl8365mb_interface_is_serdes(phy_interface_t interface)
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
@@ -1046,6 +1362,10 @@ static void =
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
@@ -1073,6 +1393,15 @@ static void rtl8365mb_phylink_mac_config(st=
ruct phylink_config *config,
 		return;
 	}
=20
+	if =
(rtl8365mb_interface_is_serdes(state->interface)) {
+		ret =3D rtl8365mb_ext_config_sgmii(priv, port, state->interface);
+		if (ret)
+			dev_err(priv->dev,
+				"failed to configure SGMII mode on =
port %d: %d\n",
+				port, ret);
+		return;
+	}
+
 	/* TODO: Implement MII =
and RMII modes, which the RTL8365MB-VC also
 	 * supports
 	 */
@@ -1093,7 +1422,8 @@ static void rtl8365mb_phylink_mac_link_down(struct =
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
@@ -1101,6 +1431,15 @@ static void =
rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 				"failed to reset forced mode on port %d: %d\n",
 				port, ret);
=20
+		if (rtl8365mb_interface_is_serdes(interface)) {
+			ret =3D =
rtl8365mb_sds_config_forcemode(priv, false, 0, 0,
+							     false, =
false);
+			if (ret)
+				dev_err(priv->dev,
+					"failed to reset forced =
SGMII link on port %d: %d\n",
+					port, ret);
+		}
+
 		return;
 	}
 }
@@ -1123,7 +1462,8 @@ static void rtl8365mb_phylink_mac_link_up(struct =
phylink_config *config,
 	p =3D &mb->ports[port];
 	=
schedule_delayed_work(&p->mib_work, 0);
=20
-	if (phy_interface_mode_is_rgm=
ii(interface)) {
+	if (phy_interface_mode_is_rgmii(interface) ||
+	    rtl8365mb_interface_is_serdes(interface)) {
 		ret =3D =
rtl8365mb_ext_config_forcemode(priv, port, true, speed,
 						     duplex, tx_pause,
 						     rx_pause);
@@ -1132,6 +1472,16 @@ static void rtl8365mb_phylink_mac_link_up(struct =
phylink_config *config,
 				"failed to force mode on port %d: %d\n", port,
 				ret);
=20
+		if (rtl8365mb_interface_is_serdes(interface)) {
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
@@ -2206,5 +2556,6 @@ =
module_exit(rtl8365mb_exit);
=20
 MODULE_AUTHOR("Alvin =C5=A0ipraga =
<alsi@bang-olufsen.dk>");
 MODULE_DESCRIPTION("Driver for RTL8365MB-VC =
ethernet switch");
+MODULE_FIRMWARE(RTL8365MB_DW8051_FW_NAME);
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("REALTEK_DSA");
--=20
2.54.0


