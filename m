Return-Path: <netdev+bounces-302700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pEDiBlyPQmoM9wkAu9opvQ
	(envelope-from <netdev+bounces-302700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B11426DCADC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=DnfRbfgl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302700-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302700-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 843AA3026709
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54772438FE8;
	Mon, 29 Jun 2026 15:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27333C108B;
	Mon, 29 Jun 2026 15:24:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746663; cv=none; b=naozfj/X4pYVH29RTuwhha8a43g+MP+U6pgfoguXy2M8TsaYEkmMl7SQCPbRg24w4D/tp0Bi06cc2c1ftN4o7aH5y7hkSp5AAaBW5apc7uoUrx2z3NNxj+lQejX1Z9/DXH7lJpmu1g+vVzIisc9xwtMKEaHv/K4VAritAP6TR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746663; c=relaxed/simple;
	bh=uzvOeyBIGJ0zH58vlG6UTeG2oa3ZaqKUvQ/CpRjhHGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzvXowriGOU3H2MYxg5gQOHKtK1jNH7UXWMzZz01uUvpmGFDK4Pv2ZFl/qCHaynIJEf5+X+HjNXkVAAilV9qStHYtc+otAiGA5EkTofg9N+90R8/g5GgS+SCQLYqq2IrCqVqJzhLcYHgqrHV/N3Yp85xG5LKIQ2sq0FRxmShwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=DnfRbfgl; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746632; x=1783351432;
	i=markus.stockhausen@gmx.de;
	bh=/RDVHMovIXh5DrYkL3r1VHqHbiwSP7QSB+a/pojgNQE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DnfRbfglDh/L2coigTkPTEcXr+Z/mXnh2n3YwzKfomIDq5C8CNYSXBlGVZCvdAs3
	 11ryECfUjvi9xP0Xv0JaWaQtEzP3d14sfXAg1p7HX1at69I3iLum0FcG/iMqzhWTK
	 uU9PmRzmh4gLTZWyRoK4NLZD9LrQ7fqoMpNdNx976CAUa0LFUNpN8/QWe0A/EV810
	 T+TY6KgxMy3BsdCoNRTDx1lg3k59egDq8j8+0V2lSDVUrdvjiiFtz6vKqkgE2BQpq
	 S7okN5OkxO/WhqefF4FVAbZhi/JMp04raDCPLaro07zueYMFhUJARfRsTrZ1GPxWd
	 EtM0zNKpPMgblR5m+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1wwZZP0ozv-012tO9; Mon, 29
 Jun 2026 17:23:52 +0200
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
Subject: [PATCH net-next v2 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Mon, 29 Jun 2026 17:23:31 +0200
Message-ID: <20260629152336.2239826-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NDjWQNJWF/VSq10Sub4YhbBu8qR8gA+rOSJRqw/UmwikMjcVuLr
 26uAhiXyb1dW2/3Efe0OHKhNJgQil4Go5p/64cUNxiZ7uoZmxyyfDIUtICVmV6Baw2TRSdP
 Jv/Xr1ssgIjeRbf2vOmc8Sf7w3eFE5JaJf1jLOLwRbyl30d1xpNtBIscwt0LhwBTtGO/xKe
 HcjJgUn/2Irbc0OoAuYtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C4x4LOjfrzY=;bm1bnJDRQKGBmlVyF50Jn1OTepf
 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
 KZLy8132g=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-302700-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B11426DCADC

From: Daniel Golle <daniel@makrotopia.org>

Some MDIO buses require to program PHY polling registers depending on
the PHY type. RealTek switch SoCs are the most prominent example of a
DSA switch which doesn't allow to program MAC speed, duplex and
flow-control settings without using PHY polling to do so [1].

Avoid a half-baked solution in the MDIO bus driver because

- it must reinvent the bus scanning to determine the PHYs and
- it must anticipate the right point in time (e.g. deferred PHYs).

Hence there is a need to inform the MDIO bus driver that a PHY is
being attached or detached. Provide two simple hooks in struct
mii_bus which are called

- right after a PHY has been attached
- just before the PHY is going to be detached

Remark! A slightly different version of this patch was part of a
former series [2]. The discussion already showed that an initialization
hook should be placed somewhere late during the whole setup. This
commit implants it right after phy_init_hw() as suggested. On top of
this it adds the detach hook.

[1] https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
[2] https://lore.kernel.org/netdev/cover.1769053496.git.daniel@makrotopia.=
org/

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/phy/phy_device.c | 9 +++++++++
 include/linux/phy.h          | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..676cbf183350 100644
=2D-- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1876,6 +1876,12 @@ int phy_attach_direct(struct net_device *dev, struc=
t phy_device *phydev,
 	if (err)
 		goto error;
=20
+	if (phydev->mdio.bus->notify_phy_attach) {
+		err =3D phydev->mdio.bus->notify_phy_attach(phydev);
+		if (err)
+			goto error;
+	}
+
 	phy_resume(phydev);
=20
 	/**
@@ -1919,6 +1925,9 @@ void phy_detach(struct phy_device *phydev)
 	struct module *ndev_owner =3D NULL;
 	struct mii_bus *bus;
=20
+	if (phydev->mdio.bus->notify_phy_detach)
+		phydev->mdio.bus->notify_phy_detach(phydev);
+
 	if (phydev->devlink) {
 		device_link_del(phydev->devlink);
 		phydev->devlink =3D NULL;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..3160ca99deab 100644
=2D-- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -376,6 +376,10 @@ struct mii_bus {
 			 int regnum, u16 val);
 	/** @reset: Perform a reset of the bus */
 	int (*reset)(struct mii_bus *bus);
+	/** @notify_phy_attach: Perform post-attach handling */
+	int (*notify_phy_attach)(struct phy_device *phydev);
+	/** @notify_phy_detach: Perform pre-detach handling */
+	void (*notify_phy_detach)(struct phy_device *phydev);
=20
 	/** @stats: Statistic counters per device on the bus */
 	struct mdio_bus_stats stats[PHY_MAX_ADDR];
=2D-=20
2.54.0


