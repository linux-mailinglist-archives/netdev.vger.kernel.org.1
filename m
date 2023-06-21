Return-Path: <netdev+bounces-12521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D2737F03
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A2B1C20E42
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297ADDB0;
	Wed, 21 Jun 2023 09:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7916DF57
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:31:15 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30291989
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so4561748f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339872; x=1689931872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybtO4Wog7AXA+LuJ7ppZ2BwN9dyYZ5NmmDbgKQHeLHM=;
        b=GbEYPR52b9eyHWmMfQU9tvxe081wY8nIF6gJ+LgJ2SlgFQ61zD+2NzGNljuXKeWy24
         LICZ2j4cIUIqB4M9uHH9OBqCAf81admdZooSMEzGnVTZlENGAJArH+OU0feZq4wZJOIJ
         Vvmyp1jnZUar0x3VDO97AP/HdoH9AoCKcyIa/32nekVLkhrKozliSJQmm6MdckAS7A1d
         43G5aKpBfnpfF8e4HGgwvkwzwk0ERyZ/t+jxxVJGFEiSAhKR7nkVegtGqXe0vJySt9CZ
         Z0BZB4msJpteWeG4DHueVVr5CfwIUnYQExTnPDUsxSv8vYpYVsW6e2jl8xXbVPL4Qhu4
         tNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339872; x=1689931872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybtO4Wog7AXA+LuJ7ppZ2BwN9dyYZ5NmmDbgKQHeLHM=;
        b=ECUwiyezT+xjjEG6yX3h5rfg5eik2rwfPM8LPPltQYpzvlKzQX5BKJj0J6xArvzdrx
         TC8PLgXdXTmffV5vNK3ZBXBGB9tDpxT27SAladswu1e0RmrdDpRE+pJRAafLQerR3FT2
         RFsLlvt4Bfc4Opt6aTFOP3JqQvwv0Jue2aOiwETLexvwIpQi9L9iQdnCCnlxP/YxzfU8
         mF/UJ/n/w1XGTFj+b88n40yQ3sSdM/YS3DlIeda3ZxOp60Eqw9p5/47ffBl9LrCJlPBS
         h+Y0gGrnYxT97PnVSv6QbpX3oX5SsCXY3ANRX1tiHOiRmj6udAhFEBI+GeOLtJdnPVS4
         wqGA==
X-Gm-Message-State: AC+VfDw2K1j+9mguDP2PlYKv16rD1HOtLT7fOtR9JH9YgJO67V1h7zqL
	FLoM98Cp1GnH6iBSzPxSh3W0Tg==
X-Google-Smtp-Source: ACHHUZ6N4ShxDPmm0lHjPVsFzQjzdixQQokpJC6Xp7OpddAHkKElZIycIIwE8vb2xIbBKwges4fvGg==
X-Received: by 2002:a5d:6501:0:b0:30f:c420:1743 with SMTP id x1-20020a5d6501000000b0030fc4201743mr12562307wru.26.1687339872182;
        Wed, 21 Jun 2023 02:31:12 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:11 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 3/6] can: tcan4x5x: Check size of mram configuration
Date: Wed, 21 Jun 2023 11:31:00 +0200
Message-Id: <20230621093103.3134655-4-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621093103.3134655-1-msp@baylibre.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To reduce debugging effort in case the mram is misconfigured, add this
size check of the DT configuration. Currently if the mram configuration
doesn't fit into the available MRAM it just overwrites other areas of
the MRAM.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/can/m_can/m_can.c         | 16 ++++++++++++++++
 drivers/net/can/m_can/m_can.h         |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a5003435802b..1cdd2675f022 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1887,6 +1887,22 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
+int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size)
+{
+	u32 total_size;
+
+	total_size = cdev->mcfg[MRAM_TXB].off - cdev->mcfg[MRAM_SIDF].off +
+			cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
+	if (total_size > mram_max_size) {
+		dev_err(cdev->dev, "Total size of mram config(%u) exceeds mram(%u)\n",
+			total_size, mram_max_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(m_can_check_mram_cfg);
+
 static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 				const u32 *mram_config_vals)
 {
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index a839dc71dc9b..d8150d8128e7 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -101,6 +101,7 @@ int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 int m_can_class_get_clocks(struct m_can_classdev *cdev);
 int m_can_init_ram(struct m_can_classdev *priv);
+int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
 
 int m_can_class_suspend(struct device *dev);
 int m_can_class_resume(struct device *dev);
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2342aa011647..e706518176e4 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -80,6 +80,7 @@
 	 TCAN4X5X_MCAN_IR_RF1F)
 
 #define TCAN4X5X_MRAM_START 0x8000
+#define TCAN4X5X_MRAM_SIZE 0x800
 #define TCAN4X5X_MCAN_OFFSET 0x1000
 
 #define TCAN4X5X_CLEAR_ALL_INT 0xffffffff
@@ -307,6 +308,10 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (!mcan_class)
 		return -ENOMEM;
 
+	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
+	if (ret)
+		goto out_m_can_class_free_dev;
+
 	priv = cdev_to_priv(mcan_class);
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-- 
2.40.1


