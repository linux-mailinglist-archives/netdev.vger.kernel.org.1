Return-Path: <netdev+bounces-25044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6A2772BBD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D05281338
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5130412B62;
	Mon,  7 Aug 2023 16:54:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574C111BB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D94CC07616;
	Mon,  7 Aug 2023 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691427240;
	bh=DbCsnFuIRCDw4RClbgLWL7mrfxpciKVOySkovPw9qFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqZc/lNm3p5A0/axSHPM+HKodX/2okxj2yUncPg8/EuidVFfhDFrPQXfyH4p2TbqL
	 Sss7KEJd7Kshoa771W7BJ4/pvsFSUUsjfebuEHNP6B5a2q4+sZkGjpeRMwKVdym6XK
	 rybcVtLL6zDgSQHTm+9ngtp+lgZNJv0ety3ISoCYcWUNWJaD/CFQF1imyrH9kY7xfy
	 OpWCyW3bYYlhti8Jb5DEkVLC3H2m8AURoMGaLxbt3FoAVsksJvGC0Q4CoAh+oIU0G5
	 SLzEWFACPwGQAp1QWkk2ZC5eqA28r6loGcSxYCYIYNHiGu2yAEqOJZYEOziKlF26Wo
	 VBcZ/LnCfvb1g==
From: Jisheng Zhang <jszhang@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 07/10] dt-bindings: net: snps,dwmac: add safety irq support
Date: Tue,  8 Aug 2023 00:41:48 +0800
Message-Id: <20230807164151.1130-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230807164151.1130-1-jszhang@kernel.org>
References: <20230807164151.1130-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The snps dwmac IP support safety features, and those Safety Feature
Correctible Error and Uncorrectible Error irqs may be separate irqs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..5d81042f5634 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -107,6 +107,8 @@ properties:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when Safety Feature Correctible Errors happen
+      - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
 
   interrupt-names:
     minItems: 1
@@ -114,6 +116,8 @@ properties:
       - const: macirq
       - enum: [eth_wake_irq, eth_lpi]
       - const: eth_lpi
+      - const: sfty_ce
+      - const: sfty_ue
 
   clocks:
     minItems: 1
-- 
2.40.1


