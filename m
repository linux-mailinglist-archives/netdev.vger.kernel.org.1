Return-Path: <netdev+bounces-25283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C52773B05
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B66F2818B3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB312B8E;
	Tue,  8 Aug 2023 15:37:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054E134A2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:37:22 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F877103
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:36:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c10ba30afso1456000466b.1
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691508986; x=1692113786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn7IE2pryGOHb2DoJQeDxIJbX1ZjycHHaLdxqy0m/QU=;
        b=kV++EJwwvuuVtOA5cszXd5QxJKnjb6aM2gqdWJXUhwAsnxftnRmplw/0mqhARHQy74
         BVvI+Zr18fwLEjqr7Xf49HOsndk+FychQxSCTs2cNEsBLMsMnHqxua/y3nSjtQXHEQZ1
         03ikBMqy7RMHrw+VC6nM71ntE4o3L2xfVK6f2FWBU9WgQSveThHWb/b6SLuZtW//FLgJ
         QcBWhOeiZB+7vWC6BD9FRGkiZ9/iawcJeAF1BWN6xNnIiru8ZtDbCKqq+726BRD4/e5S
         XcA1pHcpjrcEab6r0NOhQnSymrz5sqvh8UUyDY3Ft1pjZ0+0aQzmy/N5dBu66z8EH/ww
         7JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508986; x=1692113786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn7IE2pryGOHb2DoJQeDxIJbX1ZjycHHaLdxqy0m/QU=;
        b=UmzkH2gLTs+ngNwjoIth2AiKCI8vYpokhT315Kfu3s88rhMc+ss7nGs8rfaZrP0sI+
         vtVljmmfOUSz5EhfNqSGz4PptBJdCZL9f7r0mUnttFLdq1DpXU9tLydRtDmx0t743+od
         shYj9QQo68oqppWgLl11O5XATdnjl3uR29k2IhqZhtv5pDFVzRABW9pMGUA51gEWMaI2
         cAXMzZJgzPSMbl7OYnd3oJ7mJINTV4TkWr4HsDRjPNan+a4HHI7D3BSIQJG3Q2tBq2+w
         Qg4JEaSgmuybDGQUV/6/+WUC4lr1/VoqC+GVsCSOXQoO/N0Tn2ohLxiZ+K6gJnijFFcQ
         p4zQ==
X-Gm-Message-State: AOJu0Yzp3qE0pcqdMKW/O8FwMf+IHQFsrr1UupNXQx4BbJF1AOtM7K1D
	nPZJ51rFS8YIVhIWcGXLuc2nPPBjRxk=
X-Google-Smtp-Source: AGHT+IHjsOdCNKq22sHt98MLgYlUN6bTBstt/T/RhNyJk+//HgCweo9nalaGYZ6RIlK9mtBq1YjyIg==
X-Received: by 2002:ac2:4c4d:0:b0:4fe:d15:e1d2 with SMTP id o13-20020ac24c4d000000b004fe0d15e1d2mr3642191lfk.12.1691498592013;
        Tue, 08 Aug 2023 05:43:12 -0700 (PDT)
Received: from saproj-Latitude-5501.yandex.net ([2a02:6b8:0:51e:9737:440c:8f23:2506])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512020300b004fb7b4700ffsm1880821lfo.268.2023.08.08.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:43:11 -0700 (PDT)
From: Sergei Antonov <saproj@gmail.com>
To: netdev@vger.kernel.org
Cc: vladimir.oltean@nxp.com,
	Sergei Antonov <saproj@gmail.com>
Subject: [PATCH net-next v2] net: ftmac100: add multicast filtering possibility
Date: Tue,  8 Aug 2023 15:43:07 +0300
Message-Id: <20230808124307.2252938-1-saproj@gmail.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If netdev_mc_count() is not zero and not IFF_ALLMULTI, filter
incoming multicast packets. The chip has a Multicast Address Hash Table
for allowed multicast addresses, so we fill it.

Implement .ndo_set_rx_mode and recalculate multicast hash table. Also
observe change of IFF_PROMISC and IFF_ALLMULTI netdev flags.

Signed-off-by: Sergei Antonov <saproj@gmail.com>
---
v1 -> v2:
* fix hashing algorithm (the old one was based on bad testing)
* observe change of IFF_PROMISC, IFF_ALLMULTI in set_rx_mode
* u64 and BIT_ULL code simplification suggested by Vladimir Oltean
---
 drivers/net/ethernet/faraday/ftmac100.c | 50 ++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 139fe66f8bcd..183069581bc0 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -149,6 +149,40 @@ static void ftmac100_set_mac(struct ftmac100 *priv, const unsigned char *mac)
 	iowrite32(laddr, priv->base + FTMAC100_OFFSET_MAC_LADR);
 }
 
+static void ftmac100_setup_mc_ht(struct ftmac100 *priv)
+{
+	struct netdev_hw_addr *ha;
+	u64 maht = 0; /* Multicast Address Hash Table */
+
+	netdev_for_each_mc_addr(ha, priv->netdev) {
+		u32 hash = ether_crc(ETH_ALEN, ha->addr) >> 26;
+
+		maht |= BIT_ULL(hash);
+	}
+
+	iowrite32(lower_32_bits(maht), priv->base + FTMAC100_OFFSET_MAHT0);
+	iowrite32(upper_32_bits(maht), priv->base + FTMAC100_OFFSET_MAHT1);
+}
+
+static void ftmac100_set_rx_bits(struct ftmac100 *priv, unsigned int *maccr)
+{
+	struct net_device *netdev = priv->netdev;
+
+	/* Clear all */
+	*maccr &= ~(FTMAC100_MACCR_RCV_ALL | FTMAC100_MACCR_RX_MULTIPKT |
+		   FTMAC100_MACCR_HT_MULTI_EN);
+
+	/* Set the requested bits */
+	if (netdev->flags & IFF_PROMISC)
+		*maccr |= FTMAC100_MACCR_RCV_ALL;
+	if (netdev->flags & IFF_ALLMULTI)
+		*maccr |= FTMAC100_MACCR_RX_MULTIPKT;
+	else if (netdev_mc_count(netdev)) {
+		*maccr |= FTMAC100_MACCR_HT_MULTI_EN;
+		ftmac100_setup_mc_ht(priv);
+	}
+}
+
 #define MACCR_ENABLE_ALL	(FTMAC100_MACCR_XMT_EN	| \
 				 FTMAC100_MACCR_RCV_EN	| \
 				 FTMAC100_MACCR_XDMA_EN	| \
@@ -182,11 +216,7 @@ static int ftmac100_start_hw(struct ftmac100 *priv)
 	if (netdev->mtu > ETH_DATA_LEN)
 		maccr |= FTMAC100_MACCR_RX_FTL;
 
-	/* Add other bits as needed */
-	if (netdev->flags & IFF_PROMISC)
-		maccr |= FTMAC100_MACCR_RCV_ALL;
-	if (netdev->flags & IFF_ALLMULTI)
-		maccr |= FTMAC100_MACCR_RX_MULTIPKT;
+	ftmac100_set_rx_bits(priv, &maccr);
 
 	iowrite32(maccr, priv->base + FTMAC100_OFFSET_MACCR);
 	return 0;
@@ -1067,6 +1097,15 @@ static int ftmac100_change_mtu(struct net_device *netdev, int mtu)
 	return 0;
 }
 
+static void ftmac100_set_rx_mode(struct net_device *netdev)
+{
+	struct ftmac100 *priv = netdev_priv(netdev);
+	unsigned int maccr = ioread32(priv->base + FTMAC100_OFFSET_MACCR);
+
+	ftmac100_set_rx_bits(priv, &maccr);
+	iowrite32(maccr, priv->base + FTMAC100_OFFSET_MACCR);
+}
+
 static const struct net_device_ops ftmac100_netdev_ops = {
 	.ndo_open		= ftmac100_open,
 	.ndo_stop		= ftmac100_stop,
@@ -1075,6 +1114,7 @@ static const struct net_device_ops ftmac100_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_eth_ioctl		= ftmac100_do_ioctl,
 	.ndo_change_mtu		= ftmac100_change_mtu,
+	.ndo_set_rx_mode	= ftmac100_set_rx_mode,
 };
 
 /******************************************************************************
-- 
2.37.2


