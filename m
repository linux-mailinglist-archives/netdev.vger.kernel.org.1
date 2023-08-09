Return-Path: <netdev+bounces-25997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B6776615
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C474F280254
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A01DDC8;
	Wed,  9 Aug 2023 17:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFC1DDC0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656F6C433C8;
	Wed,  9 Aug 2023 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691600536;
	bh=+gV2OwgbEESWlTBw1vccjy1Lziej65rySDz1k5zLKn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niUMi23cuW63S1k46u9PkZlkcaUSZok42j5k2gcuTvEtlUpzFZt2xQz+it9W81a2e
	 5J1x8dqycYRIOpb/XWG1KMiG45wbJqJGNVUIMEng6vKmrNoDV9EuxkdTy25t+CvSdk
	 hzaAJT9UH7CpGMUZd696Suf2pySmDe9uNYjkdO8IqVopyMiXMNWJIH7M1yH7j3ZRtw
	 vdoQ2TCpoGAaddKyP9fcWxQ/5oxCEqFz7GI4+Jk1tltCNwTLodTaPleSec9DNZYx2m
	 egZCVPR2nEyN6kKnphiKNIzaG7rn4Ko26Ac0U0U6n/T5REhgGkn9khLyg+ziPFw6hB
	 j7PJ+1A6XR16g==
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
Subject: [PATCH net-next v3 09/10] dt-bindings: net: snps,dwmac: add per channel irq support
Date: Thu, 10 Aug 2023 00:50:06 +0800
Message-Id: <20230809165007.1439-10-jszhang@kernel.org>
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


