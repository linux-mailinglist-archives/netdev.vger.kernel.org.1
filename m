Return-Path: <netdev+bounces-290586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKONDHJID2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:01:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4FA5AAB96
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9CD1300F5F0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A973FE343;
	Thu, 21 May 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="gkvKwdOi"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081553FD14D
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386403; cv=none; b=OFC9bcRVRHSZjJ1sqzMFkqzE/NSlOqhq3bFRNHcC78STSFXm2h9KEYh0uK+L2krwN3gMBkXiYBzHaxwrfX3OBbsD3jh4jJNbbKu9rbjUi/pIwWzdQbfe9hv3NjdcOLBKXa8fKbG/Tpzu6xCpj8PtbnRbjHQgt/WWKqz6EME6+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386403; c=relaxed/simple;
	bh=izdoFORXghVkA8vTDMCYxbZphUmokXboLDKjKcZrX7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSHm9PaXoRNRl9lxF1s3i8LueXuoUY/I2WYpUbxhKissKhuo3gWe8zUyFunC0jSF7A+R8/vRqmIAM7CfbD4zC0LPc4retPcodWmxLHaAwFeU/2zHDhWhNoIRV/cQe1S9WV8kF6zue5GgvmP0zfZSK4IhLrRscH+oj51ItvZr8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=gkvKwdOi; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386376; x=1779991176;
	i=markus.stockhausen@gmx.de;
	bh=QjUWEgy4UqxrEPwEvCiiHqvxXXRmiqB8grcOJlQUqiM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gkvKwdOiBodZEWGnxMJ98kv7n9IJu2uSGTKP9Q81XilWakOVsNNy3RuA/pCgIsf5
	 kFfLBI2vC6UGthIo9vpjwD6dEHdz5IEj7kCDc5fGB0f51ayy9rKHob6zS9TqssJ4R
	 fvpsLJSLad3Q+nKsR8c32msUU/GM3IzuRDQkgJSmd7kws6rHFyn1iL/74cxITRLLE
	 3OtCNFNJgPLlylhbifhNvIlMwhDO0jI7p67laeJu5OSeK08HI/zmPJoGldsfIhhqP
	 VWblsrKcceNtlhH0n1z4yYEoCTmAkieAzDdsdCamJxkYf8CsavvLPZVsbbASCFeqc
	 2xVR84l798xvE5nNzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1xGRQ21nT0-017p3Q; Thu, 21
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
Subject: [PATCH net-next v2 3/9] net: mdio: realtek-rtl9300: Add ports to info structure
Date: Thu, 21 May 2026 19:59:12 +0200
Message-ID: <20260521175918.1494797-4-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:ddGPXYOSbuVoMcrG2BJf3uIRoGUFPhe9dQ25jrZ2u7BB2JOWMB1
 k8uO8SP8yYsTlshmrbqp+32z8qZ1naOQT/VIng7F4KNcSwF1KY/TrM250BUfuwrayfPwcLX
 AyEEozAUWU9fsb+hLMm/gFaNo0m6IG15USDhPXsRe3m/JpgpgVlt2Wy19U8q8hLVElMpeuO
 baBcvbTNeWqLsFYsj8iuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8j4nZ3KyO3o=;InX9sUd4OVtP2QTgIB6b+8it7RS
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290586-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CB4FA5AAB96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ethernet MDIO controller in the Realtek Otto series has a very special
command register style. Instead of working with bus/address it works on
ethernet port numbers. For this the controller is initialized via mapping
registers that tell which port is mapped to which bus/address. Every
request to the driver is then converted as follows

1. Kernel calls driver with bus/address
2. Driver converts bus/address to port and issues command
3. Hardware maps port back to bus/address

The number of ports is different for each device. Make this configurable
by adding a property to the info structure. Switch the existing usage of
MAX_PORTS to this new property where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 931c6684b2f3..941e557bc0e2 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -52,6 +52,7 @@
 #include <linux/regmap.h>
=20
 #define RTL9300_NUM_BUSES		4
+#define RTL9300_NUM_PORTS		28
 #define SMI_GLB_CTRL			0xca00
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
 #define SMI_PORT0_15_POLLING_SEL	0xca08
@@ -80,6 +81,7 @@
=20
 struct otto_emdio_info {
 	u8 num_buses;
+	u8 num_ports;
 };
=20
 struct otto_emdio_priv {
@@ -106,7 +108,7 @@ static int otto_emdio_phy_to_port(struct mii_bus *bus,=
 int phy_id)
=20
 	priv =3D chan->priv;
=20
-	for_each_set_bit(i, priv->valid_ports, MAX_PORTS)
+	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports)
 		if (priv->smi_bus[i] =3D=3D chan->mdio_bus &&
 		    priv->smi_addr[i] =3D=3D phy_id)
 			return i;
@@ -351,7 +353,7 @@ static int otto_emdio_9300_mdiobus_init(struct otto_em=
dio_priv *priv)
 	int i, err;
=20
 	/* Associate the port with the SMI interface and PHY */
-	for_each_set_bit(i, priv->valid_ports, MAX_PORTS) {
+	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports) {
 		int pos;
=20
 		pos =3D (i % 6) * 5;
@@ -472,7 +474,7 @@ static int otto_emdio_map_ports(struct device *dev)
 		if (err)
 			return err;
=20
-		if (pn >=3D MAX_PORTS)
+		if (pn >=3D priv->info->num_ports)
 			return dev_err_probe(dev, -EINVAL, "illegal port number %d\n", pn);
=20
 		if (test_bit(pn, priv->valid_ports))
@@ -537,6 +539,7 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
+	.num_ports =3D RTL9300_NUM_PORTS,
 };
=20
 static const struct of_device_id otto_emdio_ids[] =3D {
=2D-=20
2.54.0


