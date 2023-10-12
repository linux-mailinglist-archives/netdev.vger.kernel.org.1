Return-Path: <netdev+bounces-40539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570847C79D5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79D4B20A3C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1043D00E;
	Thu, 12 Oct 2023 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KV3CnEMx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE42B5D8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:35:25 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0011B8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:35:22 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so59001fa.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697150121; x=1697754921; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXO4MwbGSox8rKRwzbnM2zZwOBZ2z8Fw/s+ke6QnvYQ=;
        b=KV3CnEMxFJtvM3QTZMX6sbsVGR9yMUU3IaNqfwXPLsWzqHb9fji2VHY22O7/IVrWX/
         qGuR4AMRwkJ0OByoVaoUbadLfPBLGIiTWprDSH1N3vBAXXzws3ICJRzCET2B6tWH/lCs
         h1ArxcVwhGgXRmOFax8Kxupgi6my5yVaui2iT9E5x2Gr4a0vfIBOH6vTltN0liQcIHE0
         lyZsaSRm/gyosCEpdgpkFIFIE7iGjnJ4Fdi9gjpbZ5h9CFKi0Ign3NqerVqegg22YwoC
         im33GTdpW6hw7tH2CYJMgf2NBWkJg014ufolh+D8ABVXFty+4DgPW2v/+vOaf1jF+zT6
         0Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697150121; x=1697754921;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXO4MwbGSox8rKRwzbnM2zZwOBZ2z8Fw/s+ke6QnvYQ=;
        b=unwBj34bPz58lIKral8hMMgiqEB2dn1pAatjA8J07ZOjr87E83B3mRu6arXJiRl2PW
         kFTCCpkuqnRWs04Ob0RYnqLiui0+4diazRWFu97k28Yg2zNlYvWyEy/DyNUBvZEDw9Te
         GwMZB0tm7CviP7VtoxdTASczWPgmQRTcUolr9CIfROJUS6syOWsVbqB7Hb1vZ8+57gnL
         ovn9VhI7014qhNjYro/2nZr41PH0lLkDLaLZ3045IVlVtaX4Aiqf4t/jwQmzNZf2n4Vy
         92ou79Hm86sOm0dWc68Ya0rHLXy6dYfOxJpIz+yMDdVtxg2/TV11VbhazrH1chfxMVgQ
         6a4A==
X-Gm-Message-State: AOJu0Ywn1Cdi1lj2EVv5U8c6TBrBkbYJJXy5AtFO2t68M4o823alnW/W
	96QBR9D9eSnpVf2UPbwjwxBxRg==
X-Google-Smtp-Source: AGHT+IG2cIx6DdV3B+I16sZS0ktRHmF97um53+8sbh/NgQJX+5tMKhRcw84Ma5j9WlNR4GfU6ctdDw==
X-Received: by 2002:a2e:8488:0:b0:2bc:d6a8:1efd with SMTP id b8-20020a2e8488000000b002bcd6a81efdmr21034673ljh.39.1697150121181;
        Thu, 12 Oct 2023 15:35:21 -0700 (PDT)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id x21-20020a05651c105500b002bcb89e92dcsm3811671ljm.6.2023.10.12.15.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:35:20 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] Create a binding for the Marvell MV88E6xxx DSA
 switches
Date: Fri, 13 Oct 2023 00:35:13 +0200
Message-Id: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJ0KGUC/x3MTQqAIBBA4avErBtQ+5OuEi0sxxowC4UKorsnL
 b/Few8kikwJ+uKBSCcn3kOGLAuYVxMWQrbZoISqpBAaNxNP8h61plY2Ci8T0JPNnutq6pxVzkK
 uj0iO7/88jO/7AQR7dUFpAAAA
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
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This shows the path we could take with this, deprecating the
weird external bus thing.

I don't know what to do about the irq lines with a pointless
type flag that should be onecell:ed.

I need proper schema checking to add LED support to the
Marvell switch. Just how it is, it can't go on like this.

Andrew: if you have lots of ideas and want to do lots of
changes, feel free to just take over the patch set and do
what you like, this is an RFC after all.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (3):
      ARM: dts: marvell: Fix some common switch mistakes
      RFC: dt-bindings: marvell: Rewrite in schema
      RFC: net: dsa: mv88e6xxx: Register mdio-external

 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 249 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/marvell/armada-370-rd.dts        |   2 -
 .../dts/marvell/armada-381-netgear-gs110emx.dts    |   2 -
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     |   2 +-
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |   2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi  |   2 -
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   2 -
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |   2 -
 drivers/net/dsa/mv88e6xxx/chip.c                   |  16 +-
 11 files changed, 267 insertions(+), 123 deletions(-)
---
base-commit: 69d714c69583c4387147d0b7f2f436d42baddadd
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


