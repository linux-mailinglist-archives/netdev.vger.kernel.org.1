Return-Path: <netdev+bounces-25089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02746772EBA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334E11C20CD5
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359871641C;
	Mon,  7 Aug 2023 19:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB171641B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:31:36 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0FA172A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:31:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31763b2c5a4so4255423f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436693; x=1692041493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAPKS4SAXmZKxicJb9ydkGPtaas2WIonOZ7to+HEfxA=;
        b=tOmh3T/d1Kx4g5+xfWbagK8zeGuje07up/l4PO1tcHXwuVmvIvKezEFEUOszEceBwv
         WLoDiMbUQkX8jTprThvfI+94af++yK1HBv5TLq1zf5liFa6GUHWuLrbyYBO0KyAAx0sW
         G2YMRuSYtUZkPA6TUkDb0scVx1tV5W+yGsHfFKU+iwvrWydYuU/0Yd+dyq0Z6CgdXhCl
         kxKph2hAcWnEy/TuTREzxTULR40oj+9vctCBPlWjIp1S+PjMazFOy9kN+l9V1dn6ae0X
         x8M6Hk9pZxtjeD89oR/plTnS6CIGysZeXPcQ6k/Tppw434ibY95fOMnSJJIDiU5GfYxO
         OpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436693; x=1692041493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAPKS4SAXmZKxicJb9ydkGPtaas2WIonOZ7to+HEfxA=;
        b=YprjosGPfjtKtSQegV6Wd4aKHOkhGk66rGdWVoe8tpoqw1Giu1SboGJJV24CbotXVd
         4F9ZrOkKbN1XEdKfpbjTNkvjup5vvMnV38Y55CE7rFMnajatlAPIzdowRUMwRMpX3hU0
         9+yBAhtA57QuzyvlKk4nYrg0L/owZO7Wtfjd+WC4Z7vQ04T7lreQcsfFl7Pmpdt0De4L
         ELKRfU/eMNBpYLLvRWDphofb+i1Y5RnEAFumU5OYrZh0IKq2SYv61XFm5OyoxJdDm5fA
         8VeFsf6x1ZLSIizYJL8wBbPSG5A39L94jRI9PjwTcE8HoLc2YhGUyMxDu8veVtLuBx/f
         CHxw==
X-Gm-Message-State: AOJu0YyCag3ba/eZENo1xKjmfHNsdQAqSs/fIt4kaVEEuSpTrO+bE0mU
	fvzAxYJLN7zlRtlw5PVZUAeIRg==
X-Google-Smtp-Source: AGHT+IFftT9bB5ixmjqvw1q7hvp1QMCeUhqraDuekV0noaWoXd5f9+2RWAbtpR5sMmr8DxPlkMO5oQ==
X-Received: by 2002:a5d:6683:0:b0:317:67fa:eeb4 with SMTP id l3-20020a5d6683000000b0031767faeeb4mr7411809wru.57.1691436693519;
        Mon, 07 Aug 2023 12:31:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003fbdbd0a7desm15985654wmj.27.2023.08.07.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:31:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: net: snps,dwmac: document the snps,shared-mdio property
Date: Mon,  7 Aug 2023 21:31:01 +0200
Message-Id: <20230807193102.6374-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807193102.6374-1-brgl@bgdev.pl>
References: <20230807193102.6374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Two MACs may share one MDIO lines to their respective PHYs. In this case
one of the MACs is the logical "owner" of the bus, while the other can be
considered a secondary controller. Add a new property that allows one
MAC node to reference the MDIO node on a different MAC over a phandle.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..f9c2285674d1 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -500,6 +500,12 @@ properties:
     required:
       - compatible
 
+  snps,shared-mdio:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the mdio node defined on a different MAC node which this
+      device shares.
+
   stmmac-axi-config:
     type: object
     unevaluatedProperties: false
-- 
2.39.2


