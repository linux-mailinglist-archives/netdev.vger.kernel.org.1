Return-Path: <netdev+bounces-12510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF11737EE4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC0D281556
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9FEF9C0;
	Wed, 21 Jun 2023 09:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC71E57E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:24:22 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB731FCB
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so3626588f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339441; x=1689931441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3yb9swE3xTiKnV49xmW7qQT7kAh84V+/Srm0DQQmxA=;
        b=x4YWo/dRgd3X1CXi35YBtv7s4YeY0ryc8LBoz5C1znXUZ4qpZmvgbeA75ObRCxYC5M
         h1XBldnohWKXdZpZtDM3VAU7/kkv5vP0Qho9j1LvleCyUJPglEcq/jPLE9n6DdjU9Qu+
         Ng2VjFCleB6NhIxz0uE0YJoAKEExD/0cOZCkerXlzsEELo2fqCTDKUbxx8riLQMtYsb2
         89SmXnAjPt81FEv8oatHcckOq2p6JhqAXtfUoUyaB1N5Tku4lKDoUEUHBRKbVWz0Ayt9
         BTmqCDy2K13LALirN5MlP02JiisY3IzrSOwagkN2XIEQEovHLnOp2jl+4v4YWGt61wt0
         zLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339441; x=1689931441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3yb9swE3xTiKnV49xmW7qQT7kAh84V+/Srm0DQQmxA=;
        b=VzVSy6/c1Q8hvf7KTPs/TfxEpREp4j0gr6PVNXP8nn4289vpnv1mpPPvwBvpiBxXaU
         0QMJkoxWT1XuGReXFJVWZW4eCOEpwxBde1yrSZgsvyA7MwVs987DIYyxAhIPBfXtETBL
         Ogs68Y/R0vswai9rUpCftqoaXI7IgQbWF1rQGbrcmqXIcVS61pYOHpN49KtKO36VKH+l
         9F1zcWYWJ8WdwNFuaKMg7kxeChh4u4anKG3GmGpbllRgv+jHT8EbzTbk1DWziFJCoUMx
         i76g6kQR/31JZ2+tG89Yfdu8tTMk+B3SOKamWcooYn9HMfVFi8zUdsuG8OiTBvcwP7Ti
         9LuA==
X-Gm-Message-State: AC+VfDwAXHRjKOFpFbg09MRRLBzOEWb8YQlxEs/BoeUTlE4olNxy6unD
	vgBgXhBGymm+KF6hzpClaJGYxg==
X-Google-Smtp-Source: ACHHUZ4bqQlJaFCvx+3AffW3dpFHExJEQziJdGScuvpiXckJsPH9Jmtck1XrxSNuUqtVz1m0fTMbAw==
X-Received: by 2002:adf:ffce:0:b0:30f:b045:8b60 with SMTP id x14-20020adfffce000000b0030fb0458b60mr9833679wrs.69.1687339441432;
        Wed, 21 Jun 2023 02:24:01 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:24:01 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 05/12] can: m_can: Add tx coalescing ethtool support
Date: Wed, 21 Jun 2023 11:23:43 +0200
Message-Id: <20230621092350.3130866-6-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621092350.3130866-1-msp@baylibre.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add TX support to get/set functions for ethtool coalescing.
tx-frames-irq and tx-usecs-irq can only be set/unset together.
tx-frames-irq needs to be less than TXE and TXB.

As rx and tx share the same timer, rx-usecs-irq and tx-usecs-irq can be
enabled/disabled individually but they need to have the same value if
enabled.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5238a5967971..d1435d1466b2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1953,6 +1953,8 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
+	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
 	return 0;
 }
@@ -1979,16 +1981,50 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX event FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames_irq == 0 != ec->tx_coalesce_usecs_irq == 0) {
+		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
+	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
+		netdev_err(dev, "rx-usecs-irq %u needs to be equal to tx-usecs-irq %u if both are enabled\n",
+			   ec->rx_coalesce_usecs_irq,
+			   ec->tx_coalesce_usecs_irq);
+		return -EINVAL;
+	}
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
+	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
+
+	if (cdev->rx_coalesce_usecs_irq)
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
+	else
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
 
 	return 0;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
-		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
+		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
-- 
2.40.1


