Return-Path: <netdev+bounces-14836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90637440BA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E2D2810D8
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C88171A4;
	Fri, 30 Jun 2023 16:59:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060817725
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 16:59:05 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD69F4488
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 09:58:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313f1085ac2so2317252f8f.1
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688144332; x=1690736332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlU+UgpZzYjQ8Qz1hoTyGS42vPJJFIQhlwcsmTQ11ZM=;
        b=a6hqvXY1JZ53EuG1WH+aJvzumRxz8MhojSkJAkXi5hAQb5v5fGuTTh4KK4Uw3cUajv
         PSjqHesy/jV0RaO96YTj4rT462zAZY19OyAkphRPRykyxTQTW/ANH1DuGHCOO/JulfVg
         nLaQqkH3L0YtaMY5x2h3+NvSw4clXziXBZzJBYWjnzXrs53abbtjZYHMibeluJrAODfz
         mWAKd7fyLySIipmS+LO9d+UPhPX5vI4CZ/owp3JTgP91N7FWy9g3So2NQhDOWWDzeCAH
         jPf+E8YYg5uOZXJkf2PACxH6JZw4pWGh/bZkOUTqSVZVfahLS0EYYq8uio+V4gidJnEr
         kDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144332; x=1690736332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlU+UgpZzYjQ8Qz1hoTyGS42vPJJFIQhlwcsmTQ11ZM=;
        b=mHPqKxMJ7ZiIOYm14k/b5hWSeLxgbEhUdXYz1rKEEXHkNBbMQcoU9h31f28K9Ybv2B
         yM/kON7C37JrXFsckNNOBUcGQKbK5IllPwPUDJNcYFACQ/0A5l+DwrpmAp82Hc+KYU4Z
         HUwS+07+VTdKHoLBEsTBBktnUC61lCMCMgddfmWQcDRET7DcumnkgvcpzsSjKoiHcTxP
         SvP9VjZHN4RbRExmjBVB+40CxKXQ4K3vJdAfRE6+FbIibGzYQEkgeZJ6UqNoPRzuPFj7
         +2pOW1PzaC/CeCYK383OAGYGitcpcWuOiea1hnQ5WW2Ip3Eexkp4nbP23EE93De8B3n9
         5Ktw==
X-Gm-Message-State: ABy/qLYIl6ubv+vvoLcscgCbQcP8ctzZ41glcfjUXOVD0JGlRku7JJiT
	+XuXCScOn3rbek0BvkMuRy8Eww==
X-Google-Smtp-Source: APBJJlGMQoq8MJdB0hfT3I6T0d0F1LVt3vu4+o1NWHKLvHvj4GZq3IgRqC7tve+tvUz9c8RXUpjMNw==
X-Received: by 2002:adf:cc81:0:b0:314:d19:fc31 with SMTP id p1-20020adfcc81000000b003140d19fc31mr2913745wrj.51.1688144332721;
        Fri, 30 Jun 2023 09:58:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm18913772wri.73.2023.06.30.09.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:58:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 30 Jun 2023 18:58:35 +0200
Subject: [PATCH v2 10/15] dt-bindings: pinctrl: oxnas,pinctrl: remove
 obsolete bindings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-topic-oxnas-upstream-remove-v2-10-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-oxnas@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lU0Rgil/ev1/BqzGapYknrWAekAzhIDCjFFvr/Tl7mg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwm4+5/g0rcYb66QxjBIlFiUjvocLVgWZT6mtpaE
 GF1Pn0+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8JuAAKCRB33NvayMhJ0dPvD/
 93ZAw/LIPqNPF0li9/7yv9xUx84tStF1AkO8ltYZ00U95njJe5mPlivwj+pDdPNLiCEk2nmUPunY3M
 7CuVgtBbHpWcIqx8BDZ70S3yrj6NvQ4MaoES6FuoTEwqXEc8PMvk6wEkEjfL0M13jSe/oNVrYgnzlq
 tenzbEkFaTh5Hgi4XxDqiMvprL37YdzCRzmsoic5XqS2eewnvUAUqy+rhQ1GdnpyiOVv8V0tp4Pqm5
 9cOwbashPgyJeWOsmnzN6Rae795M5pTBkJx1knCyQtXZLKEPNifnQOCfpzSjIFHuPMTqYDQzeZetvI
 fjP4q1vHO1m6hvP6sYHb4iMNXi4ho37b8eUabnUBZP2syBsyP+UBeL0f6wMbDE4Bqyc8i2Me9rXVVD
 qbaKXAAZzqiZgNKBbCRSU+kwDU0/mZVH9BNnAORdEYeYo4XSglwuLtKubLamhA1DHbMmeO5spP202f
 3O5Rg17wscN4iJbKsZjfzH4YJ2Vx0gMqEO77pyJhyhxiLkXDfiHiX3ESELQpbUQb76vCDlxOvUNIis
 sLVWN+pk3K2ckjcQhpsFrL3blpXjHiNTZDdFkjiMf2MdFl69K2sRxnNDEvBZCAAkMBXGExG5t6kuE5
 YzCjrEAZmHYK/h/PtJt2bj+n/N+O8EIkQJnxiI6dKaSy/UtKIirJ4XpqqPqw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 pinctrl bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  | 56 ----------------------
 1 file changed, 56 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
deleted file mode 100644
index b1159434f593..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Oxford Semiconductor OXNAS SoC Family Pin Controller
-
-Please refer to pinctrl-bindings.txt, ../gpio/gpio.txt, and
-../interrupt-controller/interrupts.txt for generic information regarding
-pin controller, GPIO, and interrupt bindings.
-
-OXNAS 'pin configuration node' is a node of a group of pins which can be
-used for a specific device or function. This node represents configurations of
-pins, optional function, and optional mux related configuration.
-
-Required properties for pin controller node:
- - compatible: "oxsemi,ox810se-pinctrl" or "oxsemi,ox820-pinctrl"
- - oxsemi,sys-ctrl: a phandle to the system controller syscon node
-
-Required properties for pin configuration sub-nodes:
- - pins: List of pins to which the configuration applies.
-
-Optional properties for pin configuration sub-nodes:
-----------------------------------------------------
- - function: Mux function for the specified pins.
- - bias-pull-up: Enable weak pull-up.
-
-Example:
-
-pinctrl: pinctrl {
-	compatible = "oxsemi,ox810se-pinctrl";
-
-	/* Regmap for sys registers */
-	oxsemi,sys-ctrl = <&sys>;
-
-	pinctrl_uart2: pinctrl_uart2 {
-		uart2a {
-			pins = "gpio31";
-			function = "fct3";
-		};
-		uart2b {
-			pins = "gpio32";
-			function = "fct3";
-		};
-	};
-};
-
-uart2: serial@900000 {
-	compatible = "ns16550a";
-	reg = <0x900000 0x100000>;
-	clocks = <&sysclk>;
-	interrupts = <29>;
-	reg-shift = <0>;
-	fifo-size = <16>;
-	reg-io-width = <1>;
-	current-speed = <115200>;
-	no-loopback-test;
-	resets = <&reset 22>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-};

-- 
2.34.1


