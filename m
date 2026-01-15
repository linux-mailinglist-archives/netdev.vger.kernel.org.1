Return-Path: <netdev+bounces-250202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26494D24FCB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F55330393DD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD40379979;
	Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE42399A4C
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487903; cv=none; b=m3r9EDs6YHXdtyAcbgNUAY2QSQQv0BwW6WIY+a97j2r+GPu6xKaZ1WOXF4xGpBMRfrfdkESrdGXITH+yPSzLHrTMgnXzPjrrwP86rtzPUjJ/kb3qCUWjXDi78vMzJN5Ib5mXVcBsd9WJiOobtZTNotE0Up3pDIDAW/8eRIMnOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487903; c=relaxed/simple;
	bh=dAvRCGWtWrgyCIbjzXr78wi4bL8QADGL+zFdAiYR2bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnyCdwP/RIYy9KdWD39FBKTOQUhOr3cR1FVy3OfY9LgLMBo4Nvp4N1q+w3LOCxPO0hUSbK6oNuw45rBWo8CCqSfUL8tZllSvHR19VDcgwY/AbvRx6MHUCpwsGfsv9fnjTYeSyGlxaHPyFNmqxzS1N5BGGnaTCN23v6YgVC2QhKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3ffc3d389a8so669049fac.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487896; x=1769092696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J/FeA4DjIpvihRKqOOPncXjlCgByUn4v1i0+sGL5vbs=;
        b=P5XbTdxbKuIvCVtN7DEp0Hqkyj2zuJCHkuon71MeLhAD2Oy1EDA/R0afGGZGxGc2gx
         zfOV9gAp5mkzWVeA7r6WYeB3X6WeDbxpkAO87nfKYvBJeohSy9okNTWdy0AebikWQvK0
         AvMTYkVjAEiqSMK1FZBVOcZUiN7kRzzPmsUqSUYBb4mUelD4Dw8IjQeD22xknCxfpKYS
         aXwNseQ11FebsIm7qWJ7Hf0OyKU8QA5OydBwqG35wTc83ZFUCnL0JpzT1/hV4hR9avui
         qEnv1K0s7u1LU2vYNi3H3IFPfX09o7FJsjgiCL1Sf9QA9obtnM1GBn4ljx+nTUbLQIJ7
         lgYA==
X-Gm-Message-State: AOJu0YxWIHAxo82jl1ztoRPv2dgomWoQ2QGFuqJ5l6XTvk5sv5DkeydL
	fs6Ce9heJ2d5X9xdWKzQe89HIdXOU12IW0fxLgKux6DTBNeUzckZIITA
X-Gm-Gg: AY/fxX6jTQSRCevGP6Y2/e3/TxTVFd99r4ISr/vDu8hhc4n4tHmKPJKATX8LDRvMscK
	s7ZwT2LZ7tOwE5YccDEbLufLYBKQLc96sdxhUmnU7GCMZmVyDdTKiPVD5j9BJf4/3ldT4nOiPov
	ROH+2lcw9pKAgsckLxf0GM8WP2BYzdK4J8SBr/qARRPxRStaoKx1IKT1zP+ltpqeTIXKU8P2OgR
	aTySml5N+ugqWYiz5hjSgn96PzJwf7JClec673jbreGzmJOBZ6qtJ1vjzFG5Szx5swXTTOGb9LZ
	p9qHVA3xKbuzGm3kLxb8lOpHXKx3ZfRA5DPjKMxqo6LfAEWEjXc/5ElmlX76crBQW1uLF/K9q8u
	xyar3FnWNYkd9+93M/NURFJFBxRAxGKSINFbmt70MVrXCMLfH5LIOY/rnhQ6fhHEvplThkVObVC
	iZR9BBeJACmx06
X-Received: by 2002:a05:6871:2211:b0:3d4:760f:544b with SMTP id 586e51a60fabf-4040716055bmr4253866fac.46.1768487895761;
        Thu, 15 Jan 2026 06:38:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4040997ffacsm3714947fac.6.2026.01.15.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:50 -0800
Subject: [PATCH net-next 3/9] net: mediatek: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-3-b3e1b58bced5@debian.org>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
In-Reply-To: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=leitao@debian.org;
 h=from:subject:message-id; bh=dAvRCGWtWrgyCIbjzXr78wi4bL8QADGL+zFdAiYR2bc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvRK7lb2WvUAPqaQKV1+ODpLebJeMp5bYV+Z
 NGd9H0VU2uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70QAKCRA1o5Of/Hh3
 bSgUD/94DPM5bKVosd7hSCjQw9XhbrFa34AvpHooSQCwpmP0Abk5I+Rh+hYzUDUq0QQV/wSU95b
 CJ6l2SNhGUWoWw3CrFPm80hM6b3RIl6KN0aAsDiaVWMUrbN+KNbT3yEZp73aIHS8o/OxNFuVzmo
 Yuaz7rZ9ekX+FvaUabuLH/dFnmrMGQ5r0AYhTBGOMn5mMtab0Rx7SidFT5AWsXJGb5SSu4S6AVM
 ROPo81FwQsyWgssFN9PiKK19CzyjkMsmSag/Bwi/h50v7tjlNZO+WCcrcFhCQfchKXz2+Plk/0C
 xDGaZ5E90LuNVi916p4rNFr8qc3x8uza4tF9RdurlbPNtKVxbQe6vaFyD2iwpo3p14/XQu+tbk+
 nrJmVj7ro9woJ1ukGdJ2WQEppydsccRtXmOpCuYFPwFfKjigX2c5SVumJtB2W5JUtWRfOXDF3oF
 4HVB/iPaNvLUgH5TzULt6Z3DNCh8d26NSPGspqxMsWndDHfZOjcG6ywIDyI78FCG2fvihxNpGc3
 Ed3ljL/dQPx0Y/nEdviEtGnaD1/d3fBTy3KwjAqIstvw8FEqLPPtLomDZHeyhaO7gB0zmRCH+1h
 Et4JOHjw0ZttjoVW83jemJG1OUmKM06SyamadYHRvSfaaW6aPAvPQQ/sDuW8WlsSRrTiLcICFNK
 fjUU/Z4OqxvNkzg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e68997a29191..99abec2198d0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4625,18 +4625,20 @@ static void mtk_get_ethtool_stats(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&hwstats->syncp, start));
 }
 
+static u32 mtk_get_rx_ring_count(struct net_device *dev)
+{
+	if (dev->hw_features & NETIF_F_LRO)
+		return MTK_MAX_RX_RING_NUM;
+
+	return 0;
+}
+
 static int mtk_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			 u32 *rule_locs)
 {
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		if (dev->hw_features & NETIF_F_LRO) {
-			cmd->data = MTK_MAX_RX_RING_NUM;
-			ret = 0;
-		}
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		if (dev->hw_features & NETIF_F_LRO) {
 			struct mtk_mac *mac = netdev_priv(dev);
@@ -4741,6 +4743,7 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 	.set_pauseparam		= mtk_set_pauseparam,
 	.get_rxnfc		= mtk_get_rxnfc,
 	.set_rxnfc		= mtk_set_rxnfc,
+	.get_rx_ring_count	= mtk_get_rx_ring_count,
 	.get_eee		= mtk_get_eee,
 	.set_eee		= mtk_set_eee,
 };

-- 
2.47.3


