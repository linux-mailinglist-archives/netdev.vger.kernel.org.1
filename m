Return-Path: <netdev+bounces-294864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Js0HHjFsIGrj3AAAu9opvQ
	(envelope-from <netdev+bounces-294864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3663A5BA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=a6LCKgb3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294864-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294864-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 631363083EB1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D919737E2FB;
	Wed,  3 Jun 2026 18:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410637F8C6
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509612; cv=none; b=WfwGDh7xTPQg00GcuKFvIuwMiQpsbz7QQ6WsUz7tATPHEFM1pIOS/tUdVd3fKp0iS51rG82BEprglS5a+CKmSRHHnRAkEnUlQskhWI6OAJKJhn6ueuCtWCeIe5QpqhEqyPL4OmkTZl4flbx8UlGEHqbUBcG6o13PjEalmcpRMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509612; c=relaxed/simple;
	bh=47JHiTp58n1XRluBPYFzkw+QY/HsENVrTfVdqjy+zbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2/4aHrOddtboaoLr7Op+wV1GjJHcWknDyGpD1hr6jteGreOSIO9sJZm4wABNwyo5UGGrpCHO33aUpxmeLrFoLcVMDpPJWTRnE1y8LDebTVKqkBDHJCPeRef7YF2mMWIM193iL/Qp/hZPx+LFsFZgOgHrZtMxwVPZRz4OELV97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=a6LCKgb3; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509609; x=1781114409;
	i=markus.stockhausen@gmx.de;
	bh=RpK0CLysEiPlM/Lf3WbL4IHtxjLLOsB/X8xrRX1VMkI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a6LCKgb3T78ZfrTM1Hqdao6WlBdEoptaggb2Y4mZygxr4ldfkHbaiMxHUxGFZWxQ
	 MtBtGVlkwNdLYFRGPV29bQif5xDhchkaJEKDiICpq4SPfRU4i2j0+VjemmQvpir7w
	 lJxkh+ceGEjKwIjCsoyOExgqBd5ZLRsNgdhzUD2XmC9YO4RoF6KUqGPL0JCo03tkQ
	 jzAbeSIn7uSpKcRvlv9wIzKPcuF4AMsJrUovD+In24DMu/hOwdVn2/g0vQ+sgLOcx
	 gmOFURO8C1CaA7SPeGCXoi/0DKsLfVZbiESehMNVHsY63t7MUMNJ9ejU91PVIOR4F
	 SqoEvNxcRbtElSKvoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXhK-1wrKaR059G-00SxjM; Wed, 03
 Jun 2026 20:00:09 +0200
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
Subject: [PATCH net-next v2 5/7] net: mdio: realtek-rtl9300: relocate c22/c45 device tree readout
Date: Wed,  3 Jun 2026 19:59:22 +0200
Message-ID: <20260603175924.123019-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603175924.123019-1-markus.stockhausen@gmx.de>
References: <20260603175924.123019-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QSafC5AMmtdbSWk/XGaNbYNJWmH0dwprv1SMEh6vx+5CD7RAQEv
 54Ynct+bcCHX+IxWDIJCFN09FNfeeKV7/YaDltplO4gTqoJT+nz+5G4Bk5UhCHTDbnQfRSK
 OPevtLCUHzE3m/VLRCFdrNrIY4/aIxpJcqw+wh19RWDNvYOuwSH2nA5aL8AKXFcAyUaUtkf
 SaREF3jW2gh93yNvy1mBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9+rAh4450QE=;haE1tUsOdRSwJDyfr5kyHezEg1J
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,m:markus.stockhausen@gmx.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294864-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECE3663A5BA

otto_emdio_map_ports() is the central place to lookup the topology and the
properties of the Realtek ethernet MDIO controller from the device tree.
Deviating from this the c22/c45 detection via "ethernet-phy-ieee802.3-c45"
is running separately in otto_emdio_probe_one(). It loops over the same
nodes, just at a later point in time.

There is no benefit to divide this setup and to have a time window where
the data structure is only filled partially. Additionally it uses the
"fwnode" API. Consolidate the setup and convert it to the "of" API.

Remark. This is a subtle change for dangling PHY nodes (not referenced
by ethernet-ports). Before this commit all PHY nodes were evaluated for
c45 setup, now only the referenced ones.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 58854c54ad99..e626dd7fb4b8 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -405,18 +405,6 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
 		return dev_err_probe(dev, -EINVAL,
 				     "illegal (dangling) smi bus number %d\n", mdio_bus);
=20
-	/* The MDIO accesses from the kernel work with the PHY polling unit in
-	 * the switch. We need to tell the PPU to operate either in GPHY (i.e.
-	 * clause 22) or 10GPHY mode (i.e. clause 45).
-	 *
-	 * We select 10GPHY mode if there is at least one PHY that declares
-	 * compatible =3D "ethernet-phy-ieee802.3-c45". This does mean we can't
-	 * support both c45 and c22 on the same MDIO bus.
-	 */
-	fwnode_for_each_child_node_scoped(node, child)
-		if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45"))
-			priv->smi_bus_is_c45[mdio_bus] =3D true;
-
 	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*chan));
 	if (!bus)
 		return -ENOMEM;
@@ -506,6 +494,15 @@ static int otto_emdio_map_ports(struct device *dev)
 			goto put_nodes;
 		}
=20
+		/*
+		 * The MDIO accesses from the kernel work with the PHY polling unit in =
the
+		 * switch. The PPU either operates in GPHY (i.e. clause 22) or 10GPHY m=
ode
+		 * (i.e. clause 45). Select 10GPHY mode if there is at least one PHY th=
at
+		 * declares compatible =3D "ethernet-phy-ieee802.3-c45".
+		 */
+		if (of_device_is_compatible(phy_dn, "ethernet-phy-ieee802.3-c45"))
+			priv->smi_bus_is_c45[bus] =3D true;
+
 		__set_bit(pn, priv->valid_ports);
 		priv->smi_bus[pn] =3D bus;
 		priv->smi_addr[pn] =3D addr;
=2D-=20
2.54.0


