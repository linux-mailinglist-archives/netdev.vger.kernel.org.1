Return-Path: <netdev+bounces-294027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEI6M3xqHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA2628918
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B626B309B0BA
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCE2D7386;
	Tue,  2 Jun 2026 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="MEineBoy"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DC2E54AA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378039; cv=none; b=JsS6g9+SNH7lUSNCPXg1JNqecdMxBuOxzMx6DegzZeN2RieTp6lVNMJF6pOmhUXT+WIU3BQCc7knZhDLhc4VRkCFCt/YmIYx7mMz3YCBRM7UvXfKcwpiHGQRwKJGwmFDNw3NlUyKbV48g0Ta9tXc7VK/NE48LHgbEUv48ay/Yxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378039; c=relaxed/simple;
	bh=PuzlTuv6iyLLSGMavk3yezoBbocOKW2wW6mppaWFQlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWiwJnwQErgsgsmyY3c53zFp8ZIGv+6RX+Ds3hbSnEsCmDArPt6V4CThuRB2x9jtIGobrW0+j3dZDPwXp9RYk8RHGypqCPpLl3UoKIsvbnjb5YX2ZziQLHddKPZ6r42TWfvhGvWRAkzajiaDvqAT6Vw9iTI4kLGgqmIkCpN532c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=MEineBoy; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378012; x=1780982812;
	i=markus.stockhausen@gmx.de;
	bh=TlGiqH0G4kU0OhJcj3QhR5rbhUMLcNuKwK40Z546APk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MEineBoyfqmVSzCgW3wPQNllRoIKlvlK8Fc5kNhdHDjxG/HAaXdvzZ4sS8tyRbJK
	 UXrHSrk2s3m7KYNavXnEFrABYmgmAV92RNxOeoSSGHyVfMrEQ+N5BULDIT2GlOS9v
	 5wYaM4tolTJUgOSWBuX/o29elLVFdNFPq2Jfp1B9/jQ8q6jqLqbBSa/bnoy1ud0TD
	 aAuUb01P4BXgn9KEDUErx9uYvecMURv5/MYdeh8WrafobO7E2q72UWeThrH0y7y9r
	 IqyVLmihVG/s+zkpQGd667TM+hlqhF75xE+M0J3p9MDQ/7Y+MQY9bAH3e2oHcAaBY
	 7DRgxMurVyFWCKmK0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fjb-1wOX190ncV-0042Ny; Tue, 02
 Jun 2026 07:26:52 +0200
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
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 2/8] net: mdio: realtek-rtl9300: Correctly handle ethernet-phy-package
Date: Tue,  2 Jun 2026 07:26:34 +0200
Message-ID: <20260602052640.93083-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602052640.93083-1-markus.stockhausen@gmx.de>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tcvbBAq1Eh79fU7BHRAZxjLfg+0yGygweC4ulpzftsZC1EjCorL
 c0410SJv9uap8fT2udwhNSpF2PIFmEdD83s8/oGSJurkXiijKUb8IFfLuEMrqHaikRuDzuA
 5K9qPLFuQWiF47gbuCtCn9YLoEptO8MeQ2ALjmGG4zO0aOoEc0wRd24Ka/YH1Fc0P7rSFQ0
 SyK2+a8YPQmkFfQVhLceQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xghLktGW4/4=;vHQEP6wgOz7mdwJmu+16rkyrdNY
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,gmx.de:mid,gmx.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mensi.ch:email]
X-Rspamd-Queue-Id: 77CA2628918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Realtek Otto switches usually make use of multiport PHYs (e.g. 8 port
1G RTL8218D or 4 port 2.5G RTL8224). The device tree can describe this
fact via an "ethernet-phy-package" node that resides between the bus
and the PHY node.

When looking up the device tree bus node via the chain port->phy->parent
the driver totally ignores the existence of a PHY package. Enhance the
lookup to take care of this feature.

Signed-off-by: Manuel Stocker <mensi@mensi.ch>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 1ccc0ab0daef..381c45e0597b 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -421,6 +421,21 @@ static int otto_emdio_probe_one(struct device *dev, s=
truct otto_emdio_priv *priv
 	return 0;
 }
=20
+static struct fwnode_handle *otto_emdio_get_bus_node(struct fwnode_handle=
 *fwnode)
+{
+	struct fwnode_handle *parent =3D fwnode_get_parent(fwnode);
+	struct fwnode_handle *grandparent;
+
+	if (parent && fwnode_name_eq(parent, "ethernet-phy-package")) {
+		grandparent =3D fwnode_get_parent(parent);
+		fwnode_handle_put(parent);
+
+		return grandparent;
+	}
+
+	return parent;
+}
+
 /* The mdio-controller is part of a switch block so we parse the sibling
  * ethernet-ports node and build a mapping of the switch port to MDIO bus=
/addr
  * based on the phy-handle.
@@ -449,7 +464,7 @@ static int otto_emdio_map_ports(struct device *dev)
 			continue;
=20
 		struct fwnode_handle *bus_fwnode __free(fwnode_handle) =3D
-			fwnode_get_parent(phy_fwnode);
+			otto_emdio_get_bus_node(phy_fwnode);
 		if (!bus_fwnode)
 			continue;
=20
=2D-=20
2.54.0


