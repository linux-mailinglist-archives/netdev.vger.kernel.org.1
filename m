Return-Path: <netdev+bounces-290580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFcyGxtKD2qPIwYAu9opvQ
	(envelope-from <netdev+bounces-290580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:08:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A75AACBD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00ECD30767BA
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68AE379ECF;
	Thu, 21 May 2026 17:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="m0s0VKQp"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5B3E5587
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386391; cv=none; b=PLqAJbo9/p958auASLRIPpi4NMy1+rRNGIJ0Es1JQvZutIJ1BhAY4a+grrvnyf78FUEcY22IpqZ5c37WhCszgcq+pJ2Ma9ENfI2HTkmwrwnWqMgWmbpxnmGL1OJeFtuKouLYsDLqjUqHqWw3XC5P1gHY7LXt0JqrQi3CbfrNzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386391; c=relaxed/simple;
	bh=R1I9KFE9fOZv9NX7CZ8r36ot2Jt55pIhJ4oYzduYNn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFEJfORJP4WF6IT1+CiT4H8bxSiiY+S/6VaNDb8/mYs/GeIkrrtFMW3Fb4aI1a6Dyp3Oi7QpXfwCvk2zZOXzSMlg6phJ7qdkoPEJUQ8MFCl9NFHf01S8gBY/pBDTfNHyFFZTKc7YRC6Keive5JBXtBdqppndoPmp1ujFdvTAVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=m0s0VKQp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386377; x=1779991177;
	i=markus.stockhausen@gmx.de;
	bh=yaq+uL6IDkWme7/hRSmyaY0YOdEuJ7ILqkA84J6bgfk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m0s0VKQpirV1ezMyydKvoQCKLyMtfX4tEz2pFqzFwSDlspCObt+AI/HHypLeGgL6
	 EQdrITgojP426aK/VbsE0ZpqbaHLfXLvAfvmmgiuv9iJEXM97nig7ZWtI/dMuhei+
	 9s0Q/iz2DICws121ahkvrRFcqs2EYiirhbRQTtc12VgbeyzpAVd2i5s5eDIyb75aa
	 R667AzYBmWwnPSLDSs8bvVJvqc3gjehvhjo7wzNfGrX0U65fpdZV8bIWC+2kHvnL4
	 JO+so3T3VZYi5zYjf4bvz+bTZeVvdZaRBvnNXKV+COpScIUT9/7oA+vc7uM07wfV/
	 FjT0+8OeitqCS75AgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1wvKhL3raR-00mZfx; Thu, 21
 May 2026 19:59:36 +0200
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
Subject: [PATCH net-next v2 5/9] net: mdio: realtek-rtl9300: Add register structure
Date: Thu, 21 May 2026 19:59:14 +0200
Message-ID: <20260521175918.1494797-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
References: <20260521175918.1494797-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tRnQ7VtkJDKRSARCbI6U70BZoJfoKHCTq5aMRPdTJOJUJHqPpsT
 Bb92jLsyjfQbUqTKO74+aTBF+WZdOBRcXgZ2/P4bxDCc8MIg7TTYY204KaMD0u9Z2wv15pg
 s4ldbHnunxCn2BT6on8ZA2U5zmoHbL/1N1aab1Jr3Kovs4D+pqz/cTBR97WofQMFh8prRDY
 4j2BM7ibelho5zwQ39GWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vnP11JZ5p6E=;hLXxsaHpY9vqqZA9QbCvr7S9XVH
 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
 29pMzVcRMRHGtSKQJqYISY/T6nMpdsWO1Wzg7yB
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290580-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DA1A75AACBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MDIO controller of the Realtek Otto switches has either 4 or 7 command
registers. This depends on the number of supported ports. These registers
are "scattered" around the MMIO block and their addresses depend on the
specific model.

Nevertheless all command registers share a common pattern:

- A mask register with one bit per addressed port
  (remark: the driver internally works on ports instead of bus/address)
- A I/O data register that transfers the to be read/written data
- A C45 registers that takes devnum and regnum
- A C22 register that also includes run and status bits
  (remark: this also takes the Realtek proprietary C22 PHY page)

Provide an additional structure for these command registers so it can be
reused in two places.

1. For defining the register addresses in the regmap.
2. For defining the to be read/written register data

This will finally result in access patterns like

static int otto_emdio_run_cmd(u32 cmd,
                              struct rtl_mdio_cmd_regs *cmd_regs, ...)
{
  regmap_write(regmap, priv->info->reg->cmd_regs.c45_data,
                       cmd_regs->c45_data);
  ...
}

static int otto_emdio_9300_write_c45(...)
{
  struct otto_emdio_cmd_regs cmd_regs =3D {
    .c45_data  =3D ...
    .io_data   =3D ...,
    .port_mask =3D ...,
  };

  return otto_emdio_run_cmd(RTL9300_CMD_WRITE_C45, &cmd_regs, ...);
}

As a first step start with the C45 register. This one takes the
devnum/regnum data that is stored in the high/low 16 bits.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 94f59a56bc46..c992f09835f9 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -71,7 +71,7 @@
 #define SMI_ACCESS_PHY_CTRL_2		0xcb78
 #define   PHY_CTRL_INDATA		GENMASK(31, 16)
 #define   PHY_CTRL_DATA			GENMASK(15, 0)
-#define SMI_ACCESS_PHY_CTRL_3		0xcb7c
+#define RTL9300_SMI_ACCESS_PHY_CTRL_3	0xcb7c
 #define   PHY_CTRL_MMD_DEVAD		GENMASK(20, 16)
 #define   PHY_CTRL_MMD_REG		GENMASK(15, 0)
 #define SMI_PORT0_5_ADDR_CTRL		0xcb80
@@ -81,7 +81,13 @@
 #define MAX_SMI_ADDR	0x1f
 #define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
=20
+
+struct otto_emdio_cmd_regs {
+	u32 c45_data;
+};
+
 struct otto_emdio_info {
+	struct otto_emdio_cmd_regs cmd_regs;
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
@@ -262,7 +268,7 @@ static int otto_emdio_9300_read_c45(struct mii_bus *bu=
s, int phy_id, int dev_add
=20
 	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
 	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_3, val);
+	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
 	if (err)
 		goto out_err;
=20
@@ -320,7 +326,7 @@ static int otto_emdio_9300_write_c45(struct mii_bus *b=
us, int phy_id, int dev_ad
=20
 	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
 	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_3, val);
+	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
 	if (err)
 		goto out_err;
=20
@@ -541,6 +547,9 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 }
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
+	.cmd_regs =3D {
+		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
+	},
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
=2D-=20
2.54.0


