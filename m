Return-Path: <netdev+bounces-254438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEpdM4N1emmE6wEAu9opvQ
	(envelope-from <netdev+bounces-254438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:45:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443ACA8C5B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BC023019FD9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452B137418C;
	Wed, 28 Jan 2026 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EiVu0vk0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB621B9FD
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633147; cv=none; b=u8O6GHy7k4R8zsAvqbI4KEG+7bFGnKNWB9HGr7zitMqqnFNPM7oexu6VKAzRkYyU8YtV3qDhFG8VtwNKdfytbrz21gFs29XttWllROCpjKmtCEm3RXnutClBmbgualcA+vdCxfdUsASNnPjwfhkbH2SgO4saPx/2/q2V8GNW9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633147; c=relaxed/simple;
	bh=cVlGaDtD/sHzN/VmwT1BIJq3CDK2ab5YwpOqp1MmRXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llufBhzQYEYlV8W9+qTwhnUY7ohWCvgXDMgLIn2RhsQlj6ZWB4BZZdNTmQZewz0menmgKpz9XhWuokX41g09446jmTZxySj7pZOdIOUqgxUwbiSqXLvQgAHyVCEoTobFD+vwPcjLu7ywng4XSR3Hl7mOflRCp7yuZ/dcTN6xdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EiVu0vk0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AF7784E42308;
	Wed, 28 Jan 2026 20:45:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8421D6071F;
	Wed, 28 Jan 2026 20:45:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BFFD119A882A;
	Wed, 28 Jan 2026 21:45:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769633141; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cUxQMmS4PTgDBQUSEvvZqd3m1nQMmyjDBJyQpg9/Dko=;
	b=EiVu0vk0MI5kVykZCoVFWr7dX3WM6oDjs/9NqFEXBph8d0lWjmjclq4Pwa3qIUVep20gsn
	utG1zgUCDSJeyWBdJW1HABfJWjK9yq2nOQREUiD6a5E1OEVdu1BQk/0waHzDtPOEmdT6+/
	aLDKxVttJkljI/fbyCdFLUz3vI3PZsSaoS8vSIjEu8NziDVoz/6M60h+jkIjfnqbEkfTxS
	SUS62VJUXQGqCSI0fG7o3gwbH83tuTZKh0Sw/kxIfzlmvhJLelGBaisTT6l52VIRqpLjRt
	iLsqeh1IV+6yi2k3taMXxvAOUvR6zJD4W9KkcT6wBEBTb8yFp6Q5W2ontWjmJQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v2 01/12] net: phy: phy_port: Correctly recompute the port's linkmodes
Date: Wed, 28 Jan 2026 21:45:14 +0100
Message-ID: <20260128204526.170927-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-254438-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 443ACA8C5B
X-Rspamd-Action: no action

a PHY-driven phy_port contains a 'supported' field containing the
linkmodes available on this port. This is populated based on :
 - The PHY's reported features
 - The DT representation of the connector
 - The PHY's attach_mdi() callback

As these different attrbution methods work in conjunction, the helper
phy_port_update_supported() recomputes the final 'supported' value based
on the populated mediums, linkmodes and pairs.

However this recompute wasn't correctly implemented, and added more
modes than necessary by or'ing the medium-specific modes to the existing
support. Let's fix this and properly filter the modes.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_port.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
index ec93c8ca051e..68a0068220ed 100644
--- a/drivers/net/phy/phy_port.c
+++ b/drivers/net/phy/phy_port.c
@@ -118,11 +118,14 @@ void phy_port_update_supported(struct phy_port *port)
 	int i;
 
 	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
-		linkmode_zero(supported);
-		phy_caps_medium_get_supported(supported, i, port->pairs);
-		linkmode_or(port->supported, port->supported, supported);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
+
+		phy_caps_medium_get_supported(med_supported, i, port->pairs);
+		linkmode_or(supported, supported, med_supported);
 	}
 
+	linkmode_and(port->supported, port->supported, supported);
+
 	/* If there's no pairs specified, we grab the default number of
 	 * pairs as the max of the default pairs for each linkmode
 	 */
-- 
2.49.0


