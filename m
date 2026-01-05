Return-Path: <netdev+bounces-246941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05128CF2843
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C04430019F3
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B133C327C0D;
	Mon,  5 Jan 2026 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhRVS73L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31349327C06
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602984; cv=none; b=jaotrA3GW7EklXw6ApfI7kMXbDYVMjlnK0dYIwBXcMHnBcGMiYHvpfHUBiGZeZLHd+1LBPP0yUOt5CyXUWC8cLCZ/hnHGMjzquRpyILUJu6QzpRUkaVO/Qd1uEM2d9yg+qR7gkgL0BqttCoOrmgwWSCTh8fIK2R7GS3UFfkiDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602984; c=relaxed/simple;
	bh=ee5soaoyKiBuasxn1iD+tDCH2itJaaLVbfJQApUgCBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bku56ne8NR+geZhgg2zbDca4iSWfaFYcnkMbs4CI1qp55rMcziOgJiYUq9xWmguXKtT5toyV1k7oGdWGWiVmIXC5ZKyw2X0e2aMJTXOd6vDEYQizy7mUixtNOI2uN/VaxmfdrJXORCaNGSDtFZSYewenOVfl6VRdgRtzYquiAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhRVS73L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4B2C116D0;
	Mon,  5 Jan 2026 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767602983;
	bh=ee5soaoyKiBuasxn1iD+tDCH2itJaaLVbfJQApUgCBo=;
	h=From:Date:Subject:To:Cc:From;
	b=GhRVS73LqH4Ylz6MPvKYhUeLXT7nfBkPdJ3s0Ocf5uXrLiH+7CFJAluoEigDkdL5M
	 vnTkunG8UQAvQIGXWzr7QN3bx1HMwBB4c7Q4oYaOHt/DxjI+xXgqnxXhByjZTBrZoJ
	 6q/084ljYKHTpTcZ93jPrGxfZ64wqYPb8rISTvAFdQdw6TWH7RfTTHXF5kRnt7Ydhl
	 6rF73wYk3RpmEO3UTx77er34OGtTx0We0w7fFthjJBCAFzkHgZIMMM1705NpwH+4VU
	 WJvXYmQfik8OqzIbiK54qD3u+C29/+D9FYW4ZtdKfEV4+EjdpVT+TJ2Lpzrc0UcDQq
	 ewOlp0qlUm4HQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 05 Jan 2026 09:49:16 +0100
Subject: [PATCH net-next] net: airoha: npu: Dump fw version during probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-airoha-npu-dump-fw-v1-1-36d8326975f8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgMakapXEYdWU81gLS3+QPHuF
 sdveC9B5CAcYSgSBL4kyuEy6rKAedNuZZQlG6iitiZqUEs4No3On7icu0d7Y9tbpUxH1ugGcug
 DW3n+6Ti97wf+4UJ4ZAAAAA==
X-Change-ID: 20251223-airoha-npu-dump-fw-59f77b82fba3
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Dump firmware version running on the npu during module probe.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 68b7f9684dc7f3912493876ae937207f55b81330..22f72c146065998d5450477f664ed308b1569aa3 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -657,6 +657,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	struct resource res;
 	void __iomem *base;
 	int i, irq, err;
+	u32 val;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -750,6 +751,11 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 
+	if (!airoha_npu_wlan_msg_get(npu, 0, WLAN_FUNC_GET_WAIT_NPU_VERSION,
+				     &val, sizeof(val), GFP_KERNEL))
+		dev_info(dev, "NPU fw version: %0d.%d\n",
+			 (val >> 16) & 0xffff, val & 0xffff);
+
 	platform_set_drvdata(pdev, npu);
 
 	return 0;

---
base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
change-id: 20251223-airoha-npu-dump-fw-59f77b82fba3

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


