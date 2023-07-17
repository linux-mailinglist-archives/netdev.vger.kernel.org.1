Return-Path: <netdev+bounces-18415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10147756D51
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B920B281315
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6EEC15B;
	Mon, 17 Jul 2023 19:33:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33027C2D2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:33:56 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318D9D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so7971129e87.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622433; x=1692214433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E972yFM3JntaXBnJuhniRRThlZGyx2yAjB4GWaKwH8=;
        b=pw127TbVg6ySd8lkqSZHol04qKWO3c1QWnUglNeJslnpvQt6rCs2hCiugsR88HMSbr
         m5ynVQ/Kp4Y+VBj+gAi2f97Rnzxy+uKj/sVOrjzmFZRVhxaN2j3jEHtQktZhYw4kevi9
         RYSVqRZIIjoNbFc4LXZG3Gj/vJcsxp2y0ACW6LcJB/Nos/tjxD+R/V9THAmJRxSe8SUs
         j4q2Pq4bGMgrs3/OnYhEnf70VRsdhQbWJcdKacXng5ZNS1EFrRonxGov063lYrJ1erNy
         V8nm7vrjUGTH6b2wINpgwr15LL1yMjjfnEBPNYNDdKw3HZn6aloMTqcSu9voTsjCvls6
         JEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622433; x=1692214433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E972yFM3JntaXBnJuhniRRThlZGyx2yAjB4GWaKwH8=;
        b=BkS5X7UKLQY4+ccgx68yTx7agPAvH9UpKTaXd7XzDZjPHba9fQc9W4fJF+EM5x0RNK
         1w6Ep56SNTINl75/k5L+uoUFZPZeA9SY/aZOrm19TnD1dqvAAXh7pPLfaHnR2sXuw2Ow
         h5vAVpofKezNehyjzPazbT/InhJGlaqVoqzkee42p0hhpr2cGVFPkbet+PTNdVnEiloD
         Nt2cZu7eoEaEpTbwxcvX1ZEJdh20ZR8az/HH1JnaOAp1HgVg8s1CCTT4fRyI2N1OLAiC
         QBJgFytLs1hrGWacIuiDGlfEMd2VRWh6ANXBcTyZhQ0b0MwESwarK9Scs6Z+TZOr0Hna
         EEsA==
X-Gm-Message-State: ABy/qLbEUTiKPpahir3/Hx35rHbFOkPICgg8ta2mV2rOhH9FtNUHxXBc
	laDPB0+Sl4cGuMqh+JynJVxD2iZZNF3ckw==
X-Google-Smtp-Source: APBJJlFvYGkDa99yuVM9RuFh6MeeZmwcy2xjmilIIpYQSutJZRStN5VP+koX8NxHYhzKDUxiYQVPFQ==
X-Received: by 2002:a05:6512:b85:b0:4fb:9075:4fca with SMTP id b5-20020a0565120b8500b004fb90754fcamr9683321lfv.11.1689622432610;
        Mon, 17 Jul 2023 12:33:52 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:5cdb:47c:bcfa:4c2b])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d5507000000b003142ea7a661sm280944wrv.21.2023.07.17.12.33.51
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
Subject: [PATCH net-next v3 1/5] net: phy: add registers to support 1000BASE-T1
Date: Mon, 17 Jul 2023 21:33:46 +0200
Message-Id: <20230717193350.285003-2-eichest@gmail.com>
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

Add registers and definitions to support 1000BASE-T1. This includes the
PCS Control and Status registers (3.2304 and 3.2305) as well as some
missing bits on the PMA/PMD extended ability register (1.18) and PMA/PMD
CTRL (1.2100) register.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
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


