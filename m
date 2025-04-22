Return-Path: <netdev+bounces-184781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1CA9725F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6B7AE3FF
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2E293476;
	Tue, 22 Apr 2025 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lu1vzrV+"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C4292904;
	Tue, 22 Apr 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338648; cv=none; b=tFf4SzrDHL269aqvsXhYupPd8NrIDoEDfdNQNVrT/TBLDPkzseGa4wODEoBgsP0179kbTIMqKLlYR4J/2bUSI4j+FP4fTNpEBUwxO8HP09grcBDGIxHj3Cn9mZCZdW2nXD52qAiOwCA1izyJa749Ro0fWJEoMB/3TBOwR5f5F6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338648; c=relaxed/simple;
	bh=hMCxPIYxzmV3KUVfwA4wJCgOM3lhL0C2UHBxP4+Ankc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSIMhJIAJv2QX0l+lHTMkFNA1KErRYj/gF19m+J1HSLr2RYeT1mOzNM3YHe4mbQ5hi0SG15g00BDycfXHiaxsQO0J3vFMsUgcVe50OmUOT5wtva2EXgq5VBNOTpRLE4SNUQF8TO5cfHXTfgw7QhSBGlC3pgKcB0xQQNwDrLyPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lu1vzrV+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF95C1FD45;
	Tue, 22 Apr 2025 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745338644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNmfKWXLdsLmg0P+nz3LlGUh4bvQptyAhlgGd24elxg=;
	b=Lu1vzrV+WjeG/cG/kW3OgBU37GuYW2ZdU+JwxGG1l97/cH4s9bUfwvM5BjzXpU8PbTBq9M
	dhjEaiFgNLJkmaHstTHzPfDSUlYFFFZhzYbsaa7EzssP7PcvdRbT3sgOQAuKBjx5c0YCk4
	Mk+BJswp+7tzgxW2BYop89k6tTUv7HXH0v5S3yAl1MKWn3mOywqgzWGgXB4KqdtTcHJm/v
	TDzVaYcpY8cVLWGkZDxe3bnhZ9QeEPTdJ9KQ2IJ/V+cnR3MAkZFUcKbWeBTCMqidRmUucy
	KOjFMUTP9CHe/pNNxRlQmzJaulprYn2puo9nhExvuo4CRgb55QVuUabtFtH9YA==
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
Subject: [PATCH net-next v7 3/3] net: ethtool: netlink: Use netdev_hold for dumpit() operations
Date: Tue, 22 Apr 2025 18:17:16 +0200
Message-ID: <20250422161717.164440-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422161717.164440-1-maxime.chevallier@bootlin.com>
References: <20250422161717.164440-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Move away from dev_hold and use netdev_hold with a local reftracker when
performing a DUMP on each netdev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 8ccc6957295d..9f08e9d9ed21 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -601,18 +601,19 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 {
 	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
 	struct net *net = sock_net(skb->sk);
+	netdevice_tracker dev_tracker;
 	struct net_device *dev;
 	int ret = 0;
 
 	rcu_read_lock();
 	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
-		dev_hold(dev);
+		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 		rcu_read_unlock();
 
 		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
 
 		rcu_read_lock();
-		dev_put(dev);
+		netdev_put(dev, &dev_tracker);
 
 		if (ret < 0 && ret != -EOPNOTSUPP) {
 			if (likely(skb->len))
-- 
2.49.0


