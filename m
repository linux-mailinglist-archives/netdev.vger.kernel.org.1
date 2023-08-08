Return-Path: <netdev+bounces-25380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEFB773D39
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E861C20952
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1437168D1;
	Tue,  8 Aug 2023 15:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D914019
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:59:04 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75FB18C1D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:58:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so90463131fa.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691510329; x=1692115129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie3WcAqbCuJwn+bSe+8uiPLhrE9XYV8epIzLQ3pbcL4=;
        b=accuhKDnjl6ytUoUPh/0fwJjQUgg6PBrwg7W1cW6U6YwzcoS6rwMvDGf12HN0HC+Cd
         N7uQvUXXMPRmPCgNaPFFX4FQrqZ6Gmyqjj9uL0tjz6VmHfMoGj8XbpDOtrwcSCgGkf0b
         CskIxAcGAz4H22gT+FJEtYRGVMLTTaCgdmAGYAbeHK0W+B8+1bZtyT33jyeXQMMu7sZb
         vewp1SD5/8C5SmyMbN7lXpMXMFNjNI0azINZ7kTDl6wCABFOhBWPbOBL6CydQMCnmK7F
         E2DZ4b+spOCWqXHLiUMI44k1Jlg98O1opYjt58PWc9sauEs0tWxm70qYGuZkpoFQVg8R
         tksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510329; x=1692115129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie3WcAqbCuJwn+bSe+8uiPLhrE9XYV8epIzLQ3pbcL4=;
        b=ULAVC5mqJ1uLPtUlgH1FbrFpsJuzzRV1NnEUeOjVu+55zOmWmdeCbWrFikLQd/VKLZ
         vNDctUMqhTMu1+1ljswPsxBAANGYqeEhIbwx3SnUXLxfGTMY/mfz3bFKD2aypj0AMo3v
         I+C18rJShnK0QLryl8Mm3jCCGRP1tsomM6lU4mi8mvkhcp4ZU1liPwwHEpGSTVWzr+oO
         KTk6xpnGAnXo03dCWJO5miic71OvwjpEnP1xim7Wp6q5+FYx+Nc8IAkW4uQTp1z2gGg9
         4PZy4u5fSvLFXEJbo1UHMJynGbV9D4pYBlp+xlpVuhfT9PIRQPZ9ylj1lu2INNN1Erxh
         mcxQ==
X-Gm-Message-State: AOJu0YzlC+UF0BVKLRgTYeRUu9CAkT+rilUyO0gtraauDb8ohi5fIgoy
	gz63jGy+xxCPkEYiTlkTt8Xoa6Dv+g+6jDwNYT+U1Q==
X-Google-Smtp-Source: AGHT+IGUZorkCi64YkQRQ50LyONGuQyCaMkyjeEos2tgFQ6faizt7lG2rcTuyHFQW//RTS5PrFhblA==
X-Received: by 2002:adf:ea11:0:b0:313:f1c8:a968 with SMTP id q17-20020adfea11000000b00313f1c8a968mr8055326wrm.2.1691496185883;
        Tue, 08 Aug 2023 05:03:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id v8-20020adfe4c8000000b00317046f21f9sm13499726wrm.114.2023.08.08.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:03:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next] net: stmmac: don't create the MDIO bus if there's no mdio node on DT
Date: Tue,  8 Aug 2023 14:02:54 +0200
Message-Id: <20230808120254.11653-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

The stmmac_dt_phy() function that parses the device-tree node of the MAC
and allocates the MDIO and PHY resources misses one use-case: when the
MAC doesn't have a fixed link but also doesn't define its own mdio bus
on the device tree and instead shares the MDIO lines with a different
MAC with its PHY phandle reaching over into a different node.

As this function could also use some more readability, rework it to
handle this use-case and simplify the code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be8e79c7aa34..91844673df43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -320,12 +320,14 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
 			 struct device_node *np, struct device *dev)
 {
-	bool mdio = !of_phy_is_fixed_link(np);
 	static const struct of_device_id need_mdio_ids[] = {
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{},
 	};
 
+	if (of_phy_is_fixed_link(np))
+		return 0;
+
 	if (of_match_node(need_mdio_ids, np)) {
 		plat->mdio_node = of_get_child_by_name(np, "mdio");
 	} else {
@@ -340,20 +342,18 @@ static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
 		}
 	}
 
-	if (plat->mdio_node) {
-		dev_dbg(dev, "Found MDIO subnode\n");
-		mdio = true;
-	}
+	if (!plat->mdio_node)
+		return 0;
 
-	if (mdio) {
-		plat->mdio_bus_data =
-			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
-				     GFP_KERNEL);
-		if (!plat->mdio_bus_data)
-			return -ENOMEM;
+	dev_dbg(dev, "Found MDIO subnode\n");
 
-		plat->mdio_bus_data->needs_reset = true;
-	}
+	plat->mdio_bus_data = devm_kzalloc(dev,
+					   sizeof(struct stmmac_mdio_bus_data),
+					   GFP_KERNEL);
+	if (!plat->mdio_bus_data)
+		return -ENOMEM;
+
+	plat->mdio_bus_data->needs_reset = true;
 
 	return 0;
 }
-- 
2.39.2


