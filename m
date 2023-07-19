Return-Path: <netdev+bounces-18847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD62758E04
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF4C281635
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23771FC6;
	Wed, 19 Jul 2023 06:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE1179
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:43:02 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553AD119
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so9228592a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689748979; x=1692340979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHgY84twMbjEQAwkCs3QuwRSbKQDG52BVmNMWuTPOgE=;
        b=J8ejhmc6bkxkSzKAZVlD2zoKiEI6xP+MCBXm779XZh5A+zUSGwWpios7zQDVGkgQDE
         0CXXptsIyByQhjmocWqkNsqtxzVYSnjyV0KfUk2Tng80Na952yPkGTbJpDqUh7FcLTZ8
         hF50qWdp4+9Zd6zVZJEL68+x64lI5tQWdPVO+u1xX1y91NchAlIb8RYyybbrQQWVHKFd
         H60Wjc05V1E3bY9VlU0gew6lI1bMSCBkZh4K7ZrlfSPRuvCV+OZrMqCge0o8MZ1+yG+X
         qp9b1Y3vCIbJ8OS9Wsnoqw8uhgYmqE7gQbj66zUMLiovetiC5YRHAf4C1Yg/L7SCkv7Q
         WMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689748979; x=1692340979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHgY84twMbjEQAwkCs3QuwRSbKQDG52BVmNMWuTPOgE=;
        b=ZPMfmZ8mvVZgE0a6T731Na5+AP1FI8rEga6CEYVykWqcD0rzE1sItyuOa/65vRXiBk
         DpcQEa6N8bSgWwmOEirqM/knlyWuPOudSH+koGot0hJe71Ey5l25KSfm6ldcj3uwVko+
         Bp14Jfc5co6uPJimgwQpWwXNcxkMq+8at40guB65JITjg1gZNubxsTGCLzdfJuJWK9CA
         A64hH7pZ8ur/4BRvghPQfz8ANgVBrAxgSh7LhSRV1bUorqdKAflAh+5XifFNmNEx+jfW
         1joni9Zf2mDHNDyX72p9lkEizoijBp6TbWR8XulR3HKD7juxB+UBxJj12g4Svqz9NLce
         Mb1g==
X-Gm-Message-State: ABy/qLae976lH8qG9y6wFWX+03Xbh9OS8iA6jMX2K6eSG0OpZhDhujV5
	RlMBBO5/b+TdkN6+PjMCYrxTI7EMgqPQ4Q==
X-Google-Smtp-Source: APBJJlEx5jxCqMyJt0HVKJRGPh4ZerJf0A09W+GWm7NumZbHoQz3q9ksg2Pw0exaidNIsraqu33ulw==
X-Received: by 2002:aa7:c0cd:0:b0:51d:d30c:f1e3 with SMTP id j13-20020aa7c0cd000000b0051dd30cf1e3mr1577364edp.16.1689748979465;
        Tue, 18 Jul 2023 23:42:59 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:b88b:69a9:6066:94ef])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b0051e0f8aac74sm2301868edy.8.2023.07.18.23.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:42:59 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	francesco.dolcini@toradex.com,
	kabel@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eichest@gmail.com
Subject: [PATCH net-next v4 0/5] Add a driver for the Marvell 88Q2110 PHY
Date: Wed, 19 Jul 2023 08:42:53 +0200
Message-Id: <20230719064258.9746-1-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for 1000BASE-T1 to the phy-c45 helper and add a first
1000BASE-T1 driver for the Marvell 88Q2110 PHY.

v4:
  - Move PHY id to include/linux/marvell_phy.h (Marek)
  - Use PHY id ending with 0, gets masked (Andrew)

v3:
  - Read the BASE-T1 capabilities from the ability register (Andrew)
  - Fix several missing return values (Francesco)
  - Poll the reset bit to be sure the soft reset was done (Andrew)
  - Fix reading the latched link status wrongly (Andrew/Russell)
  - Remove probe function (Francesco)
  - Add defines for Marvell specific registers (Andrew)
  - Move the BASE-T1 ability reading to a separate function (Andrew)

v2:
 - Use the same pattern in Kconfig as for 88X2222 (Andrew)
 - Sort Kconfig and Makefile entries (Andrew)
 - Add generic registers to mdio.h (Andrew)
 - Move generic functionality to phy-c45.c (Andrew)
 - Document where proprietary registers are used (Andrew)
 - Remove unnecessary c45 check (Andrew)
 - Remove cable tests which were not implemented (Andrew)
 - Remove comma for terminator entry (Francesco)
 - Sort include files (Francesco)
 - Return phy_write_mmd value in soft_reset (Francesco)

Stefan Eichenberger (5):
  net: phy: add registers to support 1000BASE-T1
  net: phy: c45: add support for 1000BASE-T1 forced setup
  net: phy: c45: add a separate function to read BASE-T1 abilities
  net: phy: c45: detect the BASE-T1 speed from the ability register
  net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY

 drivers/net/phy/Kconfig           |   6 +
 drivers/net/phy/Makefile          |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 263 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy-c45.c         |  63 +++++--
 include/linux/marvell_phy.h       |   1 +
 include/linux/phy.h               |   1 +
 include/uapi/linux/mdio.h         |  18 +-
 7 files changed, 338 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/phy/marvell-88q2xxx.c

-- 
2.39.2


