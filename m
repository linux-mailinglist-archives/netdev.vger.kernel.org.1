Return-Path: <netdev+bounces-73606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122BE85D5AF
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2381C21A9A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149AE7F8;
	Wed, 21 Feb 2024 10:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA5443F
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511737; cv=none; b=gsaqA7lWL08nlu9pAmwCcVs5uq19kdTLwVUGcrYEGf8CN/V8hiHI3L2hpaDLmJydkjrpZSFWMwrwY1Z7RUctD7Mm6lZmL0vc/ezWxt/C6ZHpgyPhMvphCDWCloJnZKbiCh9Hr1qmCSpw2LUn/dmJqxMIWBwLBGOMagnam6mXbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511737; c=relaxed/simple;
	bh=LLGEvBkjPI6PfzYpSJ+GbWmjrMg85JwaG1WSFU6uT5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XSzYnNOLEUFYHwX04bpmLNE4s0wpMJDCyUDJO0DJ5OjrRunLnspNhgY8ykjUSx5fd8nY9Xp6ftwKQCPg++aXXTm1KK4+R4ujPRNNRFnYU8vtiJO7vILNvpg94NNxWZP+S1qBesXr9IfOevvjjQ5Eog2tQ71b3xl+BE9JTiYpZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.46])
	by gateway (Coremail) with SMTP id _____8CxifD00dVl8scPAA--.41333S3;
	Wed, 21 Feb 2024 18:35:32 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.108.46])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs3y0dVlJss9AA--.26964S2;
	Wed, 21 Feb 2024 18:35:31 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	alexandre.torgue@foss.st.com
Cc: joabreu@synopsys.com,
	davem@davemloft.net,
	horms@kernel.org,
	fancer.lancer@gmail.com,
	netdev@vger.kernel.org,
	Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH net-next] net: stmmac: fix typo in comment
Date: Wed, 21 Feb 2024 18:35:14 +0800
Message-Id: <20240221103514.968815-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTs3y0dVlJss9AA--.26964S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFyUXr1DuFWfZr1rKw13KFX_yoWDXFg_WF
	4a9F17Xw4YkF4Fyw45GFy5ur4F9rn8Wr109rn8Ka4a9ayjqwn8X3s5ury0qrn5Ww4fZF1D
	ur1xtFn7A3s2qosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU466zUUUUU

This is just a trivial fix for a typo in a comment, no functional
changes.

Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
In fact, it was discovered during the review of the Loongson
driver patch.:)

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
+/* Following DMA defines are channels oriented */
 #define DMA_CHAN_BASE_ADDR		0x00001100
 #define DMA_CHAN_BASE_OFFSET		0x80
 
-- 
2.31.4


