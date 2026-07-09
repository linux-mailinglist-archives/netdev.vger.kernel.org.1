Return-Path: <netdev+bounces-306055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3A7CKkJDT2ptdAIAu9opvQ
	(envelope-from <netdev+bounces-306055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:44:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B872D4C1
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=Bop6gkYI;
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306055-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306055-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BC7E3009B09
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17D3D3012;
	Thu,  9 Jul 2026 06:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD873D45F8;
	Thu,  9 Jul 2026 06:42:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579339; cv=none; b=Gk0LiAX3TgfVoY+7/G653pU0XaKaj2IMa5XzXKwOjQMAr06HxoHHg+FySxL4UmMiPZ0wvyyH0X+v3oTxgmxAYx6BbHZoSe9xyg6EuMq2wzi6gYNs7YGA591JXeqqEzTXhoAMYaF8tf1JzLfm+ZvAsIuyZXvORrjht/+A4H38iCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579339; c=relaxed/simple;
	bh=uzvOeyBIGJ0zH58vlG6UTeG2oa3ZaqKUvQ/CpRjhHGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6cFGm1TmF3igRkEbk8OpN+I3Lj8Dc1pp3UH+e+Dxj/+BHyDOwV/XrdGJryQoDZzJnUUCkQXqH+Mo9dJRCulmmI1W0bNPc5KwZPRJ1ZMJxIUEAHsPkLw270DbvY0GP1KHboDGlyN2aGZUqFSi7FLu+Ex0qy8oztTaLU8D62/Kj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Bop6gkYI; arc=none smtp.client-ip=212.227.17.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783579333; x=1784184133;
	i=markus.stockhausen@gmx.de;
	bh=/RDVHMovIXh5DrYkL3r1VHqHbiwSP7QSB+a/pojgNQE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bop6gkYI4V/SufVfNrKpTg8htociiKNIkPSVOQLhUHQXt+6OPTqpJHaj8VLj6oyW
	 ESryMNS3vYsGMCGYapgrYotRnAxn/t7gnd37QywIUCocnnTrZ32duq2xx5Huq5xCP
	 JY8VKqImMA0V+BmtMFaONv3Hv+z+6Fil/33ML3EjUzqtCUZvp2rXF2eF6gmbd6JPO
	 eWzo5iiq9JbaVzE8WgoBUE+dxVUbRcAqwQ7ZJwipYJsm5KdXgeDEx+dmEMWUsBqJx
	 1G+SV6QhFWaF2gHauirAibt5PrtJitgowMtgWuSTx2Shb99Db7wHmjIHqSSTUL4Hu
	 ES43FtyVqXCUTSH6MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1x61eP1zrc-017hiQ; Thu, 09
 Jul 2026 08:42:13 +0200
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
Subject: [PATCH net-next v4 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Thu,  9 Jul 2026 08:41:52 +0200
Message-ID: <20260709064157.2865063-4-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:FJbIM4dMtxwr8b5QGh0HabIrIZrQhDxmIs0u/Ur3Ztv3YASpmk9
 a31U8mrYCoApmZZdmweHDo6dmR9Ljnnii1dUQl3DsHuN/wQ1wQIzfMV5iXz6Uw+kBeVwL1k
 mb0NM9U8UBa3iGW8BTycB4HVnqKdqrNDV2XB7I5/uYK4YsB3qZmEqjUdLiMdzoLwHaC/T8X
 KOlFgAWyl8IAOCRRk3KNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8r4BBh7f5PU=;5leyTaJrljghW+mceVUSicNxyrv
 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
 AoaIQ2/Tk=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-306055-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:from_mime,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F9B872D4C1

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


