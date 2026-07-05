Return-Path: <netdev+bounces-304794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzZTKviISmrKEQEAu9opvQ
	(envelope-from <netdev+bounces-304794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0018470A954
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 18:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=mPU7DL5J;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304794-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304794-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED2C303C03D
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B42F7F1F;
	Sun,  5 Jul 2026 16:36:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA172F7EE5;
	Sun,  5 Jul 2026 16:36:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269374; cv=none; b=g6i3cq4khfKiRkufN1yeaCtyc+PuJmLszcB+7yCVMOuqgyUXM7Kr//eQaJCDGIiRYjGOedkcKV16Xhc/wstkavZXO+cbISjVwzpF5b358o4F1E60rNMZ6Aehp0p58rRr9ze+vCRjpUJPltZ04T9K5/jsW58VOLppitPKNQ6V2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269374; c=relaxed/simple;
	bh=9Udjd8kXQnNi4a5APCEKl2/nRMD7dJdA1LYvq6Xf0Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8KJkulgfgly1KZALzlvOuqreAv8xPDfq+ld+F5obtlKTw++9ljW6edpfEKbyQx59+Ct/rmdHLlHfeIgnAwg50l0D7wB1q7rtASSNHXkxdFEXMQyC56I4a6STb6NhfczL4tMFOIzueAvj4GtJOQhyshWa8Ko50Uu1on4zWSrtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=mPU7DL5J; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783269348; x=1783874148;
	i=markus.stockhausen@gmx.de;
	bh=TFwNnnbWHnTazSJ7lW++cJ02voFhB/XCv67Jy1mkKeQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mPU7DL5Jhzw/Huzwvq0+F58Te1bxn5J4QJEAE1xFbVE9YKwRBcwzuYYtni7O9BaN
	 KfwMPNu239WlUpopoF+5FE++zPuFQAJTrC0eiGvCDxzufesTEIUUcyqiSHY0Cw2Hv
	 6V+GcPmZctLd08kSwSdmVgo8geH6bT8SbNLCgSNfUcuNFI+d01YC4PvDKDBvyZ5Dj
	 AStkv30NQ0R5KQtQw/2gHDYELmAe5yvquC+NDBnSC20MolHJod3XU/cnK1rSW2a2f
	 EZDzVZZ52gIS8/U9EknPehdmPTcvjIhCJiR0NuuxE8isYtD6euynFSg7XMQ2dCkGC
	 91M+dKXCop8Kji9f2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dwj-1xCZ5V3LJV-014X3p; Sun, 05
 Jul 2026 18:35:48 +0200
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
Subject: [PATCH net-next v3 5/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Sun,  5 Jul 2026 18:35:29 +0200
Message-ID: <20260705163532.2853959-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
References: <20260705163532.2853959-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BUZOTAOS+t9X8cZkQX5N3+NZent38XlN0M4n+Dt4PxK+2U2Ifvs
 lxeFgdQY8swJ1C7nUbwO8AA7RNfvnfkjpuKhTe7P7zuA5Jv3h0zb+6JO9g/RVtxjS/ZMiCL
 +aSvhHzyLZhqolYBdB5fCAHe45/7bLKU2ZzoXyeFkNjyhGuHl/+0cnXllam72EImdUs81QH
 OZvHRw84DyLLpQY5CA/cw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+ewLDskVmi8=;gvHHa8QiRKb1+v3WooIxutDOk3Z
 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
 e5lFZZQLg3e87fySixPm/48db4OB/4uSSvlgwfW
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-304794-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0018470A954

The hardware polling unit of the Realtek switches has a very special
handling for PHY register 31 (aka Realtek page register) in place.

- On the RTL838x it is permanently reset to zero.
- On other devices there is some magic saving/restoring (aka parking)
  in the background in place.

This makes access to PHYs a gamble.

As of now all known existing hardware designs have Realtek PHYs for 1G
connectivity. Otherwise the polling engine and the MAC status update
will not work at all and the vendor SDK would fail totally.

This driver differentiates clearly between C22 and C45 buses. During
probing it enables only one of the protocols for a bus. So it is safe
to assume that any C22 access will only target a Realtek based 1G PHY.
For safety reasons block any non-Realtek PHY on a C22 bus.

Intercept access to register 31 and handle it internally. Store the
desired value for each port in the driver. When issuing hardware access
to other registers add the page to the command towards the controller.
This given, the hardware will run two consecutive c22 commands that are
not interrupted by polling.

  ... hardware poll ...
  phy_write(phy, 31, page)
  phy_write(phy, reg, value)
  ... hardware poll ...

Remark! To keep this simple, writes to register 31 are only accepted if
they are lower than the device specific raw page - 0..4094/8190.
Otherwise -EINVAL is returned. Under the above assumption (Only 1G
Realtek PHYs on c22 bus) this is no limitation.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 34 ++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index c36244cd9a66..a5cac0d04114 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -171,6 +171,7 @@
 #define PHY_CTRL_CMD				BIT(0)
 #define PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
 #define PHY_CTRL_MMD_REG			GENMASK(15, 0)
+#define PHY_VENDOR_REALTEK			0x001cc800
=20
 #define MAP_ADDRS_PER_REG			6
 #define MAP_BITS_PER_ADDR			5
@@ -198,6 +199,7 @@ struct otto_emdio_priv {
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
+	u16 page[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -351,7 +353,7 @@ static int otto_emdio_9300_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, port),
 	};
=20
@@ -365,7 +367,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_REG_ADDR, regnum) |
 				  FIELD_PREP(RTL9300_PHY_CTRL_PARK_PAGE, 0x1f) |
-				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9300_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9300_PHY_CTRL_INDATA, value),
 		.port_mask_low	=3D BIT(port),
 	};
@@ -405,7 +407,7 @@ static int otto_emdio_9310_read_c22(struct mii_bus *bu=
s, int port, int regnum, u
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.broadcast	=3D FIELD_PREP(RTL9310_BC_PORT_ID, port),
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 	};
=20
 	return otto_emdio_read_cmd(bus, RTL9310_PHY_CTRL_TYPE_C22, &cmd_data,
@@ -417,7 +419,7 @@ static int otto_emdio_9310_write_c22(struct mii_bus *b=
us, int port, int regnum,
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	struct otto_emdio_cmd_regs cmd_data =3D {
 		.c22_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_REG_ADDR, regnum) |
-				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+				  FIELD_PREP(RTL9310_PHY_CTRL_MAIN_PAGE, priv->page[port]),
 		.io_data	=3D FIELD_PREP(RTL9310_PHY_CTRL_INDATA, value),
 		.port_mask_high	=3D (u32)(BIT_ULL(port) >> 32),
 		.port_mask_low	=3D (u32)(BIT_ULL(port)),
@@ -463,8 +465,12 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
nt phy_id, int regnum)
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D 31)
+			return priv->page[port];
+
 		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+	}
=20
 	return ret ? ret : value;
 }
@@ -478,8 +484,17 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 	if (port < 0)
 		return port;
=20
-	scoped_guard(mutex, &priv->lock)
+	scoped_guard(mutex, &priv->lock) {
+		if (regnum =3D=3D 31) {
+			if (value >=3D RAW_PAGE(priv))
+				return -EINVAL;
+
+			priv->page[port] =3D value;
+			return 0;
+		}
+
 		ret =3D priv->info->write_c22(bus, port, regnum, value);
+	}
=20
 	return ret;
 }
@@ -592,6 +607,7 @@ static int otto_emdio_notify_phy_attach(struct phy_dev=
ice *phydev)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
 	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct otto_emdio_chan *chan =3D phydev->mdio.bus->priv;
 	int ret;
=20
 	if (port < 0)
@@ -600,6 +616,12 @@ static int otto_emdio_notify_phy_attach(struct phy_de=
vice *phydev)
 	if (test_bit(port, priv->phy_poll))
 		return 0;
=20
+	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
+	    (!phy_id_compare_vendor(phydev->phy_id, PHY_VENDOR_REALTEK))) {
+		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
+		return -EOPNOTSUPP;
+	}
+
 	scoped_guard(mutex, &priv->lock) {
 		ret =3D otto_emdio_set_port_polling(priv, port, true);
 		if (!ret)
=2D-=20
2.54.0


