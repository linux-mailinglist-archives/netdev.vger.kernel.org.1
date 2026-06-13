Return-Path: <netdev+bounces-298959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MwCqKmk/LWokeQQAu9opvQ
	(envelope-from <netdev+bounces-298959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E53B67E77B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:30:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=T77vHkW2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298959-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298959-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C6193011EA6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318A3E0232;
	Sat, 13 Jun 2026 11:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC753E0080;
	Sat, 13 Jun 2026 11:30:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350230; cv=none; b=Q24DyiLCQWyW+rUWSOjPVr4RNraMt4haw+NvHGvpC/55FgNMYHfLVGEnCwfVG4lloqyJaybfbtgOnySEgtAjlbGfnX7CASgmkX8iDeXqjlYoWexeetzxW/oZ1XYlB45rmIFijMKVzONWcuxjMGmNm/AcMmR39smtjNYcvwpLukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350230; c=relaxed/simple;
	bh=AepKWm1/TQoYh7hnyZlEB9fd6c0S6wf+d+DHgQxg+EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Ew0Wood/aWqb4Ey3AxRp5XkIhYBwjN2hdDRMm0hxvansdBhyDC4CZolMjlTuUvuLwwRj4mBwfOHdazfA8J+r11pJcebAhh+NmVkBf13BpcnyVl66W2n4aDWRJHZ9uP/f15bg6yYCetm9xhiz7o4c7nJ7aqCqs6h7Ir9US7orw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=T77vHkW2; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350203; x=1781955003;
	i=markus.stockhausen@gmx.de;
	bh=HmQ/YywZrGhpJ/QD69gQwh23fHIHWRgTaatijuJM7a0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T77vHkW2ViWh6Rn/ARZKCVELOhuBG+/eaH5E71lUw5wuzvIV3snT0Ilcp+yJ+y0+
	 ZgeiKMLaPOmBUZcHUe3ShjPT14ypBxCmeWg/L/0kjJf1P/SMONjsarUMdQ4kVIx96
	 3TF/IrwQ0HFs9JlX2iDBBJMjgO3SbaFT60nW5i+ZUiBySqUhhlnxZPuDoknu4fddO
	 BKBvcFiBbOlUwG0O5XGMqD7XSF2Ot7AYhWd8afzNYVTz63cLEOMAeOySt5msfXdWP
	 UycRDFGIGlaQDsbprOWgKx8hlvFVFBy4bNck/K/roshTiPaf6TzB93YurlFxWORiE
	 TnpHKmdpB7coKjobMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1wcT9u2hA9-0089u0; Sat, 13
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
Subject: [PATCH net-next 8/8] net: mdio: realtek-rtl9300: Add support for RTL839x
Date: Sat, 13 Jun 2026 13:29:46 +0200
Message-ID: <20260613112946.1071411-9-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:pK+tAFY2RRiCWJDA6iV4okNt78HMRamBPD1teNrLHizLiFqamhg
 sMvhEdMi+9Qm+l8dNkkw7M/oMmUbpHut4c6n+MgWrUJwj5Q/yg7yqohpeIa+Luy4Vo8IbeQ
 2e8K09tQCiJ4shf9TWt7+Mq7JESgA2s6aWkG4gVuhgp7/cVzoap3T3LQNKQhZrN+BQstXB5
 4nXJOLBaURKxlLzVhCWBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NStwBzDDG20=;vv7rm7wiBgSCzdfurNKHL9ui/Ee
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-298959-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E53B67E77B

The MDIO driver has been prepared for multiple device support. Add all
required bits for the RTL839x (aka cypress) series. This is straightforwar=
d
but some things are worth mentioning.

- The device has a lot in common with the RTL931x series. 8192 (Realtek)
  pages and 7 MMIO registers
- There are two SMI buses for 1G PHYs. Neither the bus nor address map
  register exists.
- The MAC layer shows link flapping when temporarily deactivating the
  hardware polling for one port. Mark this in the info structure.
- The hardware has not much to configure. So the setup_controller()
  function is not needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 104 ++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index d9ff0b0aecbb..2ab1aeb85eed 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -139,6 +139,29 @@
 #define RTL8380_SMI_POLL_CTRL			0xa17c
 #define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
=20
+#define RTL8390_NUM_BUSES			2
+#define RTL8390_NUM_PAGES			8192
+#define RTL8390_NUM_PORTS			52
+#define RTL8390_BCAST_PHYID_CTRL		0x03ec
+#define RTL8390_PHYREG_ACCESS_CTRL		0x03dc
+#define   RTL8390_PHY_CTRL_REG_ADDR		GENMASK(9, 5)
+#define   RTL8390_PHY_CTRL_PARK_PAGE		GENMASK(27, 23)
+#define   RTL8390_PHY_CTRL_MAIN_PAGE		GENMASK(22, 10)
+#define   RTL8390_PHY_CTRL_FAIL			BIT(1)
+#define   RTL8390_PHY_CTRL_WRITE		BIT(3)
+#define   RTL8390_PHY_CTRL_READ			0
+#define   RTL8390_PHY_CTRL_TYPE_C45		BIT(2)
+#define   RTL8390_PHY_CTRL_TYPE_C22		0
+#define RTL8390_PHYREG_CTRL			0x03e0
+#define   RTL8390_PHY_CTRL_EXT_PAGE		GENMASK(8, 0)
+#define RTL8390_PHYREG_DATA_CTRL		0x03f0
+#define   RTL8390_PHY_CTRL_INDATA		GENMASK(31, 16)
+#define   RTL8390_PHY_CTRL_DATA			GENMASK(15, 0)
+#define RTL8390_PHYREG_MMD_CTRL			0x03f4
+#define RTL8390_PHYREG_PORT_CTRL_LOW		0x03e4
+#define RTL8390_PHYREG_PORT_CTRL_HIGH		0x03e8
+#define RTL8390_SMI_PORT_POLLING_CTRL		0x03fc
+
 #define RTL9300_NUM_BUSES			4
 #define RTL9300_NUM_PAGES			4096
 #define RTL9300_NUM_PORTS			28
@@ -457,6 +480,62 @@ static int otto_emdio_8380_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, RTL8380_PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_8390_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(RTL8390_PHY_CTRL_MAIN_PAGE, priv->page[port]),
+		.ext_page	=3D FIELD_PREP(RTL8390_PHY_CTRL_EXT_PAGE, 0x1ff),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C22, &cmd_data);
+}
+
+static int otto_emdio_8390_read_c45(struct mii_bus *bus, int port,
+				    int dev_addr, int regnum, u32 *value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, port),
+	};
+
+	return otto_emdio_read_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data,
+				   RTL8390_PHY_CTRL_DATA, value);
+}
+
+static int otto_emdio_8390_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(RTL8390_PHY_CTRL_INDATA, value),
+		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
+		.port_mask_low	=3D (u32)(BIT_ULL(port)),
+	};
+
+	return otto_emdio_write_cmd(bus, RTL8390_PHY_CTRL_TYPE_C45, &cmd_data);
+}
+
 static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -963,6 +1042,30 @@ static const struct otto_emdio_info otto_emdio_8380_=
info =3D {
 	.write_c45 =3D otto_emdio_8380_write_c45,
 };
=20
+static const struct otto_emdio_info otto_emdio_8390_info =3D {
+	.cmd_fail =3D RTL8390_PHY_CTRL_FAIL,
+	.cmd_read =3D RTL8390_PHY_CTRL_READ,
+	.cmd_write =3D RTL8390_PHY_CTRL_WRITE,
+	.cmd_regs =3D {
+		.broadcast =3D RTL8390_BCAST_PHYID_CTRL,
+		.c22_data =3D RTL8390_PHYREG_ACCESS_CTRL,
+		.c45_data =3D RTL8390_PHYREG_MMD_CTRL,
+		.ext_page =3D RTL8390_PHYREG_CTRL,
+		.io_data =3D RTL8390_PHYREG_DATA_CTRL,
+		.port_mask_low =3D RTL8390_PHYREG_PORT_CTRL_LOW,
+		.port_mask_high =3D RTL8390_PHYREG_PORT_CTRL_HIGH,
+	},
+	.link_flap =3D true,
+	.num_buses =3D RTL8390_NUM_BUSES,
+	.num_pages =3D RTL8390_NUM_PAGES,
+	.num_ports =3D RTL8390_NUM_PORTS,
+	.poll_ctrl =3D RTL8390_SMI_PORT_POLLING_CTRL,
+	.read_c22 =3D otto_emdio_8390_read_c22,
+	.read_c45 =3D otto_emdio_8390_read_c45,
+	.write_c22 =3D otto_emdio_8390_write_c22,
+	.write_c45 =3D otto_emdio_8390_write_c45,
+};
+
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
 	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
@@ -1014,6 +1117,7 @@ static const struct otto_emdio_info otto_emdio_9310_=
info =3D {
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
 	{ .compatible =3D "realtek,rtl8380-mdio", .data =3D &otto_emdio_8380_inf=
o },
+	{ .compatible =3D "realtek,rtl8391-mdio", .data =3D &otto_emdio_8390_inf=
o },
 	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &otto_emdio_9300_inf=
o },
 	{ .compatible =3D "realtek,rtl9311-mdio", .data =3D &otto_emdio_9310_inf=
o },
 	{}
=2D-=20
2.54.0


