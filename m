Return-Path: <netdev+bounces-294866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U5tdFkpsIGrv3AAAu9opvQ
	(envelope-from <netdev+bounces-294866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C57DB63A5CD
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=MiQCpehZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294866-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294866-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80293308FC88
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB13380FDD;
	Wed,  3 Jun 2026 18:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBD3803E3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509613; cv=none; b=XoVciBWcbKCIJCadDSxpQdVcTBvpuLruTDkauKIInEfTYjY5iKWKB1ycAll/bgViJH8CltvUZ3/KM0owpJbBysV9QfeqAlZM8D6X4BrVFwjYvE70i5AurZIQswTncoIs4JXA0KhhNeFUbHD2H0mzp4ZrGYczKSWJRjdA3KtOU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509613; c=relaxed/simple;
	bh=HrIns+EXwcHziKLEun//Vh1EOLUP48WrMLwGLWbcJXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgPGN2cK4CROVZHVCc4lAtzJbPjZv/34gHriXGT/dxp8bgEoE0r4MQKWue7kFcLBTKcasQh6YNJWgU2GkIo917M80LTzSbf2FE7wB50PK7Z1BNYNG2YSQCuBcLzF1+aIT6/J6rc/CgX2S8Fze+mX2p/ET82VGDIz+BnUhoCXyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MiQCpehZ; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509607; x=1781114407;
	i=markus.stockhausen@gmx.de;
	bh=O5ftJ/vrqRmAcN03vYZqqD3tfna7lSUeuRi/OUfO5MU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MiQCpehZGY1tDXQev1lbFDbp1hk46wHenv8QvmFq7J5pkP3d708OCNeDuhtmgdnU
	 C+yHccQ3u3nt6h/G3bsAJoiV74D3ZB453sbMY6qNSeJtwi1Ma6rtUS3xbrLihfJXr
	 3Fpstb7hnQMLOuSjrjlD3B7+V64DYB8sxqynFfb5CiFe+O/U7aoM/Ku+VBCozMI3K
	 IJUK7BF9OG0Xqt0qwPGJLwkoE9+VVy2Q7vWo/2K5RcaB6ZcDFcJe+Mnnb4zKVItY6
	 Njxwy2cEYHwRtCpQX7ZIMMK2yfDDr7OlyJwe9Y7O898WYxa/J6mNAeMmn0K8kw5+a
	 qfqCNNbnqe1ClPDuYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1wdX432Szw-00P8G2; Wed, 03
 Jun 2026 20:00:07 +0200
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
Subject: [PATCH net-next v2 1/7] net: mdio: realtek-rtl9300: Refactor otto_emdio_map_ports()
Date: Wed,  3 Jun 2026 19:59:18 +0200
Message-ID: <20260603175924.123019-2-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:97C1CdbBmGM3ddsmtbpblFOmQ0RgDjH6UHefajHRSfiWZ6GiqNe
 DQEhaiZX5eIHxjHKrR5Ikjt75b7QCBBssaIUm+yBr8WE5x5Hi5cxYfU5RIO1lWYzC8LiLSB
 KvrkvkXOgtS9HHJEfPbpAk3ODOJFSfEEzQZTPxTP2MrOBsjyKvNqLKIlKf+Rv5thtMCdS6I
 9O7Dg/m9I2Fsia9+1PLZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TDklWOs1ZKE=;nj8+yoRsnYQYBWxlI7DK8MSAkFI
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
	TAGGED_FROM(0.00)[bounces-294866-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C57DB63A5CD

This function has multiple issues:
- It uses __free low level cleanups
- It mixes "fwnode" and "of" functions

Convert this to a uniform "of" usage and manual reference counting
cleanup. With that also fix two subtle lookup bugs in the original
code.

  mdio_dn =3D phy_dn->parent;
  if (mdio_dn->parent !=3D dev->of_node)
    continue;

This skips an API access and therefore misses reference counting.
Additionally in the case of a very buggy device tree, phy_dn might
be a root node. Looking up its grandparent leads to a NULL pointer
access.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 69 +++++++++++++++----------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index bafcd6afe619..a280363593d2 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -427,60 +427,75 @@ static int otto_emdio_probe_one(struct device *dev, =
struct otto_emdio_priv *priv
  */
 static int otto_emdio_map_ports(struct device *dev)
 {
+	struct device_node *ports_dn, *phy_dn, *bus_dn, *ctrl_dn;
 	struct otto_emdio_priv *priv =3D dev_get_drvdata(dev);
 	struct device *parent =3D dev->parent;
-	int err;
+	u32 addr, bus, pn;
+	int err =3D 0;
=20
-	struct fwnode_handle *ports __free(fwnode_handle) =3D
-		device_get_named_child_node(parent, "ethernet-ports");
-	if (!ports)
+	ports_dn =3D of_get_child_by_name(parent->of_node, "ethernet-ports");
+	if (!ports_dn)
 		return dev_err_probe(dev, -EINVAL, "%pfwP missing ethernet-ports\n",
 				     dev_fwnode(parent));
=20
-	fwnode_for_each_child_node_scoped(ports, port) {
-		struct device_node *mdio_dn;
-		u32 addr;
-		u32 bus;
-		u32 pn;
-
-		struct device_node *phy_dn __free(device_node) =3D
-			of_parse_phandle(to_of_node(port), "phy-handle", 0);
+	for_each_available_child_of_node_scoped(ports_dn, port_dn) {
+		ctrl_dn =3D NULL;
+		bus_dn =3D NULL;
+		phy_dn =3D of_parse_phandle(port_dn, "phy-handle", 0);
 		/* skip ports without phys */
 		if (!phy_dn)
 			continue;
=20
-		mdio_dn =3D phy_dn->parent;
+		bus_dn =3D of_get_parent(phy_dn);
+		if (!bus_dn)
+			goto put_nodes;
+
+		ctrl_dn =3D of_get_parent(bus_dn);
 		/* only map ports that are connected to this mdio-controller */
-		if (mdio_dn->parent !=3D dev->of_node)
-			continue;
+		if (ctrl_dn !=3D dev->of_node)
+			goto put_nodes;
=20
-		err =3D fwnode_property_read_u32(port, "reg", &pn);
+		err =3D of_property_read_u32(port_dn, "reg", &pn);
 		if (err)
-			return err;
+			goto put_nodes;
=20
-		if (pn >=3D priv->info->num_ports)
-			return dev_err_probe(dev, -EINVAL, "illegal port number %d\n", pn);
+		if (pn >=3D priv->info->num_ports) {
+			err =3D dev_err_probe(dev, -EINVAL, "illegal port number %d\n", pn);
+			goto put_nodes;
+		}
=20
-		if (test_bit(pn, priv->valid_ports))
-			return dev_err_probe(dev, -EINVAL, "duplicated port number %d\n", pn);
+		if (test_bit(pn, priv->valid_ports)) {
+			err =3D dev_err_probe(dev, -EINVAL, "duplicated port number %d\n", pn)=
;
+			goto put_nodes;
+		}
=20
-		err =3D of_property_read_u32(mdio_dn, "reg", &bus);
+		err =3D of_property_read_u32(bus_dn, "reg", &bus);
 		if (err)
-			return err;
+			goto put_nodes;
=20
-		if (bus >=3D priv->info->num_buses)
-			return dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n", bus)=
;
+		if (bus >=3D priv->info->num_buses) {
+			err =3D dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n", bus=
);
+			goto put_nodes;
+		}
=20
 		err =3D of_property_read_u32(phy_dn, "reg", &addr);
 		if (err)
-			return err;
+			goto put_nodes;
=20
 		__set_bit(pn, priv->valid_ports);
 		priv->smi_bus[pn] =3D bus;
 		priv->smi_addr[pn] =3D addr;
+put_nodes:
+		of_node_put(bus_dn);
+		of_node_put(phy_dn);
+		of_node_put(ctrl_dn);
+		if (err)
+			break;
 	}
=20
-	return 0;
+	of_node_put(ports_dn);
+
+	return err;
 }
=20
 static int otto_emdio_probe(struct platform_device *pdev)
=2D-=20
2.54.0


