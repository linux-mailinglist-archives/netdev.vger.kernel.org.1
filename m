Return-Path: <netdev+bounces-25046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33449772BC3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FEB1C20C7C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B58134C2;
	Mon,  7 Aug 2023 16:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE4134B1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E5C433C9;
	Mon,  7 Aug 2023 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691427246;
	bh=+gV2OwgbEESWlTBw1vccjy1Lziej65rySDz1k5zLKn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lk41pLhcEvbcRlk0Ghwfq5+V5oNP2DVAqeH5W4Ji1yCDzYOVskRRfMmdUBPcV71cG
	 8R7ccknV2Caa0lPazKNgCTD7wow65XATCsKeZ9PayomLzLyrC0/92jaC8KlILrbSFZ
	 GCoi7s+DeNf36Q2BJqlXv+iVoeSAH2KBt1gOhgS6MzRHvImiq7FyPyyZCCL8zsGAbD
	 kZ2EDaJRQre4aUkygKuX1GaPsVB5BorIjpd2fmvYKA7io7UUPCsSv0XzhI1gF5a6Qt
	 qC1kS/ovu2aACZ1BAUzD4RkgPblju27ZYfjbKMD0L5MxwKZ+z0blHbbUL8ucH6SteH
	 mHkcONWri8Ipw==
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
Subject: [PATCH net-next v2 09/10] dt-bindings: net: snps,dwmac: add per channel irq support
Date: Tue,  8 Aug 2023 00:41:50 +0800
Message-Id: <20230807164151.1130-10-jszhang@kernel.org>
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

The IP supports per channel interrupt, add support for this usage case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5d81042f5634..5a63302ad200 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -109,6 +109,7 @@ properties:
       - description: The interrupt that occurs when Rx exits the LPI state
       - description: The interrupt that occurs when Safety Feature Correctible Errors happen
       - description: The interrupt that occurs when Safety Feature Uncorrectible Errors happen
+      - description: All of the rx/tx per-channel interrupts
 
   interrupt-names:
     minItems: 1
@@ -118,6 +119,38 @@ properties:
       - const: eth_lpi
       - const: sfty_ce
       - const: sfty_ue
+      - const: rx0
+      - const: rx1
+      - const: rx2
+      - const: rx3
+      - const: rx4
+      - const: rx5
+      - const: rx6
+      - const: rx7
+      - const: rx8
+      - const: rx9
+      - const: rx10
+      - const: rx11
+      - const: rx12
+      - const: rx13
+      - const: rx14
+      - const: rx15
+      - const: tx0
+      - const: tx1
+      - const: tx2
+      - const: tx3
+      - const: tx4
+      - const: tx5
+      - const: tx6
+      - const: tx7
+      - const: tx8
+      - const: tx9
+      - const: tx10
+      - const: tx11
+      - const: tx12
+      - const: tx13
+      - const: tx14
+      - const: tx15
 
   clocks:
     minItems: 1
-- 
2.40.1


