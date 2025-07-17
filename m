Return-Path: <netdev+bounces-207714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2DEB085BC
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0744618936DD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F921ADCB;
	Thu, 17 Jul 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwerPM6e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8821A931;
	Thu, 17 Jul 2025 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735508; cv=none; b=bW3DQ7gYQFpG/YJgJE9z7IIc2uvtqH5ZuJSOqnfjIC3JSBjf4Vr4beCCUDh3LtqcyWFdBNDQmk3/Dr1S+QjVfVQRtLB/hDJaHhyWCoylGKGi+tBOXYMNqWvakcil/F/7xBBrsI2ttqJFfHg/k1ncsxLBCyP338M4T5eX7mCVj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735508; c=relaxed/simple;
	bh=bbMe/p4KUpOOmlbJ3xxcrOUiZhOzHwySeN2cBLuyzhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1mYDL+yGSPRaGu4KQrWVFn7r0tRG9mkT13kuiTPZL9zesgQa9FtYIxrmMN4Sld8E3CG6JOVwj3tHJnVQb7Aw2LkXxsmPVF0ta24yMt7EkaKixk00tBVY4b+cMBdupNdMLAYo0VC0j2ujOh/S9IfTuwVbdHbUPlTiXKMDnKVNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwerPM6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69957C4CEED;
	Thu, 17 Jul 2025 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752735507;
	bh=bbMe/p4KUpOOmlbJ3xxcrOUiZhOzHwySeN2cBLuyzhA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FwerPM6eBQ7kjyLxF16HXTnRVEji8UCVNnvrU+zFDpnNh1JsiHHiouZtvdnOVU2pE
	 8Oil5sURRQCVifKEzd28VXlU2Gjoa1rSkaW61qWM7y4APeRYNzYbrahTq/k0vsh59E
	 Y+1dzeRsyUQf1DD1Q5wga5a2yT6ThGWsoT2TzyidCbWRdzkCCvei13OhRNjUCpQzBy
	 McwbciZve9kk/a0//OFooiD621nI5FypxIrQF9c1xLu7xsKW3e7Z7dyFsHld4ZOekt
	 8J2sKLi2ASy7CaL0mFLONSa0u9BhWA1FXdrNnTg9DuYZZMxEBE75FWfjXS7qvAjEzK
	 auvfejIr1HpIg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 17 Jul 2025 08:57:47 +0200
Subject: [PATCH net-next v4 6/7] net: airoha: npu: Enable core 3 for WiFi
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-airoha-en7581-wlan-offlaod-v4-6-6db178391ed2@kernel.org>
References: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
In-Reply-To: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

NPU core 3 is responsible for WiFi offloading so enable it during NPU
probe.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 68ddc940f675b42599bd2c0245dc715bb56edb32..90000496b6a234897d4f208ab78d54af14be4aac 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -724,8 +724,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
-	/* do not start core3 since it is used for WiFi offloading */
-	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
+	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xff);
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 

-- 
2.50.1


