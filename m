Return-Path: <netdev+bounces-292381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLPyOUgeF2pA5gcAu9opvQ
	(envelope-from <netdev+bounces-292381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:39:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E63345E7E38
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAE353002F7D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A943C05B;
	Wed, 27 May 2026 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="fQAzFSOd"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39C43636A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899715; cv=none; b=l20wep+hu4E9LT+ZXVCh77X8fU9917ohRRCc/bRgouHXSZkBpabyJYc9BE9ZP7JtaXxPolA3uc77reVg+lRTbxQ6siKG03RA302Xq+oy5XTZUymqHYJmmiSxWM/8djAFqbqfJtvulyuwpDRBkt8+7zkD5k2jlI7oGmyqGjfrmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899715; c=relaxed/simple;
	bh=ARP5DBUThYoGGgkQug/q5MIWXrj4i7QoUeSXrPnbhdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E89bXlBxpjs+0wgvUOCLHfrAGH+OFqSMaPhQdyUWV6Bwj5KdP+dZkJ+GgW/7vH/ayaq4wLzQyk6JOTp7HVSzDAoXPvo/EAvSbnH2zDkK6peQUPBqPZqWKCWjwFdbYllLz9X07QdoN2FCO6dT2ieowus0SueWcZoZYKJFdUpgfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=fQAzFSOd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779899708; x=1780504508;
	i=markus.stockhausen@gmx.de;
	bh=DOT8RJXYi30esoIojtJgwDEgGM3+T69MlUaNPVfKRkM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fQAzFSOduyBzTvAGQDNTHF15vfALuFJ5eSFLxq0C7DYK2Kfwn/GfRLiTWILYqFY0
	 x9HiCfViZ0Zz19rpwkE0Qp8WaURgHG0LUqCff8KzdAWgxwNruUS6Ur6t+QgQdCVsB
	 Vj0oJmN9vODbnJ9DdqtPbkyz8cKGDUy5ubJr6b7Goq+H1UvNGJlXnRC6RtGeR8Pfl
	 kA2C3czXwRzHkSZgdfVU7AUS2c22Eh2JwHLKhbxj6oY6xps8nXHmDkXowT9Mcce5w
	 uI8YmWMAjn30vli6WLlkHWC6CvmcrhdDvkSkHkkhtovWMQ1hS0qAwdJYGpTgyjG+7
	 HYeBnu3B/9B74EhvYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1xIAzA1JMi-00vSLY; Wed, 27
 May 2026 18:35:08 +0200
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
Subject: [PATCH net-next v2 4/4] net: mdio: realtek-rtl9300: use command runner for read_c22()
Date: Wed, 27 May 2026 18:34:49 +0200
Message-ID: <20260527163449.1294961-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
References: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CNctEB88RfkUileIQYAI2/V5qhJoC0UX9nQNUKv3K1s4s0HRpPG
 1e+l0AqgMmDj0TVxSGCamLb48bFHV7zFOhVyYLMJdy+W1iwuZY5dvg1H/gZGzy2R2k/2Bhz
 FV+ezMmxRq3u2fKDB8VeWws/5FGW/4ubyhtQZM6DdtNtoC/bGVqQPcKAictyfpuXmKS46ZB
 nzHKuY31L2y5ZjO1+yfPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:427NJkysJZY=;HHK1ccMqy1HYKrl9laZUyb+te4h
 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
 YQaz4Bp7QBwg9NNKPo=
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-292381-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: E63345E7E38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the final missing read_c22() path to the new read enabled command
runner. Do it the same way as other implementations.

- bus calls otto_emdio_read_c22()
- this hands over to SoC specific otto_emdio_9300_read_c22()
- finally the registers are filled and the runner issued

With this cleanup remove the obsolete helper otto_emdio_wait_ready()

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 87 ++++++++-----------------
 1 file changed, 27 insertions(+), 60 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 92d7fe6fa1f3..bafcd6afe619 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -97,7 +97,7 @@ struct otto_emdio_info {
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
-	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
+	int (*read_c22)(struct mii_bus *bus, int port, int regnum, u32 *value);
 	int (*read_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum,=
 u32 *value);
 	int (*write_c22)(struct mii_bus *bus, int port, int regnum, u16 value);
 	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
@@ -213,66 +213,17 @@ static int otto_emdio_write_cmd(struct mii_bus *bus,=
 u32 cmd,
 	return otto_emdio_run_cmd(bus, cmd | priv->info->cmd_write, cmd_data);
 }
=20
-static int otto_emdio_wait_ready(struct otto_emdio_priv *priv)
+static int otto_emdio_9300_read_c22(struct mii_bus *bus, int port, int re=
gnum, u32 *value)
 {
-	struct regmap *regmap =3D priv->regmap;
-	u32 cmd_reg, val;
-
-	lockdep_assert_held(&priv->lock);
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
-
-	return regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_C=
MD), 10, 1000);
-}
-
-static int otto_emdio_9300_read_c22(struct mii_bus *bus, int phy_id, int =
regnum)
-{
-	struct otto_emdio_chan *chan =3D bus->priv;
-	struct otto_emdio_priv *priv;
-	u32 io_reg, cmd_reg, val;
-	struct regmap *regmap;
-	int port;
-	int err;
-
-	priv =3D chan->priv;
-	regmap =3D priv->regmap;
-	io_reg =3D priv->info->cmd_regs.io_data;
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
-
-	port =3D otto_emdio_phy_to_port(bus, phy_id);
-	if (port < 0)
-		return port;
-
-	mutex_lock(&priv->lock);
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, io_reg, FIELD_PREP(PHY_CTRL_INDATA, port));
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
-	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
-	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
-	err =3D regmap_write(regmap, cmd_reg, val);
-	if (err)
-		goto out_err;
-
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_read(regmap, io_reg, &val);
-	if (err)
-		goto out_err;
-
-	mutex_unlock(&priv->lock);
-	return FIELD_GET(PHY_CTRL_DATA, val);
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	struct otto_emdio_cmd_regs cmd_data =3D {
+		.c22_data	=3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, port),
+	};
=20
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return otto_emdio_read_cmd(bus, PHY_CTRL_TYPE_C22, &cmd_data, value);
 }
=20
 static int otto_emdio_9300_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
@@ -314,6 +265,22 @@ static int otto_emdio_9300_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_write_cmd(bus, PHY_CTRL_TYPE_C45, &cmd_data);
 }
=20
+static int otto_emdio_read_c22(struct mii_bus *bus, int phy_id, int regnu=
m)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
+	u32 value;
+
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
+	if (port < 0)
+		return port;
+
+	scoped_guard(mutex, &priv->lock)
+		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+
+	return ret ? ret : value;
+}
+
 static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
@@ -437,7 +404,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		bus->read_c45 =3D otto_emdio_read_c45;
 		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
-		bus->read =3D priv->info->read_c22;
+		bus->read =3D otto_emdio_read_c22;
 		bus->write =3D otto_emdio_write_c22;
 	}
 	bus->parent =3D dev;
=2D-=20
2.54.0


