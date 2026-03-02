Return-Path: <netdev+bounces-262691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKdUBZqopWngCwAAu9opvQ
	(envelope-from <netdev+bounces-262691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4221DB85C
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FA8A30217C5
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42A4014BE;
	Mon,  2 Mar 2026 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GANvyKan"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C24014A6;
	Mon,  2 Mar 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464269; cv=none; b=Naa64EOmsZhiaau2djuBEkC69b6e+uXXA06o63qSQYnvrSa57UclwTRQPM8E+YiAx8yNVRDafiJbYjBb2a8LQe0W3ID3C59p0ELT1LIE/keuv86G++ryfSCtsrCwKPOv6SIcukl9Tv0CmPolQiDvROm/a3gOu9qzy9xVB4R2fyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464269; c=relaxed/simple;
	bh=S3mnSMmtPzmTVzhJoUQ4a7SdRnoDLgRFvId3NK4J+mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=goG89pmQJtd+MakaBqh+8CewZ8TdZ3MpQtoNi6eJmHL8xX7hHivq4HvZXBQSJBWQMTqDTGdu+E0VLPNh1H1BM9xhAqBZ/+YYLgSX6thALulAWqE4sXaodr7bpqiUr453aAxGFeYUYW2gqJSx6KoVJcvURWuQ/2PgFXysEP3v0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GANvyKan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA9DC19423;
	Mon,  2 Mar 2026 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772464268;
	bh=S3mnSMmtPzmTVzhJoUQ4a7SdRnoDLgRFvId3NK4J+mQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GANvyKan2IXX5CoTA/nIinryeNHadthB+SeeSGMA5NaIRuXxhlDfXKs4O26IzPdNj
	 ZteGK24msw3tQ7mBYkMVNdC9SQGnXAL3kYA+0xw4Lsr3hyZ8uSbEQUfDpVKzzQ9Xf/
	 8L5gOly59uFEmiyuNlX9dfpXVGz+7q6b0B1dbc49y+lCaq+SusQ26aFU/E8Rl85OTC
	 GLxAutvwlrhFw5ZUkdTOFn+ebiRPCKfAW05brmYUehV/dSEYlj1Rf7o1FxI+PTaW7E
	 ql/0lHKzgnpOHqwY00nuXmloKILvzUn1w0F4WlG0vRZz0py0+pgKxFzw2XSi2ZGzUJ
	 2EWkAL1aOK6LQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE8EA4E0A;
	Mon,  2 Mar 2026 15:11:08 +0000 (UTC)
From: Serapheim Dimitropoulos via B4 Relay <devnull+sdimitropoulos.coreweave.com@kernel.org>
Date: Mon, 02 Mar 2026 10:10:59 -0500
Subject: [PATCH net-next] net: mdio: add fwnode compatible matching to
 mdio_bus_match()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-mdio-fwnode-match-v1-1-ac542b7c53a3@coreweave.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDsQh1Jpr1JcRPOnzsJJSUIri
 Hc3uPwW7+1UkBWFXt1OGT8tmqyhv3U0L94+YA3NJE4eTmTgNWji+LcUwKuv88KTPDHdAwYfHbX
 umxF1u55vMlQ2bJXG4zgBis//TG0AAAA=
X-Change-ID: 20260227-mdio-fwnode-match-b29eb4de7af0
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772464267; l=3051;
 i=sdimitropoulos@coreweave.com; s=20260302; h=from:subject:message-id;
 bh=MRrfkvAZ3+WAdPSLi3xHODK806e9I/kLyRuqHAkQMlg=;
 b=iZTvmuUSjDogsrbLldqRhLOUPu/mEq40ouAS0VkuZRPW137iZthkyPR4iDj22HW0h/iCpsk46
 7+yVlk6K3FCC2c+1+Ro8u0JB4vACBjTuaIfDZs4X7R0FUW7lRCquRMZ
X-Developer-Key: i=sdimitropoulos@coreweave.com; a=ed25519;
 pk=Qysvg7jaTIU0posaYFtqa5SKJlFwqzil4X0U1p1zo/g=
X-Endpoint-Received: by B4 Relay for sdimitropoulos@coreweave.com/20260302
 with auth_id=655
X-Original-From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
Reply-To: sdimitropoulos@coreweave.com
X-Rspamd-Queue-Id: 8B4221DB85C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262691-lists,netdev=lfdr.de,sdimitropoulos.coreweave.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[sdimitropoulos@coreweave.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>

The MDIO bus match function currently only supports Device Tree
(of_driver_match_device) and PHY-ID-based matching (bus_match callback).
This means MDIO drivers that rely on compatible-string matching, such as
the mv88e6xxx DSA switch driver, cannot bind on systems that describe
hardware topology via firmware nodes (fwnode/software nodes) rather than
Device Tree.

This is a problem for x86/ACPI platforms where MDIO buses are created
dynamically (e.g., USB-to-MDIO bridges) and have no Device Tree
representation. On these systems, kernel modules or ACPI tables can
describe the MDIO device topology using software nodes with a
"compatible" property, but mdio_bus_match() never checks it.

Add a fallback matching path that iterates the driver's of_match_table
and checks each compatible string against the device's fwnode using the
existing device_is_compatible() helper. This is placed after the OF
match (which handles DT natively) and before the bus_match callback
(which handles PHY-ID matching), so existing match behavior is
unchanged.

This enables DSA switch drivers like mv88e6xxx to bind on x86 systems
where the switch topology is described via software nodes or ACPI,
closing a gap in MDIO bus support for non-DT platforms.

Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
---
 drivers/net/phy/mdio_bus.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index afdf1ad6c0e61..4575122edb475 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -959,6 +960,7 @@ static int mdio_bus_match(struct device *dev, const struct device_driver *drv)
 {
 	const struct mdio_driver *mdiodrv = to_mdio_driver(drv);
 	struct mdio_device *mdio = to_mdio_device(dev);
+	const struct of_device_id *id;
 
 	/* Both the driver and device must type-match */
 	if (!(mdiodrv->mdiodrv.flags & MDIO_DEVICE_IS_PHY) !=
@@ -968,6 +970,19 @@ static int mdio_bus_match(struct device *dev, const struct device_driver *drv)
 	if (of_driver_match_device(dev, drv))
 		return 1;
 
+	/*
+	 * Fall back to fwnode compatible matching for non-DT systems.
+	 * This enables MDIO drivers (e.g., DSA switch drivers) to bind
+	 * on platforms using software nodes or ACPI to describe the
+	 * MDIO device topology.
+	 */
+	if (dev_fwnode(dev) && !dev->of_node && drv->of_match_table) {
+		for (id = drv->of_match_table; id->compatible[0]; id++) {
+			if (device_is_compatible(dev, id->compatible))
+				return 1;
+		}
+	}
+
 	if (mdio->bus_match)
 		return mdio->bus_match(dev, drv);
 

---
base-commit: fd6dad4e1ae296b67b87291256878a58dad36c93
change-id: 20260227-mdio-fwnode-match-b29eb4de7af0

Best regards,
-- 
Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>



