Return-Path: <netdev+bounces-289534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB4kG1CXDGphjgUAu9opvQ
	(envelope-from <netdev+bounces-289534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:01:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7932582C79
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 390383099584
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A12E9ED6;
	Tue, 19 May 2026 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="TRTPZR/h"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81D409118
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209910; cv=none; b=NHBptxXeQMqIZ6snYvuuy3LJj3fM/j69ERposqc1v0cAVxtt8Jd1WKK/L6sGVlRZbr8UtSIsp1i7cZm6+sLkVsGbovlGu3DZRX2VfM5upfIVew12KyaYsId7A+dJ55GLAUEcd2bEY69Ltz9zPB7vwYkYVkfAW6GrcA7DjFizE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209910; c=relaxed/simple;
	bh=v7BTHLXO1+/lJAaLhrv2/w5joX6jCwYuw+tcd/0hnfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN2EJeZexNzRINgm2ljpWlJcb8hGYEFTr0w1L/+pnpdhSOKM+uJ7SCRXt996QVMPBki1PntHcpxRryKKp/3u9fY4QAKH4FQgzvvwzbXP1xfQxBGSNKPHAz05x4Uq8tT+f7WdK+/Ff6Aa88qSL10dKygdURo1i/fPBtjcPP0BSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=TRTPZR/h; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209889; x=1779814689;
	i=markus.stockhausen@gmx.de;
	bh=I//rrs9EOs3nFE/H7WSqgssQZ7NaWqUc+EXvljhV7D4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TRTPZR/h8CjfySY70ZEP7pOlyoRAopme1wl4xNNuaOG5M1SLFC/xxLUKYSuwJ5aV
	 iRYeigutN87JgFO8owgGdfwYAOM0iD65iM6e3x7K7kIpBQXUDv/n2ReROiuqUTxJE
	 ImBskZ5wc1MFWW5Ooxa8PskKi+P49F826BSgFzxwL1JEMdydkV/iewUgFBBbhCZW3
	 Wu36Y7G968wj5+9nwhim+Of8Q0kwUpBZCGMqI5KetZT3Vw9WnzOhRSUXkkX2o0U/B
	 bHF0hv32/SUguOUbtl3MGHowrzRmn9gylFKN+stMpwuJUUoSPnuDqCdpT5J2d5/dg
	 KoiIur1AMkGr9R76vA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1wTlUP2i5w-0018ap; Tue, 19
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
Subject: [PATCH 4/9] net: mdio: realtek-rtl9300: Add pages to info structure
Date: Tue, 19 May 2026 18:57:42 +0200
Message-ID: <20260519165747.1288903-5-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:J65rnOB8WTDAFND2lRztApQvdRZt57GVd974evyTLRTxWH/T8Wu
 /On7zYmqXUIrXaWrYk9BM48c7oMUzbLKEH5nGVrL36+ONjkW5s88EXMtILAc9YxMzYX6dm5
 8Fl8aM00dmSCwvXbzHuCJhUgRIH93aSNeKQmgOuj9P5iXb+ggYmQruUkGeQrBKjgAKYE5bx
 zNerGmkclAk2mwBLB/lTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jWMmvw01/I0=;SuiE2XPTBTyGc9RNxY84jSP1C2L
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
	TAGGED_FROM(0.00)[bounces-289534-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E7932582C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek MDIO controller has a paging feature that allows to run C22
reads/writes in one turn. At least this holds true for attached Realtek
based PHYs. The controller is given the page, the register and the data
and it runs all the page switching in the background in hardware.

There is however one special page that allows to pass through all C22
commands directly to the PHY - without any caching. This so called raw
page is dependent of the hardware. It is the highest supported page
number minus 1. This is either 4095 for low port count SOCs (up to 28
ports) or 8191 for high port count SOCs (up to 56 ports).

Provide the number of supported pages as a device specific property.
The raw page directly derives from that as "num_pages - 1". Make use
of it where needed.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 4533c2f68cab..0ea691d9fc1b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -47,13 +47,16 @@
 #define MAX_PORTS       28
 #define MAX_SMI_BUSSES  4
 #define MAX_SMI_ADDR	0x1f
+#define RAW_PAGE(x)	((x) - 1)
=20
 #define RTL9300_NUM_BUSES		4
+#define RTL9300_NUM_PAGES		4096
 #define RTL9300_NUM_PORTS		28
=20
 struct rtl_mdio_info {
 	u8 num_buses;
 	u8 num_ports;
+	u16 num_pages;
 };
=20
 struct rtl_mdio_priv {
@@ -126,7 +129,7 @@ static int rtl9300_mdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
=20
 	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
+	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv->info->num_pages)) |
 	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
 	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
 	if (err)
@@ -179,7 +182,7 @@ static int rtl9300_mdio_write_c22(struct mii_bus *bus,=
 int phy_id, int regnum, u
=20
 	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
 	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
+	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv->info->num_pages)) |
 	      PHY_CTRL_WRITE | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
 	err =3D regmap_write(regmap, SMI_ACCESS_PHY_CTRL_1, val);
 	if (err)
@@ -512,6 +515,7 @@ static int rtl_mdiobus_probe(struct platform_device *p=
dev)
 static const struct rtl_mdio_info rtl9300_mdio_info =3D {
 	.num_buses =3D RTL9300_NUM_BUSES,
 	.num_ports =3D RTL9300_NUM_PORTS,
+	.num_pages =3D RTL9300_NUM_PAGES,
 };
=20
 static const struct of_device_id rtl_mdio_ids[] =3D {
=2D-=20
2.54.0


