Return-Path: <netdev+bounces-199078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDFADED78
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E80189DE20
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B62E9755;
	Wed, 18 Jun 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="RhzH9Zfb"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E02E92CD;
	Wed, 18 Jun 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252060; cv=none; b=l0GfmQ+y8309CbIeYuerwaTPz7DZZkUBad/OxEWVGsubk8wYkv74MMmddsmzkQPvzLkv1jSpASb5BfZmdTpUJTedVqBBN7tGAxUmjZ2u44EKWQ0jmD1/9tGY4l+d06+Hfy/220iSnfCl9n8qWzxxqVGNNLBsHvkLOt5d/AsllGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252060; c=relaxed/simple;
	bh=3pvuwSe57OyXWYyH6qSbVju+S2OcvM/F5upjFh4+loU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3HL9AshCRju22GNbEVFYnMKX3qyw84aA5Pc6eomfXXrM0N0fh0YD234SLGPUCcwgVWuaYaIhACW5W5dqMUMLKfkpg4JRG/bdfNirgTXZ8Tsq7KApOR3k1QsgYR9XLjB+7MwaNzi3M0Xjdq7BWddSRDgW4t3rUQHXAFq8W0euAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=RhzH9Zfb; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 54971614C4;
	Wed, 18 Jun 2025 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750252050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7RRMFR5bvStrbJAlB1dlE3PbQroltgCFLw5x1wwfKug=;
	b=RhzH9ZfbD9Bw1e4a0IYqZtEtXY+8lYnCPrL5sYbd5jSow/OhpdlnoNudzDABQvaS5Z5AVV
	rht0jTKYIgZo4iOBiaqAmm+rcfbbBroW98hPMAiWpcsXEWEZHf/R2PuFo9RAKhn9ODb+9H
	T+97Dy3hwqm5zVU5gl2hm15RrEiCZso=
Received: from frank-u24.. (fttx-pool-80.245.76.73.bambit.de [80.245.76.73])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 166401226D6;
	Wed, 18 Jun 2025 13:07:30 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	arinc.unal@arinc9.com
Subject: [net-next v5 0/3] rework IRQ handling in mtk_eth_soc
Date: Wed, 18 Jun 2025 15:07:11 +0200
Message-ID: <20250618130717.75839-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series introduces named IRQs while keeping the index based way
for older dts.
Further it makes some cleanup like adding consts for index access and
avoids loading first IRQ which was not used on non SHARED_INT SoCs.
    
changes:
    
    v5:
    - fixed typo and add linebreak in description of patch 1
    - moved comments from previous patch #3 to patch #1 with changes suggested by simon
    - rename consts to be compatible with upcoming RSS/LRO changes
      MTK_ETH_IRQ_SHARED => MTK_FE_IRQ_SHARED
      MTK_ETH_IRQ_TX => MTK_FE_IRQ_TX
      MTK_ETH_IRQ_RX => MTK_FE_IRQ_RX
      MTK_ETH_IRQ_MAX => MTK_FE_IRQ_NUM
    - change commit title and description in patch 3
    
    v4:
    - calculate max from last (rx) irq index and use it for array size too
    - drop >2 condition as max is already 2 and drop the else continue
    - update comment to explain which IRQs are taken in legacy way
    
    v3:
    added patches
    - #2 (add constants for irq index)
    - #3 (skip first IRQ on ! MTK_SHARED_INT)
    to the v2 non-series patch
    
    https://patchwork.kernel.org/project/netdevbpf/patch/20250615084521.32329-1-linux@fw-web.de/
    
Tested on BPI-R4/mt7988 with IRQ names and BPI-R2/mt7623 and BPI-R3/mt7986 with upstreamed
dts via index-mode.
I do not have any MTK_SHARED_INT (mt7621/mt7628) boards to testing.

Frank Wunderlich (3):
  net: ethernet: mtk_eth_soc: support named IRQs
  net: ethernet: mtk_eth_soc: add consts for irq index
  net: ethernet: mtk_eth_soc: skip first IRQ if not used

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 62 +++++++++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  7 ++-
 2 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.43.0


