Return-Path: <netdev+bounces-16604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F76A74DFE1
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAE61C20A2C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EE154B2;
	Mon, 10 Jul 2023 20:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C656FA9
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:59:07 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2599
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso55503555e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022742; x=1691614742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLxSCAZzO2go93LK8Bgrfe7zqGiDVYg6d7olDch3ypE=;
        b=jWY0L0TpWLmrJB5FKcT+lM2FgAz8L52xqGpSyA0F8y4uF0jVIOGK/FQCwHRJV5zMO+
         u5n/aZRoD4w7ZXraoyyDbKHQEkPZb6j+uXHCTLBt11Plc37hpOTvCzrGID+2hMxZ3jKm
         6BSx/rwqL9eACwBVCSPfY63TEyuiOfqStZ2HlBr1WiwOW97HqqqFr6O5VtHc+mgyPZUY
         SdVbAphHz5OhitaayMuuCQuitSq+023nSATRftL3UUTk+vjuoqwsksF4WHXvIdxDffxW
         w0/7gwvLq+BeaSafxFaw1wqF30C0k4n7sSqRmEnAyrDFe8KvgMMteYnnPcF7FlrA9BJn
         8TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022742; x=1691614742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLxSCAZzO2go93LK8Bgrfe7zqGiDVYg6d7olDch3ypE=;
        b=I+c05Z3Qy17hRDbARgmPcQMxqBemayNASU7hbSQhzOaghsFiUDKkXLoonrAxtIeo8A
         Tscdpidf/iUvo1miN7c0a3kaY0arkJ7ai5FSw+WOrdMh9Xawt9w3DoUS7ZN+vDP/dcaI
         eA+4T35ReYwCVk/4+uuPv9hZkpjfgJ2m/7x9h+lS/7vPcs8T6p68g+QDXJBNXbq1ktYV
         nY0dxezhPQp2A9OuZaVlQIXSl5jFGONLZs+Xyp2wym63oFkRLCo0UKhsxUDsQhAswX4W
         okhiwtlOk2TcBGT43Uc9DRf2sHNDMopWRPb6+o04OOOfmhEN0Lu8+1gW/FGTAtvfwG1Z
         Wu2g==
X-Gm-Message-State: ABy/qLYrg4bPKlkBCtUxSPAiOSyBV/7lP1mU3zIrHTDwgIfBA6taqnnS
	WJdwk/++gZ/Sm5nbcRTrWTNYkZB6D6nMCA==
X-Google-Smtp-Source: APBJJlE3d6vlLMc+Kgui3gZ24Ly+lvP6qJ55brTgoUFkf9A5Fy6lfxQC2ZYHd/JYvWhHN/lSfxSElA==
X-Received: by 2002:a7b:c847:0:b0:3fb:a1d9:ede8 with SMTP id c7-20020a7bc847000000b003fba1d9ede8mr13067159wml.10.1689022742367;
        Mon, 10 Jul 2023 13:59:02 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f6df:53b3:3114:b666])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm11167880wmj.14.2023.07.10.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:59:01 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/4] Add a driver for the Marvell 88Q2110 PHY
Date: Mon, 10 Jul 2023 22:58:56 +0200
Message-Id: <20230710205900.52894-1-eichest@gmail.com>
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

Add support for 1000BASE-T1 to the phy_device and phy-c45 drivers and
add a first 1000BASE-T1 driver for the Marvell 88Q2110 PHY.

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

Stefan Eichenberger (4):
  net: phy: add the link modes for 1000BASE-T1 Ethernet PHY
  net: phy: add registers to support 1000BASE-T1
  net: phy: c45: add support for 1000BASE-T1
  net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY

 drivers/net/phy/Kconfig           |   6 ++
 drivers/net/phy/Makefile          |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 149 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy-c45.c         |  12 ++-
 drivers/net/phy/phy_device.c      |  14 +++
 include/linux/phy.h               |   2 +
 include/uapi/linux/mdio.h         |  12 ++-
 7 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/phy/marvell-88q2xxx.c

-- 
2.39.2


