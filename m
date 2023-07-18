Return-Path: <netdev+bounces-18488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CF7575F7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F3281330
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 07:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E683A957;
	Tue, 18 Jul 2023 07:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393CBA4B
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:57:47 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30991704
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:57:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3143798f542so5635725f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667036; x=1690271836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw3452bl3IVkLYCgTU07wlcs12OEKKnmFHT15uujsjI=;
        b=jb+AE0lg/ruaMMzxDMgfRqakGL8VLjLeo6Uqd5vQpe/fo4aghhp8yAogRi3gZN5Di+
         VjqGOimJnzwWl7hPJiaE2MWJSUKmZPAMM47DS926vvpjih1ch3h8fvIeY/1E6e/PGzvt
         uoH5TenqWMg+mW0R4LuG0uYfi8sLgrUiQh0hH0BpNNRzAhafkDEVQqunY2X9Qe/ZTnwj
         2Z/FyIAW/GZQSwLCNsuqAka2sIo9oVdFgR0URDWc8Y9BpQJz5JrJBzX0lW+QgDREUE/h
         ZSr+17C19j3SaRz6O3h2BvRvNcF5ppmXfBm9DV54NcuVex9xh2qhpsMglB6RzpZPw8Se
         4yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667036; x=1690271836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw3452bl3IVkLYCgTU07wlcs12OEKKnmFHT15uujsjI=;
        b=LFjokmmUgUsTXtA/X/ug3eloyF1muLIxTwd0YetnU2VfmGOme8/qd+3sAHNwUc7SVJ
         6XKaQKBpzQNLHyoZY16sI0r4M/KUwBO0bMDI398g5E81YlSt5wc6nsmlhHH7TraiCv41
         BkO1iYk1rr2f3CW8h6FhfFxbCLTTarPE5TBoSIrOigKixdbXVfdckdEbLV1Ei27kRZH7
         CERX6RKcIOSGB3IDloSHEV7YjpAXeXAaD3hacupMGAqDue05FDAlqBydG+YnO0JkW/vo
         jrto9HkuajTfJ5IJmnX2bM3ZwRw5DZfsZal+hnQHF2saGCCIoc4nCYuSZF5ZjUnIjvK9
         25fw==
X-Gm-Message-State: ABy/qLZAAd/Q39sXg7poNDCRjwyXgqbufIQbgxdx/IwcFLd18kJ/3n9S
	/dpTG4gc8jsvmc5X34eFsQHPzA==
X-Google-Smtp-Source: APBJJlG4gvJkuWZOqhO+jvg2v72AC2MPY7n1+BA4EirjRCEXV+BN3SdjTHxmOiThZLSH6zO/kwgnIA==
X-Received: by 2002:a5d:6841:0:b0:314:1ebc:6e19 with SMTP id o1-20020a5d6841000000b003141ebc6e19mr12196935wrw.64.1689667036031;
        Tue, 18 Jul 2023 00:57:16 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:15 -0700 (PDT)
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
Subject: [PATCH v5 04/12] can: m_can: Add rx coalescing ethtool support
Date: Tue, 18 Jul 2023 09:57:00 +0200
Message-Id: <20230718075708.958094-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
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
index e979aeb2ef13..c19fc10a7645 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1943,8 +1943,54 @@ static const struct net_device_ops m_can_netdev_ops = {
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
+	if ((ec->rx_max_coalesced_frames_irq == 0) != (ec->rx_coalesce_usecs_irq == 0)) {
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


