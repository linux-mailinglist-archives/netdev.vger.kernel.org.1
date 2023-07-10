Return-Path: <netdev+bounces-16607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6D74DFE6
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383251C20A05
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE5C156F0;
	Mon, 10 Jul 2023 20:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD01640B
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:59:08 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D7399
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so50416275e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022745; x=1691614745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inNhifSCScujB3EoImsaK9GQEjAl0FReGzhUXigrf/Y=;
        b=hl4GHUB8C7Go7CbsYyHJi2Dc8b1QZvKZncLk9Hb8WAXqXUTA3Sm4DUTH6GOYzv50ag
         sBf56IdCzo8deiwSc/FMqNW9ZB10OW4czO5DU57QfyqGrqQzv7L4e3qJx+e/QTW7A+YE
         glYRStX5ITwCHRW03xHmkYL5+JkPGmKHsWAnio5Hwqh+1CWVX4fd8Gw9wVyU6pQywpTV
         gvmWk6uqou+JT1od21BV8E4MgMJWyazgIAL4iV9msK4KS/KsqiyCCLu3M1NgefyUhJfN
         Ie0g/ibhwY7Aa2hunImh4aono4vt/daUCieB7zoTH/neu4enISFapFXQqwigVDbhMw8+
         5Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022745; x=1691614745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inNhifSCScujB3EoImsaK9GQEjAl0FReGzhUXigrf/Y=;
        b=JBEK1oG+afbWBNjgc0UkWPaujO6Aq7ch2Dor+VAtu42OwKRX9kTvWST2BznQjyGCjX
         6JuLHN9LL2FIZ3JdsY5AVdtxilLPMPVeMa61XI5givncdZbBJRizyXN9lakWmXlsYXGf
         8O+9PoosmhIF6hGjtzXuU6nwytDdWfDwoSQL0HHI0/yqps5TawXqGGe6OWo23l9q4twH
         ljDh5vkUx0gs4U59hSthA8FK10IRRfxqbAe8qNzS1EcVQpFdt/rEbyKKUgbQKUnZ7dUw
         1r3ip9vbQuERUcVr6VESMRI3ZoltOX23/lWkaBIGpR2wJVQ8H9TcsDMLEO+2SFvzq1hd
         Bxuw==
X-Gm-Message-State: ABy/qLZEqcNZP9NYQk+bheCjk/zVH6ZJ/4pQ5A2sNUZrLOpTo3FtHiqh
	OMIiW2H5QM64vuu1WYKUnnQU2Y8nlvrVtw==
X-Google-Smtp-Source: APBJJlEw4RBL61ooiJafU7JMZgkP2r7GZDb++ddUG1zLLUtbVDmeB0MkBGnpzIrwm95ouFfDjIY1rQ==
X-Received: by 2002:a1c:6a05:0:b0:3fb:fda1:710c with SMTP id f5-20020a1c6a05000000b003fbfda1710cmr9420861wmc.2.1689022745691;
        Mon, 10 Jul 2023 13:59:05 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f6df:53b3:3114:b666])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm11167880wmj.14.2023.07.10.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:59:05 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] net: phy: c45: add support for 1000BASE-T1
Date: Mon, 10 Jul 2023 22:58:59 +0200
Message-Id: <20230710205900.52894-4-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710205900.52894-1-eichest@gmail.com>
References: <20230710205900.52894-1-eichest@gmail.com>
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

Add support for 1000BASE-T1 to the forced link setup.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/net/phy/phy-c45.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 93ed072233779..ec1232066b914 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -108,7 +108,7 @@ EXPORT_SYMBOL_GPL(genphy_c45_pma_baset1_setup_master_slave);
  */
 int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 {
-	int ctrl1, ctrl2, ret;
+	int bt1_ctrl, ctrl1, ctrl2, ret;
 
 	/* Half duplex is not supported */
 	if (phydev->duplex != DUPLEX_FULL)
@@ -176,6 +176,12 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		ret = genphy_c45_pma_baset1_setup_master_slave(phydev);
 		if (ret < 0)
 			return ret;
+
+		bt1_ctrl = 0;
+		if (phydev->speed == SPEED_1000)
+			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000;
+		phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
+			       MDIO_PMA_PMD_BT1_CTRL_STRAP, bt1_ctrl);
 	}
 
 	return genphy_c45_an_disable_aneg(phydev);
@@ -976,6 +982,10 @@ int genphy_c45_pma_read_abilities(struct phy_device *phydev)
 					 phydev->supported,
 					 val & MDIO_PMA_PMD_BT1_B10L_ABLE);
 
+			linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+					 phydev->supported,
+					 val & MDIO_PMA_PMD_BT1_B1000_ABLE);
+
 			val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_STAT);
 			if (val < 0)
 				return val;
-- 
2.39.2


