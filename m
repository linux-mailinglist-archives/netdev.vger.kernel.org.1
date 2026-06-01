Return-Path: <netdev+bounces-293615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ln7Kb1GHWpbXwkAu9opvQ
	(envelope-from <netdev+bounces-293615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:45:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C42E61BB16
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7687B3030768
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17B38CFEF;
	Mon,  1 Jun 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="utpxjufA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507F389116;
	Mon,  1 Jun 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303241; cv=none; b=pu5PCARj45FG2oXCvsVLU8Cj5vawwFd1H4mPIOY+gX7vvbdHLWTVvSfeF538ErIcnBViC47fPJXrQrNHwW4e2uIHEVXXjDoP1DQ7cqQgQQZWoyCrA1+BbiZbwOuBhcnlfzhazZ1RX9bb33qOxkolf4jCPPF7dqw+CqxM0aWUwTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303241; c=relaxed/simple;
	bh=0HdDkK/TOSL0phTZpiBrOQIZaoNT35M+ccOOAiuQQ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3c0FqSPZC972s08pVChztKl+qDw27LPj8uzBExL9GWjkXUkKWQ+ejIluJoe4h4sLtyk9+fgB4NMgptSR/emwzUps3GNhqE7D5XY8m+2o+z7smkjq7tGPiKPwmcYwYa476xmwMjIg/bj/BVSw03NVNi4x16p3xS4ZNiCFm4Jq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=utpxjufA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C39F3C62200;
	Mon,  1 Jun 2026 08:40:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D8904602AB;
	Mon,  1 Jun 2026 08:40:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0AB0108881D6;
	Mon,  1 Jun 2026 10:40:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780303235; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rAHF5SYcrtIeGSTN66k3V1ki0y/e4CSmPJwMqIdfps8=;
	b=utpxjufAbmgmP0CD2yYn1yWsvkUtqvx4/nPO79++0z7KOwj+DeeHv/9il26TFnw0RE5L2J
	o777R4xlvzWNQUbUyIqSYwPd1bvdBLGpMuIvPuKbEmUh+qJD3rmmBHqUIEMokQhgmdsQt5
	NvJnQ61PYfNgc85XtbRtf+6cBys3fBPYsO3sZyrXWfYNz+62XzTDhTj5U1SB6vX1E9H1M2
	FA2jr5E2dlx8WmApmJMLAGKn+vAW7mcGZVksuqkrJ5KAMxpvJaIlAM/tQg0HVBCTIAO2XO
	4Jwdkn2OdeMzE3uv5Bclc9QX1i8hS2Aip2VmZeyNCWNxSm7Fp02QyVh9fccYqw==
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
	thomas.petazzoni@bootlin.com
Subject: [PATCH net v2 1/3] net: phy: clean the sfp upstream if phy probing fails
Date: Mon,  1 Jun 2026 10:40:26 +0200
Message-ID: <20260601084029.815461-2-maxime.chevallier@bootlin.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293615-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5C42E61BB16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reported that we don't call sfp_bus_del_upstream() in the probe
failure path, so let's add it, otherwise the sfp-bus is left with a
dangling 'upstream' field, that may be used later on during SFP events.

This issue existed before the generic phylib sfp support, back when
drivers were calling phy_sfp_probe themselves.

Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Null-ify phydev->sfp_bus upon sfp_bus_add_upstream failure

 drivers/net/phy/phy_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3370eb822017..6ccbfacf7d1d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1718,6 +1718,9 @@ static int phy_sfp_probe(struct phy_device *phydev)
 
 		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
 		sfp_bus_put(bus);
+
+		if (ret)
+			phydev->sfp_bus = NULL;
 	}
 
 	if (!ret && phydev->sfp_bus)
@@ -3775,6 +3778,9 @@ static int phy_probe(struct device *dev)
 	return 0;
 
 out:
+	sfp_bus_del_upstream(phydev->sfp_bus);
+	phydev->sfp_bus = NULL;
+
 	if (!phydev->is_on_sfp_module)
 		phy_led_triggers_unregister(phydev);
 
-- 
2.54.0


