Return-Path: <netdev+bounces-191901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF65ABDD3F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AB37B0D00
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3024290D;
	Tue, 20 May 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ+9q0fJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A01AF0C8
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751623; cv=none; b=YVpMN9VraM4uGt7KqSjPKUobss6rhuY7/gOJTTvdAFLb92OiLni8yYmimUIzJmUFgD50a8DoF8SawitsvE1sCSgE92iFb6C6uJXmK3mvtqMvyT4gt5wq7ci/0VgHDp9dH13HXU/zeUb3W1DRg+UVQ0z/AdIe+MphEnjLVsrO3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751623; c=relaxed/simple;
	bh=UQfJvh5021ymW/G9gh8EoO5JxCDWd0uvGKSwEiCv7E0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rpci/PyRnARE3ERpVZL1hprw2j956yXy2NhubQIhGlUAzhCl51TuZoF9JGjX+adAXJSkq63VzS4DH3Rw42dkpTa22sWWBevGmqF5yqGgW9hJ/M2p/iwJf+TUkB6lREEtw48suLXfKGth16YJ7rol+Hp5K9/pamUdHPAJRimRT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ+9q0fJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA936C4CEE9;
	Tue, 20 May 2025 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747751623;
	bh=UQfJvh5021ymW/G9gh8EoO5JxCDWd0uvGKSwEiCv7E0=;
	h=From:Date:Subject:To:Cc:From;
	b=aQ+9q0fJXMJ5lhQGGKqFh6loEs0vjEb6JRqQQ5HsCoHvFfDZLI16YBJz0tutRCM3F
	 jCgySkrVHzmVJEPK13z5akCdb/IH66xjUKCxxxCp3nl76laRzsvYEEMJtBiNgIYHW/
	 ck2j5KHcbe0Mb4He57DsNDw80uLol8KERhGPire9X24KCs5oSSCZ2aYpiqCK7XefYJ
	 gXi+IwmPZNZf3mEjtCclQRmaL6XmtQqD03EN2C0MZPspPBcolP2QdcJABVkvjg73ZF
	 OI6hdwF0MYYvT6ptoLHaINQgLLLbFBD/ts4WtYXqWUue2P3O+Lv2Oo65na/u600bnx
	 Uvb6XyGha8GqA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 20 May 2025 15:33:33 +0100
Subject: [PATCH net-next] net: ethernet: mtk_eth_soc: Correct spelling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-mtk-spell-v1-1-2b0d5b4a4528@kernel.org>
X-B4-Tracking: v=1; b=H4sIALySLGgC/x3MQQqEMBAF0atIr22IjYp6FXERxz/aqFGSIIJ49
 wmzfFDUQwFeEajLHvK4NOjhEoo8o89i3QzWKZnESGUqMbzHlcOJbeNxktKiltY2llJ/enz1/r9
 6cojscEca3vcHWMSozGUAAAA=
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.0

Correct spelling of platforms, various, and initial.
As flagged by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 4 ++--
 drivers/net/ethernet/mediatek/mtk_wed.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 2d4b9964d3db..6f72a8c8ae1e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1178,7 +1178,7 @@ struct mtk_reg_map {
 };
 
 /* struct mtk_eth_data -	This is the structure holding all differences
- *				among various plaforms
+ *				among various platforms
  * @reg_map			Soc register map.
  * @ana_rgc3:                   The offset for register ANA_RGC3 related to
  *				sgmiisys syscon
@@ -1278,7 +1278,7 @@ struct mtk_soc_data {
  * @mii_bus:		If there is a bus we need to create an instance for it
  * @pending_work:	The workqueue used to reset the dma ring
  * @state:		Initialization and runtime state of the device
- * @soc:		Holding specific data among vaious SoCs
+ * @soc:		Holding specific data among various SoCs
  */
 
 struct mtk_eth {
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index e212a4ba9275..351dd152f4f3 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2000,7 +2000,7 @@ mtk_wed_configure_irq(struct mtk_wed_device *dev, u32 irq_mask)
 		if (mtk_wed_is_v3_or_greater(dev->hw))
 			wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_TX_TKID_ALI_EN);
 
-		/* initail tx interrupt trigger */
+		/* initial tx interrupt trigger */
 		wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_TX,
 			MTK_WED_WPDMA_INT_CTRL_TX0_DONE_EN |
 			MTK_WED_WPDMA_INT_CTRL_TX0_DONE_CLR |
@@ -2011,7 +2011,7 @@ mtk_wed_configure_irq(struct mtk_wed_device *dev, u32 irq_mask)
 			FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_TX1_DONE_TRIG,
 				   dev->wlan.tx_tbit[1]));
 
-		/* initail txfree interrupt trigger */
+		/* initial txfree interrupt trigger */
 		wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_TX_FREE,
 			MTK_WED_WPDMA_INT_CTRL_TX_FREE_DONE_EN |
 			MTK_WED_WPDMA_INT_CTRL_TX_FREE_DONE_CLR |


