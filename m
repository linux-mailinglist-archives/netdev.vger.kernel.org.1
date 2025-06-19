Return-Path: <netdev+bounces-199473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98839AE06DD
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B1C4A3112
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1B24DD13;
	Thu, 19 Jun 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="w/NBMfkZ"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097A24BBFD;
	Thu, 19 Jun 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339304; cv=none; b=etxPznkEAdsmPnFXiA9mWtP2ZkSClrn4IKC5j2qtmAljCMFv4lJJgdaIjVRs7Qjuz4MqkiKE2F2L668e5PhzZxeX4U+XHyajzo2xKNxBxN8DA0+NH1ACQDlBBNlwdP8eDQu2DiWn3CtP63pSvLERSP127AUo4f8jFKZKfu/mjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339304; c=relaxed/simple;
	bh=yOBuUvOyfgLzNONHVmQslW/YIMWy3rpROYKM225PTgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moJ3o/Yx/rWwW2wEYXdGyQl101YdCvsWbFDfi2lWGqQl4jsJ0daXLeISurkIYnA5LX5rseCllza1sYCLKa9TMYlSLVdBKiO9taO6vMnrTlL2RCqeEai8+Vr9na+WecZ48mUsETBtDN9o1KSBQdxhZuJqhriqRQHwRa4I2F11n8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=w/NBMfkZ; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 69E1B61633;
	Thu, 19 Jun 2025 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750339294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQ7YWrPQH4eKb2hcGi9xzFrlY9L4wPx8/nkdEx2cSuc=;
	b=w/NBMfkZg41xJNspRvdAMMJP0SmfIqfenp3BdYrDzVBF5j7z30iwx+sbem56jOMphsWs4j
	k1HiEyoA9TOd3Hgh7WUDo4QypezNrQ/WL0xmCw4Lq7lgNjXj0RgG3OH93xhtFfe3kw3mRp
	+wfmwaeZe9Q5+ohKOglSZcdMgvGrdbk=
Received: from frank-u24.. (fttx-pool-80.245.76.73.bambit.de [80.245.76.73])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 246471226B5;
	Thu, 19 Jun 2025 13:21:34 +0000 (UTC)
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
Subject: [net-next v6 0/4] rework IRQ handling in mtk_eth_soc
Date: Thu, 19 Jun 2025 15:21:20 +0200
Message-ID: <20250619132125.78368-1-linux@fw-web.de>
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
    v6:
    - change irq names from tx/rx to fe1/fe2 because reserved irqs
      are usable and not bound to specific function
    - dropped Simons RB because of this
    - updated description of patch "skip first IRQ if not used" and
      use MTK_FE_IRQ_SHARED instead of 0 in condition too
    - add "only use legacy mode on missing IRQ name" patch
    
    v5:
    - fixed typo in patch 1
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


Frank Wunderlich (4):
  net: ethernet: mtk_eth_soc: support named IRQs
  net: ethernet: mtk_eth_soc: add consts for irq index
  net: ethernet: mtk_eth_soc: skip first IRQ if not used
  net: ethernet: mtk_eth_soc: only use legacy mode on missing IRQ name

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 69 ++++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  7 ++-
 2 files changed, 58 insertions(+), 18 deletions(-)

-- 
2.43.0


