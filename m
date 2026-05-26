Return-Path: <netdev+bounces-291871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLfKCBHeFWrTdQcAu9opvQ
	(envelope-from <netdev+bounces-291871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:53:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A95DAF91
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE3C430C1B8E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05C413D8B;
	Tue, 26 May 2026 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="s66zChVv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC640B6DC
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817467; cv=none; b=Mfwo6egaZHQZAI5tQoUED81rTc0D7MEikJ4ihJBNCbhhWhkka0pJk+g+KUtSOlRmb4HoJ3NFFOXMV8ZPGz5oDvoGvlEDcQ03xat8gzrb8lTNadaPJ5c4Otu2fdOd+ms9t4wB6c7XcBLUBQQYxcMfzg4M9KvNRYfHKBqAGvCcFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817467; c=relaxed/simple;
	bh=9ykLx1DjYg1CeyDn9dUk9cQCMf//QdqtLyt5DQvkiGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAPWWIarfERF8fyS1wi1xdp8+iY6WRSlkdui6Z0QuklHMd8ukTsCoDcsU2B0ejl7xma+lW8uTXwwVPt/zQ3dloGNIkUowpOcaWJjMBFUgXY1WGvog2A2WHny0ueaumlh6zvzPrJvBcPyURcLl0GxmB4JT+XQa661jTQMNoA4fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=s66zChVv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779817444; x=1780422244;
	i=markus.stockhausen@gmx.de;
	bh=5nMb8t9cTRyzcgcEkRt913b/r5vhQ592OrMm/vwO8Qw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s66zChVvQu4u77kK8KqClMXp3NCDD3l9MUd20rKJr08Qwa/tStmNeMt5jJ0YL5gK
	 P8GySl3OUvwtJqzSl6+/uNSHUQ6zWe7dfq2Kk/dnT96hAqWyf/OGSoVcfBFYxmGkD
	 beuK0Qoz3ZMR/yfwMgv5QtflmVrvZiCjZv7gwj08cviJATs3xca6RXar49V4cz+fw
	 LuRCw+++qVoTP6u+q09PvVcVtUrFDG9hWf2wi//TyVCOd5+mXiX7vHH17mgfem7rB
	 SfmbvdPML7kIWJpQG2P+pOai7TilACaJcYXKq0SBqbXyUZR04kOanc5IX049fSkeP
	 EVEaGCHA966cBLSd3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1xJcIy0Wom-00whWY; Tue, 26
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
Subject: [PATCH net-next 1/5] net: mdio: realtek-rtl9300: provide generic command runner
Date: Tue, 26 May 2026 19:43:40 +0200
Message-ID: <20260526174344.1186832-2-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:DgD2qg3a9rJjGGfZAqnnam0TG6Jbn+d5ta0LrQ5C8dKk4KyF4I0
 E9jQRS0zy6jyyux4jUtS3YRfAsjh3x5gILFjniKKokYs2jg7vjUTIpWNHfJep//FpDdWvar
 WkwVNWHpzPhbaJKsj5GqhbyLekxdiVCNB3vrl0+EyqsbjdlyuPCO1HBFcHzvS61zIW9ctsI
 FeNGT72y8Qdm59r97X6PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W8lKiVsmhNE=;32IoOV1Xn+Kf6ugRRObbTP8uymF
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-291871-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 8B5A95DAF91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current bus read/write commands for C22/C45 are RTL930x specific.
Avoid to duplicate those 200 lines of code for the RLT838x, RTL839x and
RTL931x targets. Instead provide a generic command runner that is SoC
indpendent. The implementation works as follows:

The runner will take a prepared list of the four MDIO registers. It will
feed the data into the registers. This generic write to all registers
(or to say "a little bit too much") is no issue. The hardware looks at
the to be executed command and will only take the pieces of data that
are really required. No side effects have been observed on any of the
four SoCs during the time this mechanism exists in downstream OpenWrt.

The last fed register is the C22/command register. This will be enriched
with the proper command flags from the caller. The hardware issues the
command and the runnter will wait for its finalization.

Besides from feeding all registers the runner emulates the behaviour of
the old code:

- check defensively for a running command in advance
- take over the existing timeouts
- Return -ENXIO in case of hardware failure (fail bit)

As a first consumer of this runner convert the write_c45() function.
This is realized in a two stage approach

- a generic otto_emdio_write_c45() will be called by the bus
- this will forward the request to the device specific writer. In this
  case otto_emdio_9300_write_c45().

With all the above mentioned in place, there is not much left to do in
otto_emdio_9300_write_c45(). It just fills the register fields and
calls the runner with the right command bits.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 121 ++++++++++++++----------
 1 file changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 65c59b8457d4..13132079aab3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -90,6 +90,7 @@ struct otto_emdio_cmd_regs {
 };
=20
 struct otto_emdio_info {
+	u32 cmd_fail;
 	struct otto_emdio_cmd_regs cmd_regs;
 	u8 num_buses;
 	u8 num_ports;
@@ -97,7 +98,7 @@ struct otto_emdio_info {
 	int (*read_c22)(struct mii_bus *bus, int phy_id, int regnum);
 	int (*read_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regnu=
m);
 	int (*write_c22)(struct mii_bus *bus, int phy_id, int regnum, u16 value)=
;
-	int (*write_c45)(struct mii_bus *bus, int phy_id, int dev_addr, int regn=
um, u16 value);
+	int (*write_c45)(struct mii_bus *bus, int port, int dev_addr, int regnum=
, u16 value);
 };
=20
 struct otto_emdio_priv {
@@ -132,6 +133,52 @@ static int otto_emdio_phy_to_port(struct mii_bus *bus=
, int phy_id)
 	return -ENOENT;
 }
=20
+static struct otto_emdio_priv *otto_emdio_bus_to_priv(struct mii_bus *bus=
)
+{
+	return ((struct otto_emdio_chan *)bus->priv)->priv;
+}
+
+static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
+			      struct otto_emdio_cmd_regs *cmd_data)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	const struct otto_emdio_info *info =3D priv->info;
+	u32 cmdstate;
+	int ret;
+
+	lockdep_assert_held(&priv->lock);
+
+	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.port_mask_low, cmd_dat=
a->port_mask_low);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.io_data, cmd_data->io_=
data);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.c45_data, cmd_data->c4=
5_data);
+	if (ret)
+		return ret;
+
+	/* C22 data and command bits share the same register. */
+	ret =3D regmap_write(priv->regmap, info->cmd_regs.c22_data,
+			   cmd_data->c22_data | cmd | PHY_CTRL_CMD);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_read_poll_timeout(priv->regmap, info->cmd_regs.c22_data,
+				       cmdstate, !(cmdstate & PHY_CTRL_CMD), 10, 1000);
+	if (ret)
+		return ret;
+
+	return cmdstate & info->cmd_fail ? -ENXIO : 0;
+}
+
 static int otto_emdio_wait_ready(struct otto_emdio_priv *priv)
 {
 	struct regmap *regmap =3D priv->regmap;
@@ -304,64 +351,33 @@ static int otto_emdio_9300_read_c45(struct mii_bus *=
bus, int phy_id, int dev_add
 	return err;
 }
=20
-static int otto_emdio_9300_write_c45(struct mii_bus *bus, int phy_id, int=
 dev_addr,
-				  int regnum, u16 value)
+static int otto_emdio_9300_write_c45(struct mii_bus *bus, int port,
+				     int dev_addr, int regnum, u16 value)
 {
-	struct otto_emdio_chan *chan =3D bus->priv;
-	struct otto_emdio_priv *priv;
-	u32 io_reg, cmd_reg, val;
-	struct regmap *regmap;
-	int port;
-	int err;
+	struct otto_emdio_cmd_regs cmd_regs =3D {
+		.c45_data	=3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
+				  FIELD_PREP(PHY_CTRL_MMD_REG, regnum),
+		.io_data	=3D FIELD_PREP(PHY_CTRL_INDATA, value),
+		.port_mask_low	=3D BIT(port),
+	};
+
+	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE, &cmd_=
regs);
+}
=20
-	priv =3D chan->priv;
-	regmap =3D priv->regmap;
-	io_reg =3D priv->info->cmd_regs.io_data;
-	cmd_reg =3D priv->info->cmd_regs.c22_data; /* shared command/C22 registe=
r */
+static int otto_emdio_write_c45(struct mii_bus *bus, int phy_id,
+				int dev_addr, int regnum, u16 value)
+{
+	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
+	int ret, port;
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
 		return port;
=20
-	mutex_lock(&priv->lock);
-	err =3D otto_emdio_wait_ready(priv);
-	if (err)
-		goto out_err;
+	scoped_guard(mutex, &priv->lock)
+		ret =3D (*priv->info->write_c45)(bus, port, dev_addr, regnum, value);
=20
-	err =3D regmap_write(regmap, priv->info->cmd_regs.port_mask_low, BIT(por=
t));
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_INDATA, value);
-	err =3D regmap_write(regmap, io_reg, val);
-	if (err)
-		goto out_err;
-
-	val =3D FIELD_PREP(PHY_CTRL_MMD_DEVAD, dev_addr) |
-	      FIELD_PREP(PHY_CTRL_MMD_REG, regnum);
-	err =3D regmap_write(regmap, priv->info->cmd_regs.c45_data, val);
-	if (err)
-		goto out_err;
-
-	err =3D regmap_write(regmap, cmd_reg, PHY_CTRL_TYPE_C45 | PHY_CTRL_WRITE=
 | PHY_CTRL_CMD);
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
-
-	mutex_unlock(&priv->lock);
-	return 0;
-
-out_err:
-	mutex_unlock(&priv->lock);
-	return err;
+	return ret;
 }
=20
 static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
@@ -438,7 +454,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
 		bus->read_c45 =3D priv->info->read_c45;
-		bus->write_c45 =3D priv->info->write_c45;
+		bus->write_c45 =3D otto_emdio_write_c45;
 	} else {
 		bus->read =3D priv->info->read_c22;
 		bus->write =3D priv->info->write_c22;
@@ -558,6 +574,7 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 }
=20
 static const struct otto_emdio_info otto_emdio_9300_info =3D {
+	.cmd_fail =3D PHY_CTRL_FAIL,
 	.cmd_regs =3D {
 		.c22_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_1,
 		.c45_data =3D RTL9300_SMI_ACCESS_PHY_CTRL_3,
=2D-=20
2.54.0


