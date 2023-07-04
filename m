Return-Path: <netdev+bounces-15399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78A74757A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AD51C209CC
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712A76AA9;
	Tue,  4 Jul 2023 15:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39263D9
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:41:16 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44FE54
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:41:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso5608626f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688485272; x=1691077272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWXXL9s1BJRYnUAguG7AL32mNcBk3V4Zv//tw7akh/8=;
        b=M1Lonh49LTCa8uBlzHV7xYKQNj07LcHkhyTKyytEx4gXKZgQvEWCEnMisKJXkK/A6k
         /Y/HY2/q0srTd6Ce4WergPUdh96IzEIbIi4pSxfHGo+ilqxhv9W8CsPb2fwKzQ+gl3cG
         gnFbwsi/FlKZ0QDCkyIYV5NUX7QCZ5aPbjTQmF9KuGli6Pc0UokLFaPgs0pZ91/w50E7
         DmjLLNcg7jELi1hN7PxNXbpBjpDKaNNU+pPmHA2TwALZlr5VpmJaIceK3DEZbjz4I7Rt
         SX11mGImtVV+4dtzWjyJ4Mcf/U3Y6oSLz9kpBIR0K8xoAjwZhUAVftwSZRIHXMd53Jml
         svng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485272; x=1691077272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWXXL9s1BJRYnUAguG7AL32mNcBk3V4Zv//tw7akh/8=;
        b=OQZPjsPn45JiFb+gDTt0agPoHqmJfas44tDADqUaCUhaeazSAsuXgy9XKVtRxJFVih
         6Fho8teZ5+aX6NLhbBPxxUEntQhh+1hRopRiNbB0lYSknjLwBpouZVXwbV2Z56QORcGg
         bNmQ3mNEv55Z6CLeDWte1ISJ+st1k8Nb2ATQh7PfCPdriRHSGTN5/M/H3tDwHTZTiJdE
         mzHE+qOb6IYIYJVeLSCFhUFbvcBAT0lsHuTy58IhTdrnkYI0St7X80iqlF470IGvOw+H
         LVG+Ng0b0zeJwzbP0B69BQ2zISzXL12LuojcThYC1FVNoPicOXgXkMygJGjCJKmlGnC2
         3q+A==
X-Gm-Message-State: ABy/qLbnmAaac4vF4vN42TFHbfaV47y9Ypan6Kg/shRaisNhciUP0ozC
	yuOBVSR8mXEscGe04fjXhgP3DkQOflg=
X-Google-Smtp-Source: APBJJlESJn8ZiMjwz3E9H1GUxj9FbN0DaKpPc3vJCQdopGvXRapBwbySAdJrIcYbO71SljOpe0eUig==
X-Received: by 2002:adf:f049:0:b0:313:f708:5d4 with SMTP id t9-20020adff049000000b00313f70805d4mr12229195wro.24.1688485272098;
        Tue, 04 Jul 2023 08:41:12 -0700 (PDT)
Received: from saproj-Latitude-5501.yandex.net ([2a02:6b8:0:51e:d104:e38:9cda:1615])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fb225d414fsm24056017wma.21.2023.07.04.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:41:11 -0700 (PDT)
From: Sergei Antonov <saproj@gmail.com>
To: netdev@vger.kernel.org
Cc: vladimir.oltean@nxp.com,
	Sergei Antonov <saproj@gmail.com>
Subject: [PATCH net] net: ftmac100: add multicast filtering possibility
Date: Tue,  4 Jul 2023 18:40:53 +0300
Message-Id: <20230704154053.3475336-1-saproj@gmail.com>
X-Mailer: git-send-email 2.37.2
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

If netdev_mc_count() is not zero and not IFF_ALLMULTI, filter
incoming multicast packets. The chip has a Multicast Address Hash Table
for allowed multicast addresses, so we fill it.

This change is based on the analogous code from the ftgmac100 driver.
Although the hashing algorithm is different.

Signed-off-by: Sergei Antonov <saproj@gmail.com>
---
 drivers/net/ethernet/faraday/ftmac100.c | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 139fe66f8bcd..0ecc0a319520 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -149,6 +149,25 @@ static void ftmac100_set_mac(struct ftmac100 *priv, const unsigned char *mac)
 	iowrite32(laddr, priv->base + FTMAC100_OFFSET_MAC_LADR);
 }
 
+static void ftmac100_setup_mc_ht(struct ftmac100 *priv)
+{
+	u32 maht0 = 0; /* Multicast Address Hash Table bits 31:0 */
+	u32 maht1 = 0; /* ... bits 63:32 */
+	struct netdev_hw_addr *ha;
+
+	netdev_for_each_mc_addr(ha, priv->netdev) {
+		u32 hash = ~ether_crc_le(ETH_ALEN, ha->addr) >> 26;
+
+		if (hash >= 32)
+			maht1 |= 1 << (hash - 32);
+		else
+			maht0 |= 1 << hash;
+	}
+
+	iowrite32(maht0, priv->base + FTMAC100_OFFSET_MAHT0);
+	iowrite32(maht1, priv->base + FTMAC100_OFFSET_MAHT1);
+}
+
 #define MACCR_ENABLE_ALL	(FTMAC100_MACCR_XMT_EN	| \
 				 FTMAC100_MACCR_RCV_EN	| \
 				 FTMAC100_MACCR_XDMA_EN	| \
@@ -187,6 +206,10 @@ static int ftmac100_start_hw(struct ftmac100 *priv)
 		maccr |= FTMAC100_MACCR_RCV_ALL;
 	if (netdev->flags & IFF_ALLMULTI)
 		maccr |= FTMAC100_MACCR_RX_MULTIPKT;
+	else if (netdev_mc_count(netdev)) {
+		maccr |= FTMAC100_MACCR_HT_MULTI_EN;
+		ftmac100_setup_mc_ht(priv);
+	}
 
 	iowrite32(maccr, priv->base + FTMAC100_OFFSET_MACCR);
 	return 0;
@@ -1067,6 +1090,21 @@ static int ftmac100_change_mtu(struct net_device *netdev, int mtu)
 	return 0;
 }
 
+static void ftmac100_set_rx_mode(struct net_device *netdev)
+{
+	struct ftmac100 *priv = netdev_priv(netdev);
+
+	ftmac100_setup_mc_ht(priv);
+
+	if (netdev_mc_count(priv->netdev)) {
+		unsigned int maccr = ioread32(priv->base + FTMAC100_OFFSET_MACCR);
+
+		/* Make sure multicast filtering is enabled */
+		maccr |= FTMAC100_MACCR_HT_MULTI_EN;
+		iowrite32(maccr, priv->base + FTMAC100_OFFSET_MACCR);
+	}
+}
+
 static const struct net_device_ops ftmac100_netdev_ops = {
 	.ndo_open		= ftmac100_open,
 	.ndo_stop		= ftmac100_stop,
@@ -1075,6 +1113,7 @@ static const struct net_device_ops ftmac100_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ftmac100_do_ioctl,
 	.ndo_change_mtu		= ftmac100_change_mtu,
+	.ndo_set_rx_mode	= ftmac100_set_rx_mode,
 };
 
 /******************************************************************************
-- 
2.37.2


