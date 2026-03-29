Return-Path: <netdev+bounces-273032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GOKEP6qyWmO0wUAu9opvQ
	(envelope-from <netdev+bounces-273032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:43:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A893354516
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 00:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898DD300EFBB
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB536C0B1;
	Sun, 29 Mar 2026 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Y5LL9Wfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D82277CA4;
	Sun, 29 Mar 2026 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824172; cv=none; b=JcJKczMlGS72IK1xIBXdJ8/hCPe63rkE5SX6m/wGdmB6y7YSgnANx2Hqnkk5ytnjUZRs8p9NAQ/fyJLSEGBCsB6CYL2Ytg6l9H1Df35b4YCQWFEdtjhmn6PVrUZBqaZzoArjTO7RkvsrRmcngijGHeWn+u/jtIqo1Zn0xzBzDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824172; c=relaxed/simple;
	bh=PHg2mt8D99dRuK3VNr7RPwFyahRZ5TreuFGpdQJZp9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9Lvo0+Bai983JIkylc5SgtlIW42eoaNd8CLFGHa0QQZMl7I1Rv09NOo4V9NYLQ3SKHQ9KZvuG+W33VEantZp96g72Db9aHh3NSHna0BmeI+eRBYA7YMgeIX8Fqza1gBKio7Z/wM8nEvqRMjmaJCfr4EGYJYBHADURm4iTQuqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Y5LL9Wfz; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85A7FA56EE;
	Mon, 30 Mar 2026 00:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774824156; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zDrp64/Br7qFng+yJZ1qOsRzDJYt/z0dMo5iM6ZoVNE=;
	b=Y5LL9WfzuIjRhdVndUC5KTDZd/sPV/dVA3OQVbTlz6Vj02Z4EiTZHFMgtRvpJ2nRKOA+R4
	O0TW5O/tkXWgpgVttErM89+RkLkhHx4uEG7eg0aeG6SABXVDRBmLUErsvgBWx2imosTtWo
	v4x8IPk2lzYSQxeOWcADcHBHd49SRAfuGbUnyk8MACxGlLThYxuzstUHUqRjZF48oRi/jk
	OQjRLsHHQGp3AJ+RvPb0ssyq0P93lhdsqwLfLC1HTYg6a4qemmrnu4qx07rtKhe6Ot+WMy
	fcLD4N0FjXAt5NIlMpFzb50Rj7vnLTJBMVGnZgMEpYa4g9vgitjcrMUl25dAJQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: phy: microchip: enable downshift by default on LAN88xx
Date: Mon, 30 Mar 2026 00:42:00 +0200
Message-ID: <20260329224202.500229-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260329224202.500229-1-nb@tipi-net.de>
References: <20260329224202.500229-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273032-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[raspberrypi.com,tipi-net.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3A893354516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable auto-downshift from 1000BASE-T to 100BASE-TX after 2 failed
auto-negotiation attempts by default. This ensures that links with
faulty or missing cable pairs (C and D) fall back to 100Mbps without
requiring userspace configuration.

Users can override or disable downshift at runtime:

  ethtool --set-phy-tunable eth0 downshift off

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/microchip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index a044be1ade79..3455fe713088 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -371,7 +371,7 @@ static void lan88xx_set_mdix(struct phy_device *phydev)
 
 static int lan88xx_config_init(struct phy_device *phydev)
 {
-	int val;
+	int val, err;
 
 	/*Zerodetect delay enable */
 	val = phy_read_mmd(phydev, MDIO_MMD_PCS,
@@ -384,6 +384,11 @@ static int lan88xx_config_init(struct phy_device *phydev)
 	/* Config DSP registers */
 	lan88xx_config_TR_regs(phydev);
 
+	/* Enable downshift after 2 failed attempts by default */
+	err = lan88xx_set_downshift(phydev, 2);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
-- 
2.51.0


