Return-Path: <netdev+bounces-18416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF0756D59
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F100D1C20B5F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA4C2E0;
	Mon, 17 Jul 2023 19:33:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C0C2D2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:33:56 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE794
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so4643375f8f.3
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622433; x=1692214433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chOtTGy3RCe4AdvZehAqfrlzLXYbU1xtLDtXaVPu9CI=;
        b=lD9+ZhplqgK5jibLakCkcAfLcSSFvSHnIzY0okrnreFX9S3sIXc8dg/PNRAea1WQz5
         MrlhaImBOjnk+Cil/pvxBEwC07Bvo1XUiffhzWl4Q059IHv8eXlIkhKt0ehjwTl64ABb
         1mm0mLx3HcaGUVCgX/fD6mRU+9osHCBFle1QbgX3ZgGZljHKcAXXxu4TwXtfB9x+OKRD
         4YAM6oT9+ENDis3evpzCPt0xMRJgmzHooSzDgE51gooSD2USj2Ts9skbZWXsxIZXhjLh
         QDjivkXc4QnKIAClKLK0QVMcSZMct4c03+oGo0GUm/ZFzDqsDUlU51zmZSCcGe73oCt7
         aaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622433; x=1692214433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chOtTGy3RCe4AdvZehAqfrlzLXYbU1xtLDtXaVPu9CI=;
        b=YWaKNGBq0xg1wipH+p5b9RRLswTXzq89RCzdwLD+oRtt5XRpTM9W4iCFLqGfZzYQq4
         5eiwT139LD0TLZoIgxH7paE3PuW59+N7c5T9w+uBTjk9rVshBL2e7FtCZ6OcchWS7kPf
         qShJSYP1PMxELTfCAlTHGlgJWKxkqSHm9lasZQDVGSbWEO/qPnJstsCkZ5W02sWhTY15
         Ix14NEQ8wHVyUINgcR2LI9Xml2mmgakZlJIiUzaUhAEUMw8jaxnTRi0RDCW1maxhiK1O
         H60f0Z+I+j5h7cVdcHgZkeMoHJc17zyA14nvoPdoqCUPexXd5XGonpyJ4nCPEVM/az1d
         O8pQ==
X-Gm-Message-State: ABy/qLb03qOn13zFYTCYjK3oomjug9EIZQBqpdsaFrSZXbb06BZcXDj+
	Nj5zN1l9Ju+9fIrDq7QZf1sesx2zmM4e8w==
X-Google-Smtp-Source: APBJJlHir6+Ed/tFrP6T/WyTHDpWSangLI0ZRPm2GkjxVWn/3Ct/jLexDgttqrIi9P3wyfmqRP1XJA==
X-Received: by 2002:adf:e803:0:b0:315:99b8:c785 with SMTP id o3-20020adfe803000000b0031599b8c785mr10409135wrm.9.1689622433569;
        Mon, 17 Jul 2023 12:33:53 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:5cdb:47c:bcfa:4c2b])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d5507000000b003142ea7a661sm280944wrv.21.2023.07.17.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:33:53 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/5] net: phy: c45: add support for 1000BASE-T1 forced setup
Date: Mon, 17 Jul 2023 21:33:47 +0200
Message-Id: <20230717193350.285003-3-eichest@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support to force 1000BASE-T1 by setting the correct control bit in
the MDIO_MMD_PMA_PMD_BT1_CTRL register.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
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


