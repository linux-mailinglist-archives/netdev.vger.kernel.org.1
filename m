Return-Path: <netdev+bounces-25902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E7B7761FA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115BC281CA9
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DDF198BB;
	Wed,  9 Aug 2023 14:02:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6E17754
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:02:59 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25219A1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:02:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so711378b3a.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691589777; x=1692194577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyoLe9IDclPyc8nxtmRLL+Re9tT3RP6Hr8S5cgH6TTM=;
        b=kje5h0U3k7K5XAKZFUJKKs0Y9Sx8mFR7VUTjZMv0iof6q2XVAFodD4biUmk9LyK3Zp
         h5ibMR/ltTrH0H0kDJ/O8WgicO+r5ShGYJIFoHt2XeFp+mviBh8z9TFabfkjDq5rp60X
         9X5iK2Swp7qWscrr730QcBQh2OyZHZlhNA+UeDhTUvzzDuBZxe59wbb3B8G5kTLCMV7S
         FBdba8C0lggAicwZ6zXRFupbpbj6hFyYZJoma9nApnc+GyWXg3p4FUBYC1hV+ysfNZpH
         xkaM2nxaBBQ0LPTsMYsdK6Ck7ahwnR8WbnusHTyTxnwoogC5ju2bd6LnnfOG+ghxuBls
         5E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589777; x=1692194577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyoLe9IDclPyc8nxtmRLL+Re9tT3RP6Hr8S5cgH6TTM=;
        b=dwyNR2/c5iaJy5kJpePc5xZvBXeHYO8YxzAErOk1x/hN+W/SusBo2O8/B3hA/+lePF
         kpi5LbzN6xSZK3oN3VTOkACiFof67cBuFvpY857Jt8jj8VkQtktR9pqqXTSNYUleRp5H
         jDrfc8xfTLTRgAI5j9t+51/L/LbieyGHaEp66emcjQUCUC2fXiXW/r+XWKw0VnJrxCPK
         1msHu7Mw9iI+adZYmzWuWpaz12C944URBilk2g4hrOoTZuBNO/tFqJtPnVcrgEHrVQML
         fuAliolgaphQqpmfPKK0TL9WjaD9RKHvjOw/z99wKd9nN8wLkrqsPZP6ZSOgrZVfc/a8
         Us6A==
X-Gm-Message-State: AOJu0Yx2SWRdwKYaNZ6T8FeuDBjcv4JtrSu7tlY2n1Rwzf2zY7aj8Vx2
	pg4YSEzFYyuCNKkS/UwuL+0LN0tcY6QkzQ==
X-Google-Smtp-Source: AGHT+IF9lI7n2mNHvvSOAzAAhNTh2Zjq9clZv4hGRAyJAMk+alUP4xxy0gA2KCLjyw+Ten1kJvwzbA==
X-Received: by 2002:aa7:888f:0:b0:687:82f9:3d8d with SMTP id z15-20020aa7888f000000b0068782f93d8dmr3747383pfe.2.1691589777346;
        Wed, 09 Aug 2023 07:02:57 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b0064aea45b040sm9935674pff.168.2023.08.09.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:02:56 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Thomas Haller <thaller@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCHv2 net-next 1/2] fib: convert fib_nh_is_v6 and nh_updated to use a single bit
Date: Wed,  9 Aug 2023 22:02:33 +0800
Message-Id: <20230809140234.3879929-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230809140234.3879929-1-liuhangbin@gmail.com>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The FIB info structure currently looks like this:
struct fib_info {
        struct hlist_node          fib_hash;             /*     0    16 */
        [...]
        u32                        fib_priority;         /*    80     4 */

        /* XXX 4 bytes hole, try to pack */

        struct dst_metrics *       fib_metrics;          /*    88     8 */
        int                        fib_nhs;              /*    96     4 */
        bool                       fib_nh_is_v6;         /*   100     1 */
        bool                       nh_updated;           /*   101     1 */

        /* XXX 2 bytes hole, try to pack */

        struct nexthop *           nh;                   /*   104     8 */
        struct callback_head       rcu __attribute__((__aligned__(8))); /*   112    16 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct fib_nh              fib_nh[];             /*   128     0 */

        /* size: 128, cachelines: 2, members: 21 */
        /* sum members: 122, holes: 2, sum holes: 6 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(8)));

Let's convert fib_nh_is_v6 and nh_updated to use a single bit, so that
we can add other functional bits in later patch.

Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/net/ip_fib.h     | 4 ++--
 net/ipv4/fib_semantics.c | 2 +-
 net/ipv4/nexthop.c       | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a378eff827c7..a91f8a28689a 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -152,8 +152,8 @@ struct fib_info {
 #define fib_rtt fib_metrics->metrics[RTAX_RTT-1]
 #define fib_advmss fib_metrics->metrics[RTAX_ADVMSS-1]
 	int			fib_nhs;
-	bool			fib_nh_is_v6;
-	bool			nh_updated;
+	u8			fib_nh_is_v6:1,
+				nh_updated:1;
 	struct nexthop		*nh;
 	struct rcu_head		rcu;
 	struct fib_nh		fib_nh[];
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 65ba18a91865..ce1c10e408cf 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1572,7 +1572,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 			fib_info_update_nhc_saddr(net, &nexthop_nh->nh_common,
 						  fi->fib_scope);
 			if (nexthop_nh->fib_nh_gw_family == AF_INET6)
-				fi->fib_nh_is_v6 = true;
+				fi->fib_nh_is_v6 = 1;
 		} endfor_nexthops(fi)
 
 		fib_rebalance(fi);
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 93f14d39fef6..5243bb80bade 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2213,12 +2213,12 @@ static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
 		 * and then walk the fib tables once
 		 */
 		list_for_each_entry(fi, &nh->fi_list, nh_list)
-			fi->nh_updated = true;
+			fi->nh_updated = 1;
 
 		fib_info_notify_update(net, info);
 
 		list_for_each_entry(fi, &nh->fi_list, nh_list)
-			fi->nh_updated = false;
+			fi->nh_updated = 0;
 	}
 
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-- 
2.38.1


