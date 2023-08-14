Return-Path: <netdev+bounces-27237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B777B213
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C66280F98
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D586FD7;
	Mon, 14 Aug 2023 07:09:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E795C98
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:09:51 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A95E73
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 00:09:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-56546b45f30so3125620a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691996990; x=1692601790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0c3TLEEphAL5/eO0YPgnOFzgaQ5OvBXzIFtvrL+QOK4=;
        b=F1xTxqTrvmFeFiUwpFxZm3x1pFr/mDQ1sBDBqQiiQYoLeWGdyQnoRyVZk+3sIzi6FN
         aRK8HpgYM40c5hmWVDml1XrE0VoWDzs1SVzl9lbI3gEbCPKixhnm95T164E3BGz7y/fc
         nFE0Zb0/efoTC2kjjNVHUX8yawznVQg64xNDhBwHnAS6xS7BpCFnXs2mpqZYl77+RHhK
         T+HC/MQRo2R7lbzcivfMB7kvt5ifzOmX3J5HbBlZl66WmIc3vzCTENJr4WDLctWxXGHp
         owXjECGkqq1B4C1wHG18SY7DCVj0eB7hN3Wp3RI7qy6LTNpieHLJuLReiOrWMpnH1iOu
         hQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691996990; x=1692601790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0c3TLEEphAL5/eO0YPgnOFzgaQ5OvBXzIFtvrL+QOK4=;
        b=fR4KsDdfLtEy5H1CgHCSolWGdzY4FMmPwx+pYngHdZAYp6Xvvk+w1AsCUPLWhJQRZk
         xyJbxoCdNlLRiG+lALy18lPNhTRPiTGcA0t6FyqvfHmrhFnowf38Lhhpx+FzEXWQOwJX
         80dROpi7+W85I5wFNnwu0lfT+xlxG8MUNI1lggDusnXA0Yy2lhPDv/zA/YihSAf+a6Yv
         eD4V5+4WzZH0z1UNjA6dTu79Gqzdq5R6pEHx5PJQ2oRNsA8OLUuC6NXL46+Qo6Xsk4qE
         p8bi9ys+ExtmWSpSnsqHHskbEnxiM8UxUUFls27Al91BTRWGfwyeMYwZvWqiHlqDd0UI
         kioA==
X-Gm-Message-State: AOJu0YyU59nDP0S7RkaP6QPVBh5UZRLH86LtS5b/0uEbkbceA8IgOGET
	xbcBp0Cce0j9ysoY3sD2/Rp5qw==
X-Google-Smtp-Source: AGHT+IH3h9TjelpSKWyiOrXapoN6fmGeM/W3yxjtRhsDcuBlqtxYjfZM4msZETu6o0zwnXEsFk1Lyw==
X-Received: by 2002:a17:902:9002:b0:1b9:be2e:2b40 with SMTP id a2-20020a170902900200b001b9be2e2b40mr8522331plp.50.1691996989923;
        Mon, 14 Aug 2023 00:09:49 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001aadd0d7364sm8605394plh.83.2023.08.14.00.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 00:09:49 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Ahern <dsahern@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Subject: [PATCH net-next v2] net-memcg: Fix scope of sockmem pressure indicators
Date: Mon, 14 Aug 2023 15:09:11 +0800
Message-Id: <20230814070923.35769-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
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

Now there are two indicators of socket memory pressure sit inside
struct mem_cgroup, socket_pressure and tcpmem_pressure, indicating
memory reclaim pressure in memcg->memory and ->tcpmem respectively.

When in legacy mode (cgroupv1), the socket memory is charged into
->tcpmem which is independent of ->memory, so socket_pressure has
nothing to do with socket's pressure at all. Things could be worse
by taking socket_pressure into consideration in legacy mode, as a
pressure in ->memory can lead to premature reclamation/throttling
in socket.

While for the default mode (cgroupv2), the socket memory is charged
into ->memory, and ->tcpmem/->tcpmem_pressure are simply not used.

So {socket,tcpmem}_pressure are only used in default/legacy mode
respectively for indicating socket memory pressure. This patch fixes
the pieces of code that make mixed use of both.

Fixes: 8e8ae645249b ("mm: memcontrol: hook up vmpressure to socket pressure")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
v2:
 - Add a comment to clarify the scope of indicators (Roman)
 - Drop code cleanup on tcpmem_pressure (Roman)
 - Fix the lack of a Fixes: tag (Eric)
---
 include/linux/memcontrol.h | 9 +++++++--
 mm/vmpressure.c            | 8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..dbf26bc89dd4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -284,6 +284,11 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
+	/*
+	 * Hint of reclaim pressure for socket memroy management. Note
+	 * that this indicator should NOT be used in legacy cgroup mode
+	 * where socket memory is accounted/charged separately.
+	 */
 	unsigned long		socket_pressure;
 
 	/* Legacy tcp memory accounting */
@@ -1727,8 +1732,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
-		return true;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return !!memcg->tcpmem_pressure;
 	do {
 		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index b52644771cc4..22c6689d9302 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -244,6 +244,14 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 	if (mem_cgroup_disabled())
 		return;
 
+	/*
+	 * The in-kernel users only care about the reclaim efficiency
+	 * for this @memcg rather than the whole subtree, and there
+	 * isn't and won't be any in-kernel user in a legacy cgroup.
+	 */
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !tree)
+		return;
+
 	vmpr = memcg_to_vmpressure(memcg);
 
 	/*
-- 
2.37.3


