Return-Path: <netdev+bounces-25090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E537772EBB
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD52E2814AA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACA16429;
	Mon,  7 Aug 2023 19:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FB71641A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:31:39 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9EF1724
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:31:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso3858873f8f.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436695; x=1692041495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUv2dCmaY1HQ3Em9YoZBFw+fysyiFKPhrXvqJWxPFfc=;
        b=fwYEVPozF0KvOAt3mvF2iWylh9QmqRqt6P7UQtmErMGi7zH3ak4HGMUMpMJ2bZ1lXm
         VYM/qx/GA1gZswRwl/BrgW8MPuzikyAs9Uxg3IBlbTWatJ03xBxshTdi4JF1qsKXjU1Z
         /irX6Ft5wQ+jIRnRo1aHiCGv3cgH7YDlBandU2g9jE10W7Khmwr/xqTS4Fj3vUO9DuL0
         JwJ2sEeD3P7L1CiXMTb1Sjq0RnceQPtkEL4ODMK8QJzK7EQlNwG4r2u8V2vuZ4wfRueI
         HkX0Rlz77K+vIPk4wurJ+N4egWqsykC0CyJYc+WeeM9z8hzqB5rMFP7iOL9imijzAxEK
         AUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436695; x=1692041495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUv2dCmaY1HQ3Em9YoZBFw+fysyiFKPhrXvqJWxPFfc=;
        b=h1XyUC62J+Zp4vYctgCQd8UtlhzYMT4fjw5geVBnDgWwZwYzTj0XJoOXG+GYtXJNQL
         j4bmTryLyNPCoU5joFh0DbKanxBnkG0svJcrMmHF5WYLmJmw0BVjNmosSyDJU1bGNnIF
         TKbpidKGigA/mAxdD/H5EIXtr2ZWuDz0esVKhFK0KqVCZqlXrvue5bGz8CtO44mnB3Wb
         QZ4mA6d+icQMr/qMBSsQWH1sLm44k2/8M5O5nqvP8suO9ZVks05fdEXt7BPYjV+orKBb
         GqKEYLzjRUUVQRaKlSz95AYXU/d7DMbzcDFeBONqaTW5MN5QQt5T4RVEaCl4y+Y74U8Q
         cNtQ==
X-Gm-Message-State: AOJu0YwYCd4Cfag6mSmlOY6tLNBykJMgBc3+28TbPXCQ8A2PZSvjAq0v
	W4gSp/ocSYS3IT4rYv3XLvec/g==
X-Google-Smtp-Source: AGHT+IGKHNN7HjiGFusOQDWkTj+8K7D28pYI8N1+cBGqCVE35V0LUQ9gkEQ2lEJmnrAT6utfK07xtA==
X-Received: by 2002:a5d:5912:0:b0:317:606d:c767 with SMTP id v18-20020a5d5912000000b00317606dc767mr5959349wrd.44.1691436694877;
        Mon, 07 Aug 2023 12:31:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003fbdbd0a7desm15985654wmj.27.2023.08.07.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:31:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] net: stmmac: support shared MDIO
Date: Mon,  7 Aug 2023 21:31:02 +0200
Message-Id: <20230807193102.6374-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807193102.6374-1-brgl@bgdev.pl>
References: <20230807193102.6374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When two MACs share the MDIO lines to their respective PHYs, one is
considered the logical "owner" of the bus. The secondary controller must
wait until the MDIO bus is registered before trying to attach to the
PHY.

If the mdio node is not defined for given MAC, try to read the
"snps,shared-mdio" property on its node. If it exists, parse the phandle
and store the result as the MAC's mdio device-tree node.

When registering the MDIO bus: if we know that we share it with another
MAC, lookup the MDIO bus and if it's not up yet, defer probe until it
is.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c     | 8 ++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 6 ++++++
 include/linux/stmmac.h                                | 1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index dd9e2fec5328..6a74b91595d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -543,6 +543,14 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (!mdio_bus_data)
 		return 0;
 
+	if (priv->plat->flags & STMMAC_FLAG_SHARED_MDIO) {
+		new_bus = of_mdio_find_bus(mdio_node);
+		if (!new_bus)
+			return -EPROBE_DEFER;
+
+		goto bus_register_done;
+	}
+
 	new_bus = mdiobus_alloc();
 	if (!new_bus)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be8e79c7aa34..11a24b1c7beb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -340,6 +340,12 @@ static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
 		}
 	}
 
+	if (!plat->mdio_node) {
+		plat->mdio_node = of_parse_phandle(np, "snps,shared-mdio", 0);
+		if (plat->mdio_node)
+			plat->flags |= STMMAC_FLAG_SHARED_MDIO;
+	}
+
 	if (plat->mdio_node) {
 		dev_dbg(dev, "Found MDIO subnode\n");
 		mdio = true;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 3d0702510224..892f61051002 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -218,6 +218,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
+#define STMMAC_FLAG_SHARED_MDIO			BIT(12)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.39.2


