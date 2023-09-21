Return-Path: <netdev+bounces-35367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D827A912A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 05:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5161C208C4
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5717D9;
	Thu, 21 Sep 2023 03:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC11845
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 03:14:30 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD29F4
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:14:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-69002ef0104so353816b3a.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695266067; x=1695870867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhTEm5+a18oUUkUxQB97Kv5HfRcqcJmruHfG+xCNqc8=;
        b=My7qnsMwYkdXa0OXbOGZjZuPlAcmeZaTG/YqOHujKfU6wFJoP0HTJ5R4hW8YPrVOB4
         0P3kQ2UqQvFka2pWu63djV83R2gimTRg6cE/PvODT0O9+GOwVTlX4qlVuWAn0nq9mz/6
         oPdVH7X++4baAuJDijMLSAu+72gI6yerA1QERREIbvcdFnSa3QQujoDB+AgwUBEiCUui
         DCKQ5UmydH+MyS/AOdWJ1etBiuKspjdDWfBuuj97OWDUW+saENRDqxkZW4lT3BzPOg8q
         WZkKNoTotiJuVomp+Wv+N64qNW78gUXwrBsqIsk3HoHjIFHNdDml+BKuSHgV/8otpoap
         kA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266067; x=1695870867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhTEm5+a18oUUkUxQB97Kv5HfRcqcJmruHfG+xCNqc8=;
        b=rIL/MaVQ8WpZNBhwi+9nqrN5bNw10YSkgJW49pfiP0zAs7A7QW34QWRJaTRP/ktcVF
         YkgZREjDEpG9X6l6G/skifDPZxDh0LcnUL37qAtFww0qJSCqzDxijMLVmqP532XGRMPY
         UHXQ7MZzrLCpzc5T9/r1ixwkPFJEl/KvIRu74w2CVMZZgrNDJC3xjQalp0B2IpLT4Mii
         z5oGZDHY8CjSE1sdFWLRR2voYyGLjNsbVsf2bqmCJVydJ6ZDh/UQ9NvXKY2B6W40YJHU
         1xxD7M8J7q6bHjbGTijj3GLQvjhDMWqKyZS2m4ZuJqOIX7ASmV9A2cJrHMvk3KxEoxAq
         k15g==
X-Gm-Message-State: AOJu0Yw5Lj1++KZEqBr9x7+AOfA0ffj7vHBcogpUFufqDurjsWwxO4Ij
	ZhRJZ/mF59thh/8kIO8/phOFSpONH3jswHjm
X-Google-Smtp-Source: AGHT+IEwb+gnSGOd2YXmrMB2V9odRSHYwOpTu3AqKtlqUtkMFy/AEEDYxoxA1yaTpBtmUD5fkHnrSw==
X-Received: by 2002:a05:6a00:847:b0:68a:69ba:6791 with SMTP id q7-20020a056a00084700b0068a69ba6791mr4926254pfk.8.1695266066926;
        Wed, 20 Sep 2023 20:14:26 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056a001f8200b0068fe76cdc62sm236032pfb.93.2023.09.20.20.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:14:25 -0700 (PDT)
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
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCHv3 net 1/2] fib: convert fib_nh_is_v6 and nh_updated to use a single bit
Date: Thu, 21 Sep 2023 11:14:08 +0800
Message-ID: <20230921031409.514488-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921031409.514488-1-liuhangbin@gmail.com>
References: <20230921031409.514488-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index f0c13864180e..6d05469cf5da 100644
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
index eafa4a033515..b2858b0a1229 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1573,7 +1573,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 			fib_info_update_nhc_saddr(net, &nexthop_nh->nh_common,
 						  fi->fib_scope);
 			if (nexthop_nh->fib_nh_gw_family == AF_INET6)
-				fi->fib_nh_is_v6 = true;
+				fi->fib_nh_is_v6 = 1;
 		} endfor_nexthops(fi)
 
 		fib_rebalance(fi);
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bbff68b5b5d4..54ba53c89b3d 100644
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
2.41.0


