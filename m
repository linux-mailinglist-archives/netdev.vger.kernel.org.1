Return-Path: <netdev+bounces-231416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9FBF9217
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A7DD34BDEA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A904301002;
	Tue, 21 Oct 2025 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DB8xmIlK"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A72E7166;
	Tue, 21 Oct 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086678; cv=none; b=hMJbAxiUD6QdJNWX0R+qVWkiF/9nM+liI0smj2CSEy1hQd7rD2PhbdtYxr7vucgUoknkGb8yaFKPJXncWFLIbv//dgozYVrpdVJ+zXCCykb3+zrtggeAhahgF2mxSOISqvQh1dB35sf0jqCgZ4GYLh+5aOA5TZNe80d3pNztHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086678; c=relaxed/simple;
	bh=e1O5MVtYX4Z52Hjj6r2rI9/2MLdhbBCdCttOZ5445tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3dCW44V6Y5E6Q51YAMDaiwGLlMLqfGdJbCTcwDxpgi90yi/bblUJ0z32ti9zS3E3cqsBwj9ToReQ+dtCAdLG1htRscUqqoVxE8TFOfgQOZ7+E71ILft2QbVQM7iOKHbh+zzuv7AT1zM+G1IOYcNd0qsZmZvrLoopuMHSLb1h+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DB8xmIlK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=Ixw8Tn4SSAJGBrjXyuSJb8p28o5oWrElWJkI7VzZSGU=; b=DB8xmIlK9yrts9k7Vp7zIePx2U
	D8xZEER1XoamaJkNTPi/nWKcpuVf5Adid65lUbRAdyLLXZU+GANm5Vgq7HotEZq4isYxl6/EP0S/w
	Q7mYdS//j8SE+aHlYYf7qtoPxBLWjhOh6CZrMHFoeQXGQGIJGUkv31VF/rU8JKJ+QMplb0ptppQ4D
	oJbuV5iwGSLL4HmrG2akURKuNsaPUf9DDOQs/g+IrSnFFzJpTFHE1lAm9eVANCPenDsTV/CbS57uX
	JQlOSrS4WAlluTjXqe+KgK8TJt4+Hj5rRb/EBds8uL2RVjf7blLBKq0sw3ktBSqdTj5Upk9sLkX0q
	Y8NI6GMg==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBL5c-0006q7-Eh; Wed, 22 Oct 2025 00:44:24 +0200
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: net: snps,dwmac: Sync list of Rockchip compatibles
Date: Wed, 22 Oct 2025 00:43:55 +0200
Message-ID: <20251021224357.195015-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021224357.195015-1-heiko@sntech.de>
References: <20251021224357.195015-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of dwmac variants from Rockchip SoCs have turned up in the
Rockchip-specific binding, but not in the main list in snps,dwmac.yaml
which as the comment indicates is needed for accurate matching.

So add the missing rk3528, rk3568 and rv1126 to the main list.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 28113ac5e11a..1a0d6789a59b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -87,9 +87,12 @@ properties:
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
         - rockchip,rk3399-gmac
+        - rockchip,rk3528-gmac
+        - rockchip,rk3568-gmac
         - rockchip,rk3576-gmac
         - rockchip,rk3588-gmac
         - rockchip,rv1108-gmac
+        - rockchip,rv1126-gmac
         - snps,dwmac
         - snps,dwmac-3.40a
         - snps,dwmac-3.50a
-- 
2.47.2


