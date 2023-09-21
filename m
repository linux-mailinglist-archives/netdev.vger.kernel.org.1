Return-Path: <netdev+bounces-35544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7DB7A9C97
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A0282E40
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07194CFA6;
	Thu, 21 Sep 2023 18:11:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3364C868
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:11:31 +0000 (UTC)
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45079F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:10:31 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-57b6321d600so741010eaf.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695319831; x=1695924631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NN0qVPUEzKFEN93CTjUFaZ6yz24zt8p50LMx9YRcXPk=;
        b=lktTTm/vBJaV9jYbq58GfVd8iBvb6fku4kY95dAU+JUVmKu1ZzEDdGkUyFsO/IJkDh
         9HjlioE0OJgodKNrYAY93kttw5dVpyR43a86ZflabzkjlXuuszJhDb8fIl2JKf0Uy2xa
         lWF+iQGmJ0CWrnECzNDJJiZJPIC6c5Mqalod/PBQsJbFqa6tEkqFGuuQvdGz5moBAfOh
         jglqmXmA7ILyOdNXvfzf3rGI/LWypwtjBa+38zmyEL8w3AJmsHq9O1tNceX4e9fRJ89B
         q7d/vqPP0HCug0mJdWu67GZduqXR4On/4gcOVDSP+fi1waDeA7m/mtCgYGHYAP7GgHrS
         dwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319831; x=1695924631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN0qVPUEzKFEN93CTjUFaZ6yz24zt8p50LMx9YRcXPk=;
        b=HANi7D+lWHWbQGSKu1bPDNF4HzKL4+ndIS5ETmfKEVLUIG6H7TZVf1ElQI2AhsrmZP
         NHH9yAM9ZhkRRUaFpvvH/DfztBOrQsXbUD8LhdAkZ27g4QO5lGvyNWkdvZKSze7g4CYt
         etn907QV2zVhw2XN6Vid0hKTd5WbJ9ukqM5QAZy5+i6LtcjT+dRJ4JLjih8JZ2Pcg4i/
         apKs+DSdPENZYk5ouUesZSd8i86f+ShvvLBBkfrQCC4O9sbfgSGMfSi5mSg5DkRzOySe
         flc6Xf+23GH7GiTkrbThTPP3QqaVsea7feXj0qYZBacqNb+YwC9A+glXva1VsNYuQ4m+
         UsXA==
X-Gm-Message-State: AOJu0Yx6tKiD2frZzfXn4h/8wiyFcRJvE0aIne6soDrn328lnBY/CWVj
	OmckDqIyU4itpVQX4x2ScKg4u4Zz6yUS1g==
X-Google-Smtp-Source: AGHT+IE/hcEUexcASIDQ5LiqL9XSAesD7c5bxZT3tIow2KDdt5LpivJF9D6h0WWo43JLN24u0gFR655byCKb7w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:cecf:0:b0:d85:aa2f:5715 with SMTP id
 x198-20020a25cecf000000b00d85aa2f5715mr57788ybe.10.1695286342559; Thu, 21 Sep
 2023 01:52:22 -0700 (PDT)
Date: Thu, 21 Sep 2023 08:52:16 +0000
In-Reply-To: <20230921085218.954120-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921085218.954120-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921085218.954120-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] net: add DEV_STATS_READ() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
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
index b7e151439c4886f851ba87e27a34e33cd834069a..7a44e1cbe30558dafcc2bc1a6ee47faad2e60d15 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3655,9 +3655,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
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
index 7e520c14eb8c68cf2e3821c86c7c3d1f0d8ab226..e070a4540fbaf4a9cf310d5f53c4401840c72776 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5236,5 +5236,6 @@ extern struct net_device *blackhole_netdev;
 #define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
 #define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+#define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
-- 
2.42.0.459.ge4e396fd5e-goog


