Return-Path: <netdev+bounces-182607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B4A89492
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA871894CE6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DD27991C;
	Tue, 15 Apr 2025 07:12:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785932798F0;
	Tue, 15 Apr 2025 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701158; cv=none; b=J/BOruocBq2ie3ni6J61arz35CuXgvGf9jxb6pQhUYzqCKiJn5ZLR6TwWuve7hwxLI3rZqKZapLTKb63MDvnnao/fAt14V6/nJirrNYmp4K8GI/HndT17/pz4Y9H0aNJ6t5KOMpa2lj2yTiauCKC3nH9TyMqiz71Py82EMV4PU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701158; c=relaxed/simple;
	bh=0XYQ3xxrZF3WfZN9FqWETZ1jAFrpntni4O6B5osTG4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJd/fXcf9rsYs0Z+suMAXayMoD1WJrCSG+2vXwlWaPlv18jIr7NnyfuKrn+HWkPTAdFX5/Y7LcC5TcE9t/caxA0YENw7/Rslas/lI5OOAf6M1rt+H0ze2ZxhWTPxY7BkqdR5UndZu7SF8Hacp5Gfcrzf24jIDBI1k8NiXbCieH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.238])
	by gateway (Coremail) with SMTP id _____8DxvnPhBv5nNYq9AA--.19626S3;
	Tue, 15 Apr 2025 15:12:33 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.238])
	by front1 (Coremail) with SMTP id qMiowMBxGcS1Bv5ni3SCAA--.35528S5;
	Tue, 15 Apr 2025 15:12:30 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chris.chenfeiyang@gmail.com>,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: [PATCH net-next 3/3] net: stmmac: dwmac-loongson: Add new GMAC's PCI device ID support
Date: Tue, 15 Apr 2025 15:11:28 +0800
Message-ID: <20250415071128.3774235-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415071128.3774235-1-chenhuacai@loongson.cn>
References: <20250415071128.3774235-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxGcS1Bv5ni3SCAA--.35528S5
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWrtrWUurW7AFyUZFyUXFc_yoW8tF4Dpr
	13Za9FgrZ3JF4rCanYqrWDWry5AFZ8G3srCF4Iyw4jgF9xJ34jq3sF9Fs8Ary7urWrXFyI
	vrWkCw48CFs8KwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_WrPUUUUU==

Add a new GMAC's PCI device ID (0x7a23) support which is used in
Loongson-2K3000/Loongson-3B6000M. The new GMAC device use external PHY,
so it reuses loongson_gmac_data() as the old GMAC device (0x7a03), and
the new GMAC device still doesn't support flow control now.

Tested-by: Biao Dong <dongbiao@loongson.cn>
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 3f8949547f88..b040a605b4a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -66,7 +66,8 @@
 					 DMA_STATUS_TPS | DMA_STATUS_TI  | \
 					 DMA_STATUS_MSK_COMMON_LOONGSON)
 
-#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_GMAC1	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_GMAC2	0x7a23
 #define PCI_DEVICE_ID_LOONGSON_GNET	0x7a13
 #define DWMAC_CORE_MULTICHAN_V1	0x10	/* Loongson custom ID 0x10 */
 #define DWMAC_CORE_MULTICHAN_V2	0x12	/* Loongson custom ID 0x12 */
@@ -372,7 +373,7 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
 	/* Loongson GMAC doesn't support the flow control. Loongson GNET
 	 * without multi-channel doesn't support the half-duplex link mode.
 	 */
-	if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
+	if (pdev->device != PCI_DEVICE_ID_LOONGSON_GNET) {
 		mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
 	} else {
 		if (ld->multichan)
@@ -660,7 +661,8 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
 			 loongson_dwmac_resume);
 
 static const struct pci_device_id loongson_dwmac_id_table[] = {
-	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
+	{ PCI_DEVICE_DATA(LOONGSON, GMAC1, &loongson_gmac_pci_info) },
+	{ PCI_DEVICE_DATA(LOONGSON, GMAC2, &loongson_gmac_pci_info) },
 	{ PCI_DEVICE_DATA(LOONGSON, GNET, &loongson_gnet_pci_info) },
 	{}
 };
-- 
2.47.1


