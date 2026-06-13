Return-Path: <netdev+bounces-298957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MP1FFJQ/LWo5eQQAu9opvQ
	(envelope-from <netdev+bounces-298957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B801B67E78B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="Bom/pWoe";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298957-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298957-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDE0A304A650
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2473C2BBD;
	Sat, 13 Jun 2026 11:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784623DFC91;
	Sat, 13 Jun 2026 11:30:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781350228; cv=none; b=VB0YmRDmkuIk9RsdwRqf4xP8kmykmUNjZoR6kbm0mQJvfctx0Je3jHuZ4vB8+sKJsACGgLjHWnvkf1xb/XbJVUIp7EUIKuKEhToWJPf9fOdrxVGmbSe1TyoTD4u4abO4Dx3IC/x6ixyWKrb7J1WpSd6H9yZ7S0jSClo7g1cXGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781350228; c=relaxed/simple;
	bh=DYaw6AIH8r02lJz/1nRRt7ixmpY7RKDqSyufWAAUaag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkMQ7X3CSXOnjUUpZj7r/KNeiPpqLPlyl/a7XrhcIXf/+lPQkH33baR9Qe3hI/H9D6Fsln22ZorFDKUOCUO43NsLBk1veOqtF5YbhHUnATa/6QNN/fBHikvRs+4B02Qxdwf3WOIuQt6kUWKVNcQFemHJXsOz+Yv3qSK+I9Syrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Bom/pWoe; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781350202; x=1781955002;
	i=markus.stockhausen@gmx.de;
	bh=Tr/1KFtNmvAq7wg6tiS1vqI5MN/TkY0Cdm7mPH1lBlI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bom/pWoeWfYw+rWg6KwCQfo7aIZkIbJLIywO5Q+SXtkFoPH2WUtGdYtmjzyi0b4+
	 ioRH9uKz2wyMzcMu/qV+J4om0ejhtt1MebSOWBA04OoUOLo6MXeXrIQWcWcTSM3P0
	 FXeaujsAK580Y7FFO7WHj13/tV+5Cp4gmS5ccPZ2oyecfaUxQr8bTSlMysvVkJQHj
	 4aMTLEiYxSywOA33KRxtpqzn3574ObdNnMM4MgJmQuE2pwcC5MvrTC0iwZZ+pbE6X
	 kC9Y835yeBiMR6UD9tq3mS3KLg8s8gTI/Y2+Ko98dp/zGmCSnTccwRe0IDXcusxv9
	 KKDKoKFA+9Vd/W5HKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1x46sR2rqn-00ZWZ6; Sat, 13
 Jun 2026 13:30:02 +0200
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
Subject: [PATCH net-next 5/8] net: mdio: realtek-rtl9300: Add c45 over c22 mitigation
Date: Sat, 13 Jun 2026 13:29:43 +0200
Message-ID: <20260613112946.1071411-6-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
References: <20260613112946.1071411-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ow4us60OIvjosVt5pXsl9+5lJZrYzLapkNRHEum1/DHecW2rbwA
 UOk/FvmRIeecOe+cAeMMyIu8AK5ChWlTBhkWWTqD1oDFHhrrwbGjuHgZdCjkNl2lBQzasok
 MIPyXt+h9+mFscMjH81Ig/TKgNDIkMBMjFJujSEy5nEKK3b/EGDCpt/SIG9QiyftL5/pDtP
 L0XXv71VqWyNAr0Uy/U7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mnI7AEaX5dI=;CoMKbMUJrI+O6XqFbxPcBOzPyVQ
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:markus.stockhausen@gmx.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298957-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B801B67E78B

When reading the PHY state on c22 based buses the hardware polling unit
reads the EEE status with a sequence similar to this:

  ...
  phy_write(phy, 31, 0x0);
  phy_write(phy, 13, 0x7); /* c22 over c45 MDIO_AN_EEE_ADV */
  phy_write(phy, 14, 0x3c);
  phy_write(phy, 13, 0x8007);
  phy_read(phy, 14);
  phy_write(phy, 13, 0x7); /* c22 over c45 MDIO_AN_EEE_LPABLE */
  phy_write(phy, 14, 0x3d);
  phy_write(phy, 13, 0x8007);
  ...

If the Linux kernel wants to do the same in mmd_phy_read() via a call to
mmd_phy_indirect() this most likely fails. The commands are issued in a
straight sequence but between two of them the hardware polling might run
a status check for the same PHY. This effectively breaks the kernel access
and makes use of c45 over c22 unusable.

Detailed analysis shows that for RTL838x, RTL839x and RTL931x polling
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
finishes (counter=3D4) or unexpected data is sent start polling.

Additionally:

- Add a global "initialization done" tracker that stops the mechanism
  from kicking in during bus probing.
- Add a global "link flapping" option that allows to disable the state
  tracker for the to-be-added RTL839x series completely.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 62 ++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index a7fd075947b6..e206ee3e2b1c 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -196,10 +196,12 @@ struct otto_emdio_priv {
 	struct mutex lock; /* protect HW access */
 	DECLARE_BITMAP(valid_ports, MAX_PORTS);
 	u16 page[MAX_PORTS];
+	u8 mmd_state[MAX_PORTS];
 	u8 smi_bus[MAX_PORTS];
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
 	struct mii_bus *bus[MAX_SMI_BUSSES];
+	bool init_done;
 };
=20
 struct otto_emdio_info {
@@ -209,6 +211,7 @@ struct otto_emdio_info {
 	u32 cmd_read;
 	u32 cmd_write;
 	struct otto_emdio_cmd_regs cmd_regs;
+	bool link_flap;
 	u8 num_buses;
 	u8 num_ports;
 	u16 num_pages;
@@ -254,6 +257,43 @@ static int otto_emdio_set_port_polling(struct otto_em=
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
+	if (!priv->init_done)
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
+static int otto_emdio_mmd_postfix(struct otto_emdio_priv *priv, int port,=
 int regnum)
+{
+	if (priv->mmd_state[port] !=3D 4)
+		return 0;
+
+	priv->mmd_state[port] =3D 0;
+
+	return otto_emdio_set_port_polling(priv, port, true);
+}
+
 static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
 			      struct otto_emdio_cmd_regs *cmd_data)
 {
@@ -463,7 +503,15 @@ static int otto_emdio_read_c22(struct mii_bus *bus, i=
nt phy_id, int regnum)
 		if (regnum =3D=3D 31)
 			return priv->page[port];
=20
+		ret =3D otto_emdio_mmd_prefix(priv, port, regnum);
+		if (ret)
+			return ret;
+
 		ret =3D priv->info->read_c22(bus, port, regnum, &value);
+		if (ret)
+			return ret;
+
+		ret =3D otto_emdio_mmd_postfix(priv, port, regnum);
 	}
=20
 	return ret ? ret : value;
@@ -472,7 +520,7 @@ static int otto_emdio_read_c22(struct mii_bus *bus, in=
t phy_id, int regnum)
 static int otto_emdio_write_c22(struct mii_bus *bus, int phy_id, int regn=
um, u16 value)
 {
 	struct otto_emdio_priv *priv =3D otto_emdio_bus_to_priv(bus);
-	int port;
+	int port, ret;
=20
 	port =3D otto_emdio_phy_to_port(bus, phy_id);
 	if (port < 0)
@@ -487,7 +535,15 @@ static int otto_emdio_write_c22(struct mii_bus *bus, =
int phy_id, int regnum, u16
 			return 0;
 		}
=20
-		return priv->info->write_c22(bus, port, regnum, value);
+		ret =3D otto_emdio_mmd_prefix(priv, port, regnum);
+		if (ret)
+			return ret;
+
+		ret =3D priv->info->write_c22(bus, port, regnum, value);
+		if (ret)
+			return ret;
+
+		return otto_emdio_mmd_postfix(priv, port, regnum);
 	}
 }
=20
@@ -794,6 +850,8 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
 			return err;
 	}
=20
+	priv->init_done =3D true;
+
 	return 0;
 }
=20
=2D-=20
2.54.0


