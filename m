Return-Path: <netdev+bounces-306059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UKGMLh9ET2qmdAIAu9opvQ
	(envelope-from <netdev+bounces-306059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:47:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A916A72D549
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:47:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=DRGHKL6z;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306059-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306059-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5A4E3035791
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5153DB328;
	Thu,  9 Jul 2026 06:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686C3D813D;
	Thu,  9 Jul 2026 06:42:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579352; cv=none; b=MqF8artcTfZRJwF1ZBqqcFb9g/8HpEI1aMHqKHIb6JXqKshCu4JZ+WmpA+laD4YC2bfyS8m4NXZ41frNmuOGXZEATqbsr12l6Fvy4rgsWg5odJO1SeDBTVwugSoGNBUHaBwyoZ/fU23zW4V58La0cHVsP8dvQi3ziESCnvYSKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579352; c=relaxed/simple;
	bh=+dR8UZiIvOormV9BhYeV0WEpTlr2J6FE+i5ZMrX6T0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gt86M9JrGq2dHwPPVnjAbnUJo0pLq62pa/wQynzZjwbpzhWvoHNg0s52ugcS/kkk+xjpeuf1U2MNR2n7/VXWgsvRoSxWSB5DUm6tWZ4nakY8lpXaYBsthAgJzty0AovHH/YS9qB3EusGCDu1yDsKnVpBiLU6d7ooQm6T+KSITSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=DRGHKL6z; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579334; x=1784184134;
	i=markus.stockhausen@gmx.de;
	bh=BV8mgC2toG5TVVVLGErISlLHzJBoZMep+wtt+Iq5J5U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DRGHKL6z0VhsBPlj2EH/kv9/wFI1S5lpQQzv6+P64xdMibVNW6X1/Lst6P0G1QfV
	 tFIXj/wIY2TFlKxJtVKgGYXI5D1EP7IHC8s+NSOCpox32KM4V9aj7aKhotjB+YDjV
	 PCvuXYhV45mhvB9wDX2zrEQR386jiW5o9M+4ryWoVUx65vNlGBVhAFchE/guHxMWT
	 zlzPrBxcHjV3Vw02hlnkNyIWmCwP2K2CBDlqGIvkeEOThBjgezoqra7WVt6A98Izu
	 da31tN1iRdXb2BAyt1pYWmlfvlFMq8m2/V+TMTwDbx3LbvS9iY2AYT1ypfcH/WTUJ
	 964GJUjENFNvAPGDKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1xMb861LI4-00ovqM; Thu, 09
 Jul 2026 08:42:14 +0200
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
Subject: [PATCH net-next v4 5/8] net: mdio: realtek-rtl9300: Add page tracking
Date: Thu,  9 Jul 2026 08:41:54 +0200
Message-ID: <20260709064157.2865063-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
References: <20260709064157.2865063-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TizMM6oC+0l3RDqSH//LvpY22cU6AqpTNo3DW3yp3knYV1nlJGh
 Q/5EvNi7gvtSwDAotev6WE8nr5z9PdV+XD3FSuQ8xzrVXSUAqvZ/AWIhObOZSPVrgmIKmDs
 SName1llQU8X2Ga6NpyMbyD82i9u3dE1eZFpqxXoveETWSOTa7Fai/MRuPh8OHT/dBmAu+6
 Ov+9A6MRUpzmN6dFr5I2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uqnh5OeYEAs=;Nbs8PRZYsOPJ2YulWvkN3QzG5mC
 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
 it3eWp4QpjYbB6MMmsdjr3Y97HaMVP
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306059-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A916A72D549

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
index 7096fb46b915..9141918e7c01 100644
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
@@ -592,11 +607,18 @@ static int otto_emdio_notify_phy_attach(struct phy_d=
evice *phydev)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(phydev->mdio.bus=
);
 	int port =3D otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr)=
;
+	struct otto_emdio_chan *chan =3D phydev->mdio.bus->priv;
 	int ret;
=20
 	if (port < 0)
 		return port;
=20
+	if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
+	    (!phy_id_compare_vendor(phydev->phy_id, PHY_VENDOR_REALTEK))) {
+		phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
+		return -EOPNOTSUPP;
+	}
+
 	scoped_guard(mutex, &priv->lock) {
 		if (test_bit(port, priv->phy_poll))
 			return 0;
=2D-=20
2.54.0


