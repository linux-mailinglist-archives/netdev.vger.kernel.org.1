Return-Path: <netdev+bounces-249365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54AD1742E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6BD3075F3E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28E637FF5B;
	Tue, 13 Jan 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcUSfcg4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA635C1BA;
	Tue, 13 Jan 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292455; cv=none; b=TRBaq5QpCv4V0aHX7AeLnPM+GjvILNIOIQ78rSCJAn/dOti4iAyMm4hBdtsfdn8T+cT2A8KWBl/Bn2u4DTJTLFCqzMvjNsgGA66f0Rhv/Tb42TqgBecpg9A3Qz/1dzGyc1793+8L8cdY35Xn9YrMcQ8I3vdkHHiWe+Iezal0KEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292455; c=relaxed/simple;
	bh=VmVG7HfN5qM50MKrD1A4HpIQKCxv/1GewT37Y8s+F+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfT4VXRPW3QyJKnHaPuDcOd3Rpd4sqJ25mLFbLkKBtHPrROWp/gtfRKTPKgpWMi22hEUsYfa4HjHyqO+prvWR3cuXF1NK3pldD5zz34zrRZaaiaIIIS/BiGMjAz6H/SXmCzlbty499hfqe17A8ElylJImjh6vnIhtebrEwRmTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcUSfcg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA57C19421;
	Tue, 13 Jan 2026 08:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768292455;
	bh=VmVG7HfN5qM50MKrD1A4HpIQKCxv/1GewT37Y8s+F+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IcUSfcg4T8FMsg7QJyUnAGZmUSwK7RSpWVbYrJkY/Tsszor0yphie34k2/7NPLxaF
	 UdgAN5EmixALyfmlEfZUjLOcf+xY+nF7Jm6wv1i39GL4yRWY9h4iFNNwyou6M8+RR/
	 dQmHJ/gQKUELpkmBeXsZBHkT2sT3N+Bj3Cmxko0sQ+uCWvYAQVexvOGMKdsOQCBJv1
	 MdQWSl7jusDlhn0wHzr2CEG1mpspkLBvjgMeoOjLIdutw7EZfVhHuP46Q69i1g+CnE
	 XChzBk7C1IIiz7tG8R2g5BcFNuo6wBPRlDj+zpq+WOgNma0TyqPCmQsn+lisYvrZc1
	 6BJZM7dv1HYdg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 13 Jan 2026 09:20:28 +0100
Subject: [PATCH net-next v2 2/2] net: airoha: npu: Add en7581-npu-7996
 compatible string
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-airoha-npu-firmware-name-v2-2-28cb3d230206@kernel.org>
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
In-Reply-To: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce "airoha,en7581-npu-7996" compatible string in order to
specify different firmware binaries if the EN7581 SoC is running MT7996
(Eagle) chipset.
This is a preliminary patch to enable MT76 NPU offloading for MT7996
(Eagle) chipset since it requires different binaries with respect to
the ones used for MT7992 on the EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 22f72c146065998d5450477f664ed308b1569aa3..0032a4801bca066f75f60154e6df0b41d11b899f 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -16,6 +16,8 @@
 
 #define NPU_EN7581_FIRMWARE_DATA		"airoha/en7581_npu_data.bin"
 #define NPU_EN7581_FIRMWARE_RV32		"airoha/en7581_npu_rv32.bin"
+#define NPU_EN7581_7996_FIRMWARE_DATA		"airoha/en7581_MT7996_npu_data.bin"
+#define NPU_EN7581_7996_FIRMWARE_RV32		"airoha/en7581_MT7996_npu_rv32.bin"
 #define NPU_AN7583_FIRMWARE_DATA		"airoha/an7583_npu_data.bin"
 #define NPU_AN7583_FIRMWARE_RV32		"airoha/an7583_npu_rv32.bin"
 #define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
@@ -624,6 +626,17 @@ static const struct airoha_npu_soc_data en7581_npu_soc_data = {
 	},
 };
 
+static const struct airoha_npu_soc_data en7581_7996_npu_soc_data = {
+	.fw_rv32 = {
+		.name = NPU_EN7581_7996_FIRMWARE_RV32,
+		.max_size = NPU_EN7581_FIRMWARE_RV32_MAX_SIZE,
+	},
+	.fw_data = {
+		.name = NPU_EN7581_7996_FIRMWARE_DATA,
+		.max_size = NPU_EN7581_FIRMWARE_DATA_MAX_SIZE,
+	},
+};
+
 static const struct airoha_npu_soc_data an7583_npu_soc_data = {
 	.fw_rv32 = {
 		.name = NPU_AN7583_FIRMWARE_RV32,
@@ -637,6 +650,7 @@ static const struct airoha_npu_soc_data an7583_npu_soc_data = {
 
 static const struct of_device_id of_airoha_npu_match[] = {
 	{ .compatible = "airoha,en7581-npu", .data = &en7581_npu_soc_data },
+	{ .compatible = "airoha,en7581-npu-7996", .data = &en7581_7996_npu_soc_data },
 	{ .compatible = "airoha,an7583-npu", .data = &an7583_npu_soc_data },
 	{ /* sentinel */ }
 };
@@ -782,6 +796,8 @@ module_platform_driver(airoha_npu_driver);
 
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_RV32);
+MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_DATA);
+MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_RV32);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_RV32);
 MODULE_LICENSE("GPL");

-- 
2.52.0


