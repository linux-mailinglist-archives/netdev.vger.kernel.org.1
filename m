Return-Path: <netdev+bounces-16606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960074DFE4
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5846E1C20A2C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF5154BA;
	Mon, 10 Jul 2023 20:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41894156F0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:59:08 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE24BC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso51219245e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022744; x=1691614744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c0onf4PRU4Nx8XQzCMe0ZvOIoJ1jHx4wcNy1QnLCcM=;
        b=nLjfi8sIgJ10fK9VDNoVLskkwIYt8774ut/QcTFP0nnUVfuRipp8xK11AT3ojcxikm
         0xdI2MuMMeAQW7wwdwuMcI4HlWsJ4oPR5kny0EXt8ClL0oP+cw8hfzGyv4BD8Aq7NxAm
         t+KshgskTIybrJXNvr3qEP2GmLQ5JZEJxvsO7tEekWy/fJaP9x5rixDNwinS0VNZojrV
         OPjGwwGF955EQC/OMtON7C6ydJkME0+ZgZJvn3se+44dw22XRZ0G4CZZy9kZngZAHFEZ
         LacPdaiEkrniSh4yfyp7X4WvwxZkW6plg3c8vbaOGVui4DNWChMsTKMTVfhVP0Dx8yKH
         sL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022744; x=1691614744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c0onf4PRU4Nx8XQzCMe0ZvOIoJ1jHx4wcNy1QnLCcM=;
        b=ac1oQ6kcIOJQtGERZ2D7dzD2o2YwL5EliqGg6+mmb64JVqupVuh/hK2STO2bdzCsJz
         9G5O+/mAMuSCQB2neW8Zjp33LQ2sD0iZi3YmN/qKk97zGndohEqSLzc+IVILFrWsIOQo
         bSGYaP7O9kDFn/LzmrXk8VMoavzPkTu5f/vBfQJbZPQaYqn/JwZuXP5isVuaUVGaj3qW
         e8rGp1HTFLzTLpLQH+Yjg1+3F3fpKkgHQN7aX+KPQ6THG3EVlky34EjJ6UkO96aUmO9w
         FA0aqjdZq4y6KpoHW7M2i+pVqZ6u4R0zr+8SIJ9pSx82QO/9QaNDwRi0veOtxufTd4eL
         deVw==
X-Gm-Message-State: ABy/qLY5icwVdJG5AFizFnJz8FpINI8ifQ1BgLF/DE6eTvGxDzsaOdAT
	eGCqIgLGgPopXHn+GHXuJa7ZBUCF8pPF+w==
X-Google-Smtp-Source: APBJJlG9DBFMu7sk5xtr4OUc/jghCsBjGJfU096TTujn4XrPXQDOT+OY+GEbvykiltDtq0XWSKT0RA==
X-Received: by 2002:a7b:cb8f:0:b0:3fb:4165:9deb with SMTP id m15-20020a7bcb8f000000b003fb41659debmr338324wmi.18.1689022744602;
        Mon, 10 Jul 2023 13:59:04 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f6df:53b3:3114:b666])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm11167880wmj.14.2023.07.10.13.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:59:03 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] net: phy: add registers to support 1000BASE-T1
Date: Mon, 10 Jul 2023 22:58:58 +0200
Message-Id: <20230710205900.52894-3-eichest@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add registers and definitions to support 1000BASE-T1. This includes the
PCS Control and Status registers (3.2304 and 3.2305) as well as some
missing bits on the PMA/PMD extended ability register (1.18) and PMA/PMD
CTRL (1.2100) register.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 include/uapi/linux/mdio.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b826598d1e94c..ffa821cb291a5 100644
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
@@ -332,6 +334,7 @@
 #define MDIO_PCS_10T1L_CTRL_RESET	0x8000	/* PCS reset */
 
 /* BASE-T1 PMA/PMD extended ability register. */
+#define MDIO_PMA_PMD_BT1_B1000_ABLE	0x0002	/* 1000BASE-T1 Ability */
 #define MDIO_PMA_PMD_BT1_B10L_ABLE	0x0004	/* 10BASE-T1L Ability */
 
 /* BASE-T1 auto-negotiation advertisement register [15:0] */
@@ -373,7 +376,14 @@
 #define MDIO_AN_10BT1_AN_STAT_LPA_EEE_T1L	0x4000 /* 10BASE-T1L LP EEE ability advertisement */
 
 /* BASE-T1 PMA/PMD control register */
-#define MDIO_PMA_PMD_BT1_CTRL_CFG_MST	0x4000 /* MASTER-SLAVE config value */
+#define MDIO_PMA_PMD_BT1_CTRL_STRAP		0x000F /* Type selection (Strap) */
+#define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000	0x0001 /* Select 1000BASE-T1 */
+#define MDIO_PMA_PMD_BT1_CTRL_CFG_MST		0x4000 /* MASTER-SLAVE config value */
+
+/* 1000BASE-T1 PCS control register */
+#define MDIO_PCS_1000BT1_LOW_POWER	0x0800 /* Low power mode */
+#define MDIO_PCS_1000BT1_DISABLE_TX	0x4000 /* Global PMA transmit disable */
+#define MDIO_PCS_1000BT1_CTRL_RESET	0x8000 /* Software reset value */
 
 /* EEE Supported/Advertisement/LP Advertisement registers.
  *
-- 
2.39.2


