Return-Path: <netdev+bounces-15125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612FE745C70
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A63280DDD
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B631EAFD;
	Mon,  3 Jul 2023 12:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A44EAF6
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:44:47 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B236FD
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:44:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso41432345e9.2
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688388283; x=1690980283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6q6kK6ClkNToEkJu9Udj9LlvTDAknb4j0X3GF7GnaQ=;
        b=QG61A3J6JnGAY+5STpBGlx28W6nZBcVPlfVG0VGoluKxFEKXkgl2lSbFFcWXKPf736
         6wEgwTUopLxc/DNbq1xEoHKLM2MIuYkPBx4zs9T0Mi4tU5N52QMimnzxdyPy5a6dWTxT
         j6t6jK952u+5KwO2OKV/CNtz/wWBD+qS/F1o8H5qqdHSzBE++V1jnINk8dpIKLjJmcHY
         y0s5kTO8Yzc3un/Y6ZCYilAkxOLS3dgcrLIatqu6nCeGbsymDGz9aFt018Bx89FQuYA5
         81hP6bC/JJHlnYPUYwHAVqtarCTRnl8a8N/j/xaJdbTr5Ya6Rj6VG8XT1fEcy8kE+QVu
         srwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388283; x=1690980283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6q6kK6ClkNToEkJu9Udj9LlvTDAknb4j0X3GF7GnaQ=;
        b=EsLTzqz7xeRfI+A5W8D/rjI2Qo3wTu6tudlD/IQYBqZSUl/obhCHwKBjfq887mtJR8
         DbSv1ysaYgQ7rGfa219v5k1ZL0ev6WRZlnfqOskAtwqgDN9WHiItCfnUKxy7XNPdP9f6
         A1GQu+zqPyXkWnuUYTuvXAp6GXxc6wqkQQ6c59v7VFRCw3kOnt+Cn+LXB2RFJ8GPtN8x
         PeHmqDkqj8Wy7Ml+vRHmtYPTitWDRE0xJ0+0x0qO+GAY1kdejCJcOyeE6nOyNByeou7v
         WPI1l1/npKEjp3wtv0NTCCEGSyS31K6vQ5bIMKovzUTkNtgl90xS6j1TBqtY0QrBA8sG
         Xg+Q==
X-Gm-Message-State: AC+VfDy5sNZWBrfcbCiubgxZsDe+xEG57mt6br1Mzt4seAlmB9TOFKlK
	dCa5kP+eNzlMvJbYcAm7E3jU/g7gkVq6Ow==
X-Google-Smtp-Source: ACHHUZ6a+ZvWBxf3/fKS+z2yhIQnK8NvkJNUNfSx3sx2KU2pbqGwCemXhLIFAYkkA26FGvHgPj+Pcw==
X-Received: by 2002:a7b:cd11:0:b0:3f7:b1df:26d with SMTP id f17-20020a7bcd11000000b003f7b1df026dmr8493274wmj.38.1688388283432;
        Mon, 03 Jul 2023 05:44:43 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:a288:787a:8e86:8fea])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm26650681wmb.26.2023.07.03.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:44:43 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	francesco.dolcini@toradex.com
Subject: [PATCH v1 1/2] net: phy: add the link modes for 1000BASE-T1 Ethernet PHY
Date: Mon,  3 Jul 2023 14:44:39 +0200
Message-Id: <20230703124440.391970-2-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703124440.391970-1-eichest@gmail.com>
References: <20230703124440.391970-1-eichest@gmail.com>
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
index 17d0d0555a79f..4492dbd525f4f 100644
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
index c5a0dc829714f..81b6731a85a86 100644
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


