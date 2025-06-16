Return-Path: <netdev+bounces-197971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD2ADAA42
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DD33A4C4C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA920966B;
	Mon, 16 Jun 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="v/FbWDXU"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFF1DF759;
	Mon, 16 Jun 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061270; cv=none; b=VFnU1bUQS1W1GoPJ5yuBJ3oNB3Qomcc1P9qT2jxj6b9WxUZnUsqDHvAKbPKzARxSVKGjCbZVU+GKMmZsmGY/rDr3wtqyGxcARiCo+dfzYkyuRdnp7OxzUnu+SHROylCSqz9ZdsKy6oaW7NY6lRxrJRX3jeUtBqJS2CVw68SZ33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061270; c=relaxed/simple;
	bh=cvC95Y7ToSmSyStTpTIz79xlOhzEgbBZTxF9D4b/1Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDpENpbgn369vC98tRa0fZyy1d3fWNxCCSYtTC8RuJVNRB7TedCXIGpDRzgircSHOHk2HGoSc8Pyt74ji+gGIGwr2DNbPb1MzUFCzQlWmVvptZ7cevbjCKZ8cEQmyzOJ5N40x7nud4kHnt6KNmzLb5qN0MuFP+9aNXX+jMHdztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=v/FbWDXU; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 34DDF5FDC5;
	Mon, 16 Jun 2025 08:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750061266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DJjXeuKhheNOpsysVnyfqqZfxw57KQnuiIsqRWjJXaw=;
	b=v/FbWDXUKLDLRNTjE70UxrD39XipH5Rk/nD0HgNES5rWRtjCah3ormnHSxHclcVgdTHxDb
	/EU0El/eZHFGJD2Wc1BaKfjBJXXUVU0GxJA24wB4yOkU6G7r18owNuJwISdk9VvTzYLJ3t
	QgqwKaEneJDJhPnAXRPDd72kz+IeXsQ=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E91821226D6;
	Mon, 16 Jun 2025 08:07:45 +0000 (UTC)
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
Subject: [net-next v4 0/3] rework IRQ handling in mtk_eth_soc
Date: Mon, 16 Jun 2025 10:07:33 +0200
Message-ID: <20250616080738.117993-1-linux@fw-web.de>
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
  net: ethernet: mtk_eth_soc: change code to skip first IRQ completely

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 63 +++++++++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  7 ++-
 2 files changed, 52 insertions(+), 18 deletions(-)

-- 
2.43.0


