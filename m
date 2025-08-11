Return-Path: <netdev+bounces-212494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 928BCB21042
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979667A9E73
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356CE2C21C6;
	Mon, 11 Aug 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTjJcpEM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9171F4C8E;
	Mon, 11 Aug 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926368; cv=none; b=VypiDnlvSM9SxeHx1lzcJ4r1orRTy6VbqPTqtjzVT7W9row0nmL89FUcIM8Y7raCXgsMytKqPeMQ/LhU2Dgo+ub0OiBFhFWWu0URGUWT1JQS06yba1eA2YYb+FGYVnBRXx8lrfxKQDsaB8mgOttkTO3ZpFbkVPSSG5I0U+XOskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926368; c=relaxed/simple;
	bh=8/4RpIJUjXp3BOewwikXOw1DM59JzyvkMt9RjsWbDKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+6YhjfxF0fnJYZV3aWIpBfAg5X7gtpWblvCOCHT0Gp+AmEVghehr5DfY4ydrYtFOb3FcZfQ8ud8PXt++1Y8XV47t4MShLY2rq/MOjEnMvmhsSnGEkndbIQvCjbY2q/X+Rc93lyQq1Ub/lkdgfkecPvfekYZpOpeUbR2/LSyCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTjJcpEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595E0C4CEED;
	Mon, 11 Aug 2025 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926367;
	bh=8/4RpIJUjXp3BOewwikXOw1DM59JzyvkMt9RjsWbDKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eTjJcpEMFQJ9Pgk9znUfgwTQTpuTyLJdjz3H5g3hBMmXqhJkrLYR3efIQ5xhEp4Cm
	 JcUhX/eA47ivicJMbd3+hy8ISwYK8uIdllOcH70Yf5IJ9hVIQY6RxJ095qldD4Tks0
	 2G37/pP17fsbRBR9yZAelIujR4YjlslDkr7WptBIvoqocCzHb7QE299t60pWBuPNVn
	 uTAlCAz7mXSLbp9nKd5B47x4j1gGq2Jn8/qsN1QggA2la2EpUuoAEqgufg9HgpIUbH
	 B9DkZXMgNiIifz6JRkJvGOyuAbiv1U7S0Z/VAMbQhM7BjJe/FBH79K4lmyLChgcslr
	 +wEPywnC7AlZw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 Aug 2025 17:31:41 +0200
Subject: [PATCH net-next v7 6/7] net: airoha: npu: Enable core 3 for WiFi
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-airoha-en7581-wlan-offlaod-v7-6-58823603bb4e@kernel.org>
References: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
In-Reply-To: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

NPU core 3 is responsible for WiFi offloading so enable it during NPU
probe.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index e0448e1225b8eb6b66a3a279b676592876f277ae..66a8a992dbf2abc9626610b1d445eb9d3d0a5e8c 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -720,8 +720,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
-	/* do not start core3 since it is used for WiFi offloading */
-	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
+	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xff);
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 

-- 
2.50.1


