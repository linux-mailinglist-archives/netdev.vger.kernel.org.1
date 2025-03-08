Return-Path: <netdev+bounces-173180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FEAA57BB4
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 16:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795C21895037
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D84C1E8358;
	Sat,  8 Mar 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CKsLYps1"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78E1DE2D4;
	Sat,  8 Mar 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449296; cv=none; b=TdIYEQPyWjDguAvLNS4kxXtp2z/X45ZuR729XzCqyx2V3J/9CazQZduWNR1GypxlZgFRO5ConpHhavujHmucxolJgWDsSk+V+EbEn5UaL3Yu8yEbiTnbxpBg/tCnXyarLNSBkC6Yw+xS4YtoB2KDfrkOa28cP4gnkD6gK5WkUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449296; c=relaxed/simple;
	bh=+GVdI8ZYrds+o596hNQ8JWJLjKp22m3JfXDOnTxsfkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG4b/05IQixlXtA2J6otrwNCE417vLuh+t0Vj7QbukO2cfWSQkGiM9k1PAxw+FOCU4IVZsKL6o4++JxZUG717eGZtVyI1CJFawxAuKX9Hpa65TzsnftqlAwIKBS6GSnreX4bh7Nf8tRjcVNobNVSfQEiHTJmenWiUwSdAIfbi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CKsLYps1; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 473A8204CC;
	Sat,  8 Mar 2025 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741449287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/CgfC9bQQMQo7QYZcvRHcVFZ3LoI/EHR6DAT/jK644=;
	b=CKsLYps19CeEEQQCP47KdAvj2eK2Q90syFYkMMqrmOTO2ATe3GnEROyI8MkN8rE/UYP9G1
	wxS2u1MDLXgNly56PP6deBJr6zGKqyvOsxaNbtzaraa/vH3exxbS/IrYBwA/ztKZ8RpK+N
	lHloe7NzOJR0IPTDxRG+5S/gqIqpQ5Rxv/xgNQ2Q3MnBKdKGJ6yuBK4Ydt/+hxhWct4/xN
	0IkOVUUmQkhkl+vjVQQUljkoZ36UZfE6DaLfl0INx9Fn4tVhq5PxYBBqX0QZlsw9pceLor
	Ld9eX17446V4rP8SuG8GMs+VeNTU31VhICb1XEvTJvErDiZl9ID6Tx9RAlqugQ==
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
Subject: [PATCH net-next v2 2/7] net: ethtool: netlink: Rename ethnl_default_dump_one
Date: Sat,  8 Mar 2025 16:54:34 +0100
Message-ID: <20250308155440.267782-3-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudehudevhedvvdevkeetleeigeejtddvkeejueffieevudfgvdekjeelffetvdehnecuffhomhgrihhnpehishhsuhgvrdhnvghtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

As we work on getting more objects out of a per-netdev DUMP, rename
ethnl_default_dump_one() into ethnl_default_dump_one_dev(), making it
explicit that this dumps everything for one netdev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Rebase, Fix whitespace issue.

 net/ethtool/netlink.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 11e4122b7707..f391a11242de 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -539,9 +539,9 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
-				  const struct ethnl_dump_ctx *ctx,
-				  const struct genl_info *info)
+static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
+				      const struct ethnl_dump_ctx *ctx,
+				      const struct genl_info *info)
 {
 	void *ehdr;
 	int ret;
@@ -592,8 +592,8 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 		/* Filtered DUMP request targeted to a single netdev. We already
 		 * hold a ref to the netdev from ->start()
 		 */
-		ret = ethnl_default_dump_one(skb, dev, ctx,
-					     genl_info_dump(cb));
+		ret = ethnl_default_dump_one_dev(skb, dev, ctx,
+						 genl_info_dump(cb));
 		rcu_read_lock();
 		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
 	} else {
@@ -601,8 +601,8 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 			dev_hold(dev);
 			rcu_read_unlock();
 
-			ret = ethnl_default_dump_one(skb, dev, ctx,
-						     genl_info_dump(cb));
+			ret = ethnl_default_dump_one_dev(skb, dev, ctx,
+							 genl_info_dump(cb));
 
 			rcu_read_lock();
 			dev_put(dev);
-- 
2.48.1


