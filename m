Return-Path: <netdev+bounces-248947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9015D11B14
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52C70304D195
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107928469E;
	Mon, 12 Jan 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqAo3oQW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE144264609;
	Mon, 12 Jan 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212033; cv=none; b=T4CBMnsAZUoYmqrR/89iFGmPB6PtX4smQ9Nn4VyNMwFVWS6HJydTDUN/tyxIO9kopA8gx3SqX5VHRMsZ5S3qoR6BR/BmFiWO7zDlzyu6S2Xe+N/AeB9198shhEZeLcRBMzmMUUMUyhSq3fwxY7RH68eWyiuLvCC17gYHrPoa8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212033; c=relaxed/simple;
	bh=CgzpiGNDQQYwMb8Boz7j9vAMoVu8m4Blj3bLoDD9GuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+DMcBf5mX2riPEmgT0U2QD0nwkUgqBuQKpHMZ2Lhl+OW6aHKaM4stTcO7rTuHinDzzeJMwggMiJkRCinn3zqUC6B9048wBC7wmbKZMKpbd3E61AekCjq5CmUGPWpRR8p9FEUUtjGb8hq/V2GoxGYqgRjTScHXTh6S+QLQb/Rvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqAo3oQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB90C19421;
	Mon, 12 Jan 2026 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212033;
	bh=CgzpiGNDQQYwMb8Boz7j9vAMoVu8m4Blj3bLoDD9GuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tqAo3oQWNCAZMZkpbs9QUnJXJJ9y+ef2pDO5pwwPzuD4k8I08PHkyhHbKoVWbO227
	 O+cu204k2KOg+ia9SWkjfn+NbK4E6CL4RY1af82Koi9yRV6vtqOX62g+AEwFbRdjOT
	 Di3yjh+J2XB1foj86YY8RNqj5lapG7EWZhazttPc//+NIesZLSajWh+u86RDr1FIAN
	 +NW4z6zVwa5/uQ/6b4HjZlQfymUC38zkt0gdnn9j/tXjAaDfc5QCwEPP67S6am/lYt
	 fxo9iKi3b5bdjDHeD4t71bUE7KhtGJhz7CmGhqTjNlmJUeb+w6lLiolvhzgLr/ytet
	 jxhoVWrGvprng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 12 Jan 2026 11:00:08 +0100
Subject: [PATCH net-next 2/2] net: airoha: npu: Add the capability to read
 firmware names from dts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-airoha-npu-firmware-name-v1-2-d0b148b6710f@kernel.org>
References: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
In-Reply-To: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce the capability to read the firmware binary names from device-tree
using the firmware-name property if available.
This is a preliminary patch to enable NPU offloading for MT7996 (Eagle)
chipset since it requires a different binary with respect to the one
used for MT7992 on the EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 42 +++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 22f72c146065998d5450477f664ed308b1569aa3..bba30582787babd77083c7456349f0af76afc505 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -195,18 +195,18 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 }
 
 static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
-				    const struct airoha_npu_fw *fw_info)
+				    const char *fw_name, int fw_max_size)
 {
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, fw_info->name, dev);
+	ret = request_firmware(&fw, fw_name, dev);
 	if (ret)
 		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 
-	if (fw->size > fw_info->max_size) {
+	if (fw->size > fw_max_size) {
 		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
-			fw_info->name, fw->size);
+			fw_name, fw->size);
 		ret = -E2BIG;
 		goto out;
 	}
@@ -218,6 +218,28 @@ static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 	return ret;
 }
 
+static int
+airoha_npu_load_firmware_from_dts(struct device *dev, void __iomem *addr,
+				  void __iomem *base)
+{
+	const char *fw_names[2];
+	int ret;
+
+	ret = of_property_read_string_array(dev->of_node, "firmware-name",
+					    fw_names, ARRAY_SIZE(fw_names));
+	if (ret != ARRAY_SIZE(fw_names))
+		return -EINVAL;
+
+	ret = airoha_npu_load_firmware(dev, addr, fw_names[0],
+				       NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
+	if (ret)
+		return ret;
+
+	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
+					fw_names[1],
+					NPU_EN7581_FIRMWARE_DATA_MAX_SIZE);
+}
+
 static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 				   struct resource *res)
 {
@@ -233,14 +255,22 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
+	/* Try to load firmware images using the firmware names provided via
+	 * dts if available.
+	 */
+	if (of_find_property(dev->of_node, "firmware-name", NULL))
+		return airoha_npu_load_firmware_from_dts(dev, addr, base);
+
 	/* Load rv32 npu firmware */
-	ret = airoha_npu_load_firmware(dev, addr, &soc->fw_rv32);
+	ret = airoha_npu_load_firmware(dev, addr, soc->fw_rv32.name,
+				       soc->fw_rv32.max_size);
 	if (ret)
 		return ret;
 
 	/* Load data npu firmware */
 	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
-					&soc->fw_data);
+					soc->fw_data.name,
+					soc->fw_data.max_size);
 }
 
 static irqreturn_t airoha_npu_mbox_handler(int irq, void *npu_instance)

-- 
2.52.0


