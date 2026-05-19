Return-Path: <netdev+bounces-289536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEdkHN6WDGp1jAUAu9opvQ
	(envelope-from <netdev+bounces-289536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1973C582BF8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59D993058644
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472F21A92F;
	Tue, 19 May 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="njumcUs3"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265A409116
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209915; cv=none; b=a6fGCBobhKm1kE4NcfiWnBG/JdjNx1WgJ63G1VVDJRyODTRo9y3qM5tuwsArpW/8tiK7hS067HRsRqavESJGH+saraxQGHgll2Iwnnhxp81ZNCkQmI50ZsW9J+HqPGIoLnPHxlIwAXp8M72SMZ9eCkFla42qc2WRn3bT2WorQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209915; c=relaxed/simple;
	bh=LgWF7oGRUdOBrJHG55gGd8oZI2QIQLqYLGybp9KBX8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW1VhLEJBY+nFZjN1puPeOHz25NznA1Lxhq01H8d8nFLTbhBk+8MiCb/5gTJTcCPSfFGoG9MVx6jOb0RLekV/Qk1QTf8XOHyDL5rgAa/OKJ5GPfTHSGRDnmasOyEH1x2f47dbLBUvu4HHekbF4pmTSPEvE7NqFolHGtU8yFDQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=njumcUs3; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209891; x=1779814691;
	i=markus.stockhausen@gmx.de;
	bh=+PhdzSrbvGk49i7eOjmXK+QcJL8YTnfTAySUKBH527k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=njumcUs3w/+U0TdjogmctQoLqDFbkcJz/9CBcNcouGE+3NZtZ7K/m0iNcyfx+W6O
	 8ClOsDW5ua1xw3RQcR4o9YAPUJR8Clzjq1XeExKNjUc3VB46W7p5RKSfQBkH2hSOd
	 06RM1aZoPm9WWGfdOklRdEyT5RiLcrUngqD9RYGMckvF4ZhbRK+8DD3g92Ua1tEDT
	 05DlHSJZdogpWZR4YsWl1ru+L8pvirjUnEBSuCKbY6Q0fa0VKJEzA4TlrXlwNTokO
	 gn3QeqSQ1wDzwSwwEIxn4PIzbCBLK6dP6fCRzHiHsDnQEPRyU09bHBcNR8KktDbhq
	 HM2XxQi4Zpvy6opoiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1xDddt3mfv-00yUU0; Tue, 19
 May 2026 18:58:10 +0200
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
Subject: [PATCH 9/9] net: mdio: realtek-rtl9300: Link I/O functions in info structure
Date: Tue, 19 May 2026 18:57:47 +0200
Message-ID: <20260519165747.1288903-10-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:hSymlDSE5G9TxYzxkT81/xG3KMvGLakLK11RIpmaOWBEnSFHWdc
 u38RXDoOB3wNyC0GrV1GM7lr0vrJA2mVn8ecrf6/WPRirl6yBbrJooohUeQ6hTU26VtZexh
 P9igcpKzToA5z/DPyWnHlOwG23NuPQxcEZVhxpwVQ7B3yrzIWrwkZICAwDlE7JVuiN9zKIU
 82gtbv6tzaMbxxwcGjjYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v08RHt7Rqz4=;pKP6txfVmlNuuDu8nlmq8dNMGwv
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289536-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 1973C582BF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All SOCs have slightly different I/O functions. Make them device
specific by adding the functions into the info structure.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index f43403a7f39a..eb318d31c27d 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -65,6 +65,10 @@ struct rtl_mdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
+	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
+	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
+	int (*write_c22)(struct mii_bus *bus, int phy_id, int regnum, u16 value)=
;
+	int (*write_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regn=
um, u16 value);
 };
=20
 struct rtl_mdio_priv {
@@ -404,11 +408,11 @@ static int rtl_mdiobus_probe_one(struct device *dev,=
 struct rtl_mdio_priv *priv,
=20
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
-		bus->read_c45 =3D rtl9300_mdio_read_c45;
-		bus->write_c45 =3D  rtl9300_mdio_write_c45;
+		bus->read_c45 =3D priv->info->read_c45;
+		bus->write_c45 =3D priv->info->write_c45;
 	} else {
-		bus->read =3D rtl9300_mdio_read_c22;
-		bus->write =3D rtl9300_mdio_write_c22;
+		bus->read =3D priv->info->read_c22;
+		bus->write =3D priv->info->write_c22;
 	}
 	bus->parent =3D dev;
 	chan =3D bus->priv;
@@ -534,6 +538,10 @@ static const struct rtl_mdio_info rtl9300_mdio_info =
=3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
 	.num_pages =3D RTL9300_NUM_PAGES,
+	.read_c22 =3D rtl9300_mdio_read_c22,
+	.read_c45 =3D rtl9300_mdio_read_c45,
+	.write_c22 =3D rtl9300_mdio_write_c22,
+	.write_c45 =3D rtl9300_mdio_write_c45,
 };
=20
 static const struct of_device_id rtl_mdio_ids[] =3D {
=2D-=20
2.54.0


