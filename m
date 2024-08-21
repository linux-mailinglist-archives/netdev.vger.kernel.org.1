Return-Path: <netdev+bounces-120652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCBA95A116
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF5B1F21F4F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04B1B2EC0;
	Wed, 21 Aug 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfC1Xogm"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340014F13D;
	Wed, 21 Aug 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253039; cv=none; b=CAhWXeuBJAZSjRde6DEVUrrns7u3oHqddZY89qK6gGDA/2xR2qAYcxMlYWwCKa3Unb7qHX5xHfI4sYRU/boRsHVTvA9tLMGdMR9Ld08ZbtepyzRpWeuZQNBFtgzD7daDw8sPaWe4uSDfbvMuDdkG15HaCIdOWN/IlA32NETFr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253039; c=relaxed/simple;
	bh=nLk1epyXIri4ykgoD0bbr5Zmu43P0j5YNZmqZUEUhas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0JkLeHQfszdla3L23LwU2NdKfnkt4tUjhyCrmrdT6szOLa6Ri2LxIed4ZNnt4klpIoFn3KmZ4M6Jmc9QeWO6mRuxFI/h+DCW9SPPa8dXdABSW8lqWjZ0/5N4B5dD6gDFd+Ez4wMx7hwl/5JLzEpcNpRbEcAiowgW9XX6PB82Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfC1Xogm; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DF8C4000A;
	Wed, 21 Aug 2024 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724253033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBzO1piSGkffJ9EBxOWdq865oaNPMMpegYlq8SVlDSM=;
	b=VfC1Xogmvywvys9wmaB1vqINJW2MDOk8/NNLyGW/ftEw3hOB4ylYVry9kYbRG5GtPPqZxD
	SaiRgqKEsBeo6eTTKMO8Pzsh775/MMHbNAbJoAblYFcE1R5odAEotRQWVAABukiTkgj7tx
	KZfL3+JbQ8RSvaf5naINu7sWAFtFkTagJmlOE/P2nh0RH68mapjXJEiyFYhkLqYAQm16Wa
	IeRDx2wXY/s3Iby+dcqbDQHhnuCFcptk1H+0lT8130jm4ki05rjkg+UEW1UeJD0AL6oHGl
	9gNNyJ6hN9ELTdvMu0AOw5VCX54Rpip+TaQ+QSk5cbXH4gsr0I10mIGVu/MqGw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v18 11/13] net: ethtool: cable-test: Target the command to the requested PHY
Date: Wed, 21 Aug 2024 17:10:05 +0200
Message-ID: <20240821151009.1681151-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Cable testing is a PHY-specific command. Instead of targeting the command
towards dev->phydev, use the request to pick the targeted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 net/ethtool/cabletest.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f6f136ec7ddf..01db8f394869 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -13,7 +13,7 @@
 
 const struct nla_policy ethnl_cable_test_act_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 };
 
 static int ethnl_cable_test_started(struct phy_device *phydev, u8 cmd)
@@ -58,6 +58,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	struct ethnl_req_info req_info = {};
 	const struct ethtool_phy_ops *ops;
 	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	struct net_device *dev;
 	int ret;
 
@@ -69,12 +70,16 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
+
+	rtnl_lock();
+	phydev = ethnl_req_get_phydev(&req_info,
+				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
+				      info->extack);
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
 
-	rtnl_lock();
 	ops = ethtool_phy_ops;
 	if (!ops || !ops->start_cable_test) {
 		ret = -EOPNOTSUPP;
@@ -85,13 +90,12 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test(dev->phydev, info->extack);
+	ret = ops->start_cable_test(phydev, info->extack);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
-					 ETHTOOL_MSG_CABLE_TEST_NTF);
+		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
 
 out_rtnl:
 	rtnl_unlock();
@@ -216,7 +220,7 @@ static const struct nla_policy cable_test_tdr_act_cfg_policy[] = {
 
 const struct nla_policy ethnl_cable_test_tdr_act_policy[] = {
 	[ETHTOOL_A_CABLE_TEST_TDR_HEADER]	=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_phy),
 	[ETHTOOL_A_CABLE_TEST_TDR_CFG]		= { .type = NLA_NESTED },
 };
 
@@ -305,6 +309,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	struct ethnl_req_info req_info = {};
 	const struct ethtool_phy_ops *ops;
 	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	struct phy_tdr_config cfg;
 	struct net_device *dev;
 	int ret;
@@ -317,10 +322,6 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		return ret;
 
 	dev = req_info.dev;
-	if (!dev->phydev) {
-		ret = -EOPNOTSUPP;
-		goto out_dev_put;
-	}
 
 	ret = ethnl_act_cable_test_tdr_cfg(tb[ETHTOOL_A_CABLE_TEST_TDR_CFG],
 					   info, &cfg);
@@ -328,6 +329,14 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	rtnl_lock();
+	phydev = ethnl_req_get_phydev(&req_info,
+				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
+				      info->extack);
+	if (!IS_ERR_OR_NULL(phydev)) {
+		ret = -EOPNOTSUPP;
+		goto out_dev_put;
+	}
+
 	ops = ethtool_phy_ops;
 	if (!ops || !ops->start_cable_test_tdr) {
 		ret = -EOPNOTSUPP;
@@ -338,12 +347,12 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_rtnl;
 
-	ret = ops->start_cable_test_tdr(dev->phydev, info->extack, &cfg);
+	ret = ops->start_cable_test_tdr(phydev, info->extack, &cfg);
 
 	ethnl_ops_complete(dev);
 
 	if (!ret)
-		ethnl_cable_test_started(dev->phydev,
+		ethnl_cable_test_started(phydev,
 					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
 
 out_rtnl:
-- 
2.45.2


