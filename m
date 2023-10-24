Return-Path: <netdev+bounces-43778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CF7D4BFB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E1D28193F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394DB23755;
	Tue, 24 Oct 2023 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJK7aXHL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0922F19
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:25:17 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48F10D5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:25:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507cee17b00so6196983e87.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698139514; x=1698744314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8dS0fiX8s3oTQdiSNWl2/6C6tud53gSSackCKtgSFY=;
        b=ZJK7aXHLn8PZUNU9rlSyESEpqM8kDce3ggBMM7u9hhH3jA44nHlr46RX8m9ufR05Ds
         kKSftvCEO9Fis5RWAnXH9VkULmP1jEJPqLQlr3pmbMoq60o6cY5v0xBobnDiRuEAHjbB
         Qvelouw47JRi5Qw0x1zR10DDyo1Uxdgz0b70/V/sebF7Ge9YfrgNhbxIzBGo0zkWKdd9
         DubP2vHdqbOODSwj23GXiRiCeew4zypchVi7erGM8mw41S1rNfmduMJKLBsSTGkKXYSm
         S0SgcyhCG6P1EJ5j+8dfojyHzs/y9G6P5eSdAOSlffp0NJvuKqMHvyOPNzlEWuSFGBCa
         fXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139514; x=1698744314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8dS0fiX8s3oTQdiSNWl2/6C6tud53gSSackCKtgSFY=;
        b=aEU2lqOxDLnC0Q0V/G8iLTEO0z0k7OVr6wvSaZW0NHiM3zMCOw6njCiIMikaqhlIu/
         ZDNFJx4CDlvXcSd34PTQKhLYcVn8pDvxQezsOASKKzxlFL8DYnQIydJXVg4i759JgBPm
         OSD8u+kS28qMu6ztE8DyUwAAbm0Q+4ThIDNJyrE6n7X+Uvkf8mQnup86APkxxg+zoFd5
         wR8/QhEDeMs5d/E0sTsD65j6xeebTrgdGTI+Bu58DSyssK7AS2Mj6U85Pyyg1fnm8AkE
         ld00bGVyTegA/UgUDtqNoUuchPvCEu+83cRDNtJP40qPJ+sup5RVE2Z+R4qUyMwCSwQz
         P+hA==
X-Gm-Message-State: AOJu0YwFuLTsHxDJfddIBc+mOHFbJSfM+YkEHEN4It4+lkS3KRHzObfS
	7jX/W2l7s9ur7FALleJ5KDGevg==
X-Google-Smtp-Source: AGHT+IEeJSXr1YgZmYIFPp6jS9ts3MwkUn+pOnlBFGKhRqBAjxdCMfGISVkgTdJczoseajqP98zwsA==
X-Received: by 2002:a19:8c46:0:b0:507:a087:622a with SMTP id i6-20020a198c46000000b00507a087622amr7387307lfj.60.1698139513947;
        Tue, 24 Oct 2023 02:25:13 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id c12-20020ac25f6c000000b004fbc82dd1a5sm2060246lfc.13.2023.10.24.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:25:13 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Oct 2023 11:24:54 +0200
Subject: [PATCH net-next v6 2/7] dt-bindings: net: mvusb: Fix up DSA
 example
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-marvell-88e6152-wan-led-v6-2-993ab0949344@linaro.org>
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
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
 Linus Walleij <linus.walleij@linaro.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4

When adding a proper schema for the Marvell mx88e6xxx switch,
the scripts start complaining about this embedded example:

  dtschema/dtc warnings/errors:
  net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
  net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
  is a required property
  from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

Fix this up by extending the example with those properties in
the ports node.

While we are at it, rename "ports" to "ethernet-ports" and rename
"switch" to "ethernet-switch" as this is recommended practice.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
index 3a3325168048..ab838c1ffeed 100644
--- a/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
+++ b/Documentation/devicetree/bindings/net/marvell,mvusb.yaml
@@ -50,11 +50,14 @@ examples:
                     #address-cells = <1>;
                     #size-cells = <0>;
 
-                    switch@0 {
+                    ethernet-switch@0 {
                             compatible = "marvell,mv88e6190";
                             reg = <0x0>;
 
-                            ports {
+                            ethernet-ports {
+                                    #address-cells = <1>;
+                                    #size-cells = <0>;
+
                                     /* Port definitions */
                             };
 

-- 
2.34.1


