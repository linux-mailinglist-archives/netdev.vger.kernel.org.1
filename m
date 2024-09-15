Return-Path: <netdev+bounces-128440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F297989B
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 21:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D781F2131D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175E1C9EC8;
	Sun, 15 Sep 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="K+FBSnKp"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58807282E1
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430353; cv=none; b=IKa1u3o9atO6rfXeFXLlmf496y6fkdfC/Sbpi6eePQzm3S1k6tAFPXB6jEcU9olYqsDgCLqvAR4/NcDkNZ2whXP2DtwF+iUHS35pdEQ+W34F+xVKHTJemJn4vmIdHqn/37GXzfLJOFWs0d9jmiFElRbMSjVZEWO1S6fQkGqKBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430353; c=relaxed/simple;
	bh=qS2tSf1tnCgK+/ziMhz4gBpeHLEqRJNydsjVyTgfThw=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=Ocxyc53oPXvYMMHvZCvDOjWa8GAF/2gT62FjtAy2Hm1ReO4Fp8+lzyPZq3k7K7tCPowaSiAJqnnyjPqZCiwlUAWzoG2T7JadjKCURADSN9IPolPb2WsO/6lrctjoKstZ0brLpvT7eq8kchwE0oh0GG8EAKxo3hMXNIc4RYbGFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=K+FBSnKp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726430332; x=1727035132; i=hfdevel@gmx.net;
	bh=aKPnaE/sGZW7l9IIFC7zoZv8MQDp3E1USl98j92jEqk=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K+FBSnKpEiN9j5Vk7wpRb6khavkMtLBjOkFRJbAZPJcJc+QAivmSDetZbPF+67Gi
	 K6+dQv1mHQexHjyD+fJG8GxeW5UmBfzFf5YS58fqEKY3n+E759ZnnGgR6Y8pC+jRh
	 j3ofROTWgI4h1ialJRwJ+eaVlCS/wOhx+2e6oRPef+/TJN96JmesxhFiBJfD54S6P
	 lA9aZFEUHVwbz/ETVkYpbtl5iUkmM/gVQncekqwbwv4EfJdNI6/Y+YQCkzhZzTQJu
	 ItkoE8Xv5fOjJEHJbhx+8kwZwCHinv+xFQV0x8tijidMgY/Qw9AgRUfpusqJOgKdt
	 cpRoSiQ6dHh+xdobDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bap07.server.lan [172.19.172.77]) (via HTTP); Sun, 15 Sep 2024
 21:58:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-9144938c-87b3-4224-825e-464d6503be64-1726430331937@3c-app-gmx-bap07>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 3/7] net: phy: add swnode support to
 mdiobus_scan
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 21:58:51 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:gd0pROmslQIzLBwTUKCaHpogWUiKpL8jhzDEDturkFgX/f4imT02ad5fFmfwN/lspg6vp
 pb/qXERVQmcRDJkfizACm/HtobqcV6StlkAlaufw+oY1n2dtTQ4lRmBfS9drm6kXXIBy12wv0B2n
 6tx1dxKkgsW1YbMedCHruIreV3tBCoAR/NPGX3vhwzukWYlMCnx6qfHd0RATkcRz3rKbddOT7/8M
 OjDUIKbVy7KMenO0xoNk+r2cw1Uu7FvvG/4xhiHkd5cQ2uyqW7Vsk9UNcPcckfcKemHi3U08qeX0
 5Y=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UNpRoyeamOU=;Gaq991gqIRrlHpoDlQh5QJkE8rO
 F4Ob0B8gqr+MPW9frB99nUmViIMTcmIMi9EbpmeyKorUjNiIFylQi65BOuTn49Y3WiTORK3u/
 Do67oqSIWIE5IdMOwL81L9VSQkDz/Y6xFlackYI1Z9gZhmqCCTLfNP3TU5XXBaDoZe9eVd84+
 Pry7tAFDDIM1Uk1shfxC/ip0YLhnt2Lh7dxP8QBO/SbQD1zomyQGEUZ4IEcosOIsnGLqCxbhZ
 BJZDbMl+tWD3hTGNeVwEShpqQraqaQXAXF9xVIvNcsteHB4f7u/OVyUeJlrQOkyYnfM+ceKbI
 f56Jacr7QgifZvxdzEIX0QXbLkD3BshQpcLKHqxTQOQ9x42C932VX3TsSqnK+Am/uOTrTLaWq
 2Vp5CopWN3ECgyGmGG9Oe1yzJh9B9g+CdKpY5qm36syW8Rq3ZhBqfcj6jNscONxoKVBWC0D+Y
 RuDAnmWcGz9zHlVGqGjeBMA/2H5oMzufKytS4UItaoFMgyGirlxtzCWfhNVXqHO/eCdWWEaUk
 DfGSbcN4NHzX2fIIO7En04tXZU5KHcDptsLpyCd/TXn7UTGX9LB9AvUJaVCWfodpehSjfuVZu
 AIcRPH08Sg0vd0SqSHj6SdR5UYRLOZMy83CAYwIvY/3jmnybXrkemCxgbEHbivUVW/8SbKSf+
 DQZk92OAks7T3cPxAeqQUyNd1c0eqzYpZuy8428gPg==
Content-Transfer-Encoding: quoted-printable

Add swnode support to mdiobus_scan, to allow addition of a swnode/fwnode t=
o
a phy_device. The MDIO bus (mii_bus) needs to contain nodes for the PHY
devices, named "ethernet-phy@i", with i being the MDIO address
(0 .. PHY_MAX_ADDR - 1).

The fwnode is only attached to the phy_device if there isn't already an
fwnode attached.

fwnode_get_named_child_node will increase the usage counter of the fwnode.
However, no new code is needed to decrease the counter again, since this i=
s
already implemented in the phy_device_release function.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/phy/mdio_bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 7e2f10182c0c..ede596c1a69d 100644
=2D-- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -551,6 +551,8 @@ static int mdiobus_create_device(struct mii_bus *bus,
 static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, boo=
l c45)
 {
 	struct phy_device *phydev =3D ERR_PTR(-ENODEV);
+	struct fwnode_handle *fwnode;
+	char node_name[16];
 	int err;

 	phydev =3D get_phy_device(bus, addr, c45);
@@ -562,6 +564,18 @@ static struct phy_device *mdiobus_scan(struct mii_bus=
 *bus, int addr, bool c45)
 	 */
 	of_mdiobus_link_mdiodev(bus, &phydev->mdio);

+	/* Search for a swnode for the phy in the swnode hierarchy of the bus.
+	 * If there is no swnode for the phy provided, just ignore it.
+	 */
+	if (dev_fwnode(&bus->dev) && !dev_fwnode(&phydev->mdio.dev)) {
+		snprintf(node_name, sizeof(node_name), "ethernet-phy@%d",
+			 addr);
+		fwnode =3D fwnode_get_named_child_node(dev_fwnode(&bus->dev),
+						     node_name);
+		if (fwnode)
+			device_set_node(&phydev->mdio.dev, fwnode);
+	}
+
 	err =3D phy_device_register(phydev);
 	if (err) {
 		phy_device_free(phydev);
=2D-
2.45.2


