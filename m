Return-Path: <netdev+bounces-232083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394EFC00A97
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B7C3AFBB4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF4E30E0DD;
	Thu, 23 Oct 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yMN8qMWm"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CC30CD85;
	Thu, 23 Oct 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217957; cv=none; b=ZsD5sUXXmxpiT2xVoF60fiJRpYlmYTQEyuQ5kXDVqqYnGO49IJ8UQv7WK3vKzY+D3IMCS+UllZ5YoM3pmC8BAReOGzOdzAOvhgkHNHOGvIAAwxUiE/oCg9JGVENOHvkxwt0WViMjtg6fVp8jftwIE2KfKlnV56x4X3aWzzb56Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217957; c=relaxed/simple;
	bh=p9Nkqd9QkB+VyozIo+QIngFT9Gp4OeAxXgdz3aW/ePs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1KVABMjiI67tdq35OIuoQ+BHVg9LuOzerCxNIlUC2UFIJWEtlIA+3CmsSzpUT7Uvq9GSEL0/dHre05Xqj7VZxubuzCANXbw2VkSNhPAcQSPiA6eVYCrugncEsQ/NhHl+1la9PDBYcDs+1iWRjEEgcWJVbpefWuM6a6b+ggBPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yMN8qMWm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=c9r5W/KsY8w9shEEuLt5rFhhVh41VepTKr0R2XZHIdI=; b=yMN8qMWmkQEZsxHY/Xto3vO3ak
	Y2TqtbuNvwJJFlhGLdzZh8XDs632pmECzFWzU7EZYK51xA458czcBc77jkEU++NyW2s6e0oO3PFRQ
	SK71D9+GdIOLqfEeYqbVewI6tN9RGg1l+3abcDLGxkKovp2sPnv+2Xi06S8LKYtTsC1bLfdfj46ni
	FFEnHP25nZ1xo36MjebGAlWb6L8ucGn7MqoB7c/Fsg+bDriA0BwMTjGvyaV1suDkjRGncOBuwB/2S
	6qmg02jVMDIMnqYCfnll/Ihm9G0Hy4jEBGnmUQwYf2A0ysY7eX0el5B8pd2iNn/tE/+N2VU55TMCM
	PCBPdSrA==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBtEz-0002w5-Ek; Thu, 23 Oct 2025 13:12:21 +0200
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
	jonas@kwiboo.se
Subject: [PATCH v2 5/5] MAINTAINERS: add dwmac-rk glue driver to the main Rockchip entry
Date: Thu, 23 Oct 2025 13:12:12 +0200
Message-ID: <20251023111213.298860-6-heiko@sntech.de>
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

The dwmac-rk glue driver is currently not caught by the general maintainer
entry for Rockchip SoCs, so add it explicitly, similar to the i2c driver.

The binding document in net/rockchip-dwmac.yaml already gets caught by
the wildcard match.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..5b9c056b47cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3296,6 +3296,7 @@ F:	drivers/*/*/*rockchip*
 F:	drivers/*/*rockchip*
 F:	drivers/clk/rockchip/
 F:	drivers/i2c/busses/i2c-rk3x.c
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
 F:	sound/soc/rockchip/
 N:	rockchip
 
-- 
2.47.2


