Return-Path: <netdev+bounces-17320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DBA751398
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F133281A2C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2921384;
	Wed, 12 Jul 2023 22:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEE1D2E4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:34:15 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401F1BC6
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:34:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so108223e87.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689201252; x=1691793252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sop8ZgUpaYRF3klAp2ob02ZsbXVYXG3suf+IVaKN6wM=;
        b=nFBBGWp5LJoUtDANqqUbY5bf3TopaEZk/ChO1jQr0xE66lUS27v4v5284CuYBbSaQJ
         vVJAqLB8CC6n1edb5xf5vZLSrCbGmXzxnlxDN0kvU3SnhIdQoZSoVsoUn29ONDHRY1ZS
         CUyD6IGNL7He9EdGjwEVdTd23fdwY8YER7zef5SRQrVBTauiPg5t9X2YOVQxzXD6Yq5o
         ec9Xr4BMCkso6keNr7lyZfE+HdHGlLU39us1Mid1oJBSfIL6l7CMfGUI0SLRZ1Q/8f3V
         R0PR1B9U2Ugkv6OKQE18/3wZDkeEJTCeAIinOIJIVGqhfWuoIHYS3uu9NaXA/iNWxXuV
         x9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201252; x=1691793252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sop8ZgUpaYRF3klAp2ob02ZsbXVYXG3suf+IVaKN6wM=;
        b=d2xMcy9J6Vhkv4gpAc3muZKR5qFZuV3dC6ppePYFRc7D3pFoX1x8+D8blBn1Yps94p
         Wh4pT6enIYB8rRkMj3PEu62QvSRkmOLou+2+GfoFnLnimDrhXJGwVjebkSXYWmRBZiEu
         6b2nnhNnxt1RJ6aoHNvY1TK2hXH5PkDsRc9SMjxOO+8xKG8UIhrYXizfNT31y4ChL9LC
         /mng+guldGDWu689hoMYkRUC37MJB6/YkU+/PbmhXtOG+qU3NV8YvI7cWg8Mqigf1Y2f
         ngmo9JAvrbDQfnzBEYkBh+9kcwArMuQNlA3JXT+Zk0ccVtFAoeqCgMTidcEZeQKUncK0
         NzqA==
X-Gm-Message-State: ABy/qLYqi59Fih2V+uSYkInnYiaUwlc8wCdvk4fuKkxrPfHXZQDvR/4n
	WNczpwglsSDhWmHu6LIizYeewg==
X-Google-Smtp-Source: APBJJlH4+s6Ea6ObbkRJ5sZvegThD8BTFJ7WTSLnAxhX15OyQbMld9XCyAI86YjqkP1ukwydiMRJKQ==
X-Received: by 2002:ac2:4e88:0:b0:4fb:8ee0:b8a5 with SMTP id o8-20020ac24e88000000b004fb8ee0b8a5mr15545830lfr.46.1689201251885;
        Wed, 12 Jul 2023 15:34:11 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id er16-20020a05651248d000b004fbbe647c00sm864171lfb.299.2023.07.12.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:34:11 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH net v2] dsa: mv88e6xxx: Do a final check before timing out
Date: Thu, 13 Jul 2023 00:34:05 +0200
Message-ID: <20230712223405.861899-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I get sporadic timeouts from the driver when using the
MV88E6352. Reading the status again after the loop fixes the
problem: the operation is successful but goes undetected.

Some added prints show things like this:

[   58.356209] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
    for switch, addr 1b reg 0b, mask 8000, val 0000, data c000
[   58.367487] mv88e6085 mdio_mux-0.1:00: Timeout waiting for
    ATU op 4000, fid 0001
(...)
[   61.826293] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
    for switch, addr 1c reg 18, mask 8000, val 0000, data 9860
[   61.837560] mv88e6085 mdio_mux-0.1:00: Timeout waiting
    for PHY command 1860 to complete

The reason is probably not the commands: I think those are
mostly fine with the 50+50ms timeout, but the problem
appears when OpenWrt brings up several interfaces in
parallel on a system with 7 populated ports: if one of
them take more than 50 ms and waits one or more of the
others can get stuck on the mutex for the switch and then
this can easily multiply.

As we sleep and wait, the function loop needs a final
check after exiting the loop if we were successful.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Fixes: 35da1dfd9484 ("net: dsa: mv88e6xxx: Improve performance of busy bit polling")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Instead of reading 10 times, read an extra time after the
  loop and check if the value is fine.
---
 drivers/net/dsa/mv88e6xxx/chip.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 08a46ffd53af..642e93e8623e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -109,6 +109,13 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 			usleep_range(1000, 2000);
 	}
 
+	err = mv88e6xxx_read(chip, addr, reg, &data);
+	if (err)
+		return err;
+
+	if ((data & mask) == val)
+		return 0;
+
 	dev_err(chip->dev, "Timeout while waiting for switch\n");
 	return -ETIMEDOUT;
 }
-- 
2.34.1


