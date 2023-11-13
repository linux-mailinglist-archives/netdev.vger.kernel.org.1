Return-Path: <netdev+bounces-47533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D87EA704
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400E01F23470
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08E3E47B;
	Mon, 13 Nov 2023 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWk9YWnA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A73D99D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:36:03 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5DFD6D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:36:00 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so66662681fa.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699918559; x=1700523359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuNdy95VNpWQjRKNnpzeQQ54Hlq4tpuG2i9HfgCgKck=;
        b=ZWk9YWnAIILC5S/hmsCw/pV/GPcrxB4VbupyLbglHBtUkXGtEJiJp2K7MC8P7e1Eq4
         ZifiLlUgoDrm+byqiQCFGi4APAzigOsPqLer9i26xrkKs9rx5IdkkuteSQhHwtq1YYf5
         ISIiK40dBqbzMrMpHXJ71WJnCdDzLwnkrGuteyw8FnlQpPadma591KgjXLrR8Ncrpkww
         4m59XyJpMJo6GO5oO9Zmk+GBZQ7g/hfZiGbTLdmUzHt4UH+33R9a6ZtVuT5cNgiS0tqc
         8CImP9eJ0CNeAssYb8vWYqedxE6319UZlj4pYbt0y66/ilTU7lG6E39y+qvRqsqmmcTs
         PDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918559; x=1700523359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuNdy95VNpWQjRKNnpzeQQ54Hlq4tpuG2i9HfgCgKck=;
        b=VgkDlbqiul+6eTM5i58VSFFnnUefqd3h65WpO6YMAcCEoYzxQIMSm9yB7cPY7fUEul
         x0fUTJZLYVhblyytW0jYCFRTIRnH56q+dZKZ1mDaIpzSwCrZO1o9CGOj68wGTjSXlHRD
         V50Ch5uKSqC5Z4PbUix4Tlb3POuE7vbA7YSn97Ncpvbc97ugQxYPOCf9NwHiD4O4GKEb
         bCjN3lZyi1gOswJRixa3c+CNd1dhliSgzTc9ddoyaZAEpjvzRiUPpgvGnt8dKuTB0LQL
         Z0DxNbo/NPmctMMk8bApat8q0QUYiq1n8mMwvaVe42TQzCtYz/zMJS0+5tIjZpwJauZR
         BdAQ==
X-Gm-Message-State: AOJu0Yzbm5b8ZVkbmlL9ANb7plqXX5oCpLd3hwIBM4n474yRtNxw9r6v
	/5O/YOyfMPqEXdtQKRzVefnsOA==
X-Google-Smtp-Source: AGHT+IH+vpWSTfI+TqOPfDKq76GtSXfLBIVn7t5E38cxEXvkov/kjCBQrBt7VVuzFvyFnuIoPT3IzA==
X-Received: by 2002:a2e:1659:0:b0:2c5:169f:ff03 with SMTP id 25-20020a2e1659000000b002c5169fff03mr475738ljw.5.1699918558910;
        Mon, 13 Nov 2023 15:35:58 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 17-20020a2e0611000000b002b70a8478ddsm1202859ljg.44.2023.11.13.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:35:58 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2023 00:35:56 +0100
Subject: [PATCH net-next v8 1/9] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-marvell-88e6152-wan-led-v8-1-50688741691b@linaro.org>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
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
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Bindings using dsa.yaml#/$defs/ethernet-ports specify that
a DSA switch node need to have a ports or ethernet-ports
subnode, and that is actually required, so add requirements
using oneOf.

Suggested-by: Rob Herring <robh@kernel.org>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 6107189d276a..2abd036578d1 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -46,4 +46,10 @@ $defs:
             $ref: dsa-port.yaml#
             unevaluatedProperties: false
 
+oneOf:
+  - required:
+      - ports
+  - required:
+      - ethernet-ports
+
 ...

-- 
2.34.1


