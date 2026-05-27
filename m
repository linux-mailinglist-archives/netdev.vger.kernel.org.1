Return-Path: <netdev+bounces-292359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP+EG7EQF2o12wcAu9opvQ
	(envelope-from <netdev+bounces-292359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9F15E70B6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 744383049181
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2A3E833D;
	Wed, 27 May 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="RVTI7NY2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923643BBA0F;
	Wed, 27 May 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896362; cv=none; b=kL2L3Hp8Oft6f86FV1u+K11V3b/904EBEQWXQBEWUYECp01/FFFC4n+gA8OhNrpB51tQdQgTJjxACsmsxdqLLBN1vwngbVlZ9Vm7k1b9apslIjXVRtc3Rw8X9PsNlItePfeRNzEhbEoRRAW7k4ypAuuXaW5VzKqZN99zK1TSGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896362; c=relaxed/simple;
	bh=W8Hlr1IYbkNTQ9JdhkHSTsIensxuZkUGmgS6+7ZyPg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8rBab49Q2ulvo6r/X6XMYuRRsnDRoZ+KmqRXnsGCRgEdTTKTOXEZmyHPrxHMDCz7cKvjPuVaailW78loCa9MCyPv8ijRaFfPKhz43cjdLPEEmfS0Okxnq7qe/JZORV8YJED9xg8kCPvfGf01IwOTZB8Qb6M+mF1tsFrcSBH0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=RVTI7NY2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779896358; x=1780501158; i=wahrenst@gmx.net;
	bh=TS9XB8s+xUK7Q4wumP5iRQdNdTniKGOfcj4y9qYofLg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RVTI7NY2m6XFJkckBPXIxk0KtlQ43m/0cgUOjMcoaNjb+OmNgmEIgJNXVnz1ge8p
	 IKt5DoZ2PvgRpMysdQX6nhKW0f6wxYQq4QlrBB+WKZvsiWktSnUUYIK1a6Tvbicqj
	 wcWpPTA7b5Kt5MVI2seCUdeJ2pOsaQn5nOnY14urmT/2cxgrTxVAGS8EQB4AxtEYa
	 ZUhA4c/cfR6P+luFJuN5NPokO3NuQBI3pnXedCasoTWKvyzPqVN8IZKbc3TCo6ptA
	 uxJkA2erEygWdo7eIXB8HlqnIX0q7H9ZGFjsc9ZTDmtXl++H5cH+WYW3Lo8iewyeN
	 FP2xi0lGPYQY+A7FFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1wlrhf2YFl-00MFvm; Wed, 27
 May 2026 17:39:18 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] net: phy: dp83822: Add optional external PHY clock
Date: Wed, 27 May 2026 17:39:03 +0200
Message-ID: <20260527153903.216104-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B3VNWPa2yPWjsX4vEkyXHZGp9385ckMen2WFyZdza7izqD6yQg+
 XqeqtxWDEMMGp3lw9zQeGluuNibD7h6CZSwF7wiR1wZI9uJVfNNS6xp6IKUQDYBz5gub639
 hC7qY5nbfUIdRGJq34CaKdCkFPTgmQQBRJ29zUdnzSKlA73NzaINC2eS5PLfXUD54PzCUCR
 VxHIsq3OEUpxC/4A+NM2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mhYFiz99eAc=;sAY+Cdxbg+EHfwbB/RXeodgHQmq
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-292359-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EB9F15E70B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In some cases, the PHY can use an external ref clock source instead of a
crystal.

Add an optional clock in the PHY node to make sure that the clock source
is enabled, if specified, before probing.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/phy/dp83822.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index c012dfab3171..faa8b02d32be 100644
=2D-- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2017 Texas Instruments Inc.
  */
=20
+#include <linux/clk.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
@@ -203,6 +204,7 @@ struct dp83822_private {
 	u8 cfg_dac_minus;
 	u8 cfg_dac_plus;
 	struct ethtool_wolinfo wol;
+	struct clk *clk;
 	bool set_gpio2_clk_out;
 	u32 gpio2_clk_out;
 	bool led_pin_enable[DP83822_MAX_LED_PINS];
@@ -984,13 +986,19 @@ static int dp83822_attach_mdi_port(struct phy_device=
 *phydev,
=20
 static int dp8382x_probe(struct phy_device *phydev)
 {
+	struct device *dev =3D &phydev->mdio.dev;
 	struct dp83822_private *dp83822;
=20
-	dp83822 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
+	dp83822 =3D devm_kzalloc(dev, sizeof(*dp83822),
 			       GFP_KERNEL);
 	if (!dp83822)
 		return -ENOMEM;
=20
+	dp83822->clk =3D devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(dp83822->clk))
+		return dev_err_probe(dev, PTR_ERR(dp83822->clk),
+				     "Failed to request ref clock\n");
+
 	dp83822->tx_amplitude_100base_tx_index =3D -1;
 	dp83822->mac_termination_index =3D -1;
 	phydev->priv =3D dp83822;
=2D-=20
2.43.0


