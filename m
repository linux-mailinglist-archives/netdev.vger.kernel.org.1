Return-Path: <netdev+bounces-187393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57FFAA6D0C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313031B683D8
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD8B2309BD;
	Fri,  2 May 2025 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AhjploZq"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72622D78D;
	Fri,  2 May 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175979; cv=none; b=LTt5/yVcPEEJGmJh8P5pgV8mutD99E7sKGa0yhKxTMoBjcCe9wPSlROI5rtJOP6+2SNJcWqhCqaMTaWTaH21A3/EqkuPioWjZrrUaIvPRvlaL/4N1j+sAc4T5D22QrevP9sgy0zoAcdlavhOQXzecPZNgCnK/+4PrMgEqFyIPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175979; c=relaxed/simple;
	bh=Cte1phsUs8Zr/YyttDZPP5nEwLNlPdsUnokAvREaUcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgTRDIGpDgFILgOcZgv9K29A3U0xik0kkV9jpoHH37uZBShzGhXvU0GAvf+ybarWfFAqv2l7yQzDu8Z6wVJpfFoffXekxLXu74msoxvmKfMh9ZF7heBvWp6E9TaTGpK/A/TRSNSXyQKuV1YGilObCdZiHJTv2XhfGDl/nA0edzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AhjploZq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A41DA43219;
	Fri,  2 May 2025 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746175969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn4OugAZ7sAo/dzL+u9hij9jwFPOnyywvCizSecmfL0=;
	b=AhjploZqcduQNEHAxIZ8rebFZhz2/YoGHABnqy4nz8tsjScYG+JcAOqAUr7e3M2r7/yjmY
	MjEB0QAJt8WnCvByRi8OKp92GoOe+2G6ZBWp7i4h4Ky1zwRLAu1BmWbfgYjz3G6LR/XA2Q
	qi/0ZyB5/xahc6a5ukOJnA4JJfNmNMrZx4Mj8PD2W4TKPPEqw52dXtfi8k4TA9kZSw/zXD
	1rn3z4/5gh1PV6+uNkKlvbwFC6ZozCKJR0vXlm0ErlPfOgwgWRw8lG8s6M8zX1gwGBgwFZ
	ngr00Ig/zetJ1U5i/NduJwLbL1Mm1bL30aP46+iMr/oFg1N0o3GoFPT5KF9Pjw==
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
Subject: [PATCH net-next v8 3/3] net: ethtool: netlink: Use netdev_hold for dumpit() operations
Date: Fri,  2 May 2025 10:52:41 +0200
Message-ID: <20250502085242.248645-4-maxime.chevallier@bootlin.com>
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

Move away from dev_hold and use netdev_hold with a local reftracker when
performing a DUMP on each netdev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index c8ed5a6f1e92..9de828df46cd 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -603,18 +603,19 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
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


