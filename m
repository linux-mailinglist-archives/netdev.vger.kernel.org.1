Return-Path: <netdev+bounces-34516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFA7A4732
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0327E282436
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590031D697;
	Mon, 18 Sep 2023 10:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073826E04;
	Mon, 18 Sep 2023 10:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C239BC433C7;
	Mon, 18 Sep 2023 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033028;
	bh=4RTnOVnxkFJKdO/9EOrIbdbdUbFE1MV2mBwdfo/GVPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=so9R/AAhygNiDc/qoNsV2QKu6AAme6MpJt9N93Cqd0CTfnZNVepzDrOGuy6OoTbQ0
	 RVWiRk2atmoA4XzFdz3GZefHy77dF6qd17WJ64AHW1y+C3mNyZE+8hfZb94eGipWm8
	 4/jZ6768W2LKB8ygv31n64+HPPh//PqluZu+hoYiL8z9o1ZwjagixR4jvhUm52EKiT
	 NKaLD68G4JIArKFAWgTKl8s6+fTyWEfieAcRosSse/XOjgPNV+SEkZD6nWg+K2vkRO
	 G5zOmmgSOA/+Vc/ozc96dCOQCX+k1306tf2U2FibPw1Uv89607QokcVbBXYsLsWKKs
	 LuIuuWDxBhwJQ==
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
Subject: [PATCH v2 net-next 09/17] net: ethernet: mtk_wed: fix EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC
Date: Mon, 18 Sep 2023 12:29:11 +0200
Message-ID: <ebde071cc3cc9c35b00366c41912ee2f25e5282d.1695032291.git.lorenzo@kernel.org>
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

Fix MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH and
MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH definitions for MT7986 (MT7986 is
the only SoC to use them).

Fixes: de84a090d99a ("net: ethernet: mtk_eth_wed: add wed support for mt7986 chipset")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index 47ea69feb3b2..f87ab9b8a590 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -64,8 +64,8 @@ struct mtk_wdma_desc {
 #define MTK_WED_EXT_INT_STATUS_TKID_TITO_INVALID	BIT(4)
 #define MTK_WED_EXT_INT_STATUS_TX_FBUF_LO_TH		BIT(8)
 #define MTK_WED_EXT_INT_STATUS_TX_FBUF_HI_TH		BIT(9)
-#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(12)
-#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(13)
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(10) /* wed v2 */
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(11) /* wed v2 */
 #define MTK_WED_EXT_INT_STATUS_RX_DRV_R_RESP_ERR	BIT(16)
 #define MTK_WED_EXT_INT_STATUS_RX_DRV_W_RESP_ERR	BIT(17)
 #define MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT		BIT(18)
-- 
2.41.0


