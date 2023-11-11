Return-Path: <netdev+bounces-47210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6FC7E8CF3
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 22:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B44280E31
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 21:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BC1DFD6;
	Sat, 11 Nov 2023 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XblSY0XV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86361DFE4;
	Sat, 11 Nov 2023 21:57:17 +0000 (UTC)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309B2737;
	Sat, 11 Nov 2023 13:57:17 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a69a71cc1dso122293739f.0;
        Sat, 11 Nov 2023 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699739835; x=1700344635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/5uDgxkKk+a96wf8mqYcPgtbw0PYyOeWz5yErsLgRI=;
        b=XblSY0XVHfDSowtYdIsTj7bAcm+kWdLL1iqV+R4vSNn0QO2uN9Mf0n24EhiUXbMuHk
         BaotuSdpnb7QfPH1CY6QE0BjE5EhI6p2PGd9GvhmcJsSI4g0m6tBenQRuqRPF2K/Ucc/
         9TGCyJxXCoZuIY2xcAHoIIHXQx2tgZhSzF5cxPTgHZJeS1A2XE3o4YOolCYxlgUt5OA0
         a3M84/noLxh3/kw7CCLwQouLNbgtqXKeH2bTV79wKekJdlRy+7I/ILAvTQ9qiguG4Fg2
         gWckUYA6QkIzzi0VDzhhswEodKcwMxmWWOZBhqIco1sebz3o+H24Zqs4+Ykyk+qGLRaI
         aaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699739835; x=1700344635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/5uDgxkKk+a96wf8mqYcPgtbw0PYyOeWz5yErsLgRI=;
        b=SgMb7UAMTZEKlVf5nbBm9gKdVo6gf/i9kZBNEzR20gq+FYO4V1DUHBck4X4KxUvGbX
         veZD6n2konwL7eH/w6OR9SCRCpzXdRylPK2YKjvzC5lX66MUN70knjnLHZcLZjt+H4/5
         yWXDmWhal5faEQax54dL+lLKJQVbDOrsuaA+EmzN8f8soQMuNVWe/z7FMTjH49yeo4PA
         Xh/EqxDAut3H+lTKRKpsoZvfeS99BoF3PEBBdH2yEklbzvUgHsgxWMf7l0uRQUN3yekX
         gKwIr5TP4YQcH7GyRRwnGfaahOR6rnA271IzIjrpzbRmYn1tGPN2V+uQCDFN/zeGUTNs
         rWNQ==
X-Gm-Message-State: AOJu0YyMYeUIxW/yvih0n8UXhr/WUkBXCDtgyWZZHbRLXj4jl+VTQx++
	QbF/J0jIzmq/QeshZGWVdUj2vWyvHZIUUg==
X-Google-Smtp-Source: AGHT+IHQ/jyTmvo2HXsC4gEuqg9za3k/5SvHaVttATYDSDe3/aCAD+hkt+Dpna0M4yCz8kPRP7x8Xg==
X-Received: by 2002:a05:6e02:1a8b:b0:34f:70ec:d4cf with SMTP id k11-20020a056e021a8b00b0034f70ecd4cfmr4819948ilv.8.1699739835397;
        Sat, 11 Nov 2023 13:57:15 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002801184885dsm1867210pji.4.2023.11.11.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 13:57:15 -0800 (PST)
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
Subject: [RFC net-next 2/5] dt-bindings: net: dsa: realtek: add reset controller
Date: Sat, 11 Nov 2023 18:51:05 -0300
Message-ID: <20231111215647.4966-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231111215647.4966-1-luizluca@gmail.com>
References: <20231111215647.4966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Realtek switches can use a reset controller instead of reset-gpios.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 46e113df77c8..70b6bda3cf98 100644
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
-- 
2.42.1


