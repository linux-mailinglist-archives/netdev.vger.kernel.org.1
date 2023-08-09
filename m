Return-Path: <netdev+bounces-25994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B53776606
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6521C20B2D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A711DA33;
	Wed,  9 Aug 2023 17:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A81CA13
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24935C433CA;
	Wed,  9 Aug 2023 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691600529;
	bh=DbCsnFuIRCDw4RClbgLWL7mrfxpciKVOySkovPw9qFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xl4PJ9ZwiSDgL82Q6u5+9jGBcBpVFwZX1fzaQqnb2Voy0lE9UgqIs4Habkmk+a6tG
	 CKWlECVyKR9MozeH7HHnHAI2O32KO0AEEGrXGoUIfE9h+ME/MSac6G/gz7eyjdevam
	 Q5v2iDKA6/x9O28fgQTh/90SGLo2xwRz46LoPb8/L2nKFU/TCvXaEqtCltiq+ovOs2
	 +U/gPUMk1AZXQ/KoN4+prZY62WnpFfUTvG2Ggn0h3yLsybzQIFKaEdMQ6aYmZQ/mxt
	 O5X52I4i9nBQ1l2pUlyLq46UOKsWYdfJyY81vNVjIrVz0AjIA1ObkyHaNeop7toe/k
	 9IJ8c9MEBGbgg==
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
Subject: [PATCH net-next v3 07/10] dt-bindings: net: snps,dwmac: add safety irq support
Date: Thu, 10 Aug 2023 00:50:04 +0800
Message-Id: <20230809165007.1439-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230809165007.1439-1-jszhang@kernel.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
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


