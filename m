Return-Path: <netdev+bounces-302698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xZgjI0aRQmqE9wkAu9opvQ
	(envelope-from <netdev+bounces-302698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:37:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856B6DCC77
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:37:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="HGd/kpyd";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302698-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302698-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7C493015CA6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E33436354;
	Mon, 29 Jun 2026 15:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946C427A14;
	Mon, 29 Jun 2026 15:24:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746661; cv=none; b=KR6kETa4su74h/M/6AnQ0F7/Ezux1sc388et+GjhAi4tBv7PwKP9FV1ikIdT2illeu7gpqdQrIYUlL2PM0mL9vMnlfaiPF8e588bg8SlKfPZShm78K23hCuU5qHwLn5p3wUSvhS0gB6u1X9evoiNV79duAdabgmzrVIvoUdy5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746661; c=relaxed/simple;
	bh=fto1lhtmY+1Rh9pVTw+zHAiFv+RNnDnK7NHvT3QkLpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJmvtl2uAaAm+1/1MiNthklLj1DihR6HqdPwQ3Szq/Xi1ZD3jQ8y1pE0ONCf6gFCInGx36WBfqhdT89rrBkB4KQY9RGuvYEAuOpLytLrDrnpwgZ4B8cJqz2s5qOCp3wjsdI6DQzgfgGSP3sIRxupC5a49U6IU6gH9pTxsqQL0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=HGd/kpyd; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746633; x=1783351433;
	i=markus.stockhausen@gmx.de;
	bh=1mRjhp+GPTZdWugAbPDiyd6qimWVDoJkIK71DuM6YoE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HGd/kpyd2vuLbn2PSM1+diGq/taJOaHx9YzSYkza49ui9FKy3Clqq0JNZRf8WRFl
	 a+/+m0GgfyrXGpwvr4KcHB+pvhP4xJ6tElMU/Cj0FnzMkIXjLPDpcZdfVn5BNUqIt
	 udbz23d7jjPjcJlxGVLPQVehD10oxwWHmFjR6dn60nGDFiYxOhU3yIIb2iO5CJGWc
	 dTW+uwLE5LTk16BsdaRoERyCbNuiEI5NxsKMOS1gHJXJz5o64RYg5UdbVndnV8A8C
	 FAnhkxA+z3XQGplLot/p/2P95coop363y24G5KX3sdQeFSwWd9KMCGWMU+z8P2BnV
	 +funB46MVCJoZjkcWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1wZ5am1PXJ-00Hxyp; Mon, 29
 Jun 2026 17:23:53 +0200
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
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 7/8] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Mon, 29 Jun 2026 17:23:35 +0200
Message-ID: <20260629152336.2239826-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p7Y7diPtGuD/wOVhg1tWTNJ7Kk5js/3yDRwUsB+o8t8Qf6/RQp6
 SI2/ylYwbqjPg+iT33EDqDK8ivAKaPOvQqzq+/uihNYXTzbsO8Xe52LPkFCMTDA8dC2KQqF
 gAXDfM1FVZdl17zGLj9Gw3+olSb6vFQ3PyLDDM/CRQD5XQoSd3OVAXbOLH4yk3G7SFniXNz
 TGNFZzRHATtm7df/8h8Yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EK6YdN9Dsx4=;IqjDyzoF5DI/kDh88VtJbuKfszP
 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
 eK2ElNBGU8nAwc71Io=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302698-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8856B6DCC77

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL838x (aka maple) series. This is straightforward
but some things are worth mentioning.

- The device has a lot in common with the RTL930x series. 28 ports, 4096
  (Realtek) pages, 4 MMIO registers
- The MDIO engine has no fail bit. Thus the mask is set to zero
- There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
- The setup_controller() function needs no c45 setup but must activate
  the PHY access.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 108 ++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 206f4e85b82d..24a281b46526 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -117,6 +117,28 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
=20
+#define RTL8380_NUM_BUSES			1
+#define RTL8380_NUM_PAGES			4096
+#define RTL8380_NUM_PORTS			28
+#define RTL8380_SMI_GLB_CTRL			0xa100
+#define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
+#define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
+#define   RTL8380_PHY_CTRL_REG_ADDR		GENMASK(24, 20)
+#define   RTL8380_PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
+#define   RTL8380_PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
+#define   RTL8380_PHY_CTRL_WRITE		BIT(2)
+#define   RTL8380_PHY_CTRL_READ			0
+#define   RTL8380_PHY_CTRL_TYPE_C45		BIT(1)
+#define   RTL8380_PHY_CTRL_TYPE_C22		0
+#define   RTL8380_PHY_CTRL_FAIL			0 /* no fail indicator */
+#define RTL8380_SMI_ACCESS_PHY_CTRL_2		0xa1c0
+#define   RTL8380_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8380_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8380_SMI_ACCESS_PHY_CTRL_3		0xa1c4
+#define RTL8380_SMI_POLL_CTRL			0xa17c
+#define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -389,6 +411,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
u32 cmd,
 	return otto_emdio_run_cmd(bus, cmd | priv->info->cmd_write, cmd_data);
 }
=20
+static int otto_emdio_8380_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(RTL8380_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8380_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8380_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8380_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8380_PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -619,6 +695,15 @@ static int otto_emdio_setup_topology(struct otto_emdi=
o_priv *priv)
 	return 0;
 }
=20
+static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
+{
+	/*
+	 * PHY_PATCH_DONE enables PHY control via SoC. This is required for PHY =
access, including
+	 * patching and must be set before the PHYs are probed.
+	 */
+	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_P=
HY_PATCH_DONE);
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -916,6 +1001,28 @@ static int otto_emdio_probe(struct platform_device *=
pdev)
 	return 0;
 }
=20
+static const struct otto_emdio_info otto_emdio_8380_info =3D {
+	.addr_map_base =3D RTL8380_SMI_PORT0_5_ADDR_CTRL,
+	.cmd_fail =3D RTL8380_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8380_PHY_CTRL_READ,
+	.cmd_write =3D RTL8380_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.c22_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_1,
+		.c45_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_3,
+		.io_data =3D RTL8380_SMI_ACCESS_PHY_CTRL_2,
+		.port_mask_low =3D RTL8380_SMI_ACCESS_PHY_CTRL_0,
+	},
+	.num_buses =3D RTL8380_NUM_BUSES,
+	.num_pages =3D RTL8380_NUM_PAGES,
+	.num_ports =3D RTL8380_NUM_PORTS,
+	.poll_ctrl =3D RTL8380_SMI_POLL_CTRL,
+	.setup_controller =3D otto_emdio_8380_setup_controller,
+	.read_c22 =3D otto_emdio_8380_read_c22,
+	.read_c45 =3D otto_emdio_8380_read_c45,
+	.write_c22 =3D otto_emdio_8380_write_c22,
+	.write_c45 =3D otto_emdio_8380_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -966,6 +1073,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
nfo =3D {
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
+	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.54.0


