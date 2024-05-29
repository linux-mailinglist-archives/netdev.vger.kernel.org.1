Return-Path: <netdev+bounces-98982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92A8D347A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491EB1C241B4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D873017BB31;
	Wed, 29 May 2024 10:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36717B43A
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978088; cv=none; b=hhjITBCjFCJb3DUHyTSTJTrjUXKLHSn942XOko39RbbyJDlJ7y2ntl13+li9nNZ9sOmlVh0O4eEez27Dwro3Pb/QlvKcholc3aqDqJ3sMmblRgxtC7/SBxdyWh+Vnqvw74AsUj6rSXkCctLfaAEANFoRhbqiLgr7ZLMUoiHtRek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978088; c=relaxed/simple;
	bh=p32kceePqt2XLI9REpfTyNRuAVlV9bKE8Ek9hq9kPJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNAOQ3MIG9JU5/PkKH+/himAWuuzIg/IUFRF38JPCZe/c5yr2dNxt0BddWmbXdBuMAsQ4UpKWY9pcbTf07SYX3mwKmclxb0Ld7/p7C6zuGJA2OJRFQTEXQZO/xf/zBjcRgFLtWvVVnjtpaYdtLtc/fEKYHapZhn4ZnWzPmvC7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8AxUPCmAVdmXhkBAA--.4874S3;
	Wed, 29 May 2024 18:21:26 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMWhAVdm8d4MAA--.23145S4;
	Wed, 29 May 2024 18:21:25 +0800 (CST)
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
	si.yanteng@linux.dev
Subject: [PATCH net-next v13 15/15] net: stmmac: dwmac-loongson: Add loongson module author
Date: Wed, 29 May 2024 18:21:10 +0800
Message-Id: <94cb880475efa97d211bff16413cfeaa104e68f4.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxBMWhAVdm8d4MAA--.23145S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw1ftw4kuw18tFW7ZF4rXrc_yoWfKrg_GF
	W2vrn3JF1UGr1ak3s8W3y5ZryS9FyDW3WSkF12kas5ua12vwn8Jr95ur9xJF13urWrZFn0
	qF1ftr1xCw18JosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbv8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVW8
	Xw0E3s1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYyMKtUUUUU==

Add Yanteng Si as MODULE_AUTHOR of  Loongson DWMAC PCI driver.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 559215e3fe41..9f39657f71f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -645,4 +645,5 @@ module_pci_driver(loongson_dwmac_driver);
 
 MODULE_DESCRIPTION("Loongson DWMAC PCI driver");
 MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
+MODULE_AUTHOR("Yanteng Si <siyanteng@loongson.cn>");
 MODULE_LICENSE("GPL v2");
-- 
2.31.4


