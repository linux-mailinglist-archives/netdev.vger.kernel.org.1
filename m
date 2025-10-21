Return-Path: <netdev+bounces-231417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 642CDBF921A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1170D34EDF9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF648301038;
	Tue, 21 Oct 2025 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ch6m+f/C"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC12FC873;
	Tue, 21 Oct 2025 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086678; cv=none; b=VOw5/526hLARzdGm7ZrQuorDvuv0TUTbsdL6uAXleESfazTKB2kjbwBqrM7rYWWtQpZkTaRM8aNl7zklpYqWLJxGV2c3NVTEACj8Uq4x6HKfFwv3F+gnzyuH/8jlI/yDEVSBuXdOoauWiWDvo8weNOSxNavK6fLHwgxy9sSs6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086678; c=relaxed/simple;
	bh=8a0ujLCRHrcYmX01srLTIoTcPwKvrYwdagJW/lcPt6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDBhlFYXLiqyZWNprTYnGHRgifxElFlCjHLSV314y4MxhVvD+qXqmh6mtkuoe8XPJKFrbhiIauR2AzNRccPQ5dGw/RA8xFULKg7OPUl/TQ2RRP4V8ro2ywpGjnySiLHwRztlRO9FhIi5Y0HuUIOJd0r2uE1bG9q2lMcgaslrxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ch6m+f/C; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=UYh/0i24HCJ6lXNDk9gAdvGbxmlL+x4q7FpUyO+HQ7o=; b=ch6m+f/CI9mAs2E4+YUWDjmvIP
	orPNQti3zb81TRTs+Q56UsjTTfydyVOgWktw43FYnUfwJzLobhu8RYf0Hk8FkXyGkyHvVm+4a6T9H
	PHKomt/+no5eaFYXUpdSiBbguqIiytJUC5pUBEB80+J35xLEraQb+DDPDk747WE67BCkQLvF/v7io
	G17DIuO7z1tgiXdDYqXZqPB61jRciY3GEK75G3fTJER6wmw/5n5fullbauxBw3+UbosvTxu9KTmn6
	y7tg3n6Jlmp8sRSx8VdyjsqekuUyAM/zBJwU4+3of6TSwSeBZMCzL7VBAPUmLbUr+Ol7VM2RDKZa6
	WuLs079g==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBL5b-0006q7-Lh; Wed, 22 Oct 2025 00:44:23 +0200
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
Subject: [PATCH 1/4] dt-bindings: net: snps,dwmac: move rk3399 line to its correct position
Date: Wed, 22 Oct 2025 00:43:54 +0200
Message-ID: <20251021224357.195015-2-heiko@sntech.de>
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

Move the rk3399 compatible to its alphabetically correct position.

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


