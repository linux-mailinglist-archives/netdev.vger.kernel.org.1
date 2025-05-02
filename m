Return-Path: <netdev+bounces-187391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603F9AA6D07
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D4A9C05E4
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B122D7AD;
	Fri,  2 May 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DKuSFT1C"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1A22C325;
	Fri,  2 May 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175977; cv=none; b=qe4uDRB5mO8T+lzDgUXbOoGw3zyMiakd73ekWSoVJyphC/wo0ZkQYBC3v5Ji+4HcAsHL721WRxFsGIWvOSXGlW7ODYz8EN2aFMF6gZmUNdg6na31yU/vpbl8iDdlb+GSWU1q9cx+e2aHnppFI9iGEMhW1h29j4ZayPOQaMcKjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175977; c=relaxed/simple;
	bh=1hHhcGCF3uxCQzRf9L0MUJqzfVb4MjqqF7nacc6oRyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCtmSCFW4Bt0EYSf0geYZL9qYBoqPoXmocaIaZxSfXYZ/D6O6dJGdaSwJuTjwsTCVRkx3sg25HtIXNdXnkEQtmwu6XyXzDvBjt10sm2H6fdDWweVu47V3wzPdKskktjenHNTrs/AI5WFo8jeCAwSmCW12jTGbh4NlSVZGR8FHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DKuSFT1C; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DFBA43214;
	Fri,  2 May 2025 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746175967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qP5fHpkwdXZblvpZzaRSVdXqYAoJ1F4EruazOKwBiI=;
	b=DKuSFT1CmF534CHNyAxRWuLIWCtnW6ISwJiRLIyWvhUEu58YJcEEw9CweP0s8lr/hqmxZM
	3yzZVXUvMUb37smqxQltKxGXcCCgZ3nU7k4jhByLH9inPqBa+IxHTkJ2O1q3sOUCaPSGVc
	Pz6jA9hZZccJwfsvp1GSlCHyepyTact5IvsRJWMPizFV2tcQtOQVoYmMNGTQPP9R8u8w2a
	RPfRBM3ODr5iL8LFui9/IWbxBz99ZzMbfBbbaoTS1MsI5ORy7+MZsSMHDSzIlQrBPCoQZ+
	nDSYVQ61ZH62Sc8a7UU0zzvt8kzw+tdX8nFq1IoHrSXHhgjdMiV4+QHR8o/oaw==
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
Subject: [PATCH net-next v8 1/3] net: ethtool: Introduce per-PHY DUMP operations
Date: Fri,  2 May 2025 10:52:39 +0200
Message-ID: <20250502085242.248645-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085242.248645-1-maxime.chevallier@bootlin.com>
References: <20250502085242.248645-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

ethnl commands that target a phy_device need a DUMP implementation that
will fill the reply for every PHY behind a netdev. We therefore need to
iterate over the dev->topo to list them.

When multiple PHYs are behind the same netdev, it's also useful to
perform DUMP with a filter on a given netdev, to get the capability of
every PHY.

Implement dedicated genl ->start(), ->dumpit() and ->done() operations
for PHY-targetting command, allowing filtered dumps and using a dump
context that keep track of the PHY iteration for multi-message dump.

PSE-PD and PLCA are converted to this new set of ops along the way.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 203 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 194 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 977beeaaa2f9..a58570c68db2 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -357,6 +357,18 @@ struct ethnl_dump_ctx {
 	unsigned long			pos_ifindex;
 };
 
+/**
+ * struct ethnl_perphy_dump_ctx - context for dumpit() PHY-aware callbacks
+ * @ethnl_ctx: generic ethnl context
+ * @ifindex: For Filtered DUMP requests, the ifindex of the targeted netdev
+ * @pos_phyindex: iterator position for multi-msg DUMP
+ */
+struct ethnl_perphy_dump_ctx {
+	struct ethnl_dump_ctx	ethnl_ctx;
+	unsigned int		ifindex;
+	unsigned long		pos_phyindex;
+};
+
 static const struct ethnl_request_ops *
 ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
 	[ETHTOOL_MSG_STRSET_GET]	= &ethnl_strset_request_ops,
@@ -407,6 +419,12 @@ static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
 	return (struct ethnl_dump_ctx *)cb->ctx;
 }
 
+static struct ethnl_perphy_dump_ctx *
+ethnl_perphy_dump_context(struct netlink_callback *cb)
+{
+	return (struct ethnl_perphy_dump_ctx *)cb->ctx;
+}
+
 /**
  * ethnl_default_parse() - Parse request message
  * @req_info:    pointer to structure to put data into
@@ -662,6 +680,173 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	return ret;
 }
 
+/* per-PHY ->start() handler for GET requests */
+static int ethnl_perphy_start(struct netlink_callback *cb)
+{
+	struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
+	struct ethnl_reply_data *reply_data;
+	const struct ethnl_request_ops *ops;
+	struct ethnl_req_info *req_info;
+	struct genlmsghdr *ghdr;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
+
+	ghdr = nlmsg_data(cb->nlh);
+	ops = ethnl_default_requests[ghdr->cmd];
+	if (WARN_ONCE(!ops, "cmd %u has no ethnl_request_ops\n", ghdr->cmd))
+		return -EOPNOTSUPP;
+	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
+	if (!req_info)
+		return -ENOMEM;
+	reply_data = kmalloc(ops->reply_data_size, GFP_KERNEL);
+	if (!reply_data) {
+		ret = -ENOMEM;
+		goto free_req_info;
+	}
+
+	/* Unlike per-dev dump, don't ignore dev. The dump handler
+	 * will notice it and dump PHYs from given dev. We only keep track of
+	 * the dev's ifindex, .dumpit() will grab and release the netdev itself.
+	 */
+	ret = ethnl_default_parse(req_info, &info->info, ops, false);
+	if (req_info->dev) {
+		phy_ctx->ifindex = req_info->dev->ifindex;
+		netdev_put(req_info->dev, &req_info->dev_tracker);
+		req_info->dev = NULL;
+	}
+	if (ret < 0)
+		goto free_reply_data;
+
+	ctx->ops = ops;
+	ctx->req_info = req_info;
+	ctx->reply_data = reply_data;
+	ctx->pos_ifindex = 0;
+
+	return 0;
+
+free_reply_data:
+	kfree(reply_data);
+free_req_info:
+	kfree(req_info);
+
+	return ret;
+}
+
+static int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
+				     struct ethnl_perphy_dump_ctx *ctx,
+				     const struct genl_info *info)
+{
+	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
+	struct net_device *dev = ethnl_ctx->req_info->dev;
+	struct phy_device_node *pdn;
+	int ret;
+
+	if (!dev->link_topo)
+		return 0;
+
+	xa_for_each_start(&dev->link_topo->phys, ctx->pos_phyindex, pdn,
+			  ctx->pos_phyindex) {
+		ethnl_ctx->req_info->phy_index = ctx->pos_phyindex;
+
+		/* We can re-use the original dump_one as ->prepare_data in
+		 * commands use ethnl_req_get_phydev(), which gets the PHY from
+		 * the req_info->phy_index
+		 */
+		ret = ethnl_default_dump_one(skb, dev, ethnl_ctx, info);
+		if (ret)
+			return ret;
+	}
+
+	ctx->pos_phyindex = 0;
+
+	return 0;
+}
+
+static int ethnl_perphy_dump_all_dev(struct sk_buff *skb,
+				     struct ethnl_perphy_dump_ctx *ctx,
+				     const struct genl_info *info)
+{
+	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
+	struct net *net = sock_net(skb->sk);
+	netdevice_tracker dev_tracker;
+	struct net_device *dev;
+	int ret = 0;
+
+	rcu_read_lock();
+	for_each_netdev_dump(net, dev, ethnl_ctx->pos_ifindex) {
+		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
+		rcu_read_unlock();
+
+		/* per-PHY commands use ethnl_req_get_phydev(), which needs the
+		 * net_device in the req_info
+		 */
+		ethnl_ctx->req_info->dev = dev;
+		ret = ethnl_perphy_dump_one_dev(skb, ctx, info);
+
+		rcu_read_lock();
+		netdev_put(dev, &dev_tracker);
+		ethnl_ctx->req_info->dev = NULL;
+
+		if (ret < 0 && ret != -EOPNOTSUPP) {
+			if (likely(skb->len))
+				ret = skb->len;
+			break;
+		}
+		ret = 0;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/* per-PHY ->dumpit() handler for GET requests. */
+static int ethnl_perphy_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb)
+{
+	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
+	int ret = 0;
+
+	if (ctx->ifindex) {
+		netdevice_tracker dev_tracker;
+		struct net_device *dev;
+
+		dev = netdev_get_by_index(genl_info_net(&info->info),
+					  ctx->ifindex, &dev_tracker,
+					  GFP_KERNEL);
+		if (!dev)
+			return -ENODEV;
+
+		ethnl_ctx->req_info->dev = dev;
+		ret = ethnl_perphy_dump_one_dev(skb, ctx, genl_info_dump(cb));
+
+		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
+			ret = skb->len;
+
+		netdev_put(dev, &dev_tracker);
+	} else {
+		ret = ethnl_perphy_dump_all_dev(skb, ctx, genl_info_dump(cb));
+	}
+
+	return ret;
+}
+
+/* per-PHY ->done() handler for GET requests */
+static int ethnl_perphy_done(struct netlink_callback *cb)
+{
+	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
+	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
+
+	kfree(ethnl_ctx->reply_data);
+	kfree(ethnl_ctx->req_info);
+
+	return 0;
+}
+
 /* default ->done() handler for GET requests */
 static int ethnl_default_done(struct netlink_callback *cb)
 {
@@ -1200,9 +1385,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PSE_GET,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_default_start,
-		.dumpit	= ethnl_default_dumpit,
-		.done	= ethnl_default_done,
+		.start	= ethnl_perphy_start,
+		.dumpit	= ethnl_perphy_dumpit,
+		.done	= ethnl_perphy_done,
 		.policy = ethnl_pse_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_pse_get_policy) - 1,
 	},
@@ -1224,9 +1409,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PLCA_GET_CFG,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_default_start,
-		.dumpit	= ethnl_default_dumpit,
-		.done	= ethnl_default_done,
+		.start	= ethnl_perphy_start,
+		.dumpit	= ethnl_perphy_dumpit,
+		.done	= ethnl_perphy_done,
 		.policy = ethnl_plca_get_cfg_policy,
 		.maxattr = ARRAY_SIZE(ethnl_plca_get_cfg_policy) - 1,
 	},
@@ -1240,9 +1425,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
 	{
 		.cmd	= ETHTOOL_MSG_PLCA_GET_STATUS,
 		.doit	= ethnl_default_doit,
-		.start	= ethnl_default_start,
-		.dumpit	= ethnl_default_dumpit,
-		.done	= ethnl_default_done,
+		.start	= ethnl_perphy_start,
+		.dumpit	= ethnl_perphy_dumpit,
+		.done	= ethnl_perphy_done,
 		.policy = ethnl_plca_get_status_policy,
 		.maxattr = ARRAY_SIZE(ethnl_plca_get_status_policy) - 1,
 	},
-- 
2.49.0


