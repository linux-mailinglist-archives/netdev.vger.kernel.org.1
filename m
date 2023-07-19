Return-Path: <netdev+bounces-18850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C176758E0B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287C3281670
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DCB79DE;
	Wed, 19 Jul 2023 06:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4EBE40
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:43:28 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22621FCD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52173d4e9f9so6025171a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689749005; x=1692341005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpaSSs34L1Ofk/RcNA0HWtUpf0nn7fQpfE/UPEa1hy8=;
        b=dsY+2vBkVl1LqJ08WY8sTSAGa6iWBt+M8yRAZh3CYvIPpcKVJC9DxE46MT6egRDig7
         8eNxnNZz+g5qqdVXx2yxHbKkztW9YbCtIst6qCTeq2Lv0YlCCnR4hRtSiPJ8smeIJWrG
         3znU6dYevP/LCLPws0JLHStf07/nIqlLGwEkB4+MeaDj8tuJSp+z2Mry58WHRtcUFK54
         vJEmnmg2uAxiZXMp3KC1LQ9WBii6CYguf1qEemam018UBO4VrRfyV5Q6DIolHyEt1enS
         AV1zwVTGE7of1rAZvR0GkGwT6FvoPzHi+XbQXV7EM3jM6Q5JhaIUoeiApddTxFnlp0Xa
         mZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749005; x=1692341005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpaSSs34L1Ofk/RcNA0HWtUpf0nn7fQpfE/UPEa1hy8=;
        b=PON/3K7MYFrJOqBqEP9Fe0g9oBZ/vuzKSLcmE/osJfBgoKKBChT6c1eEo5NsDlYBiz
         ozDLBrWGRX4g2cuSt9ZwoDGr6/opEW85YR8usoSvoYTc3YP/JaMinzo9DFYIdevIPQEm
         3UWlZOmZvTZFd9mCV9uWLf1PueBV38x/fM3pMrpq4gS9/xxI+upqX3Kk15C4JjNzTEn/
         y3254CLZ/dpmXyXfdqyrsFzItB8tNaTBItnQCzTTgaTZXzSFHM1ksbpL8WlwlFF0ZaRi
         souV1uLwdP+TLWhDYtKi4WpoktLD+jFpFSDw6gxoveBsjR3xET9EvsCl13qIFSfQn2GA
         rv5g==
X-Gm-Message-State: ABy/qLZm8kcqeTW556MzCJrr+YExDD5MJc7D2cAVvgqTuGRzTqaXeJcu
	GpHfaqtsnb6dASQVJbwURsxlsmpnkkfpzw==
X-Google-Smtp-Source: APBJJlF6GILGg6bqD2jaXTbYOVRnISWk9BYE1HkXm26qFj44FLIccmS6A20stj3iOND8y8c5Bs6xtg==
X-Received: by 2002:aa7:c755:0:b0:51d:e975:bea8 with SMTP id c21-20020aa7c755000000b0051de975bea8mr1567937eds.13.1689749005149;
        Tue, 18 Jul 2023 23:43:25 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:b88b:69a9:6066:94ef])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b0051e0f8aac74sm2301868edy.8.2023.07.18.23.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:43:24 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/5] net: phy: c45: detect the BASE-T1 speed from the ability register
Date: Wed, 19 Jul 2023 08:42:57 +0200
Message-Id: <20230719064258.9746-5-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719064258.9746-1-eichest@gmail.com>
References: <20230719064258.9746-1-eichest@gmail.com>
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

Read the ability to do 100BASE-T1 and 1000BASE-T1 from the extended
BASE-T1 ability register of the PHY.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy-c45.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 58a6bbbe8a70c..8e6fd4962c486 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -899,6 +899,14 @@ int genphy_c45_pma_baset1_read_abilities(struct phy_device *phydev)
 			 phydev->supported,
 			 val & MDIO_PMA_PMD_BT1_B10L_ABLE);
 
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_PMD_BT1_B100_ABLE);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_PMD_BT1_B1000_ABLE);
+
 	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_STAT);
 	if (val < 0)
 		return val;
-- 
2.39.2


