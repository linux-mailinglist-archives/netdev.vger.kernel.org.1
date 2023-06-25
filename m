Return-Path: <netdev+bounces-13820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48E73D179
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CBF280F47
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305463A3;
	Sun, 25 Jun 2023 14:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AD613E
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 14:29:40 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC21EE
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:29:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54fb3c168fcso2118307a12.0
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687703376; x=1690295376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ3Ti/D8S3EnbGsOdGwNu9kTjaPf3p14ktWAeREbOBA=;
        b=R76JOrQ1dPo/73QodWvkhogr6Xt3xbQEkJkqTXvgiKUM710so38qio0hXQtzJsCbye
         O64gRUD8e4b7zMBLCa8BCFkjiCVBuoelt8Lz44yLSCENsHauLJ5VAqcybrk7HI43XjZJ
         xw1A0f0eaZzKR/Ar36Kqyfhr3MjK8BgRBvHCT8PoFVrsUtlG8ClolFEc1xl4ajF7FpQ4
         jG1bDDFxEkF4PmsG5MN5jtqcIgZemQAg42B1hTpu7CQnS5UpXJ+RqiyD5oKIhLIk3DKX
         7lQZBR+vpTUq2cMa25g5g10YhFZV5+0w3BEdk2HvIp0mOd/DI175m+zpOf8KM/i3awwh
         RfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703376; x=1690295376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJ3Ti/D8S3EnbGsOdGwNu9kTjaPf3p14ktWAeREbOBA=;
        b=R6sUs7bpiP2XYODrXd50zfPFDkQslOPiBPiuzZVBrSY6R6t7evuHsd2c0XKqZxkeUP
         QEsUG9G6AfrBpDFfaDJF/r6Vx/3UhDR/HuQmJAVcM2b5n6cmj1mxCcAYfAy+7KFrJgT7
         OXMJDiGyDVuHbFJGr86Wd0TZDZAAXrgMLG/ZVglUWHnEpViUifHdzFWxq7YiacBS7vfU
         nLCb4ymALgUrUbXwnMJC4bMS7BPdxjRH5/UjwMNCeFKqewIdzW3Am2rFctJTBn+PVbwS
         nFNcs/Zevv4lgtHBjj8EQ8G0YkOK223YlHx0pmNks7iY1eTsvkMa764HKwCiHMKp2gEg
         lT4Q==
X-Gm-Message-State: AC+VfDyhmytppVabyqhKUA1vs6S+HBjZ1RyinaOxGgNSgxPi88wHZx85
	N2lIXxl628tHS1Nff24/PApgeA==
X-Google-Smtp-Source: ACHHUZ4HqtHP/zbYUeJtO1vXlwl9dfUGTA5Z2y9D1QGuKBCZoms2r2/THr49mB8kg8U5Z9mw09DG5Q==
X-Received: by 2002:a17:90b:4b4c:b0:25b:eeb3:adc4 with SMTP id mi12-20020a17090b4b4c00b0025beeb3adc4mr26482189pjb.15.1687703376138;
        Sun, 25 Jun 2023 07:29:36 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0025ef39c0f87sm2980744pjh.0.2023.06.25.07.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:29:35 -0700 (PDT)
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
	Yu Zhao <yuzhao@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Breno Leitao <leitao@debian.org>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Subject: [PATCH net-next 2/2] net-memcg: Remove redundant tcpmem_pressure
Date: Sun, 25 Jun 2023 22:28:11 +0800
Message-Id: <20230625142820.47185-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230625142820.47185-1-wuyun.abel@bytedance.com>
References: <20230625142820.47185-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As {socket,tcpmem}_pressure are only used in default/legacy mode
respectively, use socket_pressure instead of tcpmem_pressure in all
kinds of cgroup hierarchies.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/memcontrol.h | 3 +--
 mm/memcontrol.c            | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9b1b536b4ec9..05e9fb5fa08d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -288,7 +288,6 @@ struct mem_cgroup {
 
 	/* Legacy tcp memory accounting */
 	bool			tcpmem_active;
-	int			tcpmem_pressure;
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
@@ -1744,7 +1743,7 @@ void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
+		return !!memcg->socket_pressure;
 	do {
 		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..76c4e5c6e558 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7337,10 +7337,10 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 		struct page_counter *fail;
 
 		if (page_counter_try_charge(&memcg->tcpmem, nr_pages, &fail)) {
-			memcg->tcpmem_pressure = 0;
+			memcg->socket_pressure = 0;
 			return true;
 		}
-		memcg->tcpmem_pressure = 1;
+		memcg->socket_pressure = 1;
 		if (gfp_mask & __GFP_NOFAIL) {
 			page_counter_charge(&memcg->tcpmem, nr_pages);
 			return true;
-- 
2.37.3


