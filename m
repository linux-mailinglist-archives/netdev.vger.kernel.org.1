Return-Path: <netdev+bounces-293616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCUGCtdGHWpbXwkAu9opvQ
	(envelope-from <netdev+bounces-293616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:46:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289361BB2E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BADA130523D1
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654938D3FB;
	Mon,  1 Jun 2026 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SA7dJ88H"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93C3876A7;
	Mon,  1 Jun 2026 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303242; cv=none; b=C+DZ4O7VVCPpXuBRlRZU+xQ/gQ21VqBBVIqg+Mmy0i86VZa8QTUiW08w0Rh3S7YMuEov9S+UKcuJSvE9PyxeJ7sY9Lb4pOfgL0y3BJdSYdOefuKEK0+UdHkUYmjUyIdTxUGtsfzUmZQEcLr+u84MvJ8KBUuoG9SR/degGKcI6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303242; c=relaxed/simple;
	bh=9SwFFhj8pwEev4ROzEm7v/IF6xzDumyvZ34YJZubTao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWf7q3TaIZDvlIvlFtqiG3GBrEzHksjLP9yd7edD44bsvXjx97Dh9n03O4wP1ijq278s53krazHR9lrR0OQs3HKYg3TAftDayjspdXfzl3oYnIWi2ZjfIakPGGEcgkWzqY4rsqMkb5xgf+otWBlCo4kuAqAoXjoMj5ukExANHUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SA7dJ88H; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9EABE1A3792;
	Mon,  1 Jun 2026 08:40:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CA94602AB;
	Mon,  1 Jun 2026 08:40:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 741F110888598;
	Mon,  1 Jun 2026 10:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780303236; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Uem2QYARB7RSbR4S39JbGy9eFJwE9WGo90FrLWo7T/E=;
	b=SA7dJ88HfWthrNHg1BF2brPyKSn6F20DFwu5kAjQeKgAUy5X3Hfc5Mzseb7S2IIR8vNKR2
	mo1kxe6BsMrNU6JlCXpHHpc0PtVJZ3hYo+eLnt6isABpaXDtt/k3GeidhO0n43PKD9RfBu
	OJZZp1x6+gDhGkVCenwRvlo3RA0RStUSTlaRS+y1puCebA39nFdoDG75bLvHaQvMh5TNaB
	WvvbH9eQ7h0KocA8G8MqugO3aaanxJw2599KMN9TxB8lp31tx/J8s1SW16OPowsJsLfrAI
	FJC4hkdYaRsCfnuHah0jb0QJCiSqZcRj5HiCXcCzxbrvldIvf/kmcUvYcxzPdw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2 2/3] net: phy: remove phy ports upon probe failure
Date: Mon,  1 Jun 2026 10:40:27 +0200
Message-ID: <20260601084029.815461-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
References: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293616-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,tipi-net.de:email]
X-Rspamd-Queue-Id: 9289361BB2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When phy_probe fails, let's clean the phy_ports that were successfully
added already.

Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6ccbfacf7d1d..a171cbe2a74a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3778,6 +3778,8 @@ static int phy_probe(struct device *dev)
 	return 0;
 
 out:
+	phy_cleanup_ports(phydev);
+
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
-- 
2.54.0


