Return-Path: <netdev+bounces-232080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE32C00A61
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B78119A1EEA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E18630C624;
	Thu, 23 Oct 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0U2TPhbs"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185E309DCE;
	Thu, 23 Oct 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217955; cv=none; b=WrGKGY1jaYqZoMz10CCOEnuVII2y3BUhGxYNSInaz0Uq7JNV9LrWXOH/X7u2l+glisDv6TZ+sLPvleMz7m78fSLHSTugS2HOJC4yi1UZhjfajH7cWjcvZ1PuMVOknhffv9ZR8lzgt1aZCqq9OQvkxdhPsNO58KrGqRnuymvAtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217955; c=relaxed/simple;
	bh=0NKlgZVrJ0WHlHOfKPe+V4OTgicNjUhWa1ARDnBWY7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdfDyZAdFxJijzgR0eeY+Zqh/AjdYbu8wLG2HbbuvnkiSIYJY3o/IHwPrw2qoRQbQexnWwb8iEz4U0k4EfofA0YK/35VHSKInv7bWVIH99sfsBf0fcvOU3QlfeD0xnVXwJ+gABdJTRqPi8Cij3dClNjWeVvtrwp9BiSRvYgwbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0U2TPhbs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=nbYT9rGF4WTOZUWuy2XkjY1pOS+7bJ1poExuGFLgzIE=; b=0U2TPhbshCBFcG49CHDQa20y/Y
	57q7qI+ElOOXrIJbgzqPtpkqOFc9yo+c1aOZdkYrfgZyi0oXbCJnViJi5nqQ2X1/IU4WZFC787MiJ
	CnMs6Ltk6ZLw/1ozmOJiE2GRi/dlHXFZa3KXRTjs3jO6DyyjD2JWGg7ik4jmFOkAy77EkqNudS4wV
	KyhIL6M9XlaxAheczHoDPPz8vERtikTSbQ+y92uDj02XNegxJ/UKnMiPVZyYGS7LCzAGS2GT2Db2T
	KbejY7r4ShdyRnDUYiccu9CTsId98uNJ17PvJKUdnlmC6egkeXMd9ZZ6qUQuRrJy04/DhzZ59+o87
	sD6WK2XA==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBtEu-0002w5-RU; Thu, 23 Oct 2025 13:12:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jonas@kwiboo.se,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: net: snps,dwmac: move rk3399 line to its correct position
Date: Thu, 23 Oct 2025 13:12:08 +0200
Message-ID: <20251023111213.298860-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251023111213.298860-1-heiko@sntech.de>
References: <20251023111213.298860-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the rk3399 compatible to its alphabetically correct position.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 658c004e6a5c..28113ac5e11a 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -86,9 +86,9 @@ properties:
         - rockchip,rk3328-gmac
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
+        - rockchip,rk3399-gmac
         - rockchip,rk3576-gmac
         - rockchip,rk3588-gmac
-        - rockchip,rk3399-gmac
         - rockchip,rv1108-gmac
         - snps,dwmac
         - snps,dwmac-3.40a
-- 
2.47.2


