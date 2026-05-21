Return-Path: <netdev+bounces-290583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBScOMFQD2pEJAYAu9opvQ
	(envelope-from <netdev+bounces-290583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:36:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C85AB1F3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5388D316472F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C353FB07B;
	Thu, 21 May 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="qID6hgdm"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F00376BD3
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386399; cv=none; b=tBxuRitdwOex6wXSDfo3dJkjJOFNh+jQcgaFPGUpnSPeRZcbH702oUFp2uEDDTIyKrY9tPxbg6gzNTq3MKfffxKxhD+ijHIMpJafKm3dOmxHVt1bq/30ZHnQ0s3B5iZQOhE6rnxOB3mNuBaQWifg0AkEZxSm7szbTJmTvgRhPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386399; c=relaxed/simple;
	bh=UPBnXQIEOuT/QlZNCLoCZ/mXDo0ORDmtOFXLypE/Hps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGuma8kykcxZO1SlBVPV8/CZaF7S8bwMlFBqNizIJ8oxjUJwXGLtHsxevsdPxjikOQoOkqgcXj6iHAcKFH8RZpxSRka1rLDecQfgo5an/ylurMTzJ2FtCXRkUHfxOxC0r0aG81VnYmTwZvD+HODXLFDIkhSIQT6dX/fM8gVJznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=qID6hgdm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779386377; x=1779991177;
	i=markus.stockhausen@gmx.de;
	bh=yhorkdzlGh9DbzBP8rOLwxhTjPd9cAffDG4+HWsDCzk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qID6hgdmON+jopyR/mdDXyZR6bRlnoSgHWZpYDPPrjHTdy9NuAL4zEMgFvSF7NT2
	 lC0MPegLjnh9pJXUk8XEeWwNIjGgp6QQqNjSFrq5Ticr43SvcoROEq4ujcReHH8ye
	 DqEMerPsdyrYIdpT1bMlPJtjhqXNWyYpkLj5cgwsxRmm0VP9JOcrib+GGbFNcmYCP
	 NN1QugxKUt1kRCOyAU+DbWmFKJbl5/Ot5WDVtxkr96eq7H1dMHfaxNS47cQoEa9D6
	 cB51LCusNRB4KAUu/IBwJZj7n9V66OdazqSD4iupc38iy4Ebnk++tjYA+yLRJjUBf
	 qbVpKzqH4Dlr61sD5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s0j-1wOCo22voN-00FRqn; Thu, 21
 May 2026 19:59:37 +0200
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
Subject: [PATCH net-next v2 8/9] net: mdio: realtek-rtl9300: Add port mask register
Date: Thu, 21 May 2026 19:59:17 +0200
Message-ID: <20260521175918.1494797-9-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:MQb6TIXjbNpnLwWhyzy840qRy6sgJnVTdq3WfLIl9J4Uen6qEVY
 oztFnGeiFOr94KvJ5hZ021TMTJaxyGR1bSopl2tk97lgI0ilPjHsJkug7VTGE6JVGULgs21
 Fx98CtZnXL9lybjT0j/+iXtQIXyxA76DZ6mjipsd8X+yMC1c3pM+oCOadZCE+iov+akueqj
 NV4u6yNdkq02TNul5M8tQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gslW5DiOf6E=;LhPebunK05OgJPFOGrqqz5SN37z
 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
 IThctNLg0wFHTacmH8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-290583-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 397C85AB1F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MDIO controller commands work on ports. These are converted by
the driver and hardware forth and back to bus/address. For write
commands a port mask register needs to be filled. Each bit tells the
controller to which PHY the write will be issued. Setting multiple
bits allows to program multiple PHYs in one step. The driver will
not make use of this parallel write feature. But it must at least
fill the bit of the target port that it wants to write to.

Depending on the SOC type and the number of supported PHYs this is
either one or two 32 bit port mask registers. The driver currently only
supports the 28 port RTL930x SOCs. So provide only the mask register
for the lower 32 ports. Add it to the register structure and make use
of it where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index d379b6171e30..8130e376b59b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -57,7 +57,7 @@
 #define SMI_GLB_CTRL			0xca00
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
 #define SMI_PORT0_15_POLLING_SEL	0xca08
-#define SMI_ACCESS_PHY_CTRL_0		0xcb70
+#define RTL9300_SMI_ACCESS_PHY_CTRL_0	0xcb70
 #define RTL9300_SMI_ACCESS_PHY_CTRL_1	0xcb74
 #define   PHY_CTRL_REG_ADDR		GENMASK(24, 20)
 #define   PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
@@ -86,6 +86,7 @@ struct otto_emdio_cmd_regs {
 	u32 c22_data;
 	u32 c45_data;
 	u32 io_data;
+	u32 port_mask_low;
 };
=20
 struct otto_emdio_info {
@@ -212,7 +213,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int phy_id, int regnum
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_0, BIT(port));
+	err =3D regmap_write(regmap, priv->info->cmd_regs.port_mask_low, BIT(por=
t));
 	if (err)
 		goto out_err;
=20
@@ -323,7 +324,7 @@ static int otto_emdio_9300_write_c45(struct mii_bus *b=
us, int phy_id, int dev_ad
 	if (err)
 		goto out_err;
=20
-	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_0, BIT(port));
+	err =3D regmap_write(regmap, priv->info->cmd_regs.port_mask_low, BIT(por=
t));
 	if (err)
 		goto out_err;
=20
@@ -557,6 +558,7 @@ static const struct otto_emdio_info otto_emdio_9300_in=
fo =3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
 		.io_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_2,
+		.port_mask_low =3D RTL9300_SMI_ACCESS_PHY_CTRL_0,
 	},
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
=2D-=20
2.54.0


