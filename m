Return-Path: <netdev+bounces-91306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F458B2226
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04D41F23DCD
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDE2149C40;
	Thu, 25 Apr 2024 13:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5C71494CA
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050153; cv=none; b=BuOKNH6Sble6bEMYUHl90smWoCZ/xascu6hhPbh0iGYnPqy18W7QwNClHkYvj3XdOm/E0xaUpiW8oBkKPTOmgXq8yEsJl+He306Dmd7wxTsYvLLgyZW88soV6NM50zRmOr9F3w53/5mCF6phRUjY1hkyWGEU6TVtLXw8H+JmMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050153; c=relaxed/simple;
	bh=LovWpFjGIgETP6Tc6EbMyVlquGcqtqj6EOngiO891TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uje+tJZgTC5NoLrsBkZV7Paj+VJUhKXD6Vn0rZWDsnAuu7TcSrRWaVWRt3nAV0XJGQ84bvyBjy3Ps/KfQG0Q3pM7c3cFt01vh9dCFsQ/qA5mzmjv4M0L3nK5itlGlTK5dvcIW+zErtvTbXtlOVJgPKZuZJjiFE3beZdXD9YxyhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxJvBlVCpmzM8CAA--.13082S3;
	Thu, 25 Apr 2024 21:02:29 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxQ1ZbVCpmChkFAA--.1253S5;
	Thu, 25 Apr 2024 21:02:28 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	siyanteng01@gmail.com
Subject: [PATCH net-next v12 03/15] net: stmmac: Export dwmac1000_dma_ops
Date: Thu, 25 Apr 2024 21:01:56 +0800
Message-Id: <12eab04fb430b58574731fbab98ee1354f91100c.1714046812.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1714046812.git.siyanteng@loongson.cn>
References: <cover.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxQ1ZbVCpmChkFAA--.1253S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw17ZrW3Zry7GF1ftr1xXrc_yoWfXrc_u3
	W2qwn3Wa1Dtr42yr1jq3y5ZryFvrykuF1SkFsFqayfZa1vqr95Ja4kur1kJr15u3y5ZFn8
	Gr1IqFyIyw1xtosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjBT5UUUUU=

The loongson gnet will call it in the future.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index f161ec9ac490..66c0c22908b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -296,3 +296,4 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
 	.get_hw_feature = dwmac1000_get_hw_feature,
 	.rx_watchdog = dwmac1000_rx_watchdog,
 };
+EXPORT_SYMBOL_GPL(dwmac1000_dma_ops);
-- 
2.31.4


