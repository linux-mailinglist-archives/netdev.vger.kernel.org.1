Return-Path: <netdev+bounces-18951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF3759315
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136B328173A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7215ADE;
	Wed, 19 Jul 2023 10:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88A156C7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A56C433C7;
	Wed, 19 Jul 2023 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689762608;
	bh=uJXr1Cfnxz8KoixO3qVZNOqlh/o1Q9BoNBQIaG88Hgs=;
	h=From:To:Cc:Subject:Date:From;
	b=vBOl7IRzpCOZv29eHGvyYD6+MmA+DqMzfLb9qHC9YQPY+hGWiN6YWSS7ybDelUqEL
	 2TJXXJ6DZIvyvRtgV/e+1/+tFHCso9hHL4IFexkmmcZCS9HtV53f+A/58zcwzPnlCr
	 4hKWLiOeVh3fv4REdb5uwtxVoosdq/srBDU6fdNMOOZwZMQMesTg2MS5EMitSudvku
	 NgMXVo3qFIPDVaLO2Rb21dgYHNMBSroqTujmhNNgzUxPjtJsbLV27uLcI+dKGsGai9
	 XOev6thRSZJuwKSFnnVdwMrffbWlzVmhSmPyVbwCG9n1O9995SW1ILAQ8KZ6Arvoog
	 JnIQUJbkpNLeg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi@redhat.com,
	daniel@makrotopia.org
Subject: [PATCH net-next] net: ethernet: mtk_ppe: add MTK_FOE_ENTRY_V{1,2}_SIZE macros
Date: Wed, 19 Jul 2023 12:29:49 +0200
Message-ID: <725aa4b427e8ae2384ff1c8a32111fb24ceda231.1689762482.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce MTK_FOE_ENTRY_V{1,2}_SIZE macros in order to make more
explicit foe_entry size for different chipset revisions.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++-----
 drivers/net/ethernet/mediatek/mtk_ppe.h     |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 834c644b67db..7f9e23ddb3c4 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4811,7 +4811,7 @@ static const struct mtk_soc_data mt7621_data = {
 	.required_pctl = false,
 	.offload_version = 1,
 	.hash_offset = 2,
-	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
+	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
 		.rxd_size = sizeof(struct mtk_rx_dma),
@@ -4832,7 +4832,7 @@ static const struct mtk_soc_data mt7622_data = {
 	.offload_version = 2,
 	.hash_offset = 2,
 	.has_accounting = true,
-	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
+	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
 		.rxd_size = sizeof(struct mtk_rx_dma),
@@ -4851,7 +4851,7 @@ static const struct mtk_soc_data mt7623_data = {
 	.required_pctl = true,
 	.offload_version = 1,
 	.hash_offset = 2,
-	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
+	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
 		.rxd_size = sizeof(struct mtk_rx_dma),
@@ -4889,8 +4889,8 @@ static const struct mtk_soc_data mt7981_data = {
 	.required_pctl = false,
 	.offload_version = 2,
 	.hash_offset = 4,
-	.foe_entry_size = sizeof(struct mtk_foe_entry),
 	.has_accounting = true,
+	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma_v2),
 		.rxd_size = sizeof(struct mtk_rx_dma_v2),
@@ -4910,8 +4910,8 @@ static const struct mtk_soc_data mt7986_data = {
 	.required_pctl = false,
 	.offload_version = 2,
 	.hash_offset = 4,
-	.foe_entry_size = sizeof(struct mtk_foe_entry),
 	.has_accounting = true,
+	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma_v2),
 		.rxd_size = sizeof(struct mtk_rx_dma_v2),
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
index e51de31a52ec..fb6bf58172d9 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
@@ -216,6 +216,9 @@ struct mtk_foe_ipv6_6rd {
 	struct mtk_foe_mac_info l2;
 };
 
+#define MTK_FOE_ENTRY_V1_SIZE	80
+#define MTK_FOE_ENTRY_V2_SIZE	96
+
 struct mtk_foe_entry {
 	u32 ib1;
 
-- 
2.41.0


