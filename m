Return-Path: <netdev+bounces-20196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084AE75E3BE
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3917E1C20A06
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C2220FB;
	Sun, 23 Jul 2023 16:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6E539F
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 16:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2245C433C9;
	Sun, 23 Jul 2023 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690129354;
	bh=M4Eba7JQy2lgUhZ/eOWiOdfCqNDYEzVkATepNOkg4FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOvbnl2BUJle/h5pYPzr+kYVhkMejvSw3/GGZqULllNFjpbhOMDD1SMaVNkTB9fhj
	 TozGaLLcoKo23M+pz7O9iiz6EvOKeMlWszMxYcHFUBdH+efkSbQrg6Guale3QRTVez
	 0EJVtpGFJJSZFcnTzGHeAOj4BqFpIZ4jYNrzF9sp0p2N2uDjAbzjNCJl/TfJzcoyYQ
	 HzGoZ+V2wDZKYuJQbTMRBltvJ4DrYUFvFHWSKr3S7xcal9Txjw3M2u13KL6Xu/Tu3G
	 A0ULSwyzR36AYWwvKsKFbSdosjkAHWCcCmO5m7RSxXcoKA2b6tJY4vaeg285pA+u3y
	 FfPCLgeoLv42g==
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
Subject: [PATCH net-next 07/10] dt-bindings: net: snps,dwmac: add safety irq support
Date: Mon, 24 Jul 2023 00:10:26 +0800
Message-Id: <20230723161029.1345-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230723161029.1345-1-jszhang@kernel.org>
References: <20230723161029.1345-1-jszhang@kernel.org>
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
index ddf9522a5dc2..bb80ca205d26 100644
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
+      - const: sfty_ce_irq
+      - const: sfty_ue_irq
 
   clocks:
     minItems: 1
-- 
2.40.1


