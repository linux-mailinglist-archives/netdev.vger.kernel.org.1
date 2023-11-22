Return-Path: <netdev+bounces-50286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 145997F543B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 00:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D888B20D8E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFF200AE;
	Wed, 22 Nov 2023 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/xO5qee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D431AB
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:09:15 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b35873201bso8157939f.3
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700694554; x=1701299354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGPBNCqlVNas6AbndJSN5DY6WrC0n52CMV5MihrDmb0=;
        b=b/xO5qees7EqkpwXoWTBlJQDwkyPae1Bap/fGD0Fipu5RkIHG2W6oApLYzpXUohWZD
         Lv6TknkduSPuANWvpbsIPmVXnUzu7St2MUn3IdEEeF7yC3WItp3d5BH7cv3N09JzqOFy
         4ChCRD0pIT1ZyvNatukLevgsoLC//KHllmbfIZnqaDhLEXPlpYACTLJUfe+A7YsIaBAB
         wE+6Sw8R8+MKwt9ftzXoqlPF4yyojvnRfZN/6q586uHBX5dgtB/E+qTNzYHt+cL8yP1s
         3VILge6YFxko+3VZQgyH8x5SMAMndeH1DEk8cQba8TAU4Pcf00ulgLTzO91FSRo/adYD
         8A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694554; x=1701299354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGPBNCqlVNas6AbndJSN5DY6WrC0n52CMV5MihrDmb0=;
        b=AMgRiVP8clsFRaOTW6ZMt2biYVAG26DTFGtfvFYbK9iciBAcVctAUyp+SdxEfwjoBc
         eUrEVs+5nlViiG8SwfbwCsf8Tgn+VkfCFSCpY1O2RWnzbRkYueD0hbynyljRJZFmp9oO
         zjPQSZItSvZunVSBdjWXAubHYgtxYwQryc6Z8krCa/76aJHugBgjSK6WsllkxeAFj0Sj
         2GxgLKyTq8UvTuTJwHQuuHzbprhNP7TceRas4eWtaT5kAf5oi7zaETot/oji+Qu7oSjL
         EG7fvcF7gHSIeV0XDGKwj4EOe93Dc7H00Kw64jf9C4sRp1j5jlgsnXOFgKpqsXjd5fKs
         JyOQ==
X-Gm-Message-State: AOJu0YxAXqaQA49o6WuJuRE4lfCMp0BNr7TfoXOpRCeN7V6Lhrwo4ZaY
	mAlVxyFOx/HTbFbCSJOcvnaNOQ==
X-Google-Smtp-Source: AGHT+IF7dOhUvqzK3l8JX28iP7y9sInGo8bawEHOVGUWubN6lD0OrylMu/vBfpWrPKRkI2Laj9ticA==
X-Received: by 2002:a05:6602:3713:b0:7b0:63ab:a2c2 with SMTP id bh19-20020a056602371300b007b063aba2c2mr4122698iob.20.1700694554628;
        Wed, 22 Nov 2023 15:09:14 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id fm29-20020a0566382b1d00b0043a20ad93c8sm117754jab.41.2023.11.22.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:09:14 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	agross@kernel.org,
	mka@chromium.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] dt-bindings: net: qcom,ipa: add SM8550 compatible
Date: Wed, 22 Nov 2023 17:09:05 -0600
Message-Id: <20231122230909.895482-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122230909.895482-1-elder@linaro.org>
References: <20231122230909.895482-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SM8550, which uses IPA v5.5.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 2d5e4ffb2f9ef..702eadccdf993 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -52,6 +52,7 @@ properties:
       - qcom,sdx65-ipa
       - qcom,sm6350-ipa
       - qcom,sm8350-ipa
+      - qcom,sm8550-ipa
 
   reg:
     items:
-- 
2.34.1


