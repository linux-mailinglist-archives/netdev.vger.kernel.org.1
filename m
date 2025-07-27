Return-Path: <netdev+bounces-210385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4EB12FE9
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502B71740CE
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F3F21C179;
	Sun, 27 Jul 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ+ooKCV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653F21884B;
	Sun, 27 Jul 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627287; cv=none; b=j5XwHRKnHi2czUx1LKzUkA+JvUDMBBU3cZiIu9O0IopJXXZ+X+xv9m4XhrF+YmL7c3MYCsuRW91DZckMbRzGKRLqbQWOnclR1B+Crlt9S+5Vjm+1onNYQsQ1WbLE88wsLDWf4W78/mtgmaTMoVD+aYxYRCgJzHIBC1LAt+Qiee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627287; c=relaxed/simple;
	bh=L5gHcIa5VuUBeimB79zIuxICWFJ1hsqKpyHcNulLv0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jh+Atmd1Iasn6dgG01Rls+qPQls003gjNq56ljpM+K1pwbA85FcvkJfftwcUiqHvCemeSeWondBhQ02r6vwhJBw1GHlxHslhd9ASL1+MszFSe5qUqGINfPspKdaWuxleKPKEvjR+/CqbgkSoAfWIB2cswctgRMOEbn5/naJryPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ+ooKCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2199CC4CEEB;
	Sun, 27 Jul 2025 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753627287;
	bh=L5gHcIa5VuUBeimB79zIuxICWFJ1hsqKpyHcNulLv0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AQ+ooKCVtyXbcyJQYA7+Ts2sK3OQBfzkM6btbgdlMXyeHXTdA+cMZvyjrmXmw6xYm
	 2Ytkp+BQYxXvAtwle/0b5Xxq6PYVXkAH7u2clGmUEkk2K+Ete2+N6ZMvItSzSIYKc8
	 1EzKb10yFZ+zNST0kNhCYvfDBG1o5uF9a0dw/MOh7OzVRmeD4TTFg9UeTheQAYQ4YZ
	 ow8PlIrGEsQ/jNve8J0Y8C4Yl7KkXQAb10aTzfooo334aTTAsVH+cRf0KlH+S0MPdp
	 fRxyte26mAvacnEtLf8L+Z6njsKt6Sl7ZM811OKnPXjN19kU+dfHdb1ODwvY2nkwp2
	 AISosRQ2npiqw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 27 Jul 2025 16:40:51 +0200
Subject: [PATCH net-next v6 6/7] net: airoha: npu: Enable core 3 for WiFi
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-airoha-en7581-wlan-offlaod-v6-6-6afad96ac176@kernel.org>
References: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
In-Reply-To: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
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
index 6ad8715f3b71ef217a6097f135fe2d6995be7f8c..63e6366431e3097df7638a06a1d525af801061d9 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -715,8 +715,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
-	/* do not start core3 since it is used for WiFi offloading */
-	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
+	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xff);
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 

-- 
2.50.1


