Return-Path: <netdev+bounces-226726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4FBA4764
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25547408C2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717C21CC68;
	Fri, 26 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+Ldgd1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AF10FD;
	Fri, 26 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901420; cv=none; b=eY5xvvSQSebMvfEUFUhGuYBfFBW7jKblUBGR44BsgKWMKl2lEJAgoyNpyX+oBS3Wtz7XNTHj3wEV1+Dm9tCFGljaMEkzlkhX0ja/MMym6461T+9faGgZxazhZXtVSGX3ijBWTs6So+nbEliWld50B30yjQXmGE95BtFg2btoo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901420; c=relaxed/simple;
	bh=kpbuVipwR3UDHudSxLrP3Qb2ukZs0ZVbkYJ/4xwHids=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWg3i0MXFbIBFnapcWoi+YglRFf6KWN98ZjbMkhloGffrm+/8Wp8YdF2Wfcfet6+uVsKLMJqx2wQMBRXtAgQhpiPcMLzK2ZhdFb8/ixgYiHFxX2wLi245v76OM6eTKiCG2gSwpz7R1HqagbpE+dXwQZWSYIJEUzvU292lNZNhqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+Ldgd1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD884C4CEF7;
	Fri, 26 Sep 2025 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758901419;
	bh=kpbuVipwR3UDHudSxLrP3Qb2ukZs0ZVbkYJ/4xwHids=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I+Ldgd1mdt2RuSctsDUVZw9rhRj7eWwTc898dlk2xpIf1bwRMu41LDOgNZOs0zfL4
	 zhO8GfwHD6ENdNuBXG4oc/K0l9G75MJArzWz2Qe+Wfb7193r9IRDR/YL7jpQ8Jz81A
	 TI+s8FZyrzRyJp1en0wrPRBRNha7e31/zIKuAd1jGLs+baP865THTl+bFyhBtnvIxQ
	 lCWGrsNR92h8Ra/DLUoEOZn6vTaiNepKC5rQVUenY7nxNZt2+ke2uNUx7+JAC6m78Q
	 3FYj3TzhfwYtJ7R0WysX3ygnffOlXi+66Zwkn6fzhl4yji0XZAO8qH4KFuR/n3JuxJ
	 Ret3miDarOazw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 26 Sep 2025 17:43:23 +0200
Subject: [PATCH net-next 2/2] net: airoha: npu: Add 7583 SoC support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-airoha-npu-7583-v1-2-447e5e2df08d@kernel.org>
References: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
In-Reply-To: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce support for Airoha 7583 SoC NPU selecting proper firmware images.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index e1d131d6115c10b40a56b63427eec59ea587d22a..fee611666aa0debf77165d9b10abecceb756ea97 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -16,6 +16,8 @@
 
 #define NPU_EN7581_FIRMWARE_DATA		"airoha/en7581_npu_data.bin"
 #define NPU_EN7581_FIRMWARE_RV32		"airoha/en7581_npu_rv32.bin"
+#define NPU_AN7583_FIRMWARE_DATA		"airoha/an7583_npu_data.bin"
+#define NPU_AN7583_FIRMWARE_RV32		"airoha/an7583_npu_rv32.bin"
 #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
 #define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
 #define NPU_DUMP_SIZE				512
@@ -186,10 +188,15 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 				   struct resource *res)
 {
 	const struct firmware *fw;
+	const char *fw_name;
 	void __iomem *addr;
 	int ret;
 
-	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
+	if (of_device_is_compatible(dev->of_node, "airoha,an7583-npu"))
+		fw_name = NPU_AN7583_FIRMWARE_RV32;
+	else
+		fw_name = NPU_EN7581_FIRMWARE_RV32;
+	ret = request_firmware(&fw, fw_name, dev);
 	if (ret)
 		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 
@@ -209,7 +216,11 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 	memcpy_toio(addr, fw->data, fw->size);
 	release_firmware(fw);
 
-	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
+	if (of_device_is_compatible(dev->of_node, "airoha,an7583-npu"))
+		fw_name = NPU_AN7583_FIRMWARE_DATA;
+	else
+		fw_name = NPU_EN7581_FIRMWARE_DATA;
+	ret = request_firmware(&fw, fw_name, dev);
 	if (ret)
 		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 
@@ -612,6 +623,7 @@ EXPORT_SYMBOL_GPL(airoha_npu_put);
 
 static const struct of_device_id of_airoha_npu_match[] = {
 	{ .compatible = "airoha,en7581-npu" },
+	{ .compatible = "airoha,an7583-npu" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_airoha_npu_match);
@@ -749,6 +761,8 @@ module_platform_driver(airoha_npu_driver);
 
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_RV32);
+MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_DATA);
+MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_RV32);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("Airoha Network Processor Unit driver");

-- 
2.51.0


