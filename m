Return-Path: <netdev+bounces-226900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527CBA6051
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2827A7A77
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7E2E2F1A;
	Sat, 27 Sep 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLBvfjbG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D045279351;
	Sat, 27 Sep 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981853; cv=none; b=WuHumcY7iI/37Z8bvyhX2h9p2yf4w5vP1DBEHEJChvdmLl1ZIs8bkMfkfiJByR8D50bA5CVR4n+oqmeWXDPDooejC5Fiqm2X+n93V8nSlj6VFYbjZJiW8RsZCzC6nhDdva7ISZbt35Rq6+bIJapgx8XP8mzHNzgFO8ZnreIMnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981853; c=relaxed/simple;
	bh=zKz5W5a/bYoV41kuFP8JGCYMqCLf0l+xh3vHJjLoYTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yz5MaF2ckiUgcB61ybUiW6HqUVdmw1I0TUM3St88kSoMTi9Igjm0JFWJ/G/ywqj9f0BKhr+F4oxx9W/Q1LE/e2StRJFj9NMDAJGZDGtm8PPBtz8aJ2TD1njQsN644E5VHXruJhs0tejk6mqk+BLOg5vWbq2xLYePSSBi78EATsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLBvfjbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA5C4CEF7;
	Sat, 27 Sep 2025 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758981852;
	bh=zKz5W5a/bYoV41kuFP8JGCYMqCLf0l+xh3vHJjLoYTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BLBvfjbGmkYx2JKf2TI+gzDX4ZsWq3IzNTsng421LaMnMMr2l9LIu8tekq3ES24kg
	 Cy4y91IKXeyZ63nUHg+g/OkZRq43AlsNZhps/y8nLTfwFQB3XyXIfxy71zzgupUdHD
	 3w7aqiPBBNie5GdmzIVup2qgnr8NrGy5qUcCRbnb8VUKyVsfwDWRHxWKUb6vOX3zOq
	 huUclHjuWxETUdXAi1bp+9DgRZBWChMowI9i3rjHc4qDMRAwgzqk8vuC9r4UeduwPp
	 oReXNIFIxZnA2SFPH+vHmYoKWgCjhANPv1pJeobRvg/8XjvKoMI7yDAO+LD+0t9f63
	 59nDjOTGseo7A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 27 Sep 2025 16:03:42 +0200
Subject: [PATCH net-next v2 3/3] net: airoha: npu: Add 7583 SoC support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-airoha-npu-7583-v2-3-e12fac5cce1f@kernel.org>
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


