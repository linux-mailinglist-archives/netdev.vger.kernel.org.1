Return-Path: <netdev+bounces-18414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5C756D50
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3080D28132D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D14C152;
	Mon, 17 Jul 2023 19:33:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC3253B8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:33:54 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B78194
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-315adee6ac8so4797983f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622432; x=1692214432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S4yv8fwQlP2xWGd7Aj3w4NcX85DeguLinShg7GS7OZU=;
        b=cQv8yFUumvXQQW4OSmswYIX5ImVM+NuFP5DNsoYuBpWAql8MIw+lLFEk08yPUe1mLS
         0t2GQIj8iwsOEqEZ3cEXRcfteg/CXCZk+YfNIjgYdzP0IgNgm4LDsFm0+iDWD7dyY2KC
         MP4uCePjmdy0IT35CHRyzMxT8T/tVM9xA2v7JGuhZsN3EGAdQUJveb8vmqkIWyCE1v01
         4/IuwLQcvJudPwtqOIXZtnG9qzj3h1h25p0oNFqVLMc7qDGaItCfXRJW4/JD35M/Rhpw
         evRjuOPOEQPIlpXJGKOkgzJeiL6NZfkrXqEC9DIdeqMv+obVdhvvmmnytTtt8dIPRYP4
         fGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622432; x=1692214432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4yv8fwQlP2xWGd7Aj3w4NcX85DeguLinShg7GS7OZU=;
        b=F8KI0Ws0vBSEhjillk091Ivg1Gvm68RO2Omqfjo8phPQqmdWBKOc6TbEE3aopP1G9k
         kPSrOrCWfB6PXYR5bm5XHPtqcQt1xAzh7Z7k3fkLUnPrNN8iVKbAocR8TsP8Sgw/Qfge
         jt12jRs88lkL/lC2o6RVyyv8usvggor90KrIClo0FGUehIG9QAVaonFMcqjTmpJwztvC
         Ww+nvjpBfxbFD7KDncLV2Ab9O+WR/IdZjfm5iKSTBX0zqArgM4sOc2uLqDxPHe0jtbbs
         IGoWbgdnGUTZANG8Pjx0k03XKS3ZhJ+6F5TC7togyWT/UK8YVecyhK9onE5pt5XZ9iBH
         LVKg==
X-Gm-Message-State: ABy/qLZwgfAGDpy4qvZIKvVI+GbNdLb53lXLrevmlGQ1VOcrZ6hE4lkY
	M1PONT05E3qU5gro8PWwGGlNT+2aVhFlhQ==
X-Google-Smtp-Source: APBJJlFtwaOygCLF48tCfv/D8gnW2EiR4l1SxsGqL+zY8DhHyGavqmQtx6kuA5cDQzK6d9grkq/eRw==
X-Received: by 2002:adf:eac2:0:b0:313:ef96:84c8 with SMTP id o2-20020adfeac2000000b00313ef9684c8mr10568409wrn.67.1689622431484;
        Mon, 17 Jul 2023 12:33:51 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:5cdb:47c:bcfa:4c2b])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d5507000000b003142ea7a661sm280944wrv.21.2023.07.17.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:33:51 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	francesco.dolcini@toradex.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eichest@gmail.com
Subject: [PATCH net-next v3 0/5] Add a driver for the Marvell 88Q2110 PHY
Date: Mon, 17 Jul 2023 21:33:45 +0200
Message-Id: <20230717193350.285003-1-eichest@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for 1000BASE-T1 to the phy-c45 helper and add a first
1000BASE-T1 driver for the Marvell 88Q2110 PHY.

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
 drivers/net/phy/marvell-88q2xxx.c | 265 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy-c45.c         |  63 +++++--
 include/linux/phy.h               |   1 +
 include/uapi/linux/mdio.h         |  18 +-
 6 files changed, 339 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/phy/marvell-88q2xxx.c

-- 
2.39.2


