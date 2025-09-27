Return-Path: <netdev+bounces-226899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F4BA6042
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CEE3280B1
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9472E36EC;
	Sat, 27 Sep 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmnNOz6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D642E2F1A;
	Sat, 27 Sep 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981850; cv=none; b=GQvGoJa9FiEPYBYx5LLIHdwykxPzTpAP408Kpu1JTT9OsxRW6Orr1yuVg5c68LKZRd3lMsNgOxpFhAi2zK/s5tfs9wY3rrEUQOjR1qwPEpb7gW6N3DhtM/xziGNUGlseQRYc5v6x2xmJSNewhxe7wh3VtUV8EFHOANH5UJK/Jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981850; c=relaxed/simple;
	bh=oZNjK/4YkXKBAfZRaTcNP360qMktPQ4k62wG/OV1jdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdRpQdB44UMm7hw8GWDmFvfA7BQKsVJ3l1klYM+oGBvy5OxcZpq9mnJzpUFlanwdlNTttKJCF/hP9LB1ZQZI5I7V4swOK0Qa65JCLEqnPp1beWNNjbXzd3FJJa4burj0tKmoaobCT3dzuw4QfzoGqgvTqC5jWx5Tvo1u58wgCic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmnNOz6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE652C113CF;
	Sat, 27 Sep 2025 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758981850;
	bh=oZNjK/4YkXKBAfZRaTcNP360qMktPQ4k62wG/OV1jdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rmnNOz6GYHaPpr/Ur5N1WRbWUGyYd76XOsTc4sR0AN+EiVM5WbZY4RulcQDd1IBAY
	 EyWvNcBGEF0EcRvBPTrPwc8aila/+QXEPNNqjx0kAL+pBTcAngQa8y8zDFrzGUi4u+
	 TEZGO0srUm4BB3g6nxE29k/mDi5+6HlsEIS2rsusdhCukse1C4f7TtO4nzIPxy1tAH
	 d6eICDMdf21DJ/+gnmNdbrZh0lBv+JL5J4PwJIUljx65cbtng3DrOecYQY75v8w7Wa
	 KmHlZMxYlRFy60Ar2rLd0Wf21VpIBLFop/xeHLNUNFtoA7+CkouqNjBe2XpCWc4q8+
	 zo+01I1sJy9pg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 27 Sep 2025 16:03:41 +0200
Subject: [PATCH net-next v2 2/3] net: airoha: npu: Add airoha_npu_soc_data
 struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-airoha-npu-7583-v2-2-e12fac5cce1f@kernel.org>
References: <20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org>
In-Reply-To: <20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce airoha_npu_soc_data structure in order to generalize per-SoC
NPU firmware info. Introduce airoha_npu_load_firmware utility routine.
This is a preliminary patch in order to introduce AN7583 NPU support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 77 +++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 8c883f2b2d36b74053282bc299f0a0572b2e0e71..41944cc5f6b062129528e9357511fd9e05cbe1e6 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -103,6 +103,16 @@ enum {
 	QDMA_WAN_PON_XDSL,
 };
 
+struct airoha_npu_fw {
+	const char *name;
+	int max_size;
+};
+
+struct airoha_npu_soc_data {
+	struct airoha_npu_fw fw_rv32;
+	struct airoha_npu_fw fw_data;
+};
+
 #define MBOX_MSG_FUNC_ID	GENMASK(14, 11)
 #define MBOX_MSG_STATIC_BUF	BIT(5)
 #define MBOX_MSG_STATUS		GENMASK(4, 2)
@@ -182,49 +192,53 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	return ret;
 }
 
-static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
-				   struct resource *res)
+static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
+				    const struct airoha_npu_fw *fw_info)
 {
 	const struct firmware *fw;
-	void __iomem *addr;
 	int ret;
 
-	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
+	ret = request_firmware(&fw, fw_info->name, dev);
 	if (ret)
 		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 
-	if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
+	if (fw->size > fw_info->max_size) {
 		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
-			NPU_EN7581_FIRMWARE_RV32, fw->size);
+			fw_info->name, fw->size);
 		ret = -E2BIG;
 		goto out;
 	}
 
-	addr = devm_ioremap_resource(dev, res);
-	if (IS_ERR(addr)) {
-		ret = PTR_ERR(addr);
-		goto out;
-	}
-
 	memcpy_toio(addr, fw->data, fw->size);
+out:
 	release_firmware(fw);
 
-	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
-	if (ret)
-		return ret == -ENOENT ? -EPROBE_DEFER : ret;
+	return ret;
+}
 
-	if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
-		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
-			NPU_EN7581_FIRMWARE_DATA, fw->size);
-		ret = -E2BIG;
-		goto out;
-	}
+static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
+				   struct resource *res)
+{
+	const struct airoha_npu_soc_data *soc;
+	void __iomem *addr;
+	int ret;
 
-	memcpy_toio(base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
-out:
-	release_firmware(fw);
+	soc = of_device_get_match_data(dev);
+	if (!soc)
+		return -EINVAL;
 
-	return ret;
+	addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+
+	/* Load rv32 npu firmware */
+	ret = airoha_npu_load_firmware(dev, addr, &soc->fw_rv32);
+	if (ret)
+		return ret;
+
+	/* Load data npu firmware */
+	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
+					&soc->fw_data);
 }
 
 static irqreturn_t airoha_npu_mbox_handler(int irq, void *npu_instance)
@@ -597,8 +611,19 @@ void airoha_npu_put(struct airoha_npu *npu)
 }
 EXPORT_SYMBOL_GPL(airoha_npu_put);
 
+static const struct airoha_npu_soc_data en7581_npu_soc_data = {
+	.fw_rv32 = {
+		.name = NPU_EN7581_FIRMWARE_RV32,
+		.max_size = NPU_EN7581_FIRMWARE_RV32_MAX_SIZE,
+	},
+	.fw_data = {
+		.name = NPU_EN7581_FIRMWARE_DATA,
+		.max_size = NPU_EN7581_FIRMWARE_DATA_MAX_SIZE,
+	},
+};
+
 static const struct of_device_id of_airoha_npu_match[] = {
-	{ .compatible = "airoha,en7581-npu" },
+	{ .compatible = "airoha,en7581-npu", .data = &en7581_npu_soc_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_airoha_npu_match);

-- 
2.51.0


