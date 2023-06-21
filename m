Return-Path: <netdev+bounces-12509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009A737EE3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C38A28156A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D2DDB0;
	Wed, 21 Jun 2023 09:24:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BFDF4F
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:24:20 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94071FC8
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-311367a3e12so4736634f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339440; x=1689931440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZrlIC4UOKpv9upRfhGvF2jtmIJyO/l6blnJN/Kvfh8=;
        b=5AJVy31qidMPxttaXsZUnYinlqnN0ERHOCEPlFbpjhFQL0d2YW5FREmg5TuJvUv2zo
         ecphYqOVzQxJJgvfgN5yoHmX9CrOqcIEYtbUk3uS39swqBrpXxvulFYG5DWRE5729iQZ
         3FzNnptBBB/Pk+4DuPLO5YoRsA8Durq9oiW1ETBphaiHhSQ06U2920rL8Lk+SYNOSCzb
         AUTywM8/yoxyC+wVvrnqoTdv4ldgiiBHmq8zCFWlx+JKvX9lqF+PwhGXTi0lUBtu10PI
         DXcGyfuzb2tCDlD4yt5Kj29fe+zHBBHvF2aZ45gUwPyHO7hdKqdH1SdhtO1aX8u7wBVT
         bvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339440; x=1689931440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZrlIC4UOKpv9upRfhGvF2jtmIJyO/l6blnJN/Kvfh8=;
        b=hAu84su1rzBZnyhsijQDrT9HsPA1YF2biwPiIww8Aa9IRw+XbeW+m6DftPpUzCGYVF
         cqcf5Q2l3i8NBjew84M1OYD4pcdNTOKCfTG3xTaLGDzTFR7yPAtRVYjqLDx8LiMrNQWS
         nG1s4KMUbiVd1WZVJ5MouNMiIV6O5/oMP0PhhDAywhnHmCYQBg5lzAZGcQblYOV+mVoX
         SeQSVAJLMQAZODyvhNjtqX22ocN7RFIZMrS088BuL/SP1FixYTw0QT/qLrrdLxFNHX2M
         t/CJ7YS4iTXgaRqd+x0orvn2indFnixZ0aMs55OLEiW537oTTSY0Z7M2RGsHMrUwG0tL
         MZLw==
X-Gm-Message-State: AC+VfDybEDNEWwTuboES4lztVjOQvPzv7T/nZlmAuhQe9NMsrsIjbXYS
	kjHsxMuTHnGqNBKDlKd4FaJlZg==
X-Google-Smtp-Source: ACHHUZ4I4CXR0xNnIv4BMV2cNzxpyr/Fi8tYkheKPje8OH+K7Bjdom7tQPVeaNpOFeaZUNhwsffxnA==
X-Received: by 2002:adf:fd82:0:b0:30f:ce87:9db3 with SMTP id d2-20020adffd82000000b0030fce879db3mr13025821wrr.23.1687339440208;
        Wed, 21 Jun 2023 02:24:00 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:59 -0700 (PDT)
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
Subject: [PATCH v4 04/12] can: m_can: Add rx coalescing ethtool support
Date: Wed, 21 Jun 2023 11:23:42 +0200
Message-Id: <20230621092350.3130866-5-msp@baylibre.com>
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

Add the possibility to set coalescing parameters with ethtool.

rx-frames-irq and rx-usecs-irq can only be set and unset together as the
implemented mechanism would not work otherwise. rx-frames-irq can't be
greater than the RX FIFO size.

Also all values can only be changed if the chip is not active.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 781f287e7ce4..5238a5967971 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1944,8 +1944,54 @@ static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int m_can_get_coalesce(struct net_device *dev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kec,
+			      struct netlink_ext_ack *ext_ack)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
+	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+
+	return 0;
+}
+
+static int m_can_set_coalesce(struct net_device *dev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kec,
+			      struct netlink_ext_ack *ext_ack)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	if (cdev->can.state != CAN_STATE_STOPPED) {
+		netdev_err(dev, "Device is in use, please shut it down first\n");
+		return -EBUSY;
+	}
+
+	if (ec->rx_max_coalesced_frames_irq > cdev->mcfg[MRAM_RXF0].num) {
+		netdev_err(dev, "rx-frames-irq %u greater than the RX FIFO %u\n",
+			   ec->rx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_RXF0].num);
+		return -EINVAL;
+	}
+	if (ec->rx_max_coalesced_frames_irq == 0 != ec->rx_coalesce_usecs_irq == 0) {
+		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+
+	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
+	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_coalesce = m_can_get_coalesce,
+	.set_coalesce = m_can_set_coalesce,
 };
 
 static int register_m_can_dev(struct net_device *dev)
-- 
2.40.1


