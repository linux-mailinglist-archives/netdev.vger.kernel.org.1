Return-Path: <netdev+bounces-289530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIwGEguXDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB5C582C3D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B78EE306BEAA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F740912B;
	Tue, 19 May 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="A52CT8mL"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F540910A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209898; cv=none; b=XFfVMIQVAQNPQHVmugfctXJoFLue7eitRRwgtWu0/uMPCbAWin2DvFGTXyp9/GLd65jHevDq4I1xpo3r45XWepTedfJfZHW/giMxDbcyUX/sLaP7vEUGU38rS2K4jMutgofwLSjSJh+0XQWxEO9YMakZYVyfZop1guX+byOWAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209898; c=relaxed/simple;
	bh=N8SSxzHuPMacghOWztdAVMjHWBP8a83uqeLrZLiHld8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/4iy56vdFn/Loplu8VB/gYQ0Bhj+WGP8TwpFrT04RmYONAXfUA98nGHbUzFz72KD19dCwqZMfJTFiJCSVlhfiQTitqf5OxQXcBIbBOESAJSuvtaTo6sWyzbHJObajPCkjnIgLQ5vCOX+xmZZdAhpVnWQ89Ci5UG1jtiY2cjCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=A52CT8mL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209889; x=1779814689;
	i=markus.stockhausen@gmx.de;
	bh=0CTnurcrlvUBWW9ODoRcHPph8ednVUZTcdK2244dZjk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A52CT8mLcVUgcMXtJOBtATiio4pgpx01DxOR5p8RSGhV/dNwccQUE9zgO8jFomA1
	 SxAOgVPlZWyy5RHVRxx5ykNCCXEennXrfyOPebp2l8D4B1lcP28+yfuZGZ1ZYFpif
	 +SNxm8x6cgZK5g8XlQmAos6jDJ1A4TW+fvqq+nS8RrNyRmPo9lPXZ6/VuQmxNBcxL
	 HMwFdyIpEcdCDtRkfaWtKiRJmV9ZqlNhdGBytiJ+rQrlvYBIQjvHiwYlc6hr1Rqoa
	 kcyxil5OCnT2vRKA+mxjkKWJJO0oVdQy4g0ZAkIlCivjo78qxnDSCvvRbU0l9NdCG
	 CFE2WIaMllcHrKPM8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1x6if90kC6-00n6TV; Tue, 19
 May 2026 18:58:09 +0200
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
Subject: [PATCH 2/9] net: mdio: realtek-rtl9300: Add device specific info structure
Date: Tue, 19 May 2026 18:57:40 +0200
Message-ID: <20260519165747.1288903-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0uY/Fig7Z42bniSOlScmuLrsUV8+7HOQyiLzPlEcdDi44QLxy5t
 jHeXTObhlbShAC4TSYGb5BtEXavNRb/neUMG3iOvG8CW75T5PMt2+4SGH++I0cRyypupBhI
 7VdcoErZzNzAGObNeyVH2EVYkO99Y1tvJ5OsmB3hGxijSdyiC0YMwwL1DZ3u+xVl6c2QepH
 uzerYwkXlRbHTEU0OmdIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TPQAyf/pO14=;ecJ38uZK6YAp2vPvPOY3Ev0bcDl
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289530-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: DCB5C582C3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Device properties of the RTL930x SOCs are hardcoded into the MDIO driver.
This must be relaxed to support additional devices like the RTL838x or
RTL839x. These do not have 4 SMI buses but 1 or 2 instead.

To support multiple devices establish an info structure that contains
individual variations of each series. As a first use case add the number
of buses into this structure and use it where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a3374d5241cb..140e6ac51e2b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -48,7 +48,14 @@
 #define MAX_SMI_BUSSES  4
 #define MAX_SMI_ADDR	0x1f
=20
+#define RTL9300_NUM_BUSES		4
+
+struct rtl_mdio_info {
+	u8 num_buses;
+};
+
 struct rtl_mdio_priv {
+	const struct rtl_mdio_info *info;
 	struct regmap *regmap;
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
@@ -328,7 +335,7 @@ static int rtl9300_mdiobus_init(struct rtl_mdio_priv *=
priv)
=20
 	/* Put the interfaces into C45 mode if required */
 	glb_ctrl_mask =3D GENMASK(19, 16);
-	for (i =3D 0; i < MAX_SMI_BUSSES; i++)
+	for (i =3D 0; i < priv->info->num_buses; i++)
 		if (priv->smi_bus_is_c45[i])
 			glb_ctrl_val |=3D GLB_CTRL_INTF_SEL(i);
=20
@@ -447,7 +454,7 @@ static int rtl_mdiobus_map_ports(struct device *dev)
 		if (err)
 			return err;
=20
-		if (bus >=3D MAX_SMI_BUSSES)
+		if (bus >=3D priv->info->num_buses)
 			return dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n", bus)=
;
=20
 		err =3D of_property_read_u32(phy_dn, "reg", &addr);
@@ -476,6 +483,7 @@ static int rtl_mdiobus_probe(struct platform_device *p=
dev)
 	if (err)
 		return err;
=20
+	priv->info =3D device_get_match_data(dev);
 	priv->regmap =3D syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
@@ -499,8 +507,12 @@ static int rtl_mdiobus_probe(struct platform_device *=
pdev)
 	return 0;
 }
=20
+static const struct rtl_mdio_info rtl9300_mdio_info =3D {
+	.num_buses =3D RTL9300_NUM_BUSES,
+};
+
 static const struct of_device_id rtl_mdio_ids[] =3D {
-	{ .compatible =3D "realtek,rtl9301-mdio" },
+	{ .compatible =3D "realtek,rtl9301-mdio", .data =3D &rtl9300_mdio_info }=
,
 	{}
 };
 MODULE_DEVICE_TABLE(of, rtl_mdio_ids);
=2D-=20
2.54.0


