Return-Path: <netdev+bounces-30946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D648478A082
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134A41C20904
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B313FFC;
	Sun, 27 Aug 2023 17:35:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C5111B1
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 17:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A3FC433C8;
	Sun, 27 Aug 2023 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693157707;
	bh=oZoEXwfUFwwLsDBEmCLpSX8x/UrmxknyldKFJSTK3AA=;
	h=From:To:Cc:Subject:Date:From;
	b=IjL6aLbY9SUbeiBACiG+/YXMni5uh+WbZAa/zHt8SM8c5bgr1LLlEARw2pFd8+4Sl
	 I1Bu+1fFwCWgL+JGY2bq8VeKM/4GuHlVZY1X52luxhuOXTQQN8p3ok8PoYjkBoja1e
	 SA+2I2+E4ruSAH2K0I+mjEhdqc3PrD4KyCkFHM57XUqdXsbws/RDhYzL7Zbz97pbp1
	 ot84GPHEaPvSNAXYyFqeziWByswhbHuVDpkobDSgf287ER4JFPUhJlatEutxD28p+B
	 m1KeLc8SuJ274W9SZOMnEGSWx/tZsg++winqNegIbty7VrGNi9Wn35Z0dbcACq/FPb
	 q156aGFUpooCA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com
Subject: [PATCH net-next] net: ethernet: mtk_wed: minor change in wed_{tx,rx}info_show
Date: Sun, 27 Aug 2023 19:33:47 +0200
Message-ID: <71e046c72a978745f0435af265dda610aa9bfbcf.1693157578.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes, just cosmetic ones.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
index 5446d3be1c3a..e24afeaea0da 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
@@ -84,7 +84,6 @@ dump_wed_regs(struct seq_file *s, struct mtk_wed_device *dev,
 	}
 }
 
-
 static int
 wed_txinfo_show(struct seq_file *s, void *data)
 {
@@ -142,10 +141,8 @@ wed_txinfo_show(struct seq_file *s, void *data)
 	struct mtk_wed_hw *hw = s->private;
 	struct mtk_wed_device *dev = hw->wed_dev;
 
-	if (!dev)
-		return 0;
-
-	dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
+	if (dev)
+		dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
 
 	return 0;
 }
@@ -217,10 +214,8 @@ wed_rxinfo_show(struct seq_file *s, void *data)
 	struct mtk_wed_hw *hw = s->private;
 	struct mtk_wed_device *dev = hw->wed_dev;
 
-	if (!dev)
-		return 0;
-
-	dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
+	if (dev)
+		dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
 
 	return 0;
 }
-- 
2.41.0


