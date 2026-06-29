Return-Path: <netdev+bounces-302692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RqDtAOuOQmru9gkAu9opvQ
	(envelope-from <netdev+bounces-302692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:27:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC06DCA6F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:27:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=KeldibTF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302692-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302692-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAF753057069
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF2426EAB;
	Mon, 29 Jun 2026 15:23:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1B426EA9;
	Mon, 29 Jun 2026 15:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746638; cv=none; b=nyXxzVJGGKHN39sIfYg0yj5JJ5O4UhQXhspytRVDDuAdJZCEmk1OAXcm3+BFG/Ull3qi0yK7nDoafof6jHE2EGhPliunb31IgHlYMZC0yxezcDqXjS+GYlzmZXNmOCHBcfETl8sov/3NCnJ9nyTTvg+iLJnn+cL/3dur/V6NWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746638; c=relaxed/simple;
	bh=4ToOCEdGikA+3LziaX4ZaGqAGAdRhc9UM4hRvUSTsY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYXkBwFMLJCUT+2i3lh3/qwnXjPDe1SQUIZVVpcGLeMG2XikE55hyjxid5D1wpnLQNO+d96FKwhkyNP3E0I8Eu6g6A6NpxrU3OF21PQ0xPrU29wMre7PSe10djaxPKMXuM/3nOraxiPSVRKnEj+UIdk802EabwZ/3GiSzxiaZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=KeldibTF; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782746632; x=1783351432;
	i=markus.stockhausen@gmx.de;
	bh=LGDbOJG6xugQq4jzpbT2Wvwhv8VoaU6uCimYnXi0OGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KeldibTFhzP8QPzDfYIEFcvp4oI9w+HsqJgi4jr8qVFPW+T9Mg/cYW8uAhU+G9mJ
	 V47OJutUIEQFHo3VXjzLpllzNOdRXA1yhCsUvVvrXznEEoEgrANhez0XPLeFoyq77
	 14alJa6ok5jo56tZoJvftCeSH8ODPkPAdss1SezCXdXyWFnnjbbYBOJepeAyPe0Hp
	 4PJGMz7JOny/mVPa3AoPCmZYje5EhfA0d4SokJaraX0GRrUYvEx/k2gSfQm1vMJWm
	 daZXcBtP4gzgxf30pCbd9xseZSWdd/wRjMHO8TOAgbClai7DFOUsxfw3TsWiOhAKD
	 Vcw3sPtVdOEwaHEWlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1wzcNO3CmQ-0185ui; Mon, 29
 Jun 2026 17:23:52 +0200
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
Subject: [PATCH net-next v2 5/8] net: mdio: realtek-rtl9300: Add c45 over c22 mitigation
Date: Mon, 29 Jun 2026 17:23:33 +0200
Message-ID: <20260629152336.2239826-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
References: <20260629152336.2239826-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TXFTh2+moz/IxRMyHBm8bO2GtqHaXTWC1Izagzt/LDsS6ApTeVO
 +rXWwrLVVaO+NTV+9NmWzxr1L7GPFPlPZBmayV/GmqhXpGghCi9YUvRJicTB8MLY4veFA/f
 9YjWTuuyzIbPPqSZoxHFuz/aCL3n9dvEB4hy8GIlnPqitbifnnYwMesD0D5h2HeeImWKZUS
 ITF7JZFOWNhuob2cDizGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pMjk/z8mU+g=;oh2f4KkvB2adGIgMXFceJGZn5I2
 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
 7Kqvb8Ba0P3k3ndf64oCrm2DFyZo7XxoTuDiyKi
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302692-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93FC06DCA6F

When reading the PHY state on c22 based buses the hardware polling unit
reads the EEE status with a sequence similar to this:

  ...
  phy_write(phy, 31, 0x0);
  phy_write(phy, 13, 0x7); /* c45 over c22 MDIO_AN_EEE_ADV */
  phy_write(phy, 14, 0x3c);
  phy_write(phy, 13, 0x8007);
  phy_read(phy, 14);
  phy_write(phy, 13, 0x7); /* c45 over c22 MDIO_AN_EEE_LPABLE */
  phy_write(phy, 14, 0x3d);
  phy_write(phy, 13, 0x8007);
  ...

If the Linux kernel wants to do the same in mmd_phy_read() via a call to
mmd_phy_indirect() this most likely fails. The commands are issued in a
straight sequence but between two of them the hardware polling might run
a status check for the same PHY. This effectively breaks the kernel access
and makes use of c45 over c22 unusable.

Detailed analysis shows that for RTL838x, RTL930x and RTL931x polling
can be safely deactivated during operation. The MAC layer will continue
to show the last known state. RTL839x is an exception from this. As soon
as polling is disabled the MAC link status register shows "port down".

Enhance the driver to detect this register 13/14/13/14 access sequence.
Before the first access to register 13 of a PHY disable polling for the
corresponding port. Reenable polling as soon as the sequence is finished
or any other unexpected input is detected. Some details about the stop
and start timing:

- The stopping is issued inflight while the polling engine is working.
  After it is finished no new polling for the port will be issued (tested
  with only one port with active polling).
- Reenabling the polling engine happens within ~25us after the last
  command of the MMD sequence. This is mostly due to MMIO overhead.

Technically speaking, add a simple state machine that increments a
per-port MMD counter for each successful step of the sequence. When the
first command starts (counter=3D1) stop polling. When the last command
finishes (counter=3D4), errors happen or unexpected data is sent, start
polling.

Additionally add a global "link flapping" option that allows to disable
the state tracker for the to-be-added RTL839x series completely.

Remark! The priv->bus[] array already existed since the initial driver
version but was never filled. To make use of it in this patch add
the initialization too.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a8e9a497a0dc..8b60645093e3 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -197,6 +197,7 @@ struct otto_emdio_priv {
 	DECLARE_BITMAP(phy_poll, MAX_PORTS);
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
 	u16 page[MAX_PORTS];
+	u8 mmd_state[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
@@ -210,6 +211,7 @@ struct otto_emdio_info {
 	u32 cmd_read;
 	u32 cmd_write;
 	struct otto_emdio_cmd_regs cmd_regs;
+	bool link_flap;
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
@@ -259,6 +261,47 @@ static int otto_emdio_set_port_polling(struct otto_em=
dio_priv *priv, int port, b
 				  BIT(port % 32), active);
 }
=20
+static int otto_emdio_mmd_prefix(struct otto_emdio_priv *priv, int port, =
int regnum)
+{
+	u8 newstate, *state =3D &priv->mmd_state[port];
+	int expected, ret =3D 0;
+
+	if (!test_bit(port, priv->phy_poll))
+		return 0;
+	/*
+	 * Disabled polling might produce link flapping and false notification i=
nterrupts on the
+	 * MAC layer. In this case disable c45 over c22 MMD access because chanc=
es are high that
+	 * the register 13/14/13/14 sequence is intercepted by a parallel hardwa=
re access. As
+	 * a workaround the PHY must provide its own mmd read/write() callbacks =
and redirect to
+	 * normal c22 registers. See rtlgen_read_mmd().
+	 */
+	if (priv->info->link_flap)
+		return (regnum =3D=3D MII_MMD_DATA || regnum =3D=3D MII_MMD_CTRL) ? -EI=
O : 0;
+
+	expected =3D (*state & 1) ? MII_MMD_DATA : MII_MMD_CTRL;
+	newstate =3D regnum =3D=3D expected ? *state + 1 : 0;
+
+	if (newstate =3D=3D 1 || newstate < *state)
+		ret =3D otto_emdio_set_port_polling(priv, port, !newstate);
+	*state =3D newstate;
+
+	return ret;
+}
+
+static void otto_emdio_mmd_postfix(struct otto_emdio_priv *priv, int port=
, int cmdret)
+{
+	struct mii_bus *bus =3D priv->bus[priv->smi_bus[port]];
+
+	if (!test_bit(port, priv->phy_poll))
+		return;
+
+	if (cmdret || priv->mmd_state[port] =3D=3D 4) {
+		priv->mmd_state[port] =3D 0;
+		if (otto_emdio_set_port_polling(priv, port, true))
+			dev_err(bus->parent, "failed to enable polling for port %d\n", port);
+	}
+}
+
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
 			      struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -465,10 +508,15 @@ static int otto_emdio_read_c22(struct mii_bus *bus, =
int phy_id, int regnum)
 		return port;
=20
 	scoped_guard(mutex, &priv->lock) {
+		ret =3D otto_emdio_mmd_prefix(priv, port, regnum);
+		if (ret)
+			return ret;
+
 		if (regnum =3D=3D 31)
 			return priv->page[port];
=20
 		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+		otto_emdio_mmd_postfix(priv, port, ret);
 	}
=20
 	return ret ? ret : value;
@@ -484,6 +532,10 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 		return port;
=20
 	scoped_guard(mutex, &priv->lock) {
+		ret =3D otto_emdio_mmd_prefix(priv, port, regnum);
+		if (ret)
+			return ret;
+
 		if (regnum =3D=3D 31) {
 			if (value >=3D RAW_PAGE(priv))
 				return -EINVAL;
@@ -493,6 +545,7 @@ static int otto_emdio_write_c22(struct mii_bus *bus, i=
nt phy_id, int regnum, u16
 		}
=20
 		ret =3D priv->info->write_c22(bus, port, regnum, value);
+		otto_emdio_mmd_postfix(priv, port, ret);
 	}
=20
 	return ret;
@@ -665,6 +718,7 @@ static int otto_emdio_probe_one(struct device *dev, st=
ruct otto_emdio_priv *priv
 	if (!bus)
 		return -ENOMEM;
=20
+	priv->bus[mdio_bus] =3D bus;
 	bus->name =3D "Realtek Switch MDIO Bus";
 	if (priv->smi_bus_is_c45[mdio_bus]) {
 		bus->read_c45 =3D otto_emdio_read_c45;
=2D-=20
2.54.0


