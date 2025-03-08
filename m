Return-Path: <netdev+bounces-173183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A5A57BBB
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23E53B2C26
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D41FF1B4;
	Sat,  8 Mar 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FFPGi6uZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71F1E835A;
	Sat,  8 Mar 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449299; cv=none; b=AtXttyrpcSubcO6AfarlT+EYe85wXtTJQH9btS7H4hcbLTAhx9vIJtPfLFdITmG1v0GowuEOGP5oQu4azrB+Qh0xIqNrgHwRZPmh6++KXkIFcI7tDA6WCb6ZBJnF3DFnb8SBzknecTszz5YfxRl2xatI9R6etqrlx4u/7HFSbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449299; c=relaxed/simple;
	bh=5YI0kyNkOiLZP/Q3ING0P5lghDvzq81OA8M4j4gIaic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNjCZo9/AQj//tFHn/vRmxM+eHaOtl6pgo6kVsRxsjZ2spxDZiBnd+XE4vrZpquU00ps2mk0NT/kug7uN1aTBL9qbnTN9SnIL0fvodIN21iw9CRy+7phsqc4gmathS5u/ao4EUS4B0iaBZjuIuhBoLDCV9SuXNEDcaK2/nxEIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FFPGi6uZ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED68C204CF;
	Sat,  8 Mar 2025 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741449290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmy9NxM0ktvekYXuuKXI27bEO2tP0yU3U+/hUv66has=;
	b=FFPGi6uZLLxb9/W0w/LZ8BQjCxyxBMST6edtHqALz44Ux5cykiGOOGStK6TGiP4UaIdR3V
	RXqEpeg0mSnQTBcXJCsnfd3ZNNbeA2hULpshad4tAi+LpP2mLwv0y5GjomVi+FwCbLlwJH
	Qo6/MIskcz1SkNlxmJ5WkGRKt0ak1DWO/vzY0q7iKEv12dOhpHecvRR4qvPlY7oC8uSucR
	O3/VijVYousSUDqbUQEH89cIjJoQqbJhoPgFNtb4ZHHRkhGIf4cI+ml8Ydxg4nRdlSbnbD
	bBXSjsBlxhUwxdZ/EOBg82yojsbCzyYGO0LjW0ZG2iraZqmBdyy++k0XX47NWg==
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
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 4/7] net: ethtool: netlink: Introduce per-phy DUMP helpers
Date: Sat,  8 Mar 2025 16:54:36 +0100
Message-ID: <20250308155440.267782-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
References: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

As there are multiple ethnl commands that report messages based on
phy_device information, let's introduce a set of ethnl generic dump
helpers to allow DUMP support for each PHY on a given netdev.

This logic iterates over the phy_link_topology of each netdev (or a
single netdev for filtered DUMP), and call ethnl_default_dump_one() with
the req_info populated with ifindex + phyindex.

This allows re-using all the existing infra for phy-targetting commands
that already use ethnl generic helpers.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Rebase

 net/ethtool/netlink.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 net/ethtool/netlink.h |  6 +++++
 2 files changed, 59 insertions(+)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index ae06b72239a8..a09bcd67b38f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -559,6 +559,59 @@ static int ethnl_default_dump_one(struct sk_buff *skb,
 	return ret;
 }
 
+/* Specific context for phy-targeting command DUMP operatins. We keep in context
+ * the latest phy_index we dumped, in case of an interrupted DUMP.
+ */
+struct ethnl_dump_ctx_perphy {
+	unsigned long phy_index;
+};
+
+int ethnl_dump_start_perphy(struct ethnl_dump_ctx *ctx)
+{
+	struct ethnl_dump_ctx_perphy *dump_ctx;
+
+	dump_ctx = kzalloc(sizeof(*dump_ctx), GFP_KERNEL);
+	if (!dump_ctx)
+		return -ENOMEM;
+
+	ctx->cmd_ctx = dump_ctx;
+
+	return 0;
+}
+
+void ethnl_dump_done_perphy(struct ethnl_dump_ctx *ctx)
+{
+	kfree(ctx->cmd_ctx);
+}
+
+int ethnl_dump_one_dev_perphy(struct sk_buff *skb,
+			      struct ethnl_dump_ctx *ctx,
+			      const struct genl_info *info)
+{
+	struct ethnl_dump_ctx_perphy *dump_ctx = ctx->cmd_ctx;
+	struct net_device *dev = ctx->reply_data->dev;
+	struct phy_device_node *pdn;
+	int ret = 0;
+
+	if (!dev->link_topo)
+		return 0;
+
+	xa_for_each_start(&dev->link_topo->phys, dump_ctx->phy_index,
+			  pdn, dump_ctx->phy_index) {
+		ctx->req_info->phy_index = dump_ctx->phy_index;
+
+		/* We can re-use the original dump_one as ->prepare_data in
+		 * commands use ethnl_req_get_phydev(), which gets the PHY from
+		 * what's in req_info
+		 */
+		ret = ethnl_default_dump_one(skb, ctx, info);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
 				      struct ethnl_dump_ctx *ctx,
 				      const struct genl_info *info)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 79fe98190c64..530a9b5c8b39 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -327,6 +327,12 @@ struct ethnl_dump_ctx {
 	void				*cmd_ctx;
 };
 
+/* Generic callbacks to be used by PHY targeting commands */
+int ethnl_dump_start_perphy(struct ethnl_dump_ctx *ctx);
+int ethnl_dump_one_dev_perphy(struct sk_buff *skb, struct ethnl_dump_ctx *ctx,
+			      const struct genl_info *info);
+void ethnl_dump_done_perphy(struct ethnl_dump_ctx *ctx);
+
 int ethnl_ops_begin(struct net_device *dev);
 void ethnl_ops_complete(struct net_device *dev);
 
-- 
2.48.1


