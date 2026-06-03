Return-Path: <netdev+bounces-294863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NFEyGCdsIGri3AAAu9opvQ
	(envelope-from <netdev+bounces-294863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD3E63A5B5
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:02:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=tMfFRS+1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294863-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294863-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBF043035899
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4B37CD24;
	Wed,  3 Jun 2026 18:00:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609D37DAD5
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:00:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509612; cv=none; b=GwrtI6vVEqEOAVWpq4GadIKXFDOeK0ufqOqW0tzs9Bqx4appr1YRSq9fhHjA/SkHutEkzQHC05u0FkJBzyu32X1GWqcizOIF6MsUp82WtRPJGy59AiWU1GxNq0RjMEOYkLUi1mHl6lkTF0mdXojcm9TSQZCSaz3BlnbCDkVJz/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509612; c=relaxed/simple;
	bh=rQ8CYhlat6TvW+t0G8vstohMH/C1sj0DxiiNVgPgOvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsWJK/pCuR2UgPf64/Dlz0KyUlnEzWWci7GoDrgnDe4tjkesccS58tRo0RvREkzy5aZZuiKhK8B7kBgbg3WpBL58w3a16i7fFDvZ+XQ0234TFwH+Sm3ixDCyvl+yCeSTi6Z8libN6k86HdSowbvHcBvAqW97SEr1XTHexU52KOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=tMfFRS+1; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780509608; x=1781114408;
	i=markus.stockhausen@gmx.de;
	bh=aVGGCHeFLqSI6/1mE5gF/cLSgUfqvhDGzYpjzZKdREg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tMfFRS+17xCXS8g4FnJNp9VUH6A/0kn72K5j2KTd6AUoN4i0Z0/7lO1P0fFgdy5s
	 x7vz4dXhHoub+PBm/B4G1JFvRb7dKwoJQIsaQXv/S14VZVzNxlsJbMeu7PydzY61x
	 R5UVI4QOTVFcf/+8WGSj9Al27/h10zmvNRyrPHs0Yk9z+SRhRFzh/D2tc08z1nynT
	 Duizom7DaXd9PPmsQZ3JZtpDkjXBzmJgUbgL3spXKmnya+O4cxAZTTaJL1fBx/6pR
	 pj8i56wsjYMtzIyEkTICGnITWYzKM+7Cvpte25AU8vjJnvOiHtJvFiv0ks0g6mRPW
	 cwDCtSTfzUbxwWQW9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1wP0zE3wM7-004Ro9; Wed, 03
 Jun 2026 20:00:08 +0200
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
Subject: [PATCH net-next v2 2/7] net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
Date: Wed,  3 Jun 2026 19:59:19 +0200
Message-ID: <20260603175924.123019-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:LnL0HPzPbbeVSF3kUXVcfnQ38HB27Nkmo5ybVGTsTxjTXGm+Hb9
 WE+lH/OP67sjQvTsSnNPzHCnr5CTkoDF+SuNqS3umL0thnfV/IaJBZExEfqZns1jjkDpwNS
 N8J7URei6oTUtTBkYHHJ6jv5/u18UlGMfjo6887mklnZgjfBJNnX5iSRvlzjNPi5wA34uYi
 X26epTArERgry8xJYtOMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W8Drh98tzc8=;MH1nExpi5iHIZh6II8c7kfO/7VK
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-294863-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCD3E63A5B5

Due to its design the MDIO driver needs to set up a port to bus/address
mapping during probing. The "ethernet-ports" subnodes are scanned and
from the "phy-handle" property the MDIO nodes are looked up. In case of
a malformed device tree the driver might produce out-of-bounds accesses.
The PHY address is not checked against the maximum supported address.

Add a sanity check and drop the unneeded MAX_SMI_ADDR define.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a280363593d2..ba4151fbae0d 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -78,7 +78,6 @@
=20
 #define MAX_PORTS       28
 #define MAX_SMI_BUSSES  4
-#define MAX_SMI_ADDR	0x1f
 #define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
=20
=20
@@ -430,8 +429,8 @@ static int otto_emdio_map_ports(struct device *dev)
 	struct device_node *ports_dn, *phy_dn, *bus_dn, *ctrl_dn;
 	struct otto_emdio_priv *priv =3D dev_get_drvdata(dev);
 	struct device *parent =3D dev->parent;
-	u32 addr, bus, pn;
-	int err =3D 0;
+	int addr, err =3D 0;
+	u32 bus, pn;
=20
 	ports_dn =3D of_get_child_by_name(parent->of_node, "ethernet-ports");
 	if (!ports_dn)
@@ -478,9 +477,11 @@ static int otto_emdio_map_ports(struct device *dev)
 			goto put_nodes;
 		}
=20
-		err =3D of_property_read_u32(phy_dn, "reg", &addr);
-		if (err)
+		addr =3D of_mdio_parse_addr(dev, phy_dn);
+		if (addr < 0) {
+			err =3D addr;
 			goto put_nodes;
+		}
=20
 		__set_bit(pn, priv->valid_ports);
 		priv->smi_bus[pn] =3D bus;
=2D-=20
2.54.0


