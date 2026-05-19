Return-Path: <netdev+bounces-289539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOb2E6yXDGphjgUAu9opvQ
	(envelope-from <netdev+bounces-289539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:02:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF894582C98
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD46430C1D60
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A4367B72;
	Tue, 19 May 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="CMCCATxW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96385409115
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209920; cv=none; b=pZIuDS5MnD1cuSP53ycaLb8j1Fqlx02zCFbPkNrIf4/9yzQHlq+IbC609+1Lotvq/qyEPT6dROPpJKvKaDS23Du5ijxOJHXZDgfqApFeKTG5jTzzWAjdcEgi2lV+9uJL5gwshVaVdr+Wszd6yTiGKCiS2fl9LzeQo2s89O7SEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209920; c=relaxed/simple;
	bh=dW+Wfnue5Xp/fMV0NPDBD4uPxqe2elnNgE+pvB3DDNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEA5QExR4K23ytbeEeeMEStXdEL/nXmbgaL+5lMAlgxk0C2GCz2QoY+vFX7yLrtOvzS0LlWLDXjbeGTzBvellaOszAwIhCGB1dJclmOen3oT/KkBjCMDyabSDQh5eXKIX7iA64p39WaNMoANCcPCc3WaSfiDRTo8cB3we0nfAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=CMCCATxW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209889; x=1779814689;
	i=markus.stockhausen@gmx.de;
	bh=TNRZ4SborgKPPtsjgeaul8zwhS1ILDfNAMxXm9nqNjk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CMCCATxW4VjBRRNpNMc64OofLfKC3seeMXNG6h2SctlGc79CR3uXUiRHgkpmU8Ke
	 Bn8Hh1mVWEhDVR9IrJaqXBo0ZnSabD81xPpuTtPyuomy51NwjeoTGJSw6/hLSjU7P
	 Tn/MiythkUUVgDwrFpESTF2m8D491Z8pgUCiSkbcoISKgB1XGG07Z5vKtdp9JZpsv
	 lckxcfyMBCVNe1ny2oGaba3DfWr/qsYuYLyAprOTKdTkeqj8c5OKT++W1DDjUPHd4
	 fR6gngj8FrhCXB/8hQe2ADIhSc8+7ezUnxB0djW6ykfeiWz8fXYhytI64oY2EhDeS
	 3H/l7Lq0vN1Cw/ALmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1wQTAj1lgy-002F3f; Tue, 19
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
Subject: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info structure
Date: Tue, 19 May 2026 18:57:41 +0200
Message-ID: <20260519165747.1288903-4-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:c7vCufvhDSQdqU8WMrpGzeyEbhSdDRJHGni1rM4tBgaFPKquQsN
 qnTl9gMc9PQ2B/6/oBjT7cK2VgDHpIBpxb0mTru7xfwnqBg+b/H8Zo3gkvGlFqWlHVAMzx6
 0PGaF+QpdnmO3OrlxCq1AI3EaBkkktN9F5eaXW/djm4rfoQ0YPUuYTSU+yd4Iye9KDdzkrD
 sxdCRezJVTrjFi/1tTu0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xhhN3/CzrS8=;sJbmRMmoH10GI6pMlx4kTiUBFvt
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289539-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: BF894582C98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Each Realtek SOC series has different number of MDIO ports.
Make this configurable by adding a property to the info
structure. Switch the existing usage of MAX_PORTS to this
new property where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 140e6ac51e2b..4533c2f68cab 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -49,9 +49,11 @@
 #define MAX_SMI_ADDR	0x1f
=20
 #define RTL9300_NUM_BUSES		4
+#define RTL9300_NUM_PORTS		28
=20
 struct rtl_mdio_info {
 	u8 num_buses;
+	u8 num_ports;
 };
=20
 struct rtl_mdio_priv {
@@ -78,7 +80,7 @@ static int rtl_mdio_phy_to_port(struct mii_bus *bus, int=
 phy_id)
=20
 	priv =3D chan->priv;
=20
-	for_each_set_bit(i, priv->valid_ports, MAX_PORTS)
+	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports)
 		if (priv->smi_bus[i] =3D=3D chan->mdio_bus &&
 		    priv->smi_addr[i] =3D=3D phy_id)
 			return i;
@@ -323,7 +325,7 @@ static int rtl9300_mdiobus_init(struct rtl_mdio_priv *=
priv)
 	int i, err;
=20
 	/* Associate the port with the SMI interface and PHY */
-	for_each_set_bit(i, priv->valid_ports, MAX_PORTS) {
+	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports) {
 		int pos;
=20
 		pos =3D (i % 6) * 5;
@@ -444,7 +446,7 @@ static int rtl_mdiobus_map_ports(struct device *dev)
 		if (err)
 			return err;
=20
-		if (pn >=3D MAX_PORTS)
+		if (pn >=3D priv->info->num_ports)
 			return dev_err_probe(dev, -EINVAL, "illegal port number %d\n", pn);
=20
 		if (test_bit(pn, priv->valid_ports))
@@ -509,6 +511,7 @@ static int rtl_mdiobus_probe(struct platform_device *p=
dev)
=20
 static const struct rtl_mdio_info rtl9300_mdio_info =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
+	.num_ports =3D RTL9300_NUM_PORTS,
 };
=20
 static const struct of_device_id rtl_mdio_ids[] =3D {
=2D-=20
2.54.0


