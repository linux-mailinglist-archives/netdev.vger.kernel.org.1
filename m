Return-Path: <netdev+bounces-24938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F177238D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192402812A4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A64100CA;
	Mon,  7 Aug 2023 12:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C84436
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:15:25 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D26E44
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:15:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26854159c05so2364617a91.2
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691410523; x=1692015323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=bEAsqH3EjC2u0IGUnDABZVNA3fbPjqYFRA+b6OttdreALvj5DL7l7Ckx1qTRiEI13l
         /MNN1P3o3BUJAbMyJ5RZk7d1fAqiWmKhRsmLQRel5SV+JfC6akLzqW9B/w0QwXMG+Axx
         EbhFL6nmoNWKymjJleYouiGVXtulkdgMMReMJ48ag1EerhFmBMPRRxPb4+VYYK78FigG
         H8+2tCLHg7Q5ZF78UsXOv+7taDaXBCWTD0bY26hvadEh1o3oxyl8/xWhkUrT6uL19SQs
         ifTEX5J9eqOjtREpgVr+LfniIynboIEd/NlIcpVj3S468oO+PrfuwNV2Lw0N/Icu+Bif
         mfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410523; x=1692015323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=MnvtguvUWTIdjEn7p6SbN7ANvJTOHGAFgqlTr9vQ4nkyWORJdEu0Ult8MKPSNQ1lz0
         nH3kPO4Ds0OysDm/WjGyguI7lqoq6F3XO9nivvwHOOb5e5cbqpHy3Ijoa7kkqBIa7DXo
         H5F95uNH5c4ELEW+gPsQBbuDL3TRcnhR2ZjQNivSIJ04oCmiHNjvXVDzugnRWlUOBkHb
         PDczbXWqskLropIy2S2McdOR+BiBfMRpALXKpL2uOCSBF33LzAPc2FqfZ2jTKpT1fde9
         /0H58MEUtqNE25wHaql6iOOde4vy2BuxUHGemYbTTsVkArgast1NNTneTgqoQWjXDHt4
         R9GQ==
X-Gm-Message-State: AOJu0Yy0WmCdJbus0TxPtpBLw7o9uJNfbuy6Z+VNuKt8EfZJFnn4VQGe
	FVk/a2jn7o235XcYvoowTWJbzA==
X-Google-Smtp-Source: AGHT+IEFVp6KMtDbFDIQLBkpU/u99kKhhVeErfazpqq/dYJkpUEs2Le54iKKZ2BwOj5rl02nFUtamA==
X-Received: by 2002:a17:90b:3e88:b0:269:3771:7342 with SMTP id rj8-20020a17090b3e8800b0026937717342mr4621802pjb.18.1691410523675;
        Mon, 07 Aug 2023 05:15:23 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b00268320ab9f2sm8645761pjt.6.2023.08.07.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:15:23 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 Optimizing veth xsk performance 1/9] veth: Implement ethtool's get_ringparam() callback
Date: Mon,  7 Aug 2023 20:15:10 +0800
Message-Id: <20230807121510.84113-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

some xsk library calls get_ringparam() API to get the queue length
to init the xsk umem.

Implement that in veth so those scenarios can work properly.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..77e12d52ca2b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -255,6 +255,17 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static void veth_get_ringparam(struct net_device *dev,
+			       struct ethtool_ringparam *ring,
+			     struct kernel_ethtool_ringparam *kernel_ring,
+			     struct netlink_ext_ack *extack)
+{
+	ring->rx_max_pending = VETH_RING_SIZE;
+	ring->tx_max_pending = VETH_RING_SIZE;
+	ring->rx_pending = VETH_RING_SIZE;
+	ring->tx_pending = VETH_RING_SIZE;
+}
+
 static const struct ethtool_ops veth_ethtool_ops = {
 	.get_drvinfo		= veth_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -265,6 +276,7 @@ static const struct ethtool_ops veth_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_channels		= veth_get_channels,
 	.set_channels		= veth_set_channels,
+	.get_ringparam		= veth_get_ringparam,
 };
 
 /* general routines */
-- 
2.20.1


