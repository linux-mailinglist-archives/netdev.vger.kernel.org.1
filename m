Return-Path: <netdev+bounces-294869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3pNCtlsIGof3QAAu9opvQ
	(envelope-from <netdev+bounces-294869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:05:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964763A633
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="N8C/bix6";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294869-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294869-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A83F430591F4
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA93839BB;
	Wed,  3 Jun 2026 18:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD56379C27
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509631; cv=none; b=jrCV1oOlsefXTcaR2y3N03x2D/R8B9bxXzEzhpBZZnjGkULFQZURcWfp1VM6nekS1eqTPss0givJOEbrHnDUTHwyuHLORBiXEdFN2jImUHF3htfNW/hEfpWLgXpPA4wIwuB109m6tnM0vRSLR19rE0XK3xlb1DE4tPODFuqeQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509631; c=relaxed/simple;
	bh=msnMT1yjN7oYU2FK0uqzaKllktRCtgsObFdZa7tVY/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8IhUCc/w0pJYd7MUTNJZ46ze/GRB+eJ+GPV0/OlqeIcRdb4nLk7E5k13BPZnQZnzKSkygWPDHfKp70roNSXUxTuLPLqUxkSsTXPkKksd62tWQv6L/G/zPIyh7VnofAPuLPfB8oZhmaIRJAkPuj3EqFrD6pWPsQWy1swAeSRzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=N8C/bix6; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509609; x=1781114409;
	i=markus.stockhausen@gmx.de;
	bh=9gs+NoSC8FLPIMgx3VFAqE/XXu0YCFvrHKsN6DjzAOY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N8C/bix6rz9I7OrXsUZiOtNPlDXBYbnS8mG6mtmqcKuxTMtC6npYbvN/8AOKptBH
	 bTcmkcjr8uBOubx0beiIIZCvPcOpatLTii7rAw7oztRqicWFtJ7tpp/Z7zTcniJVM
	 nbQ1YGzV87mcAj9dg410rtY1W4TJyBFGB9YsqHvjZVLMWACFsDkA3FscvGoIQ1WEv
	 xqVU2aXdEyDQLUkJZZyBoeuursOlTwR7vFVmJYaxz+2GYF7Z/neycl2z9wK+TA88h
	 PKNfVJzlSbjlqmhFFctOfvECiEp7POGkwPPKDOI1B9buI5yby0kUvEMwKUv2qSVLg
	 TVIO/a1ni6+vD4zefA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1weM0o32Qd-00OJ2n; Wed, 03
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
Subject: [PATCH net-next v2 7/7] net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package
Date: Wed,  3 Jun 2026 19:59:24 +0200
Message-ID: <20260603175924.123019-8-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:7OIfbT3DQOY0HiJQL7Mlsg18c1XMQurqaZWLbE0HPa1ikEXsYs3
 B4onpT8WLl73Nrs5Zxceu04ITSpCwX+gRCUFQUo1UZcsKDfpocCVNLxee9R9wK5XBBMkle8
 Qo6kSSN4TrNTYqjwdnqUaAKro8s9kchCD8tcvpDEGaGe2pIQmhBxZvnfKnrMq/GujBOLdqk
 9LB/UN5kMvg2SWcGnModA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:84LkpLAcbVg=;bZEvqADdghDMjpilHc7PGVUS4GR
 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
 X1pg610ueboj9coPHY=
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
	TAGGED_FROM(0.00)[bounces-294869-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,mensi.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8964763A633

From: Manuel Stocker <mensi@mensi.ch>

Realtek Otto switches usually make use of multiport PHYs (e.g. 8 port
1G RTL8218D or 4 port 2.5G RTL8224). The device tree can describe this
fact via an "ethernet-phy-package" node that resides between the bus
and the PHY node.

When looking up the device tree bus node via the chain port->phy->parent
the driver totally ignores the existence of a PHY package. Enhance the
lookup to take care of this feature.

Link: https://github.com/openwrt/openwrt/pull/23591
Signed-off-by: Manuel Stocker <mensi@mensi.ch>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index bd361aa19739..92c8f2512476 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -432,6 +432,21 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
 	return 0;
 }
=20
+static struct device_node *otto_emdio_get_bus_node(struct device_node *dn=
)
+{
+	struct device_node *parent =3D of_get_parent(dn);
+	struct device_node *grandparent;
+
+	if (parent && of_node_name_eq(parent, "ethernet-phy-package")) {
+		grandparent =3D of_get_parent(parent);
+		of_node_put(parent);
+
+		return grandparent;
+	}
+
+	return parent;
+}
+
 /* The mdio-controller is part of a switch block so we parse the sibling
  * ethernet-ports node and build a mapping of the switch port to MDIO bus=
/addr
  * based on the phy-handle.
@@ -457,7 +472,7 @@ static int otto_emdio_map_ports(struct device *dev)
 		if (!phy_dn)
 			continue;
=20
-		bus_dn =3D of_get_parent(phy_dn);
+		bus_dn =3D otto_emdio_get_bus_node(phy_dn);
 		if (!bus_dn)
 			goto put_nodes;
=20
=2D-=20
2.54.0


