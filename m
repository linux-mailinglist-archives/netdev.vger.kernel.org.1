Return-Path: <netdev+bounces-22294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B35766F4C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D30D2827B1
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7014000;
	Fri, 28 Jul 2023 14:19:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8113FF2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 14:19:32 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768310DD
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:19:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31771a876b5so2017735f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690553969; x=1691158769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzaljnOO1Gw4qS38ZHWvBAE06zq5Umr4CoJZWfxvzDg=;
        b=xUKyFTsSuvcbCo9x7xJzgCo0oi8PFn1TINP4lMKpkxprTf0fSFnKI6CO/S5K6BG4U4
         aoSzf21spDOrbbJxqmOzt3E2ezOIXsAIegZZXaBpZ9sTRLPzZnHfC4sH6o6QWLc8Rogr
         +yXcap8TxO+tUAf6McFVa8Iuk4X2x1lQaF3GXWSpz64Q4LI590V++pfeW+hUbDZ/qbCK
         FdP4mQBw+v/PRGEN8ni/vSzX4KVKhkasOtgZvmStCpQZ5+cI1dpATaCtFOrMzXBBOSQh
         9MVaZXQDFeOApmJTmwVjSyFg6Y6Vt3Z6yE8pIAkRw08w7U+eKNQ/aROZB6Tck/bZQ/SC
         +Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553969; x=1691158769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzaljnOO1Gw4qS38ZHWvBAE06zq5Umr4CoJZWfxvzDg=;
        b=f164LY6MNcd5btPHt5vHGnBRGJUzS1vsA+Y4we5PV9B76p+BEnAVqT7eo3N6dNYkjQ
         QFEyHzCszrpkmIp/SIiygTKsPliAkFOF6HjvJFYbW/9jCGNhfgEDZPIKA9uq4gL0Ay/R
         Sw8kbR8MCkXJFubutTSeJ2AFPH8xLwmpIhiZrbag9gpCH7eXXAimdBxBn+MnD3Btixf2
         L2fSAPqU0SjbAgs5VokmBK2PkNDfIGdSryfU/Jia7AYp7J/T/dQ8oAG2SHEow3GIVHbd
         JxRfvXV18OKb71nIDAB04dQpA6pE3u364s/OUvRExA0ahFr6rN9M+agWZaxd5t4kFc5g
         6aYw==
X-Gm-Message-State: ABy/qLayzD5KlLAGFcRnXhLTNQfpVRt7zKoVdmDrjGMcgmn84kKpH4dj
	sDE9kvM+zI13hZ9qLkjhzMDm/Q==
X-Google-Smtp-Source: APBJJlFcmt7PAwt3/8ccEaz69Q1c5nt6HSR44F+rbNLEzPLymPTwyiEBTmcnY9kb/BekXh461NYLFw==
X-Received: by 2002:adf:d84b:0:b0:317:568d:d69a with SMTP id k11-20020adfd84b000000b00317568dd69amr1991756wrl.11.1690553968837;
        Fri, 28 Jul 2023 07:19:28 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a246:80e3:766f:be78:d79a:8686])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm5013681wrm.3.2023.07.28.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:19:28 -0700 (PDT)
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
Subject: [PATCH v4 3/6] can: tcan4x5x: Check size of mram configuration
Date: Fri, 28 Jul 2023 16:19:20 +0200
Message-Id: <20230728141923.162477-4-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728141923.162477-1-msp@baylibre.com>
References: <20230728141923.162477-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index c5af92bcc9c9..9210cf0705a1 100644
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


