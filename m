Return-Path: <netdev+bounces-228729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA0BD3511
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD056189E69E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B3E2580F2;
	Mon, 13 Oct 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz9C6O5Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DF623D7D3;
	Mon, 13 Oct 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363958; cv=none; b=e6Wew+lGUI+buKGFAzFzgDthyyarDbIJejc+7Uy6SCbuI1sxXdST4Zxd+zkCMPWlEglzUYhiuj3De3hs9O3i0iXFcaVGY/hcFe5++7uXN5bLeLZaTbRwir49EoDjDivU2FY7my5y7TOEOR6SuSMoAWeOif+ZA17f44untlcKdgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363958; c=relaxed/simple;
	bh=zKz5W5a/bYoV41kuFP8JGCYMqCLf0l+xh3vHJjLoYTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiLHEMW5oN88brT8weoLauuzFxMzERbhcVNpAcHTOQF3EVNW5/mxfpNmWE8axXpMiuzgBc6bMBDAaKqctEtCb8dYaQc+UTtXYpc0uw3U6EhMof+deeYVIwciJu99ui7xd3wzW8OqsSE+p5mfhBOkYG91goxtYuMlSfKYk3UEZ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz9C6O5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB80EC116C6;
	Mon, 13 Oct 2025 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760363958;
	bh=zKz5W5a/bYoV41kuFP8JGCYMqCLf0l+xh3vHJjLoYTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rz9C6O5Zko1ECNql84AFQau2NX/wvm1Q8RlorchtOi3Xnk696R6uevIrOvnAk0jpE
	 wY0WNs4suzVa9sJy69fCrqGAhvDitq0AVlYbr2dabT/NHY60flePExSKxmk8Hkz0tz
	 GUtwozyr+uw1DysBGU/q7oWIOx6QBGZaqageG+bmFx64UDWaOLyE71a1qmhO9S9zTa
	 KC3xrCxWkIOuTHJvxB4hPXP3wim3TAlN00VEFQNdFWlRGXw1iNUCRy5gVedBg80Nlr
	 LyiZ557HVG+V7wo8t1wE08olRqZIMHhNnCFXyud1KaN8owq/PNDiaN4nnz/dnbo6+Y
	 wk8dI9c38ihWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 13 Oct 2025 15:58:51 +0200
Subject: [PATCH net-next v3 3/3] net: airoha: npu: Add 7583 SoC support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-airoha-npu-7583-v3-3-00f748b5a0c7@kernel.org>
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
In-Reply-To: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce support for Airoha 7583 SoC NPU selecting proper firmware images.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 41944cc5f6b062129528e9357511fd9e05cbe1e6..68b7f9684dc7f3912493876ae937207f55b81330 100644
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
@@ -622,8 +624,20 @@ static const struct airoha_npu_soc_data en7581_npu_soc_data = {
 	},
 };
 
+static const struct airoha_npu_soc_data an7583_npu_soc_data = {
+	.fw_rv32 = {
+		.name = NPU_AN7583_FIRMWARE_RV32,
+		.max_size = NPU_EN7581_FIRMWARE_RV32_MAX_SIZE,
+	},
+	.fw_data = {
+		.name = NPU_AN7583_FIRMWARE_DATA,
+		.max_size = NPU_EN7581_FIRMWARE_DATA_MAX_SIZE,
+	},
+};
+
 static const struct of_device_id of_airoha_npu_match[] = {
 	{ .compatible = "airoha,en7581-npu", .data = &en7581_npu_soc_data },
+	{ .compatible = "airoha,an7583-npu", .data = &an7583_npu_soc_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_airoha_npu_match);
@@ -762,6 +776,8 @@ module_platform_driver(airoha_npu_driver);
 
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_RV32);
+MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_DATA);
+MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_RV32);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("Airoha Network Processor Unit driver");

-- 
2.51.0


