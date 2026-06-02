Return-Path: <netdev+bounces-294022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKVaFDhqHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C48116288D4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 358BC308442D
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC452E2F0E;
	Tue,  2 Jun 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="BUjhFZZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8523ABB9
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378028; cv=none; b=UZiJoI0Vj1ijA6x3yoImzFr4KXnalkBO5xdM0Wc2PIKv+lkZb0VvtkcAR4zknOPUARGM112AuxgmyXx5DXO1f0ZOrO07+plBOPfDqCUUgwMGJt8ra5z/YMZNokp/YmaHVUFRs4+kjRavlinswEGPlFJVff7MFUiAirnlbWOxjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378028; c=relaxed/simple;
	bh=TJLUvnVyluilqZJZFClqwraIj/bBFDXuKSBQSw/rhaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZKM0PbhFHyU4pFtrYw9n79p6n9zohOndPZUAG6w2gVzOw7H7+Exhz5WjsK85kiahV5+H1x2EFd/FO7ofEgmkynY73ieQvmP7TBnwRg3pquWF6rsp6P/kwsivBNLs9SHcG/ueBF0OqNugM0XvjzGppAs4XWH90M3FQKc/RiqJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=BUjhFZZJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378015; x=1780982815;
	i=markus.stockhausen@gmx.de;
	bh=6D2j8nxWMlpKZuVL0u3EU1ZfPQfahH90SbB2L+XA7HQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BUjhFZZJCTVqiikbIjPwPDrKUCDeHCL4DBjFUSsBfYQ5PwpM1ZZT6eaXaRXnkJ12
	 IGLlbJQUP1tCbB7YzP9/W3SODvatmvLFibeZLcd6w8x6e4X6rifRoBxgcvnssojLO
	 fACXgLzsCyBY2lbwkDTJIFXCTOcZ0YHBzKxiF23IIHdsvMfcJ8eHXYnqycJ2Vel/Q
	 GcoM+kTbMScFYhngKCET3cYFboRQQUcyIBKp1XGFVDi1U30POrPUKZz/bcmeRGOlr
	 9Qj5qb8+vK8Lp0FmF9FlYa9xHo2RjQJ0JefADJMB4GtF7UWiZCiCDNA8HU8pB2kfD
	 879r6Kn2/hzDcZp74A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1wzEgJ0Lc8-00biNN; Tue, 02
 Jun 2026 07:26:55 +0200
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
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 8/8] net: mdio: realtek-rtl9300: Convert port lookup from O(n) to O(1)
Date: Tue,  2 Jun 2026 07:26:40 +0200
Message-ID: <20260602052640.93083-9-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602052640.93083-1-markus.stockhausen@gmx.de>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sLY7fos0kSDX1umQoCQ15xPvdKXS8QD8GgX29cGXjD6CeQNFmYl
 Twv0haHZXuYPP4dpGCL+difil6pUEhNBAdKAxogj6RCw0qF6sFEjGgVdRQKWP1ApJchiPOR
 j0PZO5U0wu4bgJxmBIszBoQu/z72T94Lz6UbvVOlxAmGVvwo92JMktoreDkcNp0yzz67IW/
 5xhmmD4tAC0elJWHx/IdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nu304i5MyD0=;ImjKvcVZ2pSqIqPK3IMOnBkT7eP
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294022-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: C48116288D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When addressing a PHY on a bus/address the driver must translate that into
a port number. This is currently done with an effort of O(n). The driver
loops over all known ports and checks each if bus and address match. This
is very inefficient especially for the following reasons:

- The lookup must run for each single read/write operation
- The SoCs have very low specs (e.g. RTL838x one core, 16K cache, 500 MHz)
- High-port-count devices RTL839x and RTL931x provide up to 52 PHY ports

Create a reverse lookup table per channel during setup. This stores the
(overall) port number per PHY (on that channel). Take special care about
absent ports that are missing from device tree because of hardware design.
Save memory by using s8 type for the table (-1 =3D absent, 0..56 =3D port)=
.
Convert the lookup in otto_emdio_phy_to_port() from loop-based to
table-based.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 29 +++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 50fc8582571d..a36cb711b8ad 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -78,6 +78,7 @@
=20
 #define MAX_PORTS				28
 #define MAX_SMI_BUSSES				4
+#define PORT_ABSENT				-1
 #define RAW_PAGE(priv)				((priv)->info->num_pages - 1)
=20
=20
@@ -118,23 +119,17 @@ struct otto_emdio_info {
=20
 struct otto_emdio_chan {
 	struct otto_emdio_priv *priv;
-	u8 mdio_bus;
+	s8 port[PHY_MAX_ADDR];
 };
=20
-static int otto_emdio_phy_to_port(struct mii_bus *bus, int phy_id)
+static int otto_emdio_phy_to_port(struct mii_bus *bus, unsigned int phy_i=
d)
 {
 	struct otto_emdio_chan *chan =3D bus->priv;
-	struct otto_emdio_priv *priv;
-	int i;
-
-	priv =3D chan->priv;
=20
-	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports)
-		if (priv->smi_bus[i] =3D=3D chan->mdio_bus &&
-		    priv->smi_addr[i] =3D=3D phy_id)
-			return i;
+	if (phy_id >=3D PHY_MAX_ADDR || chan->port[phy_id] =3D=3D PORT_ABSENT)
+		return -ENOENT;
=20
-	return -ENOENT;
+	return chan->port[phy_id];
 }
=20
 static struct otto_emdio_priv *otto_emdio_bus_to_priv(struct mii_bus *bus=
)
@@ -390,8 +385,8 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 {
 	struct otto_emdio_chan *chan;
 	struct mii_bus *bus;
-	u32 mdio_bus;
-	int err;
+	u32 mdio_bus, port;
+	int i, err;
=20
 	err =3D fwnode_property_read_u32(node, "reg", &mdio_bus);
 	if (err)
@@ -427,11 +422,17 @@ static int otto_emdio_probe_one(struct device *dev, =
struct otto_emdio_priv *priv
 	}
 	bus->parent =3D dev;
 	chan =3D bus->priv;
-	chan->mdio_bus =3D mdio_bus;
 	chan->priv =3D priv;
=20
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
=20
+	/* setup reverse lookup bus/address -> port */
+	for (i =3D 0; i < PHY_MAX_ADDR; i++)
+		chan->port[i] =3D PORT_ABSENT;
+	for_each_set_bit(port, priv->valid_ports, priv->info->num_ports)
+		if (priv->smi_bus[port] =3D=3D mdio_bus)
+			chan->port[priv->smi_addr[port]] =3D port;
+
 	err =3D devm_of_mdiobus_register(dev, bus, to_of_node(node));
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
=2D-=20
2.54.0


