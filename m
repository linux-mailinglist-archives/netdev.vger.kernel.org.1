Return-Path: <netdev+bounces-112405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0D938DD2
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 13:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320281C21021
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38416C852;
	Mon, 22 Jul 2024 11:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411C5161936
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646112; cv=none; b=UpbF3OdPzBAcahphfK57EgmCtrjw3KG4wOtCGSc4uHpX5EmP5tEWoup5ZUosOrzrxbshQw5rkTtF1iI9VaUu1fLGZU7quNGhC92WjKMsjq9K5ruXUUYKtB/UEb+fxleeNSqQF/GM3vU1l9pER/aYw7sLn+7C0zDfMZp7jrR2Wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646112; c=relaxed/simple;
	bh=6h/7SajPiCin0UkJyp1APfVi8raHzC7o7vGnNP35rG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ba3WH0lCR3mkVWq4B7qWITqpJN7BPMhKEwOkL3oVQlu+qbvbhsqLXSiyTvGmHtyAbJnavaxX3iGJ3qyfraGfXTVvZizeqtgBOPP8Z4zRGwPTDbiBkHVbTTeKh7HDtE10TdL+kXOkZWbDUzpGBRzbWGkKrrzhdInLjTi86Y8nA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from localhost.localdomain (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxMMQTPJ5mtBtUAA--.19050S3;
	Mon, 22 Jul 2024 19:01:42 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com,
	diasyzhang@tencent.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH net-next RFC v15 14/14] net: stmmac: dwmac-loongson: Add loongson module author
Date: Mon, 22 Jul 2024 19:01:39 +0800
Message-Id: <a9320bffb9ae6bca71fc687069f39ed68b59d8ee.1721645682.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1721645682.git.siyanteng@loongson.cn>
References: <cover.1721645682.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxMMQTPJ5mtBtUAA--.19050S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1ftw4kuFy3Gr17JFykGrg_yoWDXFg_GF
	W2vrn3GF1UJrWSk345W3y5Zrya9ryDWa1Sk3ZFkas3Wa12vwn8Jr95urnxJF13CrWrZFnI
	qF4fJr1xCw18JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbyAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
	0xZFpf9x0pRE_MfUUUUU=
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/

Add Yanteng Si as MODULE_AUTHOR of  Loongson DWMAC PCI driver.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index f84b8c573be6..91fbae31f892 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -689,4 +689,5 @@ module_pci_driver(loongson_dwmac_driver);
 
 MODULE_DESCRIPTION("Loongson DWMAC PCI driver");
 MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
+MODULE_AUTHOR("Yanteng Si <siyanteng@loongson.cn>");
 MODULE_LICENSE("GPL v2");
-- 
2.31.4


