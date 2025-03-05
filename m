Return-Path: <netdev+bounces-172055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967CA501AA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706E13ADD04
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31B24C093;
	Wed,  5 Mar 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G4k4yM9t"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C61519BD;
	Wed,  5 Mar 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184387; cv=none; b=tegPXjwN3EiAw1Jew2nukKKVPALlTFIvkczjs6EkHl/ZkOmi6XZL5xQ4GNul/JgWGwP/AlU2kYD38YSGQFA1p9Z6M25l237IPTGN9puUVvA33DbHX7sW0LAUTksDsudRbln7fOjiuc8Qy2epGX6y4fkrfvlhcQuZL0X0weMImPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184387; c=relaxed/simple;
	bh=PrH0JFlp5F8e/mik4ug8pkpvr/OEx441cdrsPGKsdUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru1H0NtcEg8+MQkivcf7dBh2+7WJ75/yPJstOKutPfdoYe70741RNUbc0GhP3GL0cfN7yjhshS39WfJYCkMWmj3r/hWpGReEPnaxNqKafBk6E3mNPFXRjDDpphCawz+i6Qx+fI2+I0S9vmrLVEeRLNxoDvShVEpIPlnojMflyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G4k4yM9t; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B724D44110;
	Wed,  5 Mar 2025 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741184383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4Vt/+sE9uq1aYjpbMx/58Ei8i4J79Zx7ZN6MMUPbsc=;
	b=G4k4yM9ttZ1iCsFOil5MiRmHa+ABS8VQg8xqJL5FlX9vz94dEpz99jUqSUYRMfIrNKAxVz
	7mlAh06hqjgSEiIrXbXQK6WKS/LpC4K67pFFXTkpcUmSLt7qamYHn9CdoswfUX+Uny1RLm
	H9RhMj3OooeLwlTelbQCGHnb/Zk/z6wkhs09xyEskdHF6BSZ6VRbefvh9liJ41B/92VqFI
	1H8OPP49pPX6iKbyBiegf76eA6y6nNN7hvuKrZCvfp7j6Nj3s/OMTcrBjuT1UxDLjRkDge
	7A2N6aW9bvZlF2mULovljGK1Xl8rKp79x3Fx1Y0kU+1fMQKImZitqJHfBjxQ4g==
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
Subject: [PATCH net-next 1/7] net: ethtool: netlink: Allow per-netdevice DUMP operations
Date: Wed,  5 Mar 2025 15:19:31 +0100
Message-ID: <20250305141938.319282-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

We have a number of netlink commands in the ethnl family that may have
multiple objects to dump even for a single net_device, including :

 - PLCA, PSE-PD, phy: one message per PHY device
 - tsinfo: one message per timestamp source (netdev + phys)
 - rss: One per RSS context

To get this behaviour, these netlink commands need to roll a custom
->dumpit().

To prepare making per-netdev DUMP more generic in ethnl, introduce a
member in the ethnl ops to indicate if a given command may allow
pernetdev DUMPs (also referred to as filtered DUMPs).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 45 ++++++++++++++++++++++++++++---------------
 net/ethtool/netlink.h |  1 +
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 734849a57369..0815b28ba32f 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -578,21 +578,34 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 	int ret = 0;
 
 	rcu_read_lock();
-	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
-		dev_hold(dev);
+	if (ctx->req_info->dev) {
+		dev = ctx->req_info->dev;
 		rcu_read_unlock();
-
-		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
-
+		/* Filtered DUMP request targeted to a single netdev. We already
+		 * hold a ref to the netdev from ->start()
+		 */
+		ret = ethnl_default_dump_one_dev(skb, dev, ctx,
+						 genl_info_dump(cb));
 		rcu_read_lock();
-		dev_put(dev);
-
-		if (ret < 0 && ret != -EOPNOTSUPP) {
-			if (likely(skb->len))
-				ret = skb->len;
-			break;
+		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
+	} else {
+		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
+			dev_hold(dev);
+			rcu_read_unlock();
+
+			ret = ethnl_default_dump_one(skb, dev, ctx,
+						     genl_info_dump(cb));
+
+			rcu_read_lock();
+			dev_put(dev);
+
+			if (ret < 0 && ret != -EOPNOTSUPP) {
+				if (likely(skb->len))
+					ret = skb->len;
+				break;
+			}
+			ret = 0;
 		}
-		ret = 0;
 	}
 	rcu_read_unlock();
 
@@ -626,10 +639,10 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	}
 
 	ret = ethnl_default_parse(req_info, &info->info, ops, false);
-	if (req_info->dev) {
-		/* We ignore device specification in dump requests but as the
-		 * same parser as for non-dump (doit) requests is used, it
-		 * would take reference to the device if it finds one
+	if (req_info->dev && !ops->allow_pernetdev_dump) {
+		/* We ignore device specification in unfiltered dump requests
+		 * but as the same parser as for non-dump (doit) requests is
+		 * used, it would take reference to the device if it finds one
 		 */
 		netdev_put(req_info->dev, &req_info->dev_tracker);
 		req_info->dev = NULL;
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index ec6ab5443a6f..4db27182741f 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -388,6 +388,7 @@ struct ethnl_request_ops {
 	unsigned int		req_info_size;
 	unsigned int		reply_data_size;
 	bool			allow_nodev_do;
+	bool			allow_pernetdev_dump;
 	u8			set_ntf_cmd;
 
 	int (*parse_request)(struct ethnl_req_info *req_info,
-- 
2.48.1


