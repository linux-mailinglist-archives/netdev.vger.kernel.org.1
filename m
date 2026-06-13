Return-Path: <netdev+bounces-298953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rLwqLVk/LWoheQQAu9opvQ
	(envelope-from <netdev+bounces-298953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 639AE67E76D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=eXJnYKfV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298953-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298953-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E83C303B7F4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3573BB9EB;
	Sat, 13 Jun 2026 11:30:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00C205E02;
	Sat, 13 Jun 2026 11:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350220; cv=none; b=efIApVdgYkgO3ACKsTpK9tteyxB8iPr/iJYmH6QGLGBMUziHO0tRw6HdJpRByUI8JmQl6JkX0mg544xgw8Y+gHlkQ7etIUWkzRx4GlQCuP8+/yeh61XhBU6NTqklL+KS109NqP6gziO56Yq6KgKfqE/N9v9qfSHD57G9hHehYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350220; c=relaxed/simple;
	bh=83CnmxJIoORj8sD1/HL3D3OJjvDgWMxzqkj5dTz8Uys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsbzX0IqukUvRv03P2mGDMcOhGntSMyxoR1ClzxoXfoTiHN37RTbL/5Z3EqPUFbh8yQjCDuqoxIM3H/UPXKF1YFUKd/sh0G7QkH0//YNPmuvs+NxlPXUlD1LoYHMOQw8YH503NS1SF0iOYdEFt7XiTgqiPdI7EpQEAqncqBzS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=eXJnYKfV; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350203; x=1781955003;
	i=markus.stockhausen@gmx.de;
	bh=Wk2V5pVCz8YqhVOB7hC417cg3hFobNv9hgCpjXNQfwQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eXJnYKfVYyrGOzABDtnrHzWfBhut/oCSUmZwEZvbyJRC/jmSMHpDN4i0M2fXdQvf
	 ikEWxYt4HdixH/kL1HYQtIb99f861fVWdoDVV11TLq4T3M1xvFev0h3UhKve5mgMH
	 0reu3eGZFzaAg86mt8K+kQo7JFiI1ZThDRvGDsOKYpm7512LOaIq0O/FcVRopBQfx
	 KusaZDZ20vFxI5U0d1H5AHEeqOd66E/cGz+ZraSBGpzLQGQkzPSCVbPt85x0h14UA
	 f76plCYV7SmV8LlTA+juexMnl8qZuRvaowFBwyWSKAbKqPUDpB/7IIA/LpbV1hMq6
	 P7hEZyCURqZyyJoDDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1xSutA1JZP-00yKoc; Sat, 13
 Jun 2026 13:30:03 +0200
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
Subject: [PATCH net-next 7/8] net: mdio: realtek-rtl9300: Add support for RTL838x
Date: Sat, 13 Jun 2026 13:29:45 +0200
Message-ID: <20260613112946.1071411-8-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mxuXcmZD3xZyk16lEnpw62Sfst/mGZTyq4XC0ur2Um/+4tYS0V4
 Q2GLeaDMvuH1emNh1W15VTY+laIpidBWqzbM1bBsK4BP+EXOLMkbyHBr9TgxzLYx88PN0R+
 ldnqnyBPH59PZUrdlPR5WtgEVd0M8uddM07CJaKmulxLcWVePc+FM1/JinPSPBpEansj3zK
 2xDh3om9X0/QonAlyTo1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nk4YfNzesrA=;ynqBnMkosZ53PeRalbsLNH3UYiA
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-298953-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 639AE67E76D

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
 drivers/net/mdio/mdio-realtek-rtl9300.c | 109 ++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 244af5fdeaf3..d9ff0b0aecbb 100644
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
@@ -381,6 +403,60 @@ static int otto_emdio_write_cmd(struct mii_bus *bus, =
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
@@ -615,6 +691,16 @@ static int otto_emdio_setup_topology(struct otto_emdi=
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
+	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL,
+			       RTL8380_SMI_PHY_PATCH_DONE);
+}
+
 static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
 {
 	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
@@ -855,6 +941,28 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
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
@@ -905,6 +1013,7 @@ static const struct otto_emdio_info otto_emdio_9310_i=
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


