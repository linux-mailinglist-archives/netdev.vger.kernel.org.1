Return-Path: <netdev+bounces-16605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DE474DFE2
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4762E280C33
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A83156C5;
	Mon, 10 Jul 2023 20:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979A154BA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:59:07 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C87CA8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso24094425e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689022743; x=1691614743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Fjf5v9UuafzTHrJxUsERoLDEtugSFZ4poO5yBpVHGE=;
        b=If7u7GV7P5Vqvn9YzZElu4NM4khCBPoT9D41y4s9UPaeyYphZopWXEGFGmLN7qzvMv
         jY45HLJ7kv1XpcGpFYz50PvbDHdzkjTmD22IlPvf2AZgrT05+SxD3El6HFjiDUpQR6AT
         0H6LJXG5M0SY6q/lLcUAdKNzEZibeXyAia9zQqO1Mb2h+3JzQWsaK175ZQ4QG7KWflcN
         eLXQ0lGIea/B2IhSzcZiHqukaSXtN/TU6yknTxHYeLzQaHdjQQ+ZRrSZX5eD0AV1HVyO
         f7F0iCopIXQX7C9GMmNZfVPKkoP+5A7bdNo1kcXA+VXwAl9qD2/Ikrg5L5Bffv1W1cAC
         bthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689022743; x=1691614743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Fjf5v9UuafzTHrJxUsERoLDEtugSFZ4poO5yBpVHGE=;
        b=NrCWAzODG5WEbLlUMDGTpTT2OuuRnY2EBk770N4U8e0Gccz6akdFmpVhHbqnqoxqbc
         E8MfXIafOJEJ0MB1ta2b/N+v19/g7rf54aCg14XiYrlLM6SmQU+Re43uHGfrBUsUYoUo
         RRmGRNAvUllHFM0W9AFs6COtHGbz5I3n1wbq3WQttkT3HPUcX1EJfwDX1YW4mQMq1a5P
         riP1yOqSKxDGGvIbUGIhh0hTmXze5ZxZ16+x9kRV8ZcSVmxa9VMmysCOKcIiR10X7Zkq
         ZQvtdEFn/AQDzgmWN5aFpEb8GoAQ1AuToKHzXo/8IUzSl++eFi37HGifbZkl+NPvlTP4
         AGpg==
X-Gm-Message-State: ABy/qLagTeuTfUadjushrbFLxOd/pJnJS3eBF4QK3/FafeMpaW136HQA
	oYUr1Ng8OKLiF5AwgQiTFv7C9hsxIq3jiw==
X-Google-Smtp-Source: APBJJlHquV74DO0lYeXMHeMmxhl2J17Nl5qBaMDrUAjSQyq1Hvzi9iFNaF1llb7YVYDqpOFG1qhkLA==
X-Received: by 2002:a7b:ce11:0:b0:3f7:f584:5796 with SMTP id m17-20020a7bce11000000b003f7f5845796mr13233428wmc.2.1689022743269;
        Mon, 10 Jul 2023 13:59:03 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f6df:53b3:3114:b666])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm11167880wmj.14.2023.07.10.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:59:02 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/4] net: phy: add the link modes for 1000BASE-T1 Ethernet PHY
Date: Mon, 10 Jul 2023 22:58:57 +0200
Message-Id: <20230710205900.52894-2-eichest@gmail.com>
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

This patch adds the link modes for the 1000BASE-T1 Ethernet PHYs. It
supports 100BASE-T1/1000BASE-T1 in full duplex mode. So far I could not
find a 1000BASE-T1 PHY that also supports 10BASE-T1, so this mode is not
added.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/net/phy/phy_device.c | 14 ++++++++++++++
 include/linux/phy.h          |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0c2014accba7d..acc8950f08cfa 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -50,6 +50,9 @@ EXPORT_SYMBOL_GPL(phy_basic_t1_features);
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1s_p2mp_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_basic_t1s_p2mp_features);
 
+__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_t1_features) __ro_after_init;
+EXPORT_SYMBOL_GPL(phy_gbit_t1_features);
+
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_gbit_features);
 
@@ -109,6 +112,13 @@ const int phy_basic_t1s_p2mp_features_array[2] = {
 };
 EXPORT_SYMBOL_GPL(phy_basic_t1s_p2mp_features_array);
 
+const int phy_gbit_t1_features_array[3] = {
+	ETHTOOL_LINK_MODE_TP_BIT,
+	ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+};
+EXPORT_SYMBOL_GPL(phy_gbit_t1_features_array);
+
 const int phy_gbit_features_array[2] = {
 	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
@@ -165,6 +175,10 @@ static void features_init(void)
 	linkmode_set_bit_array(phy_basic_t1s_p2mp_features_array,
 			       ARRAY_SIZE(phy_basic_t1s_p2mp_features_array),
 			       phy_basic_t1s_p2mp_features);
+	/* 1000 full, TP */
+	linkmode_set_bit_array(phy_gbit_t1_features_array,
+			       ARRAY_SIZE(phy_gbit_t1_features_array),
+			       phy_gbit_t1_features);
 
 	/* 10/100 half/full + 1000 half/full */
 	linkmode_set_bit_array(phy_basic_ports_array,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11c1e91563d47..6c71f10e0f7f0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -47,6 +47,7 @@
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1s_p2mp_features) __ro_after_init;
+extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_t1_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_fibre_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_all_ports_features) __ro_after_init;
@@ -58,6 +59,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 #define PHY_BASIC_FEATURES ((unsigned long *)&phy_basic_features)
 #define PHY_BASIC_T1_FEATURES ((unsigned long *)&phy_basic_t1_features)
 #define PHY_BASIC_T1S_P2MP_FEATURES ((unsigned long *)&phy_basic_t1s_p2mp_features)
+#define PHY_GBIT_T1_FEATURES ((unsigned long *)&phy_gbit_t1_features)
 #define PHY_GBIT_FEATURES ((unsigned long *)&phy_gbit_features)
 #define PHY_GBIT_FIBRE_FEATURES ((unsigned long *)&phy_gbit_fibre_features)
 #define PHY_GBIT_ALL_PORTS_FEATURES ((unsigned long *)&phy_gbit_all_ports_features)
-- 
2.39.2


