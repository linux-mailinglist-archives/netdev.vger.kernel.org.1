Return-Path: <netdev+bounces-291870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2WkJBPjbFWrEdQcAu9opvQ
	(envelope-from <netdev+bounces-291870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF885DADFD
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1994301107D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363F413D8B;
	Tue, 26 May 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="s+xOGhJr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824541B34F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817461; cv=none; b=knzZwRBryCokXPUqp2xuowXg44Q879iVwjrk/58YmGFddfAJjqN15K2bM5aHu4Mvl2oSWeAulXP6SYqe3eG2zw2EL+4zSCm+68Hubm2tA1nbia30xRTr1oGHCd9ZdP5rqWkJVcChRnJixHER5qKfsjvTHXDNrxHZOT+HfrL2FY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817461; c=relaxed/simple;
	bh=htoZHLwJuHVjxtC/0Klc09z9d6EFJaqH/R3xv8gIo6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKqtXbhLeFJ9CgrMQ0hO7MyJFXsmhUh34LVL5TlQ1ZRtW7W4QZ9jHxINwdxPj0eLcu0PVSDqqouoOJSS2n2jJtzS3dJIOk32jtOgC35246jOGQ5mfoDI5qPbCcO0a3ckm+AzCIoAQ+vJ07ms9p37ar0OvOPbBPLhFQ0rr+GX9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=s+xOGhJr; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779817444; x=1780422244;
	i=markus.stockhausen@gmx.de;
	bh=FbHlO1wY4zLLaagruQzDLViO0yvLpMoEqDIM8sNqjzs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s+xOGhJrKVBPz343s8wbfpbwLchxOEQfZ/3h4o2jK+EJCtOt8GtDSbhDZeowghDS
	 lw9H/SFszZQ4QCVRYefODSyQVJ1kDqoEqiQkFPNeu1nSLnZS13E5G89DvVrcPgydC
	 gxaKGiJNntzGFuBDL9jCoQxYhDzvGd5neiXWjNiSMk2gtsxwCjFz0s9VViFkDrGlN
	 sb9rLPijQSJGRSgwTOFOs/feKWck79hxg6X/xauNF2J2REVP0C+1dH/3snaJ8qGog
	 f4VWM5+hnB7SWSYfoW/zTsgA0AR3Pl+HTmbsdMh1mjlAupHmEIFhpX6slyQHe0kT2
	 SnDUWZJGNH+Zm8OJrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1wZfZw1u9U-00Gvf4; Tue, 26
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
Subject: [PATCH net-next 2/5] net: mdio: realtek-rtl9300: use command runner for write_c22()
Date: Tue, 26 May 2026 19:43:41 +0200
Message-ID: <20260526174344.1186832-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:zFIgLXiwfaNIijxMW9Qu1+Ct++ggmXKsMm/YsgVE3ZjbV4gFes/
 8vCgZv8r8J2ZEFH0k20aEdstsLGj7fmOmPmTFsVj7G13KIFLSu/a12x2cMvY4Pk2D0EVOBv
 QzYayMttv13ZW+AQIYefNkYvvs3alOsjLIbz0Str1zmDeiuvS8czRrU1qQhaTObce+pqKvy
 pLFrLT5n2VzHZt26STacw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XDInCE8JqBk=;qHdx+Z1pLezkxK0E8/B6x2f9r3F
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-291870-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9DF885DADFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that the driver has a generic command runner make use of it in the
write_c22() path. For this.

- add generic otto_emdio_write_c22() helper that will be called by bus
- convert otto_emdio_9300_write_c22() to new command runner logic

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 80 +++++++++----------------
 1 file changed, 27 insertions(+), 53 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 13132079aab3..a1870b16d8b9 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -97,7 +97,7 @@ struct otto_emdio_info {
 	u16 num_pages;
 	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
 	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
-	int (*write_c22)(struct mii_bus *bus, int phy_id, int regnum, u16 value)=
;
+	int (*write_c22)(struct mii_bus *bus, int port, int regnum, u16 value);
 	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
 };
=20
@@ -241,60 +241,19 @@ static int otto_emdio_9300_read_c22(struct mii_bus *=
bus, int phy_id, int regnum)
 	return err;
 }
=20
-static int otto_emdio_9300_write_c22(struct mii_bus *bus, int phy_id, int=
 regnum, u16 value)
+static int otto_emdio_9300_write_c22(struct mii_bus *bus, int port, int r=
egnum, u16 value)
 {
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
-	err =3D regmap_write(regmap, priv->info->cmd_regs.port_mask_low, BIT(por=
t));
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, io_reg, FIELD_PREP(PHY_CTRL_INDATA, value))=
;
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
-	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
-	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)) |
-	      PHY_CTRL_WRITE | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
-	err =3D regmap_write(regmap, cmd_reg, val);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_read_poll_timeout(regmap, cmd_reg, val, !(val & PHY_CTRL_=
CMD), 10, 100);
-	if (err)
-		goto out_err;
-
-	if (val & PHY_CTRL_FAIL) {
-		err =3D -ENXIO;
-		goto out_err;
-	}
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
=20
-	mutex_unlock(&priv->lock);
-	return 0;
+	struct otto_emdio_cmd_regs cmd_regs =3D {
+		.c22_data	=3D FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
+				  FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
+				  FIELD_PREP(PHY_CTRL_MAIN_PAGE, RAW_PAGE(priv)),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
=20
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C22 | PHY_CTRL_WRITE, &cmd_=
regs);
 }
=20
 static int otto_emdio_9300_read_c45(struct mii_bus *bus, int phy_id, int =
dev_addr, int regnum)
@@ -364,6 +323,21 @@ static int otto_emdio_9300_write_c45(struct mii_bus *=
bus, int port,
 	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE, &cmd_=
regs);
 }
=20
+static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
+
+	port =3D otto_emdio_phy_to_port(bus, phy_id);
+	if (port < 0)
+		return port;
+
+	scoped_guard(mutex, &priv->lock)
+		ret =3D (*priv->info->write_c22)(bus, port, regnum, value);
+
+	return ret;
+}
+
 static int otto_emdio_write_c45(struct mii_bus *bus, int phy_id,
 				int dev_addr, int regnum, u16 value)
 {
@@ -457,7 +431,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
 		bus->read =3D priv->info->read_c22;
-		bus->write =3D priv->info->write_c22;
+		bus->write =3D otto_emdio_write_c22;
 	}
 	bus->parent =3D dev;
 	chan =3D bus->priv;
=2D-=20
2.54.0


