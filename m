Return-Path: <netdev+bounces-22525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19837767E75
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45DC1C20AAB
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB21427A;
	Sat, 29 Jul 2023 11:11:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C710F7
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:11:01 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6FC2D40;
	Sat, 29 Jul 2023 04:10:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9cd6a554cso25148521fa.3;
        Sat, 29 Jul 2023 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690629057; x=1691233857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2WVsYTQao4k2m790yPgkBUcRYo/CRh/+UQCuqc56fg=;
        b=LEfdG5XH2AcG3bXPLaz5HA6B97CYkDq073HkUfNWKsBlgbvPwMArsTrm5elIgdh1P5
         0DoGFQvIPrhF1xmk4EXgKEg4koY1oZ7HeQo/e7mcM5VSG5EFwQ7RerhzVrR6Nh7I+8Jb
         MmcY8i7SHesvrAaOZd+TaAFqCUH2/QAXO2mf53HT8aB3e5pdJtvi7yq09dU520Kr5yun
         xL5lOGj5yUyT8sCRNOvRo3xPBs9ZOL+OcT3Qq8ECp4+GXAfIRe/XmsrjGvBEMflc48BK
         MeY1kp388s2uWKYsl+jDLSoz5NkInS+s4H/c/67HouclnRn+ZfDVdYN5LumdACbAiVxq
         EncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690629057; x=1691233857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2WVsYTQao4k2m790yPgkBUcRYo/CRh/+UQCuqc56fg=;
        b=Y0TGqOMIpNohhzQMefNzwG29T33/N7+9vjq0K4dp1wIi6XIw4obDb87Z4WTlWK57PG
         okrVIeSZwAlhfRjAjBoRb0Fs2Ce/amowsVZ4sE4MA2Rnd+dxRgjnIiKbusHqcwXNGwIz
         62vdEvDaZDpvqGBRgk++MVNN8H/pEu0uIg+G+bg73SM8SUkIOj6O9Nha18DlwSaKgZTJ
         H7dZ1a9v/NAQpHm3TX+D/1ZJMQsfev0x9kXBaGhM2TD15fXbb3TyeSV2sJa4pEjIDOT9
         oRCM5elXEPn9Ok6ChKUni+mniLjeif8SREdEndRMigoI6x2FeUV2UFDJm7f61Fg63WKF
         rAVA==
X-Gm-Message-State: ABy/qLaw5hxzkfKI4rdcpMVo7PHdQZMbJ0Fsd5jyGcq5ZePLEfLkclNj
	Y/ZKtV7xStQZVt/L18+VIr+MnHyuxSG5SQ==
X-Google-Smtp-Source: APBJJlGSvHFxXqv2qEmmPgRag7EgXKr0lr6BjPH50xKtDWH+GJeG5BkdOA1kuXoQrmkg6KwgOzyz/w==
X-Received: by 2002:a2e:3603:0:b0:2b7:764:3caf with SMTP id d3-20020a2e3603000000b002b707643cafmr3363513lja.10.1690629056721;
        Sat, 29 Jul 2023 04:10:56 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id i26-20020a2e809a000000b002b9cc2f5c39sm1064989ljg.37.2023.07.29.04.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:10:56 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: net: mediatek,net: fixup MAC binding
Date: Sat, 29 Jul 2023 13:10:45 +0200
Message-Id: <20230729111045.1779-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafał Miłecki <rafal@milecki.pl>

1. Use unevaluatedProperties
It's needed to allow ethernet-controller.yaml properties work correctly.

2. Drop unneeded phy-handle/phy-mode

3. Don't require phy-handle
Some SoCs may use fixed link.

For in-kernel MT7621 DTS files this fixes following errors:
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@0: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@0: 'phy-handle' is a required property
        From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@1: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
        From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml
arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e100000: mac@1: 'phy-handle' is a required property
        From schema: Documentation/devicetree/bindings/net/mediatek,net.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 8d3554818c37..e74502a0afe8 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -388,7 +388,7 @@ allOf:
 patternProperties:
   "^mac@[0-1]$":
     type: object
-    additionalProperties: false
+    unevaluatedProperties: false
     allOf:
       - $ref: ethernet-controller.yaml#
     description:
@@ -400,14 +400,9 @@ patternProperties:
       reg:
         maxItems: 1
 
-      phy-handle: true
-
-      phy-mode: true
-
     required:
       - reg
       - compatible
-      - phy-handle
 
 required:
   - compatible
-- 
2.35.3


