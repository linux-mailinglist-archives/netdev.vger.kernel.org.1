Return-Path: <netdev+bounces-29048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983FB781764
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 06:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A880A281E1E
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520EA17E6;
	Sat, 19 Aug 2023 04:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D81116
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 04:41:04 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7F3A8D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589c6dc8670so23748557b3.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692420063; x=1693024863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSxmFrETHZdMSsZVnmVqMvzUJ3x3I7xJZUq6yH0zcxk=;
        b=P8RQiGZTbVibQQ099gxdPh1MMWKvlWijdNBq+uhYgc0V1U1dUhMvVOet7C7otVWybv
         pN/3awBT7gK0FwSyjop9PtRs0rgH9EYLG9qAJt4TfTBSt/JGP8rkdqNGv10VK0W+PT64
         JoM9Ladnxjtgkhb1nsLqlkeTY8X9s/GMKmTV9sjgnHAtvATjVrhbB4tu+AStyEfOI/a4
         j6lGfA8lU+Hq71ZRpXm7qSUVP2UzhPluTYkJ1UCJ9/7uTFKLgzuCIVyezlpE5p99GeTb
         rEuqkVFwTAndzjSkil8pT9I5ctNeAH34kwQnRpyMFKEBkWzzYu7MVn+QcSCYLQ/o/oTG
         NQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692420063; x=1693024863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSxmFrETHZdMSsZVnmVqMvzUJ3x3I7xJZUq6yH0zcxk=;
        b=dKMjTk/FD/k84Rt+F2fNqidkAFn5dPhYtGsBkYIkbGVhH2GUcX4QhB2iAxug3iaDKz
         JtvKxvrJkOhXVufgwT5ILs/KVWeSdmbbjQN+yt2s4XjDDGIq09uA4ei9VLLvRY6WPA/S
         NvlSMWz2u+xsIpxkPV/UH8FaxnUsb6j2bQOV4jQ0y3Q5q7o4/MYrnpneFF1uv6VSsYoN
         yDqmRiN6R+7gC+KEGeaHVaZCP2eyzwvYf0pnK63iNEJXUgW60TAgQqPvMubiuzqctbVL
         S43+DochP4kql90dyWewxiJMoqk5B3y2dpdqDTTH9s3WV4v2XgebS8QiYqiGmH5nZGmC
         2P8A==
X-Gm-Message-State: AOJu0YylLCIC+ZYyojEujN6GVODFKyJtyXn683glFIIDEeW2W0GyZpCr
	q4fIo2+43h+EiBu1hT9MKRoO18J8tqxCvA==
X-Google-Smtp-Source: AGHT+IHGA04kTbuZkJzQQDJnphILlspczQxaF4vqESXPuSm1d4CJ8TurMZC1jp1ULS8GIbuD1u+0adqASFjM/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ae56:0:b0:58f:b749:a50b with SMTP id
 g22-20020a81ae56000000b0058fb749a50bmr5666ywk.4.1692420063132; Fri, 18 Aug
 2023 21:41:03 -0700 (PDT)
Date: Sat, 19 Aug 2023 04:40:57 +0000
In-Reply-To: <20230819044059.833749-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230819044059.833749-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819044059.833749-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] net: add DEV_STATS_READ() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Companion of DEV_STATS_INC() & DEV_STATS_ADD().

This is going to be used in the series.

Use it in macsec_get_stats64().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/macsec.c      | 6 +++---
 include/linux/netdevice.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index ae60817ec5c2db004768448cd57fa91ad61966d1..ff5533e96bbb1705857565f9eab400e93aa39af9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3656,9 +3656,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	dev_fetch_sw_netstats(s, dev->tstats);
 
-	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
-	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
-	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
+	s->rx_dropped = DEV_STATS_READ(dev, rx_dropped);
+	s->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	s->rx_errors = DEV_STATS_READ(dev, rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7bfe387cb67c43d49d5632d4b655a..b646609f09c051fe7c1da80a438701256241ccde 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5214,5 +5214,6 @@ extern struct net_device *blackhole_netdev;
 #define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
 #define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+#define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
-- 
2.42.0.rc1.204.g551eb34607-goog


