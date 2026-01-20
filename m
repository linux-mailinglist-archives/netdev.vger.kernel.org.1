Return-Path: <netdev+bounces-251439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PtYIkRlcWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-251439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DDE5FA60
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCC3E741CEC
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D303E9F9D;
	Tue, 20 Jan 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ5NEMaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDD3E9F98;
	Tue, 20 Jan 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904275; cv=none; b=WVPpxx7b0pw6MqZcCS9u+CgNCNtqo2NC7+82p0PcDvCNuT4qsj+WdZwct+l8nbnVWznkMGQjK8OV2NxGNC4170QPQjk8X6/CfK+MqFQGgmP+oQN62mIxlej18vvlv6SBKrpIJb98BpdYi7arB8t2DxpCgt+w+k3hJ7P7Chu4qVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904275; c=relaxed/simple;
	bh=MR7e2R7CPVgyfSRb7MzhQnlnj8cAE7O5X1tWhsCzZNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cqyhdYebAvmAoeFy7g8QNuqfNt23mx5K+sVvh/BAI1lB/qDiHisZ+urfpy2YXz+qRkcC+WFAMKdEbmQ28IRbwy955yFUS+ipWV6xHyaXrm9VuALL3dtgF/ooKVGVomE9mk2hV05FB05TpGSyxoyRmiXtJhi89v/axE4JrHTyGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ5NEMaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04AAC16AAE;
	Tue, 20 Jan 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768904275;
	bh=MR7e2R7CPVgyfSRb7MzhQnlnj8cAE7O5X1tWhsCzZNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JQ5NEMawg3O7GKUxWu9q8/3xE/leOejOE99oobrByn63rWM1HbjudTvX0jewCB9RK
	 WnHo/d5e8Gj4C0Q1dQy5EFQs55T/enqqiCMskfWv0QxDm+98DXSuJCdTFYsMzEIWad
	 qfQBRnxZsjqjCyqcT+kUgV2woBjFHKu2xfkC64kc/1PN0qtSsG5nzLBWlhXXHgznES
	 SSzX0ZHA+u449aMqUeFM4xCrr1gv2NMD4wZXLMUqk7A15YUWkjXqGT2fe8RDe0Ipun
	 /7w7JHwIp8xylTDLpVdivm+IB4iooYtNuS+YMob/03kcrR5m9KrWPM0xyyiYULEEPg
	 QjYR+V8O7V29w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 20 Jan 2026 11:17:18 +0100
Subject: [PATCH net-next v4 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-airoha-npu-firmware-name-v4-2-88999628b4c1@kernel.org>
References: <20260120-airoha-npu-firmware-name-v4-0-88999628b4c1@kernel.org>
In-Reply-To: <20260120-airoha-npu-firmware-name-v4-0-88999628b4c1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[37];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251439-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F3DDE5FA60
X-Rspamd-Action: no action

Introduce the capability to read the firmware binary names from device-tree
using the firmware-name property if available.
This patch is needed because NPU firmware binaries are board specific since
they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
MT7992) and the WiFi chip version info is not available in the NPU driver.
This is a preliminary patch to enable MT76 NPU offloading if the Airoha SoC
is equipped with MT7996 (Eagle) WiFi chipset.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 46 +++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index a56b3780bb627cc393b94210b6b5c72cc95baea3..89f22f3f47dc562864f32395c88093e8f28e161b 100644
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
@@ -195,18 +197,18 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
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
@@ -218,6 +220,28 @@ static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
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
@@ -233,14 +257,22 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
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
@@ -790,6 +822,8 @@ module_platform_driver(airoha_npu_driver);
 
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_EN7581_FIRMWARE_RV32);
+MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_DATA);
+MODULE_FIRMWARE(NPU_EN7581_7996_FIRMWARE_RV32);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_DATA);
 MODULE_FIRMWARE(NPU_AN7583_FIRMWARE_RV32);
 MODULE_LICENSE("GPL");

-- 
2.52.0


