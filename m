Return-Path: <netdev+bounces-24918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF37721EA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70391C20A4D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD02FBF1;
	Mon,  7 Aug 2023 11:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3239DF71
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:26:22 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDBD55B1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 04:25:58 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2680edb9767so931618a91.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407200; x=1692012000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5ij/O+E/bk/tTzX9mgxwiCynzBHcXx4EKtI9EsHayo=;
        b=i3OLYIqgHrVEAaoeqhN7xu/7U1C+reDkv4O93uYT3wVXPD8PclsjVNwGlC6uACGJON
         5G7yHqhhbIuKFoghA6ZSicHcXMJKMfCogQ8szn+vWtZn4EOKB8vbAdIc7rpijTp0cbxa
         Z/AamO41rUovV3Rd5mToLS3fdUn/gIbndWW5fXdkD//uV9WpRp/5E2yE1kJcYdxc2q43
         2kKg85HGCsKzT23sBdglbe/LKtHC4WUeFtaNvdRNowxvHAXGs/cRyz4+kFuB/ka63yH8
         5vv+ldmlZuknYjC0UrMsohE+IjtZuT+2tIf1cSRO1giyAMKM5zLXRshImNoV+3DwaEWW
         qy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407200; x=1692012000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5ij/O+E/bk/tTzX9mgxwiCynzBHcXx4EKtI9EsHayo=;
        b=e9Y0wBE1vzMPeC7VV9X3IlXP/iZ0F5yJw0M0LCnPPCaGGF+vpi6qtdyE4YvBSCAhvc
         M87sJfZJDbMwpqIbQUMH3YVDQ491+AX3B48kN9aYjnkniz1RswlOvIWmIMop7tMLECum
         aD+m4HZ3ULcYWeKX2/TMzCAtqohYqmhV41uUs2qzNswVYDCkGGr8Zf9/HFXzw6+HRczu
         pVusPzsnGsD1mdS1O358B7fhC18fblI9GCO7MooJGapvGdrTRCoLfQ6RoOoq9S2d/Uey
         Fz7dDceUGomeKuVZHnAucv3HM6Nh0ihtZSiggVb0V7ZBjfkEaNPsOOMmFY0rjBZ2H/84
         Yrrg==
X-Gm-Message-State: AOJu0YzGI59u6ezrSHXMx3+A2p+CzJm0EY0lTvkPE77hhKoUjjP8ndes
	eVvA9GQdQ5NuhQpk4wkIn2HPew==
X-Google-Smtp-Source: AGHT+IH1iUQIXRu8fJbzxUHSh+kWmc44BJdJFh0ZxZy41KSEiq7lusFAb/6JfkXEPdg45Q03TKbByg==
X-Received: by 2002:a17:90a:9c3:b0:269:41cf:7212 with SMTP id 61-20020a17090a09c300b0026941cf7212mr4973775pjo.4.1691407200010;
        Mon, 07 Aug 2023 04:20:00 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:19:59 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev,
	simon.horman@corigine.com,
	dlemoal@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	cluster-devel@redhat.com,
	linux-nfs@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 47/48] mm: shrinker: hold write lock to reparent shrinker nr_deferred
Date: Mon,  7 Aug 2023 19:09:35 +0800
Message-Id: <20230807110936.21819-48-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For now, reparent_shrinker_deferred() is the only holder of read lock of
shrinker_rwsem. And it already holds the global cgroup_mutex, so it will
not be called in parallel.

Therefore, in order to convert shrinker_rwsem to shrinker_mutex later,
here we change to hold the write lock of shrinker_rwsem to reparent.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index fee6f62904fb..a12dede5d21f 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -299,7 +299,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -312,7 +312,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			}
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 #else
 static int shrinker_memcg_alloc(struct shrinker *shrinker)
-- 
2.30.2


