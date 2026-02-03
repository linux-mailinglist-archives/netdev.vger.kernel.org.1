Return-Path: <netdev+bounces-256380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BBDJJ8xgml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:34:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 415EFDCDB8
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48FE2307B81D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC430EF8E;
	Tue,  3 Feb 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="he/m4SPG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426A2C235D;
	Tue,  3 Feb 2026 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139741; cv=none; b=CSzHkN8idUStdSnxYL+A8XJcytNvbbI8LXk0bqs8MysdGZ7LIHOjXWeLo+XHhEVQuw5yJ71eyoIZRbJiHLHTfctf+5NEho/ceTaK8/3yoc7uyYp5JOpNJ28U7rPzzNv/XH+yl1w/ExkRwC3FIEWp+9L7s4S4vCoL5mrYriRcse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139741; c=relaxed/simple;
	bh=OXv41CaCxkIeKEa8hsRowKmYkbdiMm3q+IPpNww8qsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH9vzuajhJd95nr84wjGYZDH8JsSbIaUP+K1ncihhxuAMPkl1wnQ87wcjNXzNw1BzSZgwdtMRG5yp24i1qWuFH4zuDL441LnfEwbaekP1qUt4doxIL+d0kBUogZuEochrDa5JZnZt0zLCx8C+0HTWisI/evEv2ywAc1JTsEeQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=he/m4SPG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B2141A2BC7;
	Tue,  3 Feb 2026 17:28:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4C5B60728;
	Tue,  3 Feb 2026 17:28:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48D4D119A88F9;
	Tue,  3 Feb 2026 18:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770139737; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=/OC/buRnlLfFzn+BhWblbXGZm2j74ao97s8f0goP980=;
	b=he/m4SPG6SwfImkVhRBQpI7KhmaWYNu+FaVBgKdu05GezgzzAhw5gWHHOML8LzabWyFEpR
	i9wyO1wjW9NluRUU4gZaEzjbMMrHyvaLCe4RmIeRY43pPAM+1Wr68orKGf/1NPpnW+hk9a
	tejbH/GC0+flU8t/uPVbsYWon4r+N0/MNjWlxDFuBoXhsWB5OYCqBdfLb7jiB2+DhFJ+gk
	ozKEPDOaQCQrEBOTwQqvyOKtLt7WSDF6QgYweDEYG2J50CVE5Umcru/d4Bi3ybk5eLAnIX
	Nlg9FTf8iXgM1WkdNMi5yFxVfRu7MNWdsrQ1TyoDGzPRSiJAlCJSgQPy9Cbe0A==
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
Subject: [PATCH net-next v4 03/13] net: phy: phy_port: Correctly recompute the port's linkmodes
Date: Tue,  3 Feb 2026 18:28:27 +0100
Message-ID: <20260203172839.548524-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
References: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256380-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 415EFDCDB8
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
 drivers/net/phy/phy_port.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
index a269e9ea12c4..ad2580529842 100644
--- a/drivers/net/phy/phy_port.c
+++ b/drivers/net/phy/phy_port.c
@@ -108,16 +108,10 @@ EXPORT_SYMBOL_GPL(phy_of_parse_port);
  */
 void phy_port_update_supported(struct phy_port *port)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0 };
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {0};
 	unsigned long mode;
 	int i;
 
-	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
-		linkmode_zero(supported);
-		phy_caps_medium_get_supported(supported, i, port->pairs);
-		linkmode_or(port->supported, port->supported, supported);
-	}
-
 	/* If there's no pairs specified, we grab the default number of
 	 * pairs as the max of the default pairs for each linkmode
 	 */
@@ -127,6 +121,23 @@ void phy_port_update_supported(struct phy_port *port)
 			port->pairs = max_t(int, port->pairs,
 					    ethtool_linkmode_n_pairs(mode));
 
+	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
+		pr_info("Adding mode for medium %d pairs %d\n", i, port->pairs);
+		__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
+
+		phy_caps_medium_get_supported(med_supported, i, port->pairs);
+		linkmode_or(supported, supported, med_supported);
+	}
+
+	/* If port->supported is already populated, filter it out with the
+	 * medium/pair support. Otherwise, let's just use this medium-based
+	 * support as the port's supported list.
+	 */
+	if (linkmode_empty(port->supported))
+		linkmode_copy(port->supported, supported);
+	else
+		linkmode_and(port->supported, supported, port->supported);
+
 	/* Serdes ports supported through SFP may not have any medium set,
 	 * as they will output PHY_INTERFACE_MODE_XXX modes. In that case, derive
 	 * the supported list based on these interfaces
-- 
2.49.0


