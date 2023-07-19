Return-Path: <netdev+bounces-18849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF5758E07
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942F81C20C84
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304508BFE;
	Wed, 19 Jul 2023 06:43:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6179DE
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:43:27 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB4E1BF3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so9229074a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689749004; x=1692341004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgY/tIKs7JfRavioVCfjDpc9fCFeRXz+HCPT+5I+NT0=;
        b=Jc9Z77AUE+0QZCiipp+5cWRB9MzPy6UelJBwQ73l1sl9EUR4ChC6iIUBUPXnzSbBY3
         dx4QuFfFfdUKGWRwZ1Cf3MBITcsEpPRswf5akdZ5/L13o3ETl4xMWJdJcsHltIRbNgm5
         BW8p3KQhV5AY0t0WWnLoKOYLz2O59hwL3UaeWmLli30dlWFOhI2ROZcg3BxzFzMMF/00
         7ORujkpnRw25bj1ISufkVA2jbQQIflKsyASGc4CtXtMr9Pla0uVaNeOBn0i1OZFafQvh
         jFq36XdSKpa6l2LjiH2WOH5Vh3+sJBfZhOXhXvBHyHUS4iUiUr2bIRxuk8Wre30FDdhC
         g3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749004; x=1692341004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgY/tIKs7JfRavioVCfjDpc9fCFeRXz+HCPT+5I+NT0=;
        b=eapLo2wPRFQhv0VIWln1yOWdybqiA4CKZgnifncffN1uam5M49wx4gDQ7HCgs3DF81
         w6zO12sqYHusf/0SC6xBZ/i7yR13TCRX0T+RRwIMs/AE+gfetlm/zJsYJUe/lCNuZfSJ
         6GvD3Rf9lAV9YqfthhfuDSDI3OoKvflnfQwQA2nj9RyaBXhl+2m0heVEShmM7IDu00ug
         jtPwwC4irrDnhQ9IhEy/aqXdJvZfrVA4Zea4r573yNLRUtC2OTtuvhF26gsa1fnifub1
         jQQQZFAWraEWE6gAbuAihYjTauq4Aw4/iXISq4WjCngYemZpQg4t0Myoe637Y2q0ptbc
         SWxA==
X-Gm-Message-State: ABy/qLZWLwbQya5P31DvJC9iofriWpkHAEeJ6ZLLz4lPaZBak/eiAoSJ
	4NkmiEnYz2wN1PGN9aVAUN7gttnqzzn2vQ==
X-Google-Smtp-Source: APBJJlH2BLvZ8Osvzf4sF5fOL/EWtcxUHoeAnb/YdrjC+dhgtgv22b1TNxewH1Wcqf/sNDXywo2FBQ==
X-Received: by 2002:a05:6402:164d:b0:51e:2664:f695 with SMTP id s13-20020a056402164d00b0051e2664f695mr1536796edx.23.1689749003962;
        Tue, 18 Jul 2023 23:43:23 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:b88b:69a9:6066:94ef])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b0051e0f8aac74sm2301868edy.8.2023.07.18.23.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:43:23 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/5] net: phy: c45: add support for 1000BASE-T1 forced setup
Date: Wed, 19 Jul 2023 08:42:55 +0200
Message-Id: <20230719064258.9746-3-eichest@gmail.com>
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

Add support to force 1000BASE-T1 by setting the correct control bit in
the MDIO_MMD_PMA_PMD_BT1_CTRL register.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy-c45.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 93ed072233779..b73c428a15663 100644
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
@@ -176,6 +176,15 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		ret = genphy_c45_pma_baset1_setup_master_slave(phydev);
 		if (ret < 0)
 			return ret;
+
+		bt1_ctrl = 0;
+		if (phydev->speed == SPEED_1000)
+			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000;
+
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
+				     MDIO_PMA_PMD_BT1_CTRL_STRAP, bt1_ctrl);
+		if (ret < 0)
+			return ret;
 	}
 
 	return genphy_c45_an_disable_aneg(phydev);
-- 
2.39.2


