Return-Path: <netdev+bounces-15124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC42F745C6F
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A811C2096E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114C46AC;
	Mon,  3 Jul 2023 12:44:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3124EAD2
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:44:46 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED32CA
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:44:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso6790353e87.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688388283; x=1690980283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kunhzYriq9Ized0txGYbgG/+sX1cI8EHneLHpJ6J52g=;
        b=b24G9DRWNKbUIJQswmvMj172uR+DGaSqBm3kCBSNl8MhhcdNlgJTCktG/YtBRXm+hj
         d0TGeQDqFS31l6qYkWI6eJclUXxDtCVd7RPyJvQrowENqIhLvwF/f6NFetBZ3VA+87Mu
         HVYo9yVeALLJr2QQDBROMoIdBT2bN/Ej94Hbna1Q23ZB1uINO90KPTeZ05eeIEsoCTHe
         /hjiL3jLIC3Re8OQpu8Cnz3Oy70XCb8bctp70nH2mOcHVQQL1EREF+nIXhqtgNFjZIxr
         aZz70CKC4UyGK7jQfJmCpl37HjMkjhKusgD3hrjYjDaE3VJFh4MkNsCZmztfyyQQ5O9t
         BVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388283; x=1690980283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kunhzYriq9Ized0txGYbgG/+sX1cI8EHneLHpJ6J52g=;
        b=ZPFBo0x6onhActioD6XjhadniAaQlciLeMzuIhYHVWLfl8Cw+daVJc+fRHwKniOY/N
         qoImA01YvFK3aDh6IA9k1QXmVHISY7fyJNuXHXjKDQAfXoaiULok1Z7QNaw/p7YPDLxj
         g0G/X9cV90oQ8giIrm/YeHQrGrEc4bSxWOHOZAZy/wMulktWoNBr8D98wRQPKrzVyfOu
         wE6w+3MCvzaOeZgJSGBxfwzoYujnLM2zJJis0E64YBrfn8b0V9BG2uFSMopcmrKGxmMU
         rBuHX+H6QeOG0O8rGWlzWu4DTPzE8uKyRHUNJkhqtYknKdd0eP0e2S7KHg60fJS2Ub1d
         oFdg==
X-Gm-Message-State: ABy/qLaZE4DhytUX376xXhbVkfUrz5cVpPmYsCZFOt1PaKn89tpvRuWd
	BJFco8k+wHd4Y24KIYxP4KW5hzmlh0mU8Q==
X-Google-Smtp-Source: APBJJlHrZ0PnpArq7G3p9/Qmjw31Pi3yi+UQljevWrsbEpj9xBUBhM3JAEZUpVREcUPqtzQenIxR4w==
X-Received: by 2002:a05:6512:36c7:b0:4f9:5718:70b0 with SMTP id e7-20020a05651236c700b004f9571870b0mr5577152lfs.41.1688388282561;
        Mon, 03 Jul 2023 05:44:42 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:a288:787a:8e86:8fea])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm26650681wmb.26.2023.07.03.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:44:42 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	francesco.dolcini@toradex.com
Subject: [PATCH v1 0/2] Add a driver for the Marvell 88Q2110 PHY
Date: Mon,  3 Jul 2023 14:44:38 +0200
Message-Id: <20230703124440.391970-1-eichest@gmail.com>
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

Add support for 1000BASE-T1 to the phy_device driver and add a first
1000BASE-T1 driver for the Marvell 88Q2110 PHY.

Stefan Eichenberger (2):
  net: phy: add the link modes for 1000BASE-T1 Ethernet PHY
  net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2110 PHY

 drivers/net/phy/Kconfig           |   6 +
 drivers/net/phy/Makefile          |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 217 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c      |  14 ++
 include/linux/phy.h               |   2 +
 5 files changed, 240 insertions(+)
 create mode 100644 drivers/net/phy/marvell-88q2xxx.c

-- 
2.39.2


