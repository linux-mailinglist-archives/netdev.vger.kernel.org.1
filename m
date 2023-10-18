Return-Path: <netdev+bounces-42168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AFA7CD76B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F22281D78
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFD171AE;
	Wed, 18 Oct 2023 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJ1wYng2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA15168A4
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:03:55 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDDFF
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:03:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso6365091e87.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619831; x=1698224631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=qJ1wYng2P/ZY4bg8Bl2Yx5rMa0McXZe1kIvz6BSt706kQFSt2ugMthu+brJHImmlnu
         S1RlFuULhpnTdGoMxZu9JYBvJitNRYG07BXnz5CSRhzRO7COYkkYp0dix/gIYNyNcC9i
         Ha9RX/7UDk1Uk2qbWr27Xw+gBacCefSQeddwEdJ8ztuf0MZV4BL6UEg133XmV73tc/sd
         zPF02RJEGNiEQYKzFPKDr7bZj0c10em8c8CidnG1VOUEzQr5iV+Evq8R+LT6i+UxMO4C
         3UzvsbXYT7g7QeBhR+fnsQf0rRwiZlhdocmamphwDoGjZEtjwlpoTkaSuA+yOE+hnO8f
         PdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619831; x=1698224631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=uTsftYE+LOOqXnViRDiFptO2haX7gqmGxe/O/Eh/S1JShsJbhY/iImQO55WRZl8S9q
         EesV+uTVT4+esv12J9+ZnYTpk+EwnGTP5SI/VBAItwB1aDVJ0PT6phjLYzrseqEe1FqG
         9S/MNTYtbXsyvNTLyCTdEv8YwEHqKVvx2AWyovEjo8bx/5MDfnwCX2SZ4JnHKSjGrHTt
         xrw8d9hGawxxBIyoAPnQWDG8otmCAejXt5mzWuffe91l4z59pGiMZyblFYIoc97wf6qJ
         1f3i+MhobwD1BYd+VNQNuRnlQrBo6aeHpYaTWE4faQAFzw8xgjJmv5DyaVWpAtvf7+aZ
         WEyA==
X-Gm-Message-State: AOJu0YxaPHoEeI5lzGZj1lz67UV4Xqtc2Cvz/qtBcKE3ryre/TAFV7Nd
	59iSnVyvTIellsGuAxKQ1krBnQ==
X-Google-Smtp-Source: AGHT+IHMybJsDSExgJDVQSeN8JuA3T6ANKH6zJvy1EbxZZ9HCZV/eBXaUEtw9UO7m9Jtm4N4sfn9zQ==
X-Received: by 2002:ac2:484c:0:b0:4ff:a8c6:d1aa with SMTP id 12-20020ac2484c000000b004ffa8c6d1aamr3328690lfy.48.1697619831405;
        Wed, 18 Oct 2023 02:03:51 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b005056fb1d6fbsm616595lfr.238.2023.10.18.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:03:50 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Oct 2023 11:03:40 +0200
Subject: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
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
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bindings using dsa.yaml#/$defs/ethernet-ports specify that
a DSA switch node need to have a ports or ethernet-ports
subnode, and that is actually required, so add requirements
using oneOf.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 6107189d276a..368169f7fd37 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -46,4 +46,10 @@ $defs:
             $ref: dsa-port.yaml#
             unevaluatedProperties: false
 
+  oneOf:
+    - required:
+      - ports
+    - required:
+      - ethernet-ports
+
 ...

-- 
2.34.1


