Return-Path: <netdev+bounces-44004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4057D5CD1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091461C20C3D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA93CD13;
	Tue, 24 Oct 2023 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lx2VCpRT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337102C852;
	Tue, 24 Oct 2023 21:00:54 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2085F10D7;
	Tue, 24 Oct 2023 14:00:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso34618025ad.0;
        Tue, 24 Oct 2023 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698181251; x=1698786051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLeHTuIsioFojx66+22McT0Ecap7gXclz1uLjqwzzm4=;
        b=Lx2VCpRTCoee7tOAcxZOZqJcGz/6njRH7aLD7zC/DKEvCWjlBtFnz9ggkVG4hckWMI
         MetZLJpE3gUzmEHJUD4CSEzBZobtNTt2y9NR2PD9rV4bAe7XgwRNTkp+tjq/8JLsMaK7
         Sy1HRGivBVXw5uOyfqTsGBHBo6LKa000OV/fPdLpBOk0/TTjRdwF9NSQTx2JiRDwt3ji
         b9SQAphz4HYejgzWgax6R1twrz1upDSFt7WFz5EJVGxD66y8yCenWVKmqXRQshj2QvYY
         GuY5P7AD2vjaM4Oea1bGRdLFOaGVHrYq0TsCCqT3A1susPs6PLGxyMkq2g18LtrLSA+y
         g5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181251; x=1698786051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLeHTuIsioFojx66+22McT0Ecap7gXclz1uLjqwzzm4=;
        b=Pz6McrwrJNKXBgOiqesv50r4CP8SAeTF4DTEXirkd9Y4BdvRRPuQAMDMuR7dimnUFu
         QJlwd2WEO+mjmqz1Ld4y7L0KD9YBHmfeCT2Gdk2ZXYfyoY/+B3DFkzEfOTOnTy8nr2Hp
         Lmyd46EjMEPMb/w+LX1VSBXEbGGQ0AV1XD2YLlCtsBeHl46lC7bP+sggdrR6MUBH/smY
         J7VMDnD07RUHGPQtfP2sVsaNTb1acgR7v5B2e1Y7l215TYSTpju9h6x5zHiQh7kfHv4d
         BYRxhr89g/9Ck6ZJ3iTAFoLpvW1jIu/lJ8IZwhLnz9Ul2WRL84+PK3wGa7uARGEALmnu
         ul5g==
X-Gm-Message-State: AOJu0Yx2j8o3Xe5eFNxc2YvtuUQxneycP31DScifV2Sa8g66vSL83v/a
	T+ljimeRjBz8AGGaJCOL+WkMOIQ7ATLc6Q==
X-Google-Smtp-Source: AGHT+IG68IHx0/IctnnUf8n+E8x4XW52Qr1GVh30Q1gkP+86LcopC6bnb5aXAzEnDMMTTG5kqMOSFw==
X-Received: by 2002:a17:902:7d8e:b0:1bc:7001:6e62 with SMTP id a14-20020a1709027d8e00b001bc70016e62mr9706416plm.35.1698181251023;
        Tue, 24 Oct 2023 14:00:51 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id je17-20020a170903265100b001c728609574sm7894803plb.6.2023.10.24.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:00:50 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] dt-bindings: net: dsa: realtek: add reset controller
Date: Tue, 24 Oct 2023 17:58:06 -0300
Message-ID: <20231024205805.19314-3-luizluca@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024205805.19314-1-luizluca@gmail.com>
References: <20231024205805.19314-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Realtek switches can now be reset using a reset controller.

The 'reset-gpios' were never mandatory for the driver, although they
are required for some devices if the switch reset was left asserted by
a previous driver, such as the bootloader.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cce692f57b08..070821eae2a7 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -59,6 +59,12 @@ properties:
     description: GPIO to be used to reset the whole device
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: switch
+
   realtek,disable-leds:
     type: boolean
     description: |
@@ -127,7 +133,6 @@ else:
     - mdc-gpios
     - mdio-gpios
     - mdio
-    - reset-gpios
 
 required:
   - compatible
-- 
2.42.0


