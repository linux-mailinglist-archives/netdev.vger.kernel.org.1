Return-Path: <netdev+bounces-177056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F07A6D879
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FDA1892D21
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69D25EFBE;
	Mon, 24 Mar 2025 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DMnA8mFB"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3213F25E832;
	Mon, 24 Mar 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812831; cv=none; b=h4wm5nmsVoc5n8AzTTLRqfn2g/TLtrC5qaM2jJsHXgh+cV+K0xt/efOjQtW6lvmKTIeG+xXtLid6yOP94XsyTw5R/QpwicX1uWSd6flTeFm0wO9nKf5ii1LfEtNR+fMyuRD6gbe+WaHditY6mhz1Ha1Nd/9pmyfryTbjjbE4Yb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812831; c=relaxed/simple;
	bh=lvoZIj3Ttr2ApMuZRkpIAFN5T5NJbXw2a1xVlHodTMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UR/7Lj4S0Hw9dbvAa6Qdgqncf+JeOqt/65ci00ldriHeXB1MMageL9ftI4jIOl3j27ySmReOB0Agcu4pEMPFR/peqsEbFmYcVh2sji5V4Zwt0K7dseYGhSrRbSKbYJtSrzzlYVuwmQG66M2SuFuhT0gY2ShFRKujTxcWWfzJ48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DMnA8mFB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A483442F0;
	Mon, 24 Mar 2025 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742812827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crxwshCi6/gIzDkqvmX43AHE+I9xHsMFw6dKDZ/wTv4=;
	b=DMnA8mFBZJleF0Q20q3rSS9gcUyavMVWvycfbFy5xqPg5b4Tl8pa0N/t+zHwyeKDSugbHk
	8o6qCDxriJ/FHEPW2G8dko1PUChTWkGpKpqRbxdSq1HDkreJwhI+TJexIEoNfcAoGQaj+F
	zwJzEa+Fy9JxmHSYYdvOgzyoOP0ZxIeI57oMwz0ivnb7QR2AdGv/K4lGZ9A9m+RWV/p4IO
	3OqtwkNRqTM1qP21twkzaSxI0e1sfhmb7MMVoov+EcvQ3HdXI0Dw5HbdWa01E07jy0NCEi
	WsD96jAR2a7Rkbk66uzESNOLiq5wGDzl9ZfdqNFeR0uga2yDhx770YysXqk0ww==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next v4 7/8] net: ethtool: plca: Use per-PHY DUMP operations
Date: Mon, 24 Mar 2025 11:40:09 +0100
Message-ID: <20250324104012.367366-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeinecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtiedphhgvlhhopeguvghvihgtvgdqvdegrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvu
 ghumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Leverage the per-phy ethnl DUMP helpers in case we have more that one
PLCA-able PHY on the link.

This is done for both PLCA status and PLCA config.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4 : No changes

 net/ethtool/plca.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index e1f7820a6158..2148ff607561 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -191,6 +191,12 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
 
 	.set			= ethnl_set_plca,
 	.set_ntf_cmd		= ETHTOOL_MSG_PLCA_NTF,
+
+	.dump_start		= ethnl_dump_start_perphy,
+	.dump_one_dev		= ethnl_dump_one_dev_perphy,
+	.dump_done		= ethnl_dump_done_perphy,
+
+	.allow_pernetdev_dump	= true,
 };
 
 // PLCA get status message -------------------------------------------------- //
@@ -268,4 +274,10 @@ const struct ethnl_request_ops ethnl_plca_status_request_ops = {
 	.prepare_data		= plca_get_status_prepare_data,
 	.reply_size		= plca_get_status_reply_size,
 	.fill_reply		= plca_get_status_fill_reply,
+
+	.dump_start		= ethnl_dump_start_perphy,
+	.dump_one_dev		= ethnl_dump_one_dev_perphy,
+	.dump_done		= ethnl_dump_done_perphy,
+
+	.allow_pernetdev_dump	= true,
 };
-- 
2.48.1


