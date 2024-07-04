Return-Path: <netdev+bounces-109176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9806D9273C3
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A23528988E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22601A4F10;
	Thu,  4 Jul 2024 10:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885816C6BA;
	Thu,  4 Jul 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088123; cv=none; b=SlKIbCmjA5tZt62KAlvbdzgb+Xcz1BNCn+VdKIYJzHcFR2joo7g0xEswPO0RKvD++lcqcJ8IA3QmcWCwng09xiNN26rIY6DrhvZMMU33YNEb1a3brktmNwZH3KmGtMG2iwpr4lmII1dKvgB/pNSJHSZc6mNX1W/1n+yDD1eZq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088123; c=relaxed/simple;
	bh=kjWTEwfX1u2qciGRNuXhRv9xvHCzoaWzL1RSqv/rt68=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J52M3ujSXYHX3MrW5w9kaE7uftzwSjBtM0RrrP4CkgxGvfE9uPrk2BD0UHBVStztjXE1Z3KYhhucedgC9vnlOBZjk3eANpoV+omFe+gL79T2kcEfgkaAHgVanMoTMy1eamacBAWih4Vn/ypcbM7VIbRGsr09E2hkKycJPp4AEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sPJUW-00000000816-0b7U;
	Thu, 04 Jul 2024 10:15:04 +0000
Date: Thu, 4 Jul 2024 11:14:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: implement
 .{get,set}_pauseparam ethtool ops
Message-ID: <e3ece47323444631d6cb479f32af0dfd6d145be0.1720088047.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Implement operations to get and set flow-control link parameters.
Both is done by simply calling phylink_ethtool_{get,set}_pauseparam().
Fix whitespace in mtk_ethtool_ops while at it.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 13d78d9b3197..fbf5f566fdc5 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4464,6 +4464,20 @@ static int mtk_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static void mtk_get_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+
+	phylink_ethtool_get_pauseparam(mac->phylink, pause);
+}
+
+static int mtk_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+
+	return phylink_ethtool_set_pauseparam(mac->phylink, pause);
+}
+
 static u16 mtk_select_queue(struct net_device *dev, struct sk_buff *skb,
 			    struct net_device *sb_dev)
 {
@@ -4492,8 +4506,10 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 	.get_strings		= mtk_get_strings,
 	.get_sset_count		= mtk_get_sset_count,
 	.get_ethtool_stats	= mtk_get_ethtool_stats,
+	.get_pauseparam		= mtk_get_pauseparam,
+	.set_pauseparam		= mtk_set_pauseparam,
 	.get_rxnfc		= mtk_get_rxnfc,
-	.set_rxnfc              = mtk_set_rxnfc,
+	.set_rxnfc		= mtk_set_rxnfc,
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
-- 
2.45.2

