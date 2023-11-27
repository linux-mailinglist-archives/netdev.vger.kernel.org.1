Return-Path: <netdev+bounces-51356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D847FA50A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3289A1C20CEB
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D734CD3;
	Mon, 27 Nov 2023 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHVHU5BE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989992
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:43:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079f6efd64so5897063e87.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701099796; x=1701704596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laAP022lsP8tLUMRJS12kz9BQh0UCp0+Op3begljKsQ=;
        b=vHVHU5BE+wa2rc3yh2h9KurgMGJAXDqFpgFzOn864j46a3y/vwsdsK0whyNrHiGx7K
         OVy3C6i5UFXWaj4QbB1BNUsC9THkKo9Q1u+ccBmfZuM9ZCdnkqAfOOEMHT0yTIPGvO5P
         f1v7CCDG08mWJbdIaNUMXODIdziRr0NWT2bwAMEzRN6ScIggxwP8PLW8NlcJVUBIlxky
         zQg+Lx80fwkKFkHjwaH162iMpFg+3kxRDqdT/OU8u10ZwGHK7DGCLhzAp47GCcmKKvfY
         Vu8iE3G6BF+Wg2pdIsszfPSlhn6J6PoFCt+fB/uaz+tZe4IzPhcnLl10PSi83R2nwUB5
         YgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701099796; x=1701704596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laAP022lsP8tLUMRJS12kz9BQh0UCp0+Op3begljKsQ=;
        b=jR4z+HG6tch1NnSIlouRuTThMOZaXCNWNvIK/NqkP7BbQ1/y/yLOlphzsSmWiEEQI2
         VAf4kp5KeQY/CZv/YRb6W3LIWClK8fGb/VUmOtfv5uBwSOO0dblmOL9rKIXidfZd9y+I
         6YKffnj4b8mOV6e2fw5iCnROFYdky82GeChWyx9MTo442ijLyOcn6ZwMBQcwG/bszVdr
         DGs9eP93zT2rJanNWhokPHXP8raBT20Y5Vf0IBg3zwhlEpXn1bR3/wLOnpV5oHd6r+7a
         t8G+Bl/YJzcVyWULR+DNv6KHXc2t3WVQHBfAjnhhUoXJt6JmI6wFB8Zg3nj66EG2XD0j
         RbFw==
X-Gm-Message-State: AOJu0YxusknbdEJruU25jmQ4FtaVVJHCCHfLrcljbdnAzD+tFXIRLji/
	NNZsMW1AOYzvIoK8av1SreziEw==
X-Google-Smtp-Source: AGHT+IHYAPIK0kVbirWgTmBfDmamzEa/j5LAyTqDffhpjRhVqj7bTRWcf8vS5bUNEMjEXsL5Dt4YYQ==
X-Received: by 2002:a05:6512:3a82:b0:509:489f:d84e with SMTP id q2-20020a0565123a8200b00509489fd84emr11144123lfu.37.1701099796186;
        Mon, 27 Nov 2023 07:43:16 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2559c000000b0050ab86037d8sm1505049lfg.205.2023.11.27.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:43:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Nov 2023 16:43:06 +0100
Subject: [PATCH net-next v9 3/5] dt-bindings: net: ethernet-switch: Accept
 special variants
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-marvell-88e6152-wan-led-v9-3-272934e04681@linaro.org>
References: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
In-Reply-To: <20231127-marvell-88e6152-wan-led-v9-0-272934e04681@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4

Accept special node naming variants for Marvell switches with
special node names as ABI.

This is maybe not the prettiest but it avoids special-casing
the Marvell MV88E6xxx bindings by copying a lot of generic
binding code down into that one binding just to special-case
these unfixable nodes.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/net/ethernet-switch.yaml   | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-switch.yaml b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
index 72ac67ca3415..b3b7e1a1b127 100644
--- a/Documentation/devicetree/bindings/net/ethernet-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
@@ -20,9 +20,26 @@ description:
 
 select: false
 
-properties:
-  $nodename:
-    pattern: "^(ethernet-)?switch(@.*)?$"
+allOf:
+  # This condition is here to satisfy the case where certain device
+  # nodes have to preserve non-standard names because of
+  # backward-compatibility with boot loaders inspecting certain
+  # node names.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,turris-mox-mv88e6085
+              - marvell,turris-mox-mv88e6190
+    then:
+      properties:
+        $nodename:
+          pattern: "switch[0-3]@[0-3]+$"
+    else:
+      properties:
+        $nodename:
+          pattern: "^(ethernet-)?switch(@.*)?$"
 
 patternProperties:
   "^(ethernet-)?ports$":

-- 
2.34.1


