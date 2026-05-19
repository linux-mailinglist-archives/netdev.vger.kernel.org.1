Return-Path: <netdev+bounces-289535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D7HD2eXDGphjgUAu9opvQ
	(envelope-from <netdev+bounces-289535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:01:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B042C582C80
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF3930A1E52
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6C440912C;
	Tue, 19 May 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="hV7VpqTe"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256433403F9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209914; cv=none; b=KpeIo0J6tbMVsACys5evg9BlplcPxVS/QHzG4tORQJd+1yx01UopTbLjMh86+XTdqbYwD7t/ZWKNp1LvNJ3mq8JTTdOHzSVdrrUX3Qrs08qpmTbW3clHR7iu5/MmolWCrytB4EjmlGGBgbhkZw16MjoWG6Lq9Ov5vxAeTwxfoDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209914; c=relaxed/simple;
	bh=upCEXO0f/uCwcFk/JUo3AUxjpzjPjrIHeSe0EQ4fGW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzHTCuMAz8w5/EffVFueP1f54T7CN2fXidG5tRWlKcTSmuVUGifS2FQG26TRun52vpBpyfgCJQeKqy+KFt2YA6yW+mfCWLhuAl5KyIcGQETz1e2+clrXS+lCUp+gLiHc2h4SNQfjGJpTm4VCVjRwUjr+ghp0EdQ3fy9Pglo39oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=hV7VpqTe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209890; x=1779814690;
	i=markus.stockhausen@gmx.de;
	bh=75sOOyCOFEfFZk4ZzYVtIAAdq2FyXVt3lTgrKOL6Vvg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hV7VpqTe8P4gPPHu6kW4kwl0/DlT3VWYO+5lW36jHkBE+U+Ak2iUvWoKJqyyipMG
	 QRaFW1RcnXNlt+knXka9puGG/VbZ2gfywQDxIoUljzD91jDpOkd1MB6aC7BdhhofI
	 w/W4gqPJdi3kI3PMpt+aTO253QiZigpfFPPCvToO6pdznh9w2NNbOBdkMK03vti11
	 n3cxKWGZeiIquSEWjDnnB+N7b2dPuTkOuBLQP7Ifxe5xSxSnxfUKFLMuzTS5TyYQ5
	 ArtMnTtN031V+qBILQg2bOnW+BQ3bxrbLI6eNlTRusqnX1/jKGltLsdlcina7GtNX
	 sdJQQfUk0EE5+DtYNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1x04q73jfK-00c86f; Tue, 19
 May 2026 18:58:09 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH 5/9] net: mdio: realtek-rtl9300: Add register structure
Date: Tue, 19 May 2026 18:57:43 +0200
Message-ID: <20260519165747.1288903-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6QSEdPBX3CxIxyVKCBHHvWwmvorj78IllKH6yv2ip6QfPJp0Zhz
 C2XzuSn0u/Fq8tQCMtQ4dk6L+5GwRSZgU6cSWSMshRfgL5AVmwDSUCPjtejgKoGd8ktRXbn
 lx+9snzyX2oIZXri4NFbLg9gupF+4H9gym9v0HR4jXezjI+qYuz9A0AQjX8W62mIMDH/DgJ
 yJePe60Xf64dufxu5eaFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XfC1HsWmiYM=;hQDedLk4SUX2MxtkWfcLxd9Ei+1
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289535-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: B042C582C80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MDIO controller of the Realtek Otto switches has either 4 or 7 command
registers. This depends on the number of supported ports. These registers
are "scattered" around the MMIO block and their addresses depend on the
specific model.

Nevertheless all command registers share a common pattern:

- A mask register with one bit per addressed port
- A I/O data register that transfers the to be read/written data
- A C45 registers that takes devnum and regnum
- A C22 register (page/register) that also includes run/status bits

Provide an additional structure for these command registers so it can be
reused in two places.

1. For defining the register addresses in the regmap.
2. For defining the to be read/written data

This will ultimately result in access patterns like

static int rtl_run_cmd(u32 cmd, struct rtl_mdio_cmd_regs *cmd_regs, ...)
{
  regmap_write(regmap, priv->info->reg->cmd_regs.c45_data,
                       cmd_regs->c45_data);
  ...
}

static int rtl9300_write_c45(...)
{
  struct rtl_mdio_cmd_regs cmd_regs =3D {
    .c45_data =3D ...
    .io_data =3D ...,
    .mask =3D ...,
  };

  return rtl_run_cmd(RTL9300_CMD_WRITE_C45, &cmd_regs, ...);
}

As a first step start with the C45 register.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 0ea691d9fc1b..e382f57b7738 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -39,7 +39,7 @@
 #define SMI_ACCESS_PHY_CTRL_2		0xcb78
 #define   PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   PHY_CTRL_DATA			GENMASK(15, 0)
-#define SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_ACCESS_PHY_CTRL_3	0xcb7c
 #define   PHY_CTRL_MMD_DEVAD		GENMASK(20, 16)
 #define   PHY_CTRL_MMD_REG		GENMASK(15, 0)
 #define SMI_PORT0_5_ADDR_CTRL		0xcb80
@@ -53,7 +53,12 @@
 #define RTL9300_NUM_PAGES		4096
 #define RTL9300_NUM_PORTS		28
=20
+struct rtl_mdio_cmd_regs {
+	u32 c45_data;
+};
+
 struct rtl_mdio_info {
+	struct rtl_mdio_cmd_regs cmd_regs;
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
@@ -234,7 +239,7 @@ static int rtl9300_mdio_read_c45(struct mii_bus *bus, =
int phy_id, int dev_addr,
=20
 	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
 	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_3, val);
+	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
 	if (err)
 		goto out_err;
=20
@@ -292,7 +297,7 @@ static int rtl9300_mdio_write_c45(struct mii_bus *bus,=
 int phy_id, int dev_addr,
=20
 	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
 	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_3, val);
+	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
 	if (err)
 		goto out_err;
=20
@@ -513,6 +518,9 @@ static int rtl_mdiobus_probe(struct platform_device *p=
dev)
 }
=20
 static const struct rtl_mdio_info rtl9300_mdio_info =3D {
+	.cmd_regs =3D {
+		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
+	},
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
=2D-=20
2.54.0


