Return-Path: <netdev+bounces-31681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91478F882
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C312B1C20B6B
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBB6538C;
	Fri,  1 Sep 2023 06:24:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD545240
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 06:24:10 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5A510DF
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 23:24:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a3e943762so1405168b3a.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693549447; x=1694154247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ6PDv993Rp2fl4j4E1LU63DQukXqNgX8LZTNx5xQ8Y=;
        b=ba1c+N2snYnAVQLj3iAM94NR/IkgVDmKS0Sb6dxMLedYJTqhPYCrWdF5OCNVA8HGLp
         9WAsZTL0h7+czUsZQPrYtwOtXoezfs0jPRyvYjT/r/EdxXy8KrDsjZG5mrgWwoKoMME/
         H+laV2WJRdiZx0F7iOjmTuzoXLytOe3RaptbefvqOe/0cw/+5b+xqgGpDcn3yay7+Om8
         H5L8L8X1Y2CccxEDGlXm59s7CXx0L1qQz/HlJeETjNiQTazQt/E2uvPig0IXa2ae7TIp
         rPsazedch6fMe3ffc9UxQvirwYbPiboddPdaboCQIgENEeGK1yV6Rr2KJ7KSA/Vb3Arr
         nMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693549447; x=1694154247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ6PDv993Rp2fl4j4E1LU63DQukXqNgX8LZTNx5xQ8Y=;
        b=Txj9RXCiQepZGwVefZw1rdmn2CBGH/hn2nndk1OkSth1xpQe8iuFilAXI5+peyORkr
         Clg2m4erEBg7uh3HM+1V4KaNtWMM77nBg+mZwpbOEy4EGDSFhk0YaDaQwopfHiugsEAe
         sWttk2xM7DkgvpCkxOWYPc6x4fenwDG311lxJl0w0MQWtLEn074Jdu6hssdMsLgp4sme
         6yrk9CB378ZqH63I/xgRam+qf5Qh27gNFdsu1kHP4koldJ1aj2EOn2Fs5KbcAy4rtFn5
         LQ+kXxPjczOGm6yhsMFLYIRWuwUMspTZQLd3q2Di2ofjCYXBUw9/EK6GcDV2Kyw6AhN6
         4YuA==
X-Gm-Message-State: AOJu0YyGitAjHAqRY8r9YqD8xjmFcEsnbaULcgysHBVtLj88oDVeZF4B
	5h1LTmvX0Gh+twQZJ+EVcSqduw==
X-Google-Smtp-Source: AGHT+IFMqQT61UT4Tg0IU3qJAIzxQXgO4DhEf5zuPhELzVvTcr8/BRgzyzW20KePzBL0PUk/x6gtKA==
X-Received: by 2002:a05:6a00:17a8:b0:68a:66b2:3d15 with SMTP id s40-20020a056a0017a800b0068a66b23d15mr2442799pfg.7.1693549447179;
        Thu, 31 Aug 2023 23:24:07 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm19-20020a056a002f9300b0068c1ac1784csm2223265pfb.59.2023.08.31.23.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 23:24:06 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>
Cc: linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [RFC PATCH net-next 2/3] net-memcg: Record pressure level when under pressure
Date: Fri,  1 Sep 2023 14:21:27 +0800
Message-Id: <20230901062141.51972-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230901062141.51972-1-wuyun.abel@bytedance.com>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
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

For now memcg->socket_pressure is used for judging whether there
is memory reclaim pressure in this memcg. As different reclaim
efficiencies require different strategies, recording the level of
pressure would help do fine-grained control inside networking
where performance matters a lot.

The vmpressure infrastructure classifies pressure into 3 levels:
low, medium and critical. It would be too much conservative if
constraining socket memory usage at "low" level, so now only the
other two are taken into consideration and the least significant
bit of socket_pressure is enough to record this information.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/memcontrol.h | 39 +++++++++++++++++++++++++++++++++-----
 include/net/sock.h         |  2 +-
 include/net/tcp.h          |  2 +-
 mm/vmpressure.c            |  9 ++++++++-
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dbf26bc89dd4..a24047bf7722 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -288,6 +288,9 @@ struct mem_cgroup {
 	 * Hint of reclaim pressure for socket memroy management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
 	 * where socket memory is accounted/charged separately.
+	 *
+	 * The least significant bit is used for indicating the level of
+	 * pressure, 1 for 'critical' and 0 otherwise.
 	 */
 	unsigned long		socket_pressure;
 
@@ -1730,15 +1733,40 @@ extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
+
+static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg,
+						    bool *critical)
 {
+	bool under_pressure = false;
+
+	/*
+	 * When cgroup is in legacy mode where tcpmem is separately
+	 * charged, we have no idea about memcg reclaim pressure from
+	 * here and actually no need to, so just ignore the pressure
+	 * level info.
+	 */
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return !!memcg->tcpmem_pressure;
+
+	if (critical)
+		*critical = false;
+
 	do {
-		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
-			return true;
+		unsigned long expire = READ_ONCE(memcg->socket_pressure);
+
+		if (time_before(jiffies, expire)) {
+			if (!under_pressure)
+				under_pressure = true;
+			if (!critical)
+				break;
+			if (expire & 1) {
+				*critical = true;
+				break;
+			}
+		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
-	return false;
+
+	return under_pressure;
 }
 
 int alloc_shrinker_info(struct mem_cgroup *memcg);
@@ -1749,7 +1777,8 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
 static inline void mem_cgroup_sk_free(struct sock *sk) { };
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg,
+						    bool *critical)
 {
 	return false;
 }
diff --git a/include/net/sock.h b/include/net/sock.h
index 11d503417591..079bbee5c400 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1434,7 +1434,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 		return false;
 
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_under_socket_pressure(sk->sk_memcg, NULL))
 		return true;
 
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 07b21d9a9620..81e1f9c90a94 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -261,7 +261,7 @@ extern unsigned long tcp_memory_pressure;
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_under_socket_pressure(sk->sk_memcg, NULL))
 		return true;
 
 	return READ_ONCE(tcp_memory_pressure);
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 22c6689d9302..5a3ac3768c0f 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -308,6 +308,13 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		level = vmpressure_calc_level(scanned, reclaimed);
 
 		if (level > VMPRESSURE_LOW) {
+			unsigned long expire = jiffies + HZ;
+
+			if (level == VMPRESSURE_CRITICAL)
+				expire |=  1UL;
+			else
+				expire &= ~1UL;
+
 			/*
 			 * Let the socket buffer allocator know that
 			 * we are having trouble reclaiming LRU pages.
@@ -316,7 +323,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 			 * asserted for a second in which subsequent
 			 * pressure events can occur.
 			 */
-			WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
+			WRITE_ONCE(memcg->socket_pressure, expire);
 		}
 	}
 }
-- 
2.37.3


