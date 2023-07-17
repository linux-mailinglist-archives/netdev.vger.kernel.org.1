Return-Path: <netdev+bounces-18417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA391756D5A
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1788B1C20A21
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C90C2ED;
	Mon, 17 Jul 2023 19:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85EC2D2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:33:57 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5684A9D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fc0aecf107so44360715e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622434; x=1692214434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJyisUVVON4yBHdKtKri3/pj47bTnU//CxN8Mrd7f9I=;
        b=f+yNEjuUy0nhanE0GRAJyBmmcjQ/XOnRQnRrqS+BTIqZyqYJMbRBxyLJVIVikc90cr
         enOnGgyghsK9UU0FOARdO3BT71Q5Fk3ZTyZtOVYVTYEF3CyxidDGsdWD8t9ThdpIoOfU
         Z90cN1n3qcJwvf5onSdKTLFNBPM9Xf/OsJViSXREKrqvCJdGBBiCACSzlXK60Y/CA8/O
         2peaKISeLS3OP2S1rV1JuocCyo5c/2Vhy+Gc/sd7jvLA2Hr3LRXAJwzokgdoenZBCvAV
         D1jOwyvbPlIrvEvUDU0QVWKnxHWhkZnou/Sfh4WUb3P595IVBw6TpBz13RtyW4B+uG/l
         rj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622434; x=1692214434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJyisUVVON4yBHdKtKri3/pj47bTnU//CxN8Mrd7f9I=;
        b=drjVM9UFZ8Tx/lNG9dZtM+IdpQfbYKVsuPQWw5Grw0dSPlUzsZ4aZb0lYdV2EXMblU
         uC7yAmL5CjkgAcFwjvT4t32xYDAnzPhxUBwY3ZTxBpHOODYWRJiylNpTiNe9dD9UyHLV
         xCvVpuuEkl0aNpmsnBzSm+TDhlMMl5q5/ML0ov4oGNv57SILkPospexbfYJqSmb78aQk
         gX7lvLTllckW09Jfq2XcoWV5zDwTUP8RyFs7ygGrKiET9Vmbzd00rkpN87lqK+cXMA2n
         +Wy4xjGhdwMRSrDNnPmWX1NRAwBzZyiNWTiM/Ih6oGMFeLF2u+IcHXNu7CJwpgMP0PS5
         ARKQ==
X-Gm-Message-State: ABy/qLZ74Z+Aa85OFmNnedRaVrW9kmYLDoEXmNsQmigL1xStQ9jbNRHd
	+DQZ/3Jb79zdxDqRMKFUJQ023zNwlPZayg==
X-Google-Smtp-Source: APBJJlH+Y2OLnSd/g7fe1YEWjgNbsoOlcdvRG1FpclaFXo1/mFqADofgWAn9YfVRHcO6t5C6i6FKqg==
X-Received: by 2002:a05:600c:21c2:b0:3fc:5821:3244 with SMTP id x2-20020a05600c21c200b003fc58213244mr252138wmj.1.1689622434417;
        Mon, 17 Jul 2023 12:33:54 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:5cdb:47c:bcfa:4c2b])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d5507000000b003142ea7a661sm280944wrv.21.2023.07.17.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:33:54 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/5] net: phy: c45: add a separate function to read BASE-T1 abilities
Date: Mon, 17 Jul 2023 21:33:48 +0200
Message-Id: <20230717193350.285003-4-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717193350.285003-1-eichest@gmail.com>
References: <20230717193350.285003-1-eichest@gmail.com>
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


