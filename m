Return-Path: <netdev+bounces-41036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862BF7C964B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863F1B20BEE
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C129520B04;
	Sat, 14 Oct 2023 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mnr6dEfn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22942168BA
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 20:51:40 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C0CE
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:37 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso27279251fa.1
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697316696; x=1697921496; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qto4krpjBE/Wuaeru9wVjaS4puBPq/i+G9Tt+UL8VeY=;
        b=Mnr6dEfnv2ulV59TcxRwGVHuj6bbmpBcymfB9fS1q1DqPpRIZPibPDrimYIIUHsJHY
         1JXGycQaj1WI6mnY4Ll/AgEjqzxKncXQE8mk0giPs6ZSwSKBfOcO6rt2Q+Jxz1cZhNGn
         v4HJoPL9J7Fpu74QVWX5Fs/hxbDKQ3Lu7YIUYniFGP6uAsy5c9oJUu132bPNe3x1JaDt
         UHbLKSA8+KBsJqRfnXPKOMGtkhgIbBTxMvxeES5ZKTyVi14gVZeRPcJhClz+PiuvMUkE
         1hAvf3qBMouT+mxeKsFogjvtQpWuR5tEtGnDW/DJ5K/BkfcCbG9Io5KOoTEIfnF+EAhm
         OaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697316696; x=1697921496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qto4krpjBE/Wuaeru9wVjaS4puBPq/i+G9Tt+UL8VeY=;
        b=uqpqxcTtIfxO7CwlHxFm/AFLAYVxfe0xnBicvTBud5FenMTgPGgNcwFY4ePjKwnN/+
         Tyg9XtE43i7hJ1hP2I61ag6RHgkiGNHp74O7swyty0awvHMIwZ7tIkWo1WM1htWPK3Dc
         2DtATkNiDmEC/LT00AUAuMjMLlpuie+I+L2RgemuiVO99x6sBAU2NOF6OJaV5Sa59CI1
         jp07l10RrAJkwq6oXn1wKlB2T1B7BkCq8/zKNiKakzGpCJt3V/U+CS7GBq/gI/uAIY7Z
         SqlD77iuz43IBIyGPA0u6pLG+ybZ6BL5G77v7mS3WaoBkVEGU6nPPR11ZU9W4II+PPsu
         RXqA==
X-Gm-Message-State: AOJu0YwqH9LZOocA732DwK6xHr5QPTWaj+Ni4u4hNQxBnNpIn3E9aJeS
	LOPvwJ/qz1WHEaxWqMVDfyyTzw==
X-Google-Smtp-Source: AGHT+IE2LkLny2Hv7hkf3yTWo3sEWQ3xuaqPwi7Pl1HEr4EfSbhQQmLHHadFrPJoUvbWPgZgxpS18Q==
X-Received: by 2002:ac2:4ade:0:b0:507:a6e9:fbba with SMTP id m30-20020ac24ade000000b00507a6e9fbbamr1037614lfp.63.1697316696085;
        Sat, 14 Oct 2023 13:51:36 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b004ff96c09b47sm49926lfr.260.2023.10.14.13.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:51:35 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v2 0/5] Create a binding for the Marvell MV88E6xxx
 DSA switches
Date: Sat, 14 Oct 2023 22:51:31 +0200
Message-Id: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFP/KmUC/3WNwQ6DIBAFf8XsudsA1oo99T8aDyirklBowFAbw
 7+X2HOPk8mbt0OkYCjCrdohUDLReFdAnCoYF+VmQqMLg2Ci5oxJfKqQyFqUkq68EfhWDi3pwuO
 lHtpJi0lDWb8CTWY7yg9wtKKjbYW+mMXE1YfPcZn44X91Xv+tJ44MWcvFoLpONu14t8ap4M8+z
 NDnnL8WSdfXyQAAAA==
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This shows the path we could take with this, deprecating the
weird external bus thing.

I don't know what to do about the irq lines with a pointless
type flag that should be onecell:ed.

I need proper schema checking to add LED support to the
Marvell switch. Just how it is, it can't go on like this.

Some Device Tree fixes are included in the series, these
remove the major and most annoying warnings fallout noise:
some warnings remain, and these are of more serious nature,
such as missing phy-mode.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Break out a separate Marvell MV88E6060 binding file. I stand corrected.
- Drop the idea to rely on nodename mdio-external for the external
  MDIO bus, keep the compatible, drop patch for the driver.
- Fix more Marvell DT mistakes.
- Fix NXP DT mistakes in a separate patch.
- Fix Marvell ARM64 mistakes in a separate patch.
- Link to v1: https://lore.kernel.org/r/20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org

---
Linus Walleij (5):
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema
      ARM: dts: marvell: Fix some common switch mistakes
      ARM: dts: nxp: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes

 .../bindings/net/dsa/marvell,mv88e6060.yaml        | 106 +++++++++
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 241 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 ----------
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/marvell/armada-370-rd.dts        |   2 -
 .../dts/marvell/armada-381-netgear-gs110emx.dts    |   6 +-
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     |   2 +-
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |   2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi  |   2 -
 .../boot/dts/marvell/armada-385-turris-omnia.dts   |  16 +-
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   2 -
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |   2 -
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts    |   8 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts    |   4 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts   |   2 +-
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |   4 +-
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |   4 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |  32 +--
 .../boot/dts/marvell/armada-7040-mochabin.dts      |   2 -
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |   2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |   6 +-
 23 files changed, 390 insertions(+), 171 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


