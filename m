Return-Path: <netdev+bounces-34512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275FA7A4717
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFAE1C20969
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811B1CAB8;
	Mon, 18 Sep 2023 10:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77131CAB3;
	Mon, 18 Sep 2023 10:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5519C433C9;
	Mon, 18 Sep 2023 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033013;
	bh=0pqkmD5Iozwr7NTEc4EXc7d5bZlZew621GqsG8gHbbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUvUn1lpSzJcCShODbw2zqIEdZbMUCuCo4juC+OiK1uk6IWBDFRwUoO+lDBkt/W0G
	 kVlWzLmlOP6+OUYD6uY7jmW+tdiLR7sNFBe7cF8CacSJKVESnAL2gtkjXTJtnyBJm6
	 4D37bxG+O61SKxKEdS4E6HWEhn8zEh2abV474c5RPbDoiuePgdEe/dq+9nD7ob/CkI
	 moVEPDwvHW4h85uJV7m4eDXg+frRIvard5zFM7X48bn9bq2PKquAn994tHpHISa0yL
	 cpS9k1CdIjm6rK9kmE4rW4D8XAhXRc31/Og9fKjzDja2yXP25godpBJoI/3Ho/nwlQ
	 nqKWxJaRjqmsQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	horms@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 05/17] net: ethernet: mtk_wed: rename mtk_rxbm_desc in mtk_wed_bm_desc
Date: Mon, 18 Sep 2023 12:29:07 +0200
Message-ID: <522cdd80a8ead8a28fd83da759979b810c5e9bff.1695032291.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695032290.git.lorenzo@kernel.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename mtk_rxbm_desc structure in mtk_wed_bm_desc since it will be used
even on tx side by MT7988 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c          | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 include/linux/soc/mediatek/mtk_wed.h             | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 750326b298dc..f166d4f0b793 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -422,7 +422,7 @@ mtk_wed_free_tx_buffer(struct mtk_wed_device *dev)
 static int
 mtk_wed_rx_buffer_alloc(struct mtk_wed_device *dev)
 {
-	struct mtk_rxbm_desc *desc;
+	struct mtk_wed_bm_desc *desc;
 	dma_addr_t desc_phys;
 
 	dev->rx_buf_ring.size = dev->wlan.rx_nbuf;
@@ -442,7 +442,7 @@ mtk_wed_rx_buffer_alloc(struct mtk_wed_device *dev)
 static void
 mtk_wed_free_rx_buffer(struct mtk_wed_device *dev)
 {
-	struct mtk_rxbm_desc *desc = dev->rx_buf_ring.desc;
+	struct mtk_wed_bm_desc *desc = dev->rx_buf_ring.desc;
 
 	if (!desc)
 		return;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index fc7ace638ce8..e7d8e03f826f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -591,7 +591,7 @@ static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 
 static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 {
-	struct mtk_rxbm_desc *desc = wed->rx_buf_ring.desc;
+	struct mtk_wed_bm_desc *desc = wed->rx_buf_ring.desc;
 	struct mt76_txwi_cache *t = NULL;
 	struct mt7915_dev *dev;
 	struct mt76_queue *q;
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index b2b28180dff7..c6512c216b27 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -45,7 +45,7 @@ enum mtk_wed_wo_cmd {
 	MTK_WED_WO_CMD_WED_END
 };
 
-struct mtk_rxbm_desc {
+struct mtk_wed_bm_desc {
 	__le32 buf0;
 	__le32 token;
 } __packed __aligned(4);
@@ -104,7 +104,7 @@ struct mtk_wed_device {
 
 	struct {
 		int size;
-		struct mtk_rxbm_desc *desc;
+		struct mtk_wed_bm_desc *desc;
 		dma_addr_t desc_phys;
 	} rx_buf_ring;
 
-- 
2.41.0


