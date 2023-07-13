Return-Path: <netdev+bounces-17693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D99752B8E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 22:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD73281E93
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED1200C4;
	Thu, 13 Jul 2023 20:21:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1451ED53
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:21:31 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB082709
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso1254068f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689279687; x=1691871687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4CrEIfrjQ2FMKZX2ewx6d372/dw3pvGNTCu7mW4Pns=;
        b=gkiTYElMTDBnu1cdXyXHvgBU4WRMsZ2e0jQndmpTL9Q9PAo2YUKoHPO3Cxb1CtjNx0
         CDWaBqwpB/tNblbkeyftrlujX/t1qvXjLtJOtB4cAe2BQuw9PE7OqzI6Oks/WOCOidf7
         LxHdXmqXi9pWmjWQ8A3dFHBp9z3uuD7jGxxvo74uzOZUQInY+Sp8EgtkNWapzJiN47V7
         /EoMw+1JMJtQX1e1ri91SViJ/UOUjhqxL4KsOsPksWAOhUa1zztI3cBhc39Yfp2/WTRi
         nVwQeGbi7g2vQnITRqm47VjpxsEQRV55DaxnaaJVT+5Oq9AMubklN9gA0qdrhQjkkKGi
         re0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279687; x=1691871687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4CrEIfrjQ2FMKZX2ewx6d372/dw3pvGNTCu7mW4Pns=;
        b=FFA8MBitoGLncHIXEio6+RCzvNiVSMMH62BjkBBvrch6jvp1tjuTzDADQfZiNI8NCm
         TP6Ej2a9Pzfy2GRIFt6WO6xUDPTBOVP2JN3Ewsw7jKg/faljnXYLOr4cxC1eVjUIfKoj
         u/SYxVGD1IiesLNtLM3PvATIENmU8NCsuqA+HELjHewelZGvTZ4Fg2p9rZKMyPQZD9te
         CuQIP+pMxga7s7KfvA39aGJXDV57eLmcs+bZQSyvxeLW3T6TP3S9YSg6wDb87+VnHPEy
         OzjodoaU9cSLEruO9Uys1d8yBhMUqyb9gis1RcLPh1pIHHhgl9XQfAErKel4bxPAdf05
         L3kA==
X-Gm-Message-State: ABy/qLZaraThfakSwhbIb404bq8D27Y09bsWL9M3sTSY1yAS7tBmSQ3V
	Aw1bzZG28sn0t6CrUMypj5ETdIw0DEho2DDRj7HUUg==
X-Google-Smtp-Source: APBJJlHq2pUSPgBx5Tj6uSYMyYQXaacAVg9+vui4gpLQ5d0tkeJ9qBx5xIDImovX3hluY8+Wyit8Vw==
X-Received: by 2002:a5d:490f:0:b0:314:4237:8832 with SMTP id x15-20020a5d490f000000b0031442378832mr2246109wrq.48.1689279686899;
        Thu, 13 Jul 2023 13:21:26 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.168])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b0031590317c26sm8880170wrv.61.2023.07.13.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:21:26 -0700 (PDT)
From: Alexandru Ardelean <alex@shruggie.ro>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	olteanv@gmail.com,
	alex@shruggie.ro,
	marius.muresan@mxt.ro
Subject: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT ctrl reg for VSC8531 and similar
Date: Thu, 13 Jul 2023 23:21:22 +0300
Message-ID: <20230713202123.231445-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.41.0
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

The VSC8531 and similar PHYs (i.e. VSC8530, VSC8531, VSC8540 & VSC8541)
have a CLKOUT pin on the chip that can be controlled by register (13G in
the General Purpose Registers page) that can be configured to output a
frequency of 25, 50 or 125 Mhz.

This is useful when wanting to provide a clock source for the MAC in some
board designs.

Signed-off-by: Marius Muresan <marius.muresan@mxt.ro>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Changelog v1 -> v2:
* https://lore.kernel.org/netdev/20230706081554.1616839-1-alex@shruggie.ro/
* changed property name 'vsc8531,clkout-freq-mhz' -> 'mscc,clkout-freq-mhz'
  as requested by Rob
* introduced 'goto set_reg' to reduce indentation (no idea why I did not
  think of that sooner)
* added 'net-next' tag as requested by Andrew

 drivers/net/phy/mscc/mscc.h      |  5 ++++
 drivers/net/phy/mscc/mscc_main.c | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 7a962050a4d4..4ea21921a7ba 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -181,6 +181,11 @@ enum rgmii_clock_delay {
 #define VSC8502_RGMII_TX_DELAY_MASK	  0x0007
 #define VSC8502_RGMII_RX_CLK_DISABLE	  0x0800
 
+/* CKLOUT Control register, for VSC8531 and similar */
+#define VSC8531_CLKOUT_CNTL		  13
+#define VSC8531_CLKOUT_CNTL_ENABLE	  BIT(15)
+#define VSC8531_CLKOUT_CNTL_FREQ_MASK	  GENMASK(14, 13)
+
 #define MSCC_PHY_WOL_LOWER_MAC_ADDR	  21
 #define MSCC_PHY_WOL_MID_MAC_ADDR	  22
 #define MSCC_PHY_WOL_UPPER_MAC_ADDR	  23
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 4171f01d34e5..ec029d26071d 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -618,6 +618,42 @@ static void vsc85xx_tr_write(struct phy_device *phydev, u16 addr, u32 val)
 	__phy_write(phydev, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(addr));
 }
 
+static int vsc8531_clkout_config(struct phy_device *phydev)
+{
+	static const u32 freq_vals[] = { 25, 50, 125 };
+	struct device *dev = &phydev->mdio.dev;
+	u16 mask, set;
+	u32 freq, i;
+	int rc;
+
+	mask = VSC8531_CLKOUT_CNTL_ENABLE | VSC8531_CLKOUT_CNTL_FREQ_MASK;
+	set = 0;
+
+	if (device_property_read_u32(dev, "mscc,clkout-freq-mhz", &freq))
+		goto set_reg;
+
+	/* The indices from 'freq_vals' are used in the register */
+	for (i = 0; i < ARRAY_SIZE(freq_vals); i++) {
+		if (freq != freq_vals[i])
+			continue;
+
+		set |= VSC8531_CLKOUT_CNTL_ENABLE |
+		       FIELD_PREP(VSC8531_CLKOUT_CNTL_FREQ_MASK, i);
+		break;
+	}
+	if (set == 0)
+		dev_warn(dev, "Invalid 'mscc,clkout-freq-mhz' value %u\n",
+			 freq);
+
+set_reg:
+	mutex_lock(&phydev->lock);
+	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
+			      VSC8531_CLKOUT_CNTL, mask, set);
+	mutex_unlock(&phydev->lock);
+
+	return rc;
+}
+
 static int vsc8531_pre_init_seq_set(struct phy_device *phydev)
 {
 	int rc;
@@ -1852,6 +1888,11 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 		rc = vsc8531_pre_init_seq_set(phydev);
 		if (rc)
 			return rc;
+
+		rc = vsc8531_clkout_config(phydev);
+		if (rc)
+			return rc;
+
 	}
 
 	rc = vsc85xx_eee_init_seq_set(phydev);
-- 
2.41.0


