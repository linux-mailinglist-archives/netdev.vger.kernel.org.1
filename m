Return-Path: <netdev+bounces-26763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28B778D27
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F95C1C214B2
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1776746F;
	Fri, 11 Aug 2023 11:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF235693
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:10:37 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BF6ED
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 04:10:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c0cb7285fso249727066b.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1691752235; x=1692357035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yEmCh/4b+BWU9qDJvKWWcz5lhDGo7JYaO71Xt3Zntc=;
        b=rg3CpeIsizpP9cBrlygwF2tUMFYSdrRv01Bg7USlIfM5InOzVVsRFV/3k/6fh0w0Ux
         Z2V2LSMPKfKnoWARS8WDruUN8/YbaU0/hf0oKTnskaVhRb32QBflqXo+inHhCuG6GTcd
         y34/f/DdkuRSSJkUdYGRD2XaWBBOCIEQb1WR0r7qaC+3BLbZju9THJ/H3rccNBvLEVDA
         sRUhjUrex8Jfh3Pw6DfSgjSdHe7FooS16yIl5iVUv6TbpVJZejZIlFJ1GS25grrER9Qc
         h9Di7j2MovGQz/oaBCqUI8TI5Y0kLxUmmJSpnGBWaI0Lq5dH9QjdK72/qu0cTvKnkZ1n
         Pyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691752235; x=1692357035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yEmCh/4b+BWU9qDJvKWWcz5lhDGo7JYaO71Xt3Zntc=;
        b=C92fnzQEUSd19u+Vewo58mLHWmsKzHjpt3QnMOoln5OFo/q7QPMBYjekxGTZY4Zqhv
         8lUY2Q0uGsS2X9hIz7EzH1ueR+LyJogfvbN0xmkQlyowBSHHkVApaUE/dq2HIpcOwOEw
         PzRnuyZLVSVLSHaP/gMD4Mx7izJoEGclk5sCbE+oUqL+PUDv58SSqvDWgfUhIkwkin/o
         CTFVkdxfBbWMyDlbdQR0sg6fJTkchJDhN759lQ4E3tPeRjeaQTlCrljxTW81/g21KBXk
         gDK9oLS+kfeywjlmbsEeL/yU70Uaqg/r4rsb6DNorBjJ+bFaROYAkeUwazjwejbIVIwh
         xzPw==
X-Gm-Message-State: AOJu0YxrEtpviMrh3EDyn8gKSKkEsnu03ds2WtJVmunlBLza4phnBjR7
	hPhfZg7dj7EioB5vaJrVg8FV8g==
X-Google-Smtp-Source: AGHT+IGOQB3GS+GbS6NxtqEmWT4mAjfyb2PiaIhDxlWAEMe0UmEc4sr4429o9g1VTydUfdkgXRm3GA==
X-Received: by 2002:a17:906:cc4f:b0:99b:cb7a:c164 with SMTP id mm15-20020a170906cc4f00b0099bcb7ac164mr1321450ejb.62.1691752234917;
        Fri, 11 Aug 2023 04:10:34 -0700 (PDT)
Received: from fedora.. ([188.252.220.253])
        by smtp.googlemail.com with ESMTPSA id gg15-20020a170906e28f00b00982b204678fsm2103206ejb.207.2023.08.11.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:10:34 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	corbet@lwn.net,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: ethernet-controller: add PSGMII mode
Date: Fri, 11 Aug 2023 13:10:06 +0200
Message-ID: <20230811111032.231308-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new PSGMII mode which is similar to QSGMII with the difference being
that it combines 5 SGMII lines into a single link compared to 4 on QSGMII.

It is commonly used by Qualcomm on their QCA807x PHY series.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 6b0d359367da..9f6a5ccbcefe 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -66,6 +66,7 @@ properties:
       - mii
       - gmii
       - sgmii
+      - psgmii
       - qsgmii
       - qusgmii
       - tbi
-- 
2.41.0


