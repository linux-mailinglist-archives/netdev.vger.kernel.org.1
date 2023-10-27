Return-Path: <netdev+bounces-44836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE77DA129
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A051C2114C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E43D3A9;
	Fri, 27 Oct 2023 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i52M5Ctk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0A18C2E;
	Fri, 27 Oct 2023 19:09:59 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A25E1;
	Fri, 27 Oct 2023 12:09:58 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b52360cdf0so1463872b6e.2;
        Fri, 27 Oct 2023 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698433797; x=1699038597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPqEy9jv1wfSRtPqoFs4WQDF0XgSUK8DzG8WnJXocV0=;
        b=i52M5CtkDcAN2HLiUsr0F5eNvCCH1jFbkv6etwtbuE+JCwsxy9PK9ty6Qytzb6Ioi7
         63wwayajhidvszd1RuqYegN89HbaRoNQoS+XQMbpuuvRzYrs3k6PfsJuquJZ5KJqYEnT
         dBkuXTWufzYxHsqCsaTThcHRroj10IdYCUEl4aIxgNuu87vTATolY2Q/GWlsB3cG9qA2
         tBMEXOJFBVyoj/p/viml59yCgueHf8rmYyc0i78YBCf5ODlR1rQnv8INeSwycmnhT1PM
         1xMzATZzzpzO1banN5OpXoHrn1f3TW4lgZwBOKHo28cEyGEd70psAMVZSonf00haTN44
         Wz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433797; x=1699038597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPqEy9jv1wfSRtPqoFs4WQDF0XgSUK8DzG8WnJXocV0=;
        b=ZlcOy9gVJDwKDiSR+Gw1ANcqaExkQXDRvz49RX5zzXQAsO0aNSEYqojhRczLDimUpx
         RoPiT1JdR8DSKHXs1q9OTkmsnyuzgajr3MIul2zftJetEflIuZQKwaSwl8SevfE/d2e/
         a38pP9TYoKaXF+IFTW2a44fAm6Ac1UeMPe9WatZYJeQ1Ikos6qgD5VrCMCkLYaWMjXwh
         tzUxCQEDrTAZAj6orOsxcOFGW84Lrt0lGdiV8N4HTqOMy+nh0RzrBn6mDwenyNmqBhCI
         R960ezDgd5vDK1cRxozAORv55xRtGJkGe7uIpmnikazbtoqbcNpDQoUkttWD84ySa9pV
         YQSA==
X-Gm-Message-State: AOJu0YzIOpKXgpB9+tOwPmrPd9HBnJTSbrtcF7ZsMgwYB0FgDS05pYlD
	lqbOBjwjuirlNJFf6nTLXLU/k9XyO16aKQ==
X-Google-Smtp-Source: AGHT+IFdVvEh3Q4QtZj4reidkBZucpEkboPs3FCTlb7ywcKmUjIMx923UhFV5KD3cCXOrgZ2BYk62Q==
X-Received: by 2002:a05:6808:2c9:b0:3b2:dd32:2fe9 with SMTP id a9-20020a05680802c900b003b2dd322fe9mr3514384oid.35.1698433796956;
        Fri, 27 Oct 2023 12:09:56 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id g190-20020a8152c7000000b0059c8387f673sm958696ywb.51.2023.10.27.12.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:09:56 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	vivien.didelot@gmail.com,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 2/3] dt-bindings: net: dsa: realtek: add reset controller
Date: Fri, 27 Oct 2023 16:00:56 -0300
Message-ID: <20231027190910.27044-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027190910.27044-1-luizluca@gmail.com>
References: <20231027190910.27044-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Realtek switches can use a reset controller instead of reset-gpios.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/net/dsa/realtek.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 46e113df77c8..ef7b27c3b1a3 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -59,6 +59,9 @@ properties:
     description: GPIO to be used to reset the whole device
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   realtek,disable-leds:
     type: boolean
     description: |
@@ -385,3 +388,75 @@ examples:
                     };
             };
       };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    platform {
+            switch {
+                    compatible = "realtek,rtl8365mb";
+                    mdc-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+                    mdio-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+
+                    resets = <&rst 8>;
+
+                    ethernet-ports {
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            ethernet-port@0 {
+                                    reg = <0>;
+                                    label = "wan";
+                                    phy-handle = <&ethphy-0>;
+                            };
+                            ethernet-port@1 {
+                                    reg = <1>;
+                                    label = "lan1";
+                                    phy-handle = <&ethphy-1>;
+                            };
+                            ethernet-port@2 {
+                                    reg = <2>;
+                                    label = "lan2";
+                                    phy-handle = <&ethphy-2>;
+                            };
+                            ethernet-port@3 {
+                                    reg = <3>;
+                                    label = "lan3";
+                                    phy-handle = <&ethphy-3>;
+                            };
+                            ethernet-port@4 {
+                                    reg = <4>;
+                                    label = "lan4";
+                                    phy-handle = <&ethphy-4>;
+                            };
+                            ethernet-port@5 {
+                                    reg = <5>;
+                                    ethernet = <&eth0>;
+                                    phy-mode = "rgmii";
+                                    fixed-link {
+                                            speed = <1000>;
+                                            full-duplex;
+                                    };
+                            };
+                    };
+
+                    mdio {
+                            compatible = "realtek,smi-mdio";
+                            #address-cells = <1>;
+                            #size-cells = <0>;
+
+                            ethphy-0: ethernet-phy@0 {
+                                    reg = <0>;
+                            };
+                            ethphy-1: ethernet-phy@1 {
+                                    reg = <1>;
+                            };
+                            ethphy-2: ethernet-phy@2 {
+                                    reg = <2>;
+                            };
+                            ethphy-3: ethernet-phy@3 {
+                                    reg = <3>;
+                            };
+                    };
+            };
+    };
-- 
2.42.0


