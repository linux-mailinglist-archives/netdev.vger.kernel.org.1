Return-Path: <netdev+bounces-43356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494037D2B0B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC422814A4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764710794;
	Mon, 23 Oct 2023 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ns9iRyBm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17476101EA
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:19:13 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE173D70
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 00:19:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a3b8b113so4345702e87.0
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698045548; x=1698650348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=ns9iRyBmplWE3aUJQW8Ri3OqhrBoAB6NaDocqu7c4oIrXwXNdDmxK33gUw3KHmGqhl
         Q7afDVJxULV1AdI8LLwbIHVQiPQRXuZkWRgTHnPEWZ/e/VPrSAryVIGg7plNkzicqABR
         v6I0laHJynJjrGIpTI6Yvi+d8Uh8vB7rE+5jh5fmIe4/213PLZtNB+nAXo+k5MtxfNiO
         nKlpJ8mNQSNR7chCQoCp3sJpESQRIgKVZJQmvdp+hiyEYHIGtJP4K7u/gTzCOe57hxNw
         0+EwsmoHFnV/9hXOzcERnpAxvH9rKITFN0Ynfg9Y8CBqKpRCbupSxV+Tp3P38qqPND//
         iyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045548; x=1698650348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tyOup0+oFY1qNiEuX6Mw7ppmGYAINv0IB1dZ7z8mjE=;
        b=iKXwuNlfZtAYShG1GSzdKbqwvSwYjTtZVn3T2Azel9QOYL9Zi6XMjQcz9wTiaQDo8l
         wWqaq5/ZGLxRFoDV+SBaWeiFeqhmxxilyA1ToWTUaiMG+qh6CtjGDzJhnuKZSjd7IPpr
         S8QymzQZ3yD8CZ1kWY7VTXbjt30in2XK9bDlk6mttJs0Ta/DXKJiKKcGGIiwP6kZFvW8
         r/xJ03PlRMXatmUVjTYbxat4n7jbMG05DkSM6p8kASIS6P2Zwj1A6Ek+eC/mBzmFeO4e
         fkip4qigy+/Zu2NeOU5CzRCwXoqKAWy3Pg0a1LEzYHa13mc/tBN7tdqHG1VHxIqe3O2x
         Cmaw==
X-Gm-Message-State: AOJu0Yx5z6QKnbT6EOnQDqv1CTnOFFyIL9TTo5vk8/CzaiFXQAKdV4bm
	/XqoLud1vk3W9bcQYps/PZM1Rg==
X-Google-Smtp-Source: AGHT+IGDalWEGxPNcMqfMhzsK7CMCx7fUXXylPNH6oOJUMXrVw7IaZ2iPNraUE0ypwwaZpR/UEtg0A==
X-Received: by 2002:a19:4f16:0:b0:507:aaa4:e3b3 with SMTP id d22-20020a194f16000000b00507aaa4e3b3mr5101284lfb.50.1698045547836;
        Mon, 23 Oct 2023 00:19:07 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651204cf00b00507a682c049sm1578727lfq.215.2023.10.23.00.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:19:07 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Oct 2023 09:18:52 +0200
Subject: [PATCH net-next v5 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-marvell-88e6152-wan-led-v5-1-0e82952015a7@linaro.org>
References: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
In-Reply-To: <20231023-marvell-88e6152-wan-led-v5-0-0e82952015a7@linaro.org>
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
X-Mailer: b4 0.12.4

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


