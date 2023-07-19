Return-Path: <netdev+bounces-18851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4725758E0C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807BA28162F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F65BE65;
	Wed, 19 Jul 2023 06:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2DBE4C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:43:27 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8496E1FC4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52176fdad9dso6569417a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689749005; x=1692341005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDEyEI9JbgtX5Cqks53anCgM9gV1GIO80U6Uyh5IHww=;
        b=lu9KunBVqZthujWdtAxS5lG8PvaxBdAE2ak2kTnNOqoIqWVU+2/mvuTVVCYoCQD6yU
         sCx02MCfXAqdrYWWwoqoPOVcIljjjwTcev/JhUnBJGddO6cUlT1iUg/oK0wdzyOu10Qs
         NPYmPbTeUgGHNOpjX05TbbyUO1R/Xnwi6zYn3exk84Zbf3fBMwUREYBwcRPi0X3LMgX6
         gPWijlbYNhbpccJOc5KTOCy4Mom0xI8gqWgAxSRzX8KJKCpkd8AuzGzLJyd4LudicmD4
         flsNGgNZaH6GYeHXK7ODJkD1X+QLC5ph431DJ3ljxRYLsK4gESGt1iCsgozMdonGT0FN
         2Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749005; x=1692341005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDEyEI9JbgtX5Cqks53anCgM9gV1GIO80U6Uyh5IHww=;
        b=ft0tTj3Z8STKRqix1ZS1qXZ23pDsgbAuSluclfkxeBrT9FO0Ao9INxf8cZ95ejp1iZ
         eJcs0RyHc6eWbr/NvOPRzG876f4lOBEAK4OpMN1UcPZ4HZgefd3QzrInYtyx86M0Eg+0
         zf440ARWGjaSsbFsetPAQzZ720TDkNnR1hkv+6caVIF8q3o5LExElC/FKflpW6SHHe9t
         GmLUIXGTPd0voPhKnJbJPRLtKCDU5fN10Mfutwa8Lqis6MBdMl0/oDz6tCoOK8MAw2vx
         DJ/WojiwIRma8BsyD5YQTAE5qyHkAPn6YMb+qHIRz1dLVNXrC6fPrwBvoFrbjxdslE95
         q8vg==
X-Gm-Message-State: ABy/qLaNcCxduX87A4k7rzOcnTy7cy0gWO7JCQjBNvSWXe8kCtFJo4aX
	M3q0ZK/JZE5Z8vmDzsTr+IL09wes53xHbw==
X-Google-Smtp-Source: APBJJlGHipLv1iHyemuzM1qF0A+zIB2mooi3FcD7tJtp259G7xl7zYNqiIQma//E5UVflpN+tGI04w==
X-Received: by 2002:aa7:c2da:0:b0:51d:d4c3:6858 with SMTP id m26-20020aa7c2da000000b0051dd4c36858mr1762651edp.12.1689749004588;
        Tue, 18 Jul 2023 23:43:24 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/5] net: phy: c45: add a separate function to read BASE-T1 abilities
Date: Wed, 19 Jul 2023 08:42:56 +0200
Message-Id: <20230719064258.9746-4-eichest@gmail.com>
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

Add a separate function to read the BASE-T1 abilities. Some PHYs do not
indicate the availability of the extended BASE-T1 ability register, so
this function must be called separately.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy-c45.c | 44 +++++++++++++++++++++++++++------------
 include/linux/phy.h       |  1 +
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index b73c428a15663..58a6bbbe8a70c 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -881,6 +881,36 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 	return genphy_c45_write_eee_adv(phydev, phydev->advertising_eee);
 }
 
+/**
+ * genphy_c45_pma_baset1_read_abilities - read supported baset1 link modes from PMA
+ * @phydev: target phy_device struct
+ *
+ * Read the supported link modes from the extended BASE-T1 ability register
+ */
+int genphy_c45_pma_baset1_read_abilities(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_PMD_BT1_B10L_ABLE);
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_STAT);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+			 phydev->supported,
+			 val & MDIO_AN_STAT1_ABLE);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(genphy_c45_pma_baset1_read_abilities);
+
 /**
  * genphy_c45_pma_read_abilities - read supported link modes from PMA
  * @phydev: target phy_device struct
@@ -977,21 +1007,9 @@ int genphy_c45_pma_read_abilities(struct phy_device *phydev)
 		}
 
 		if (val & MDIO_PMA_EXTABLE_BT1) {
-			val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1);
+			val = genphy_c45_pma_baset1_read_abilities(phydev);
 			if (val < 0)
 				return val;
-
-			linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
-					 phydev->supported,
-					 val & MDIO_PMA_PMD_BT1_B10L_ABLE);
-
-			val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_STAT);
-			if (val < 0)
-				return val;
-
-			linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-					 phydev->supported,
-					 val & MDIO_AN_STAT1_ABLE);
 		}
 	}
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11c1e91563d47..b254848a9c99a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1826,6 +1826,7 @@ int genphy_c45_an_config_aneg(struct phy_device *phydev);
 int genphy_c45_an_disable_aneg(struct phy_device *phydev);
 int genphy_c45_read_mdix(struct phy_device *phydev);
 int genphy_c45_pma_read_abilities(struct phy_device *phydev);
+int genphy_c45_pma_baset1_read_abilities(struct phy_device *phydev);
 int genphy_c45_read_eee_abilities(struct phy_device *phydev);
 int genphy_c45_pma_baset1_read_master_slave(struct phy_device *phydev);
 int genphy_c45_read_status(struct phy_device *phydev);
-- 
2.39.2


