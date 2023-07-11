Return-Path: <netdev+bounces-16839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05874EF33
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6850E2810CD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255F182B6;
	Tue, 11 Jul 2023 12:42:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F4174FE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 12:42:46 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801591704
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 05:42:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6686ef86110so3038616b3a.2
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689079359; x=1691671359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF8p9HwwgSPuKR34SMZuqSQ7aAssq/odh5sAxqcKAUo=;
        b=PfObz486Wz+B8XCRMJmNpdOHd0bdAenCGoIFIrS0nn6pqgOGHIHHLLi/E7y4xelPQs
         oV1L5cDtGQ4gFHo4+itEHIwzUsNI9UXysv8UU/Pza3CLcUbZHUcxkt1As11YdvxnX8RF
         H17ZVvTu4nrEDSvdfN39NUxyIGNfeoTwnjdkSADFNYnqT8BI11t6wbWjHwH7o/9kadrH
         e5S5yw3IMsz3lksjyY+6iOF1Q4m7p0LVb07p4UTqbAdR2d9VI1K3CWAVsuHGT4SgzzBo
         xLZVs2ZfUmoYmSJPyCtnkjpSavzGDmGYFi8eCIFGc6qahboTah/quQSujY0SX5PCPa3e
         hfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689079359; x=1691671359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF8p9HwwgSPuKR34SMZuqSQ7aAssq/odh5sAxqcKAUo=;
        b=a+9rAoRsgT2BC8gA4BxkwgGA5KbyTs5MrQCfqJMQL2aH0V66l8U5gX4J4TBuk0MCzF
         rucOOSfgUkGrcANJRSouUcJ2o4K0Rgv3dkUUr5rwTk9qF8Daqzni9tGtnFbglCjUGIf8
         kpfLUL5reZRBFhY5qFMv5EqVjdR3sUUWlga9p2qAEEz6lLFz+GtOmA140GwO4SjJKhKc
         CvA/ckt7XniVuCK9kFQv/4oqL7IpRYalMonf3vXALMbwl8FZXL4dSRw8sHTymqaN6tas
         rHo8Mp+K4TKMW1xyZuWiNKGRyk1HXwk/NsUfFs+bqidcxiNLB8/hPQz/uoorJeDV3FC5
         25AQ==
X-Gm-Message-State: ABy/qLbbbysJqEbFPBk2vel9WjBlcqfBIe0iyEzOpSRGPoaMVJkSjaX2
	MZHTiccQx/t+g9lGO7ej94r47w==
X-Google-Smtp-Source: APBJJlF8Ng7++YijKQqg29ZCVWXJRwBhX6TmRTz/uJVTeJyWO9yu17EmSQrDts1Z+LLhsS5GxNFl2g==
X-Received: by 2002:a05:6a20:1456:b0:12d:d17d:c811 with SMTP id a22-20020a056a20145600b0012dd17dc811mr13827670pzi.21.1689079358984;
        Tue, 11 Jul 2023 05:42:38 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d27-20020a63735b000000b0055c0508780asm1512222pgn.73.2023.07.11.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:42:38 -0700 (PDT)
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
	Abel Wu <wuyun.abel@bytedance.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Breno Leitao <leitao@debian.org>,
	David Howells <dhowells@redhat.com>,
	Jason Xing <kernelxing@tencent.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)),
	linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Subject: [PATCH RESEND net-next 2/2] net-memcg: Remove redundant tcpmem_pressure
Date: Tue, 11 Jul 2023 20:41:44 +0800
Message-Id: <20230711124157.97169-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230711124157.97169-1-wuyun.abel@bytedance.com>
References: <20230711124157.97169-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
index 5860c7f316b9..341d397186ff 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -288,7 +288,6 @@ struct mem_cgroup {
 
 	/* Legacy tcp memory accounting */
 	bool			tcpmem_active;
-	int			tcpmem_pressure;
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
@@ -1728,7 +1727,7 @@ void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
+		return !!memcg->socket_pressure;
 	do {
 		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
 			return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..e9e26dbd65b5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7292,10 +7292,10 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
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


