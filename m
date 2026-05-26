Return-Path: <netdev+bounces-291867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM1PAPLbFWpzdQcAu9opvQ
	(envelope-from <netdev+bounces-291867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9CF5DADE8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65FFD3003516
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8D403EB2;
	Tue, 26 May 2026 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="SgRfF8ES"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267E40315A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817448; cv=none; b=d1vVnmzKxGlO2MzYDgTJE19lu0IS6ZqwcSX4zdtKcIsIfQbFG8w0GJENF0uv7/3lSawl4S2hNcVc0vDLjLz7NOs3fq05xi8zwo369eNNzVWw+PpAU+Mnf7Nx+FoKd48ykIOKFrdzDFF6ch+NXKiXApv+6VfGQQ0rM3jkf0DkX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817448; c=relaxed/simple;
	bh=J5zr3ALQTurHGHR06Nn/A+2MvJCFgLRzn/hEZDuN9VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0rE4dycsypA/uK8LenN0IONKdPUCX5EPnvkTWTANWuKK29JUne7WIK5ClmLSLWxWxcCT3ooy6VN1E94QCaT7B04mSZrYtUAT5pc9G9ay1gcCC3GnXizm0paL86cMWPloe9aRPK8+D6Vh8BBENuvc47TPi0a4XCN9u8EaNx1RTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=SgRfF8ES; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779817444; x=1780422244;
	i=markus.stockhausen@gmx.de;
	bh=fuf/WtdfZTLw/5md2gh3nIoDf+3aAySJK1bNPT/JnvM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SgRfF8ES+DHNA8bPEbe/wvCX/TfpF2+bgRyXbbUqcQrtpPd2jl4Lk5hmtWe8WH7M
	 BWUtKYd51t9MMf/PBFhCfJxl5DIgt/OJ5RvJLyhEK7RWlm8zza7Nu521znFI7ynGq
	 +sAw9j0e0k9AMtSZ1t3zg+tPl8X+CCwxpmP0V1L/FeBdbV0AcDwevel/dK/UJ3Sx6
	 Zl42JapRMCwLvFZXFKNVl0F4MlGMRs1QYn2OB7I0ag6gBNpMoeVGyzK6aVpzv34nX
	 dAn9SLWaPkROMt1wOejGzsFTdOb3v1YaMP6lyl8HoqIVcLVA3JAzV4czMfh/3UL0H
	 sek0McOk4agNlEZ1Qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1wRNr83FG2-008iSy; Tue, 26
 May 2026 19:44:04 +0200
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
Subject: [PATCH net-next 3/5] net: mdio: realtek-rtl9300: Prepare command runner for reads
Date: Tue, 26 May 2026 19:43:42 +0200
Message-ID: <20260526174344.1186832-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
References: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EXxYceq5qceQPGyL6Ma+ig/ai22fHsnMiEY/SPqsbxtXgA67G5O
 jQuH/AD4ZbLzrKz0rcSTeazNjfISe60IWZzDJTbizIopndEqpEmK7tCzOAy4RrN8pCJQlY+
 15BQn+4EHQf5xfQLH2hAotBBQbp37inL7s4OvOTtalvwmt1B3m9hAcsMWs8Zb4K7gXA79Nj
 a43BiWSiVaFL75M+VqfcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sWFAYmNcmTE=;ouitQTjaHwPnqSypmxc5l406jJ0
 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
 RrcyaqvV4EvOQS0bR8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-291867-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 6D9CF5DADE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The command runner can only be used for C22/C45 writes. Enhance it
so it can be used for reading as well. For this.

- Enhance signature and add pointer to return value
- If pointer is given, read back the return value from read operation
- Hand over NULL pointer for current write consumers.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a1870b16d8b9..6f4affe0696d 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -139,7 +139,7 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv(=
struct mii_bus *bus)
 }
=20
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
-			      struct otto_emdio_cmd_regs *cmd_data)
+			      struct otto_emdio_cmd_regs *cmd_data, u32 *value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
 	const struct otto_emdio_info *info =3D priv->info;
@@ -176,7 +176,19 @@ static int otto_emdio_run_cmd(struct mii_bus *bus, u3=
2 cmd,
 	if (ret)
 		return ret;
=20
-	return cmdstate & info->cmd_fail ? -ENXIO : 0;
+	if (cmdstate & info->cmd_fail)
+		return -ENXIO;
+
+	if (!value)
+		return 0;
+
+	ret =3D regmap_read(priv->regmap, info->cmd_regs.io_data, value);
+	if (ret)
+		return ret;
+
+	*value =3D FIELD_GET(PHY_CTRL_DATA, *value);
+
+	return 0;
 }
=20
 static int otto_emdio_wait_ready(struct otto_emdio_priv *priv)
@@ -253,7 +265,7 @@ static int otto_emdio_9300_write_c22(struct mii_bus *b=
us, int port, int regnum,
 		.port_mask_low	=3D BIT(port),
 	};
=20
-	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C22 | PHY_CTRL_WRITE, &cmd_=
regs);
+	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C22 | PHY_CTRL_WRITE, &cmd_=
regs, NULL);
 }
=20
 static int otto_emdio_9300_read_c45(struct mii_bus *bus, int phy_id, int =
dev_addr, int regnum)
@@ -320,7 +332,7 @@ static int otto_emdio_9300_write_c45(struct mii_bus *b=
us, int port,
 		.port_mask_low	=3D BIT(port),
 	};
=20
-	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE, &cmd_=
regs);
+	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE, &cmd_=
regs, NULL);
 }
=20
 static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
=2D-=20
2.54.0


