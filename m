Return-Path: <netdev+bounces-33059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D650279C9BF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4301C20AB4
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E45E17741;
	Tue, 12 Sep 2023 08:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F3154A9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C23C433C7;
	Tue, 12 Sep 2023 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694506985;
	bh=Eo9G/osr66isoQRSTOM583/A3H1yDzHwJkukyfLtq+U=;
	h=From:To:Cc:Subject:Date:From;
	b=omzgJ9/t//dkbFYezvGxCGD7JWuttTv1LEb2mtLacrfbNbCMOMwDUF4kAQAz1fpC2
	 QXT2/f/VejJ8KLadVSru40u5XlO/UQNg6MHbDH27h6OLJQ0axIzO9qvJcCoFz+UoHs
	 YvmyPV+m0PkH5tehy1Q/X8n0pDHlb7V0gq+/DMSntaG38fvU/Q7bFPC3SvoFzvNUAJ
	 ZRLut1rVYuZHer8x02wkugWgdn31p9npBkOwQGzjsh/h8YAYQROqeWnOEGIUcdLBXn
	 dOg0bP8ij61+I8vZ1TUKUSbKTpNFv7o98v1Dvf9Bos7sQJATg8jrxvggI0+u8tK14K
	 Cmd4u5s+uEuPA==
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
	pabeni@redhat.com
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: rely on mtk_pse_port definitions in mtk_flow_set_output_device
Date: Tue, 12 Sep 2023 10:22:56 +0200
Message-ID: <b86bdb717e963e3246c1dec5f736c810703cf056.1694506814.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to ethernet ports, rely on mtk_pse_port definitions for
pse wdma ports as well.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index a4efbeb16208..ef3980840695 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -196,10 +196,10 @@ mtk_flow_set_output_device(struct mtk_eth *eth, struct mtk_foe_entry *foe,
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			switch (info.wdma_idx) {
 			case 0:
-				pse_port = 8;
+				pse_port = PSE_WDMA0_PORT;
 				break;
 			case 1:
-				pse_port = 9;
+				pse_port = PSE_WDMA1_PORT;
 				break;
 			default:
 				return -EINVAL;
-- 
2.41.0


