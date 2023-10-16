Return-Path: <netdev+bounces-41197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42B7CA3BE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2701C20950
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8991CAAA;
	Mon, 16 Oct 2023 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQb0QjKa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD871C685
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:13:02 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E3F0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:13:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso56690661fa.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697447578; x=1698052378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQgNJEaB9CDsyBYuoK51xMQLKTuugJ9THzHXrzK30U8=;
        b=nQb0QjKaJfnIvo4xGbOlb7nrByQ5Rzxb52OhRQingH6C7lOLJ6+YiClX5pi4SVfrf0
         CJB1vn/eD5cNAbQwpqc4vGlwM5DDzPrKJmhHpAK6QZP7Sazrwt12ZCyWTiSU2vSTyuOW
         M91/zICsKRcowA/fbLtD2jurEDb2iCjHktQV0OXBullY5DvOtK/2Af1PFnzJUnXHtbsn
         xzWmbzgFD4qkTLZ41IJGdW80y2AJV43bKvAi8IVR2891r0CPF3OFHeK6aXQZGyQK8vhD
         7BB+bd/jX9UnVZXBNlr136ByUytUMfoXCXGrPEhgDc/JEJ+9RpXBZhOjX+FIzKracN6n
         DGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447578; x=1698052378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQgNJEaB9CDsyBYuoK51xMQLKTuugJ9THzHXrzK30U8=;
        b=q2ZhYDSYgfLFchGQ0LUfcMGkxacbU4oQVeOGX230WAPR/CGXW4JbP72ptWn9koq7QF
         R+8LriDUb/45jcKKHdvclx1HxgNZjbEnrVPQwFDANI+gHsC8MQfo3w0mcnAdnUwJSqw8
         p+rB4inmJz9IOA/7ZypTncNqFtgwAr7AjR4ZsUJMt2KKUyLVgGwjTPlChulhlu/+caGP
         pWjWBvuNG9mnotwTH2gs3X+VI5xF37kpEz4qAu83qJtSZKegXkIE6rwMWUj2t/ULT+JC
         p3+mGNaMlH7oP6o/shp0orYK7KfCigE0dg/qgbWPiPdcN3GrhnrGsXHhRwHuD84D6DqO
         rjXw==
X-Gm-Message-State: AOJu0Yz7hTqErWA0gyd3stxtesfGaPfBKBLMqNGg96zUrBCej6XTGP9O
	jLe1TuSH782gYBPqIUrqJ2MWuQ==
X-Google-Smtp-Source: AGHT+IHOrYoJN6TnzySSc3vvbrP9tHzSMIjwBQxg9l9tIyLk+Fcasw6JOLV7wUx0Rx3P9qzDheo1ow==
X-Received: by 2002:a05:6512:39d1:b0:500:ac71:8464 with SMTP id k17-20020a05651239d100b00500ac718464mr33408434lfu.66.1697447578588;
        Mon, 16 Oct 2023 02:12:58 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id br34-20020a056512402200b005068e7a2e7dsm4160986lfb.77.2023.10.16.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:12:58 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Oct 2023 11:12:56 +0200
Subject: [PATCH net-next v3 3/6] dt-bindings: net: mvusb: Fix up DSA
 example
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-marvell-88e6152-wan-led-v3-3-38cd449dfb15@linaro.org>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When adding a proper schema for the Marvell mx88e6xxx switch,
the scripts start complaining about this embedded example:

  dtschema/dtc warnings/errors:
  net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
  net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

Fix this up by extending the example.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
index 3a3325168048..ee677cf7df4e 100644
--- a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
@@ -56,6 +56,12 @@ examples:
 
                             ports {
                                     /* Port definitions */
+                                    #address-cells = <1>;
+                                    #size-cells = <0>;
+
+                                    port@0 {
+                                            reg = <0>;
+                                    };
                             };
 
                             mdio {

-- 
2.34.1


