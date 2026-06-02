Return-Path: <netdev+bounces-294020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEZnG61pHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0A628883
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40EC1300EE83
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283172F8EA2;
	Tue,  2 Jun 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="JNkeLwDs"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F68245005
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378016; cv=none; b=le4vNMZ3bhYQv2ShBNc5X4/RCDFSi1ezhNEgvDNLHUxc5Yo9asv2p0OQ2SlevKDQKUbUqFqehSC2CtQqefhAiYVxP6ZmKROagqq6LP7eO7vDvKphCRVi9v9hLvZotoSnGuF3BPQPFO/q4V6nY3aFw/EVYI0OIvFKGS9zYRpSExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378016; c=relaxed/simple;
	bh=Pzmz/ZiXwUi9g1RGMREVDozACgPjMzLOqppNonk1Wuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Abs8M6uq5xHp5WkIUSYKSS/fi7Ij6X5Sx1oMPljVA5CE0NgtjuxTrqlV4m+A/duA1Gfr8GMurAnQn8jtE1JR09EmQUHWj63obFk3uQ/44+qj6dpMv7u+SCir/wzCexKCelwHIO79YDMoNjY5ap1MZImjO73Sx536J30pdvMWbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=JNkeLwDs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378012; x=1780982812;
	i=markus.stockhausen@gmx.de;
	bh=+l2YrNbTt/eP4TpQdqJevln6YmLUl32z6iqezxEYii0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JNkeLwDsw6Ec/y1kWq+Myq9CFV75Jv0MlvV8KmrbU4FufgRzlkT7B5V18UGuTSsU
	 RHKjzXQK0D+oLlNWl5uvbGfaG8yj5X9e7O1AM/Vet510eIcNq2nKUEM6B/e42qNhX
	 SRrTapFAyd0SvW4Igkb/Z1z0J2d5eNWgwFLcRLbrPCQvqnG1xmtkYXb+HhQ8mTinC
	 tMjMmwPTvLDoMLCzlb0NBooulS1tc2AQ8ZkViS0wxfvzmfNBbH9YlqxY0yzD4POgw
	 DinhpFwEwCiyG0hoNANdqYFqPz1//sbA+3BnViVOJE9x6y6r/4LE6udtlAdfnKRfV
	 asccMsnb7ki2tvNzoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1wU0fQ2nUB-007Lla; Tue, 02
 Jun 2026 07:26:51 +0200
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
Subject: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to fwnode API
Date: Tue,  2 Jun 2026 07:26:33 +0200
Message-ID: <20260602052640.93083-2-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:42nVoAHKRHRuRuoXzUe+wv3c8+4WxVG+NivVTbI26mMtqxdPhh8
 Uz+frDFAGPCYPBXf9pHDICwfp39Y0st9eer1CS4QiroBqTn4lJ5Q+O0nXoD55CaPodsrA17
 DJ7aOon29skFQXVtNNPwTKU+ytbV5t6xIk9B4zFu9reISlJLNAesZRHeMCibwqH/xCvphsa
 fLni5TKzJC1GW7gQ6+Y5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nid2U49EoDE=;JJRew5c6ej+8chTxuOkZdWU8vkE
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294020-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00E0A628883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver still uses legacy "of_" functions to determine the port mapping
during probing. Convert this to the modern fwnode API. With that also fix
a subtle lookup bug in the original code.

  mdio_dn =3D phy_dn->parent;
  if (mdio_dn->parent !=3D dev->of_node)
    continue;

In the case of a very buggy device tree, phy_dn might be a root node. When
trying to look up its grandparent this leads to a NULL pointer access.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index bafcd6afe619..1ccc0ab0daef 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -438,20 +438,25 @@ static int otto_emdio_map_ports(struct device *dev)
 				     dev_fwnode(parent));
=20
 	fwnode_for_each_child_node_scoped(ports, port) {
-		struct device_node *mdio_dn;
 		u32 addr;
 		u32 bus;
 		u32 pn;
=20
-		struct device_node *phy_dn __free(device_node) =3D
-			of_parse_phandle(to_of_node(port), "phy-handle", 0);
+		struct fwnode_handle *phy_fwnode __free(fwnode_handle) =3D
+			fwnode_find_reference(port, "phy-handle", 0);
 		/* skip ports without phys */
-		if (!phy_dn)
+		if (IS_ERR(phy_fwnode))
 			continue;
=20
-		mdio_dn =3D phy_dn->parent;
+		struct fwnode_handle *bus_fwnode __free(fwnode_handle) =3D
+			fwnode_get_parent(phy_fwnode);
+		if (!bus_fwnode)
+			continue;
+
+		struct fwnode_handle *ctrl_fwnode __free(fwnode_handle) =3D
+			fwnode_get_parent(bus_fwnode);
 		/* only map ports that are connected to this mdio-controller */
-		if (mdio_dn->parent !=3D dev->of_node)
+		if (ctrl_fwnode !=3D dev_fwnode(dev))
 			continue;
=20
 		err =3D fwnode_property_read_u32(port, "reg", &pn);
@@ -464,14 +469,14 @@ static int otto_emdio_map_ports(struct device *dev)
 		if (test_bit(pn, priv->valid_ports))
 			return dev_err_probe(dev, -EINVAL, "duplicated port number %d\n", pn);
=20
-		err =3D of_property_read_u32(mdio_dn, "reg", &bus);
+		err =3D fwnode_property_read_u32(bus_fwnode, "reg", &bus);
 		if (err)
 			return err;
=20
 		if (bus >=3D priv->info->num_buses)
 			return dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n", bus)=
;
=20
-		err =3D of_property_read_u32(phy_dn, "reg", &addr);
+		err =3D fwnode_property_read_u32(phy_fwnode, "reg", &addr);
 		if (err)
 			return err;
=20
=2D-=20
2.54.0


