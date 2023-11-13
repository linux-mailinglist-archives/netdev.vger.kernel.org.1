Return-Path: <netdev+bounces-47418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1406C7EA248
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FF61F220A0
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D1D224E7;
	Mon, 13 Nov 2023 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="pwJTzAxe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89E22EE2
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:44:50 +0000 (UTC)
X-Greylist: delayed 112 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 09:44:48 PST
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F97B10EC
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:44:48 -0800 (PST)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 20656440CD1;
	Mon, 13 Nov 2023 19:43:46 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1699897426;
	bh=1rfJ16FI/W6yq+b3hiKtTrCWZXLvLTjA0Qnt7vb/GHM=;
	h=From:To:Cc:Subject:Date:From;
	b=pwJTzAxe05o7kyaoBXa9reTmxverBwxARjDofMha4b0ONof7ATlbKEJwilLOukS4L
	 yjlCqrCZySCtKdZc2cp7LWMUv7gw+ZQeQGoa0bDE3rYCJjP8nmJgURBB9RWiFaFVeN
	 QbqkKMyomB4X/qwRsxBcHLBYmfXap7udoC8K6aAH3MJ3QbkwNB3T+EutGT8qSlJx63
	 0P3N5E0BjXnjNUDAXNmLGFZifBcSfRBEvGvRdVyonsOBoiXffG/xOz9CEm+gDUxrLe
	 v8+CEpthMmKADftzu1A/wWPBRQJS/W3wb0VHWNA5MqyFJG+UmlJ9wUL0AdZoGvC7d7
	 85B27yVUFwgnA==
From: Baruch Siach <baruch@tkos.co.il>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH net-next 1/2] net: stmmac: remove extra newline from descriptors display
Date: Mon, 13 Nov 2023 19:44:42 +0200
Message-ID: <8e3121170d479cbe095f985e01fc5e0386f2afff.1699897483.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One newline per line should be enough. Reduce the verbosity of
descriptors dump.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd53a617..39336fe5e89d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6202,7 +6202,6 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
 			p++;
 		}
-		seq_printf(seq, "\n");
 	}
 }
 
-- 
2.42.0


