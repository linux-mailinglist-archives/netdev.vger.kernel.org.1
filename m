Return-Path: <netdev+bounces-18848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5F8758E06
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E341C20C95
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46BF3D8B;
	Wed, 19 Jul 2023 06:43:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C21FC6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:43:26 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51178119
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5216569f9e3so7396621a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689749003; x=1692341003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxrSLmt1sdcD9lzS7GfUjGkTdrTEIcrnI8+/q+GNwjk=;
        b=oXwfzpVT0PPK6fzIYhKCVfKlvTUptHmPyOFDCWG1aCVY1InK2lZeIbkZVIscz4soz/
         axKbZw5wohxPhZmcyyNxB+SwlWkms/IJej2KDWJ0VCFg7xELjY3Fy54EW9Ojl5fCVczG
         MmBWBq1hBlUVy37qaKWR3/mHrBVP45iriVzORZ1U5TCQYe3FPZ29EQBt2DNhsQ/80+Tz
         4DI5xetfzpoiuKH/S4tly5tQXqWYVgdh1/tlu/eToI7DaVVC6Si+jBg3GKlY9CiQHcuI
         3e8djEqoCgVkgR9IGeTkb5rc3QiWiYGrhYQidpUy0lacDqnmJFtrepbxK7HwjTCll1ao
         O2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749003; x=1692341003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxrSLmt1sdcD9lzS7GfUjGkTdrTEIcrnI8+/q+GNwjk=;
        b=QwKfP13WXY7o+qZsuvxzm5fQLNnPwgLP7ib2DOE1r7/ddlP4MV61e5YXbO9xiJoZwM
         4BexHRRlIIJI24MHa05f93c4ot2VFn44U5vFgpMLcTFx+eSUoHO0v1DkPoDR3L7Nt/C1
         eWwkOWOu/xwJGOaybLtURkvtMLmC1mhsB0khP4/gDTbpRXqMOauu1GwLJ39Rnx2+TPoV
         jkXs+S/2jzquCb5xEU9s8fCrSkQodSJHPLavoOOANJpSgZer/wBGZxZMYzaCUzfwbvIk
         4yBRg38wjg9M+ChSQu0+hsM2FubWuty14F8sZrcF1OzAV8LMM095yDPfdZ/7gEdCbKTD
         OlJw==
X-Gm-Message-State: ABy/qLZDvyoAs1frjCSug6gtCrlwWzVhIEh51bYTYBwDfFcvlblp5aXT
	7fUop06JeLPOUPRo0ue4ZwJwOOZMaeGFHQ==
X-Google-Smtp-Source: APBJJlGIDo08IUEZI35rB8AD5M5A16iZHmKxFBk3l5BuMTl+xVQsb/bnzet3oKL7UE1ncfM7Tmnr5w==
X-Received: by 2002:a50:ed94:0:b0:51b:c714:a2a1 with SMTP id h20-20020a50ed94000000b0051bc714a2a1mr1669418edr.7.1689749003449;
        Tue, 18 Jul 2023 23:43:23 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:b88b:69a9:6066:94ef])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b0051e0f8aac74sm2301868edy.8.2023.07.18.23.43.22
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
Subject: [PATCH net-next v4 1/5] net: phy: add registers to support 1000BASE-T1
Date: Wed, 19 Jul 2023 08:42:54 +0200
Message-Id: <20230719064258.9746-2-eichest@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add registers and definitions to support 1000BASE-T1. This includes the
PCS Control and Status registers (3.2304 and 3.2305) as well as some
missing bits on the PMA/PMD extended ability register (1.18) and PMA/PMD
CTRL (1.2100) register.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/uapi/linux/mdio.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b826598d1e94c..d03863da180e7 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -82,6 +82,8 @@
 #define MDIO_AN_10BT1_AN_CTRL	526	/* 10BASE-T1 AN control register */
 #define MDIO_AN_10BT1_AN_STAT	527	/* 10BASE-T1 AN status register */
 #define MDIO_PMA_PMD_BT1_CTRL	2100	/* BASE-T1 PMA/PMD control register */
+#define MDIO_PCS_1000BT1_CTRL	2304	/* 1000BASE-T1 PCS control register */
+#define MDIO_PCS_1000BT1_STAT	2305	/* 1000BASE-T1 PCS status register */
 
 /* LASI (Link Alarm Status Interrupt) registers, defined by XENPAK MSA. */
 #define MDIO_PMA_LASI_RXCTRL	0x9000	/* RX_ALARM control */
@@ -332,6 +334,8 @@
 #define MDIO_PCS_10T1L_CTRL_RESET	0x8000	/* PCS reset */
 
 /* BASE-T1 PMA/PMD extended ability register. */
+#define MDIO_PMA_PMD_BT1_B100_ABLE	0x0001	/* 100BASE-T1 Ability */
+#define MDIO_PMA_PMD_BT1_B1000_ABLE	0x0002	/* 1000BASE-T1 Ability */
 #define MDIO_PMA_PMD_BT1_B10L_ABLE	0x0004	/* 10BASE-T1L Ability */
 
 /* BASE-T1 auto-negotiation advertisement register [15:0] */
@@ -373,7 +377,19 @@
 #define MDIO_AN_10BT1_AN_STAT_LPA_EEE_T1L	0x4000 /* 10BASE-T1L LP EEE ability advertisement */
 
 /* BASE-T1 PMA/PMD control register */
-#define MDIO_PMA_PMD_BT1_CTRL_CFG_MST	0x4000 /* MASTER-SLAVE config value */
+#define MDIO_PMA_PMD_BT1_CTRL_STRAP		0x000F /* Type selection (Strap) */
+#define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000	0x0001 /* Select 1000BASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_CFG_MST		0x4000 /* MASTER-SLAVE config value */
+
+/* 1000BASE-T1 PCS control register */
+#define MDIO_PCS_1000BT1_CTRL_LOW_POWER		0x0800 /* Low power mode */
+#define MDIO_PCS_1000BT1_CTRL_DISABLE_TX	0x4000 /* Global PMA transmit disable */
+#define MDIO_PCS_1000BT1_CTRL_RESET		0x8000 /* Software reset value */
+
+/* 1000BASE-T1 PCS status register */
+#define MDIO_PCS_1000BT1_STAT_LINK	0x0004 /* PCS Link is up */
+#define MDIO_PCS_1000BT1_STAT_FAULT	0x0080 /* There is a fault condition */
+
 
 /* EEE Supported/Advertisement/LP Advertisement registers.
  *
-- 
2.39.2


