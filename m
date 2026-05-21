Return-Path: <netdev+bounces-290390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEnfCGT4DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:19:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDB5A4AE9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FBFF300E3CE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD43D8104;
	Thu, 21 May 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EWiicWOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC8D3CF95E
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365496; cv=none; b=J87iY3hstsaBnz917aru5PI5ewmhYIW87s4l4DCgg0qV+tsigrv6KAUJWka6SmUZ7+KfbloCReSRO9TPs0AHGb6fPIylU0+vridHCoaCyQd7hTtV/La7UqklKA90GihCELWu1PaesmJmKChwv54/DcqgrbkfwyZemWWgSRzgVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365496; c=relaxed/simple;
	bh=dOCHyCczRSWWK9AIxusLQJeUGJDpnc+Qe5MwxIOXsUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG69sFu/YRYxhX68f7nVvQwN7cqEDEMibHuH1L8pqLuk7Y557yK12bEEOxcLcpLwkkQx6/b2km9CDHy4/aiCVfBIPoS/7aKaYENrKdH2XOxvWuhocn7Qq1DBKxx2EWa6IWQwCJGAMoqHgecpvq3Wlibyi1kUhaEaasD1mswttXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EWiicWOF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C65501A365A;
	Thu, 21 May 2026 12:11:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A96160495;
	Thu, 21 May 2026 12:11:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63F74107E8A81;
	Thu, 21 May 2026 14:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779365492; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8ZzRgvQ0015w12JARl4G5bhyhPjxqElIpJOZWSZaG6Q=;
	b=EWiicWOFKOgnKAP3wJg+7U2kAkgJvAsTxC/hcWlFOnzBLA9wImFCcXrOo8bwkzTy3T79Ay
	nmV/g3qIwNuV9q2IGZ7BjoZDwXwna4Q4JHDzS719A+bIiTU+rjfsmuk9B+L2JNozbBBF72
	fFh798beJOJn67kGiiUyG1x7rIcLkekXzphEE/wX9n6ZowVY2verorcMC7MMFcoUMHAtKI
	CwaAIAbYPmuyRlIHz7uMFzFJnuwAu5VL80VFJOS+whHf4yew3KONPjaB/Ua/jNjiAnw7mK
	07zoJYO6tUz2sgO9sWPxexrIqGDBCZhbGN9938edblZ0qDO4Ak4X/06sMRtoGw==
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v11 10/10] Documentation: networking: Update the phy_port infrastructure description
Date: Thu, 21 May 2026 14:10:38 +0200
Message-ID: <20260521121040.1199622-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
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
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-290390-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CDEDB5A4AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With SFP now properly supported with phy_port, add some details in the
documentation. Fix a typo along the way (driver -> driven).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/phy-port.rst | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/phy-port.rst b/Documentation/networking/phy-port.rst
index 6e28d9094bce..83672e457565 100644
--- a/Documentation/networking/phy-port.rst
+++ b/Documentation/networking/phy-port.rst
@@ -99,13 +99,29 @@ will eventually be able to report its own ksettings::
             (_____)-----| Port |
                         +------+
 
+SFP ports
+=========
+
+SFP interfaces involve 2 distinct components, each represented by
+a :c:type:`struct phy_port <phy_port>` instance :
+
+ - The SFP cage itself is a :c:type:`struct phy_port <phy_port>`. It's special
+   in that it's not an MDI interface, buti rather a hot-pluggable MII.
+   The :c:type:`struct phy_port <phy_port>` associated to it lists the different
+   MII interfaces we can use on the cage.
+
+ - The SFP module, when inserted, will also be associated to a
+   :c:type:`struct phy_port <phy_port>`, that represents the various linkmodes
+   that it gives access to. The module's :c:type:`struct phy_port <phy_port>`
+   doesn't superseeds the cage's port, it references it through
+   the :c:type:`struct phy_port <phy_port>`. :c:member:`upstream_port` field.
+
 Next steps
 ==========
 
-As of writing this documentation, only ports controlled by PHY devices are
-supported. The next steps will be to add the Netlink API to expose these
-to userspace and add support for raw ports (controlled by some firmware, and directly
-managed by the NIC driver).
+As of writing this documentation, the port's presence and information can only
+be queried, and it's not possible to change any of the port's settings or select
+which one should be used.
 
 Another parallel task is the introduction of a MII muxing framework to allow the
-control of non-PHY driver multi-port setups.
+control of non-PHY driven multi-port setups.
-- 
2.54.0


