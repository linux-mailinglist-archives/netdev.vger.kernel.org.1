Return-Path: <netdev+bounces-37041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B9D7B3484
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3DD6028317A
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADCD51259;
	Fri, 29 Sep 2023 14:13:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233051228
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:13:20 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097CECC0
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-325e9cd483eso425094f8f.2
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996797; x=1696601597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCQIoaJbLKII1l0AGqTW1Bk8v3XX8EQRXCDvUWkrfVU=;
        b=kNEfY/mpmmx/3obmfSoRPyK3d64FG/6uJcQXiLahkoFX8I+rCp/5/PBvmNart2NZId
         Cl/vWIJp+vgATxo94YNdCPeXZzZVTMa9K3Sjy3N72SmgjkfE/MUt2kODFucYWTtnt0Km
         jmzkiUcjQlFVU01C1QyPdJoZAxSMX/sP5aYa5wn18v2pMNfxfQP58hSBD1jqEhqu/OU5
         ZtxvVzClhhUpZ+76T7vUny3w3ihXdTCvrRd4TPP1xJog2msJpdcV4vbWxkVsHCykbl9J
         s3TreMi3yUJc6LROg4zGChL/miZ4dqxrG+NaCyqcjWEULkVfY37KeGNLkbIq/J95Xagk
         1NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996797; x=1696601597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCQIoaJbLKII1l0AGqTW1Bk8v3XX8EQRXCDvUWkrfVU=;
        b=ha3vgvEkPJgLn2t8XtBfzAZKo27ngSPfEl9C4caw1FFR40LlDyKEnO+Jzx/iCdd9xr
         NvLwO1h95wGk2STjcb8uQMHNI1dLkVRkCkuXh2/FT4JYo7pmxhVhlK4fBaacUqmYrrgS
         yE+wCdTjWz70U5wbA+jyXGFbxrK1/JRrpqtX5D6beVNxXYUCJm3laF1hiKLxrAlEREVC
         TMJV2aco1J+JT+F05rp+rv6CxQy1MIzGKHuu1l/ioaqXnG9IZdfi+kHcclebLze/+BPh
         1QIz5wb5Zc3aEifjS9WMFHbjk4SFodwsKM/UQqzVy7kbyV/w6SYM3Otcj210eaOeVSqk
         ZCAQ==
X-Gm-Message-State: AOJu0Ywz9O+6zpCb3YBUTg7+5PfhSeO07gL+6pRux+iWqGx9WfnDKCVQ
	iWf1P3kgNpZOWZZFx3UjV1U/6WFK6NjXh3A4+2+zOQ==
X-Google-Smtp-Source: AGHT+IH0COH0xd0nQOPP0KuLaTXAjsN1EjNLRJnC6bT/YKQXLScCS47tM4A3SLjQUbxugFAHmXINnw==
X-Received: by 2002:adf:de0a:0:b0:31f:fb5d:96da with SMTP id b10-20020adfde0a000000b0031ffb5d96damr3728023wrm.64.1695996797063;
        Fri, 29 Sep 2023 07:13:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:16 -0700 (PDT)
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
	Judith Mendez <jm@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 06/14] can: m_can: Add rx coalescing ethtool support
Date: Fri, 29 Sep 2023 16:12:56 +0200
Message-Id: <20230929141304.3934380-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the possibility to set coalescing parameters with ethtool.

rx-frames-irq and rx-usecs-irq can only be set and unset together as the
implemented mechanism would not work otherwise. rx-frames-irq can't be
greater than the RX FIFO size.

Also all values can only be changed if the chip is not active.

Polling is excluded from irq coalescing support.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 55 ++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b20edd64bb7e..546193ab6e0d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1976,7 +1976,57 @@ static const struct net_device_ops m_can_netdev_ops = {
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
+	.get_ts_info = ethtool_op_get_ts_info,
+	.get_coalesce = m_can_get_coalesce,
+	.set_coalesce = m_can_set_coalesce,
+};
+
+static const struct ethtool_ops m_can_ethtool_ops_polling = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
@@ -1984,7 +2034,10 @@ static int register_m_can_dev(struct net_device *dev)
 {
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
-	dev->ethtool_ops = &m_can_ethtool_ops;
+	if (dev->irq)
+		dev->ethtool_ops = &m_can_ethtool_ops;
+	else
+		dev->ethtool_ops = &m_can_ethtool_ops_polling;
 
 	return register_candev(dev);
 }
-- 
2.40.1


