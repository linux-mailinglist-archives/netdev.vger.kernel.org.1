Return-Path: <netdev+bounces-204349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8539AFA1FB
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170437A7E8C
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86778252906;
	Sat,  5 Jul 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuyXZJjX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55F23D28F;
	Sat,  5 Jul 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749821; cv=none; b=pSI1YlEfWaolISTCdaeMIDSyvIxUE2+68wU8qarNE+uIBNZw3cDz8r0L9tfRzxc+3iO31+Q/6tAlsHSc1ftcifBwlyqvk/LcxXVkOPOogNIwmFYs2gsTa3Ylzf3i7/SGzN/Iy2e+fBcBSX6NXrp5F6cjLkkA5ha/RV0vFAsH1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749821; c=relaxed/simple;
	bh=cmXQhz3LP2Q2Jgn0thXqmV5cL87FTCYZGgqEsbiG/O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoJkH1t5abqk/R+POOSAVI6qNcC2k3vTPg4MkXw/vrYbQEVNW01lSbKruqwmud+DhIcAJ8rD5ufOXVojvwluyIeucJ5a6XTL+AuKmKTRgIDceEGQoFNZC//Kzd8qF4+c1mBxK9yfW9O3uqTojKKCFKznfPw2amBtk/oAo4Mj+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuyXZJjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE14C4CEE7;
	Sat,  5 Jul 2025 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751749821;
	bh=cmXQhz3LP2Q2Jgn0thXqmV5cL87FTCYZGgqEsbiG/O0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BuyXZJjXiUJ/68ytbS+R0cS5t0ddINmA6SEnImJ2JYXPrcWZLC2c+IUWjbcm6jxBo
	 ICXN5v9Id++fVv/RgM6wyYfGwNh0RUU/pM+f+fiuIddztgJG8GkXxVrH75teaA0QDG
	 g6roqaUbrgYcO3XOqn1n5dKTqtEPPA/DVcYhlMjpltKP65C4jQQnm+ymgQjwH1QiX/
	 YGPoU2qi2Vkoz10gmPIlRbXM4z9Uy31aK456CIImWTR6JPJYc16ybqESwuWaXAEQXg
	 f5Wtima/zqJ0izC1h+oTZVSwDNcwTGNIKIbLakKkMkK3IqCWf2HTP/c/wVbQiqLLiV
	 uq1/dZM8OPA/A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 05 Jul 2025 23:09:50 +0200
Subject: [PATCH net-next v2 6/7] net: airoha: npu: Enable core 3 for WiFi
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250705-airoha-en7581-wlan-offlaod-v2-6-3cf32785e381@kernel.org>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

NPU core 3 is responsible for WiFi offloading so enable it during NPU
probe.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 8c31df5b760730814ccfaa9fffff6c6aa8742f01..cbd81394cfb6d512d131f1c805f5c15d95d08634 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -731,8 +731,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
-	/* do not start core3 since it is used for WiFi offloading */
-	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
+	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xff);
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 

-- 
2.50.0


