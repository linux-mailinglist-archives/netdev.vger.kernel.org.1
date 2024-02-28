Return-Path: <netdev+bounces-75660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE786ACEE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF3D1C2127C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAD112D77B;
	Wed, 28 Feb 2024 11:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D77212A149
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119507; cv=none; b=dm9RpKgvbTkDgOzGfFfQuY6CIws/HdSKtBxP+hFeNiLK418e7bqHfhhogA2ca5VxRscYXhhFA/ExVwWno4+yWpdisYZrJqQ8onSJFbYwmX/AHzg7Be92qUs9hO6UvY0VNTESjhXjsI/UA2IPRhRlUedFXl67S1Gjbe41h+VWEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119507; c=relaxed/simple;
	bh=tY16Q7YWGq7CSXdw0p6amLbnBGGXkxFFOjyoYxLfA48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=awRQ5p/bV64I0OmakKu418G6N1Zrzkaus+uWSDdKdeWv87vC/4h9ty5W1W+Hwj4j2QOLqoY4HCq6zzw9TrUAMEyBYSDGONcAYrBW72NdkIPT1x5PlWT9XgBXFPzbmhRssW0nfullD1uqi2roca2RaEX0ZUEPKULS+BDU9eTE/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.193])
	by gateway (Coremail) with SMTP id _____8BxHOsOGN9lgmESAA--.36696S3;
	Wed, 28 Feb 2024 19:25:02 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.193])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHBMMGN9lD8xJAA--.65S2;
	Wed, 28 Feb 2024 19:25:01 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	alexandre.torgue@foss.st.com
Cc: kuba@kernel.org,
	joabreu@synopsys.com,
	davem@davemloft.net,
	horms@kernel.org,
	fancer.lancer@gmail.com,
	netdev@vger.kernel.org,
	Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH net-next v2] net: stmmac: fix typo in comment
Date: Wed, 28 Feb 2024 19:24:47 +0800
Message-Id: <20240228112447.1490926-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxHBMMGN9lD8xJAA--.65S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFyUJFyrZr1fur1kWFy3trc_yoWDWrXEga
	1a9F1fWws8CFWFyw45JFW5uw4F9F1DWr18urn5Ka4a9a1jqwn8Xr9Y9rWkXFn5Wws3uF1D
	urnrtrn2y34xtosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxxhLUUUUU

This is just a trivial fix for a typo in a comment, no functional
changes.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
Drop fix tag and pick Serge's Reviewed-by tag.
"channels oriented" -> "channel-oriented"

 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 358e7dcb6a9a..9d640ba5c323 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -92,7 +92,7 @@
 #define DMA_TBS_FTOV			BIT(0)
 #define DMA_TBS_DEF_FTOS		(DMA_TBS_FTOS | DMA_TBS_FTOV)
 
-/* Following DMA defines are chanels oriented */
+/* Following DMA defines are channel-oriented */
 #define DMA_CHAN_BASE_ADDR		0x00001100
 #define DMA_CHAN_BASE_OFFSET		0x80
 
-- 
2.31.4


