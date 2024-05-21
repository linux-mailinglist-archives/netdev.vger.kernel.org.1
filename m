Return-Path: <netdev+bounces-97404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3018CB51C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 23:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BCDBB212DD
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B4149DF4;
	Tue, 21 May 2024 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="gPPx+Q8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFC5149C65
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325850; cv=none; b=nmw8+e74oTKAo0O5GT8AUx1IM+0VuyI23nvrMg80Eha4/5taSeujBXY6xEaT08lIjtV9IJ96oYrmJdq33BgVoJ8k4S5EsV/6wXKw417Ymomb3tqYvpD66koraIF+pqUhaHVbegS4JQM4uNXrdDmxN+HDjXwMYc1amX0yJppRuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325850; c=relaxed/simple;
	bh=5USs6rChACXIHhJyT+Wu1qgAQgmwAJoe0o+y69csEnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzoYQDh5/PBkAObACkmlbsvujY+qnBSXaEIjqZfG7xfdDUIRImgp/e+jUvQUKNeGK9jSFbrJLNFuuQ/0xxa8XRFqszkQILBqCNJEyg+meuFJZ8zw9t5vFb9NusFtUfJqtNpxRRl3aNv9/kzqet/jFfX3sbpexk6OcC3/4VZaVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=gPPx+Q8F; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716325841; bh=PGvuLTeSZXbOGOX7STN02fCIGy5L2QPSCNlAObw3PHo=;
 b=gPPx+Q8FHyG7eJHxSzssdQ033h6mewfr56kY2lKemL3ERR87t43/CTEcQ3q9W92yj2fYMntmV
 fFVI9lh9uSRW+13Hzl0sOwK5ThnNBcW5SM0Ha6uWifdDTw5y2TTGctRGsB2TAVsXEE84LX+dABS
 i/3WBC4kt0JWLXCPsQ2i2eTmByR0OInXjRI885C1il/WznrYJpGUmCV1EZI3bgxwQkgg7/v2/Vh
 BYN2VIKJCri0xaqt36jT+GCLgMkf6iq2Cqu5o4lmIuouAVoa5S9mc6CZodJGVUdeJrdnn/8iS+d
 9V0DP2teDhKPUr5UrwviWJEHbBhg4cNvkvrDtkLtC9BA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, Tobias
 Schramm <t.schramm@manjaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, netdev@vger.kernel.org
Subject: [PATCH 01/13] dt-bindings: net: rockchip-dwmac: Fix rockchip,rk3308-gmac compatible
Date: Tue, 21 May 2024 21:10:04 +0000
Message-ID: <20240521211029.1236094-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664d0dcf8b6b0c828344aea6

Schema validation using rockchip,rk3308-gmac compatible fails with:

  ethernet@ff4e0000: compatible: ['rockchip,rk3308-gmac'] does not contain items matching the given schema
        from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#
  ethernet@ff4e0000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'phy-mode',
                     'reg', 'reset-names', 'resets', 'snps,reset-active-low', 'snps,reset-delays-us',
                     'snps,reset-gpio' were unexpected)
        from schema $id: http://devicetree.org/schemas/net/rockchip-dwmac.yaml#

Add rockchip,rk3308-gmac to snps,dwmac.yaml to fix DT schema validation.

Fixes: 2cc8c910f515 ("dt-bindings: net: rockchip-dwmac: add rk3308 gmac compatible")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 21cc27e75f50..3bab4e1f3fbf 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -76,6 +76,7 @@ properties:
         - rockchip,rk3128-gmac
         - rockchip,rk3228-gmac
         - rockchip,rk3288-gmac
+        - rockchip,rk3308-gmac
         - rockchip,rk3328-gmac
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
-- 
2.43.2


