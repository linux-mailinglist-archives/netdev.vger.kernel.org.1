Return-Path: <netdev+bounces-17627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7597526F6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C5B281E63
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F71ED5A;
	Thu, 13 Jul 2023 15:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459C1ED58
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:29:17 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12903583
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:28:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so6750145e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689262134; x=1691854134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pda2v+mLWC23W2SQX3mr2OpooyQsFAd9sHxngZmXyV0=;
        b=P8NhdgfcIwOtANtR5+8a4ekovJim3nBn+DFZOvEv1Ka7RsvX3MpCQ3+goSqMkxBdB3
         anumahIIPFAFyZfDFkCrVHFNxX7foU470PZhAsGyT8lvx6kiHGnJCyZ7Ct1hwPmjdigV
         Dh/QMdtoYlRRnAIQXaXqtBJnH/LOmb1SoLxJbZYzssbJoosB3I+u0HB1URmrzRs04shi
         jBE+bRXfNZ9nJc54OTGG5XKEn+M/mXl1Sc6AHpn+N/3UFMqcWLitrdWxvh1Yusey/jEI
         NlgmvFNGz5t83P69qiWJBe2E1FxT+n+OSSF8AS/mz27NvsfkADxvrlc1dxXt8s+4BDQk
         uZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262134; x=1691854134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pda2v+mLWC23W2SQX3mr2OpooyQsFAd9sHxngZmXyV0=;
        b=Q6ZG3m9+miHRN2V3IE5VIusc+5+0MszPWlkz5OasWQ5uGaUfY6DtMoD3nWI0fegu16
         SV48h6U985d4/RyKQtm6uWvGGDUEUjESKiTMijlqVB9zKIqdXhzUBHYivqtwdzT+RkZa
         rVTCUhbIR093WTgwcBCH/XwvAD9m2aYqlKsR0ZEeAW1DEMlwdlCQIDCMwDHkQXBLvkM4
         mWUwT0lL9QJhvmznikXUG4nWrEN1nh+vq2UjFtPQnIBoUa0QInpQ4SxjjOPYP2kO244g
         JgorJsN/+3YQroEp7dOt7G+L/HtoBvi/31dTLzlaTcMrNP3ccU35sGiKVmAz9TohmiEd
         ySNA==
X-Gm-Message-State: ABy/qLY6oylWrDeL+XuZJKERrwt/FSRHwfIOIBrzFUsOaBySUr/FYU7c
	X4chpFKUeizHkoaznhhejqM9bT3OuB++1ra4uURBQA==
X-Google-Smtp-Source: APBJJlHeKWUt+rQRf2rQvrQAyf3gBSy3SA70HBAYV5HjN15unr3agB9p4yrayUkvWy81/KSfnrFLPg==
X-Received: by 2002:a1c:7208:0:b0:3fb:d194:8332 with SMTP id n8-20020a1c7208000000b003fbd1948332mr2053373wmc.30.1689262134411;
        Thu, 13 Jul 2023 08:28:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fbb5142c4bsm18563121wmi.18.2023.07.13.08.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:28:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: memory-controllers: ingenic,nemc: reference peripheral properties
Date: Thu, 13 Jul 2023 17:28:46 +0200
Message-Id: <20230713152848.82752-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ingenic NAND / External Memory Controller has children with peripheral
properties, so it should reference the Memory Controller bus
Peripheral-specific schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml     | 1 +
 .../bindings/memory-controllers/mc-peripheral-props.yaml         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
index a02724221ff3..b40cec0eb651 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
@@ -39,6 +39,7 @@ properties:
 patternProperties:
   ".*@[0-9]+$":
     type: object
+    $ref: mc-peripheral-props.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml b/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml
index 5acfcad12bb7..5ff8cc26962a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mc-peripheral-props.yaml
@@ -34,6 +34,7 @@ required:
 # The controller specific properties go here.
 allOf:
   - $ref: st,stm32-fmc2-ebi-props.yaml#
+  - $ref: ingenic,nemc-peripherals.yaml#
   - $ref: intel,ixp4xx-expansion-peripheral-props.yaml#
 
 additionalProperties: true
-- 
2.34.1


