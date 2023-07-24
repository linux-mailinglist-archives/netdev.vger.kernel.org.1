Return-Path: <netdev+bounces-20347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD375F1EA
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4103028157D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A0479EC;
	Mon, 24 Jul 2023 09:56:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83B7464
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:56:46 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390C659C1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:56:22 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b7dfb95761so5887735ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192457; x=1690797257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMESg6KcZ1f/x8j8WNeV/0Ezds9kYbd4Innm/bU0Ooo=;
        b=dwKlx1oQ8gC3FGBisAur+bDXIIsIsnjGtPcpy7zH7OHDzky5UKxSTJ05GXNV3ifxFh
         uFNY+8ub7jUvRzU2N0mzwWkyUcySnlCtwLD3JQfZApULo5o50SUYvFf7wmqQeUGg+K3w
         AqzVxAjjzV5PNtSqJauuHxoQULcgDnOjWhlM27zpLCCDDjhxzzb13/oecO1ube7S7m7P
         1safwLAq/c10jFTLUU1Xqd0TB13zkKzwSGxlgMOCVqCgGIAn0g9Om1mA4z6ti880Mese
         Evcqc6hGgzGiGoOdWdO80KWYfeQwXeXM+h1Vq8tuq+SebTbp5eEFtPf8XLS7hjdlVp+9
         zxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192457; x=1690797257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMESg6KcZ1f/x8j8WNeV/0Ezds9kYbd4Innm/bU0Ooo=;
        b=V5Jq8jf79MtmS6Y21laRoTwXM9GhPcMW3mzMJuF2yWEWLc1ZAzcsK4ed/R+m32VqhB
         UoQh5WJ/AfxZki/MOyHM0TCwhz6kN5SoroJEW0O4k9TG9KvyPXwOHCIAZYqi+x7J2v1p
         gzt+/v1Nc5yQX5qGR07q2n5G8XunSrQSzhVLe9BJET+5Q1wp2j1/MRyycoCJzsXVwKXa
         YPFqkFsR0Q7/5NFjKi/VJ/gyBPW57Ygok5MJPqrLrFl/s4aQlvTdjtRi1oofg569rswP
         Yqh75gItLnQdzN+yoXGyYLnWjlAsFgKOMAhGE5AgDHumdo1p2JsMoXk5fPrWF37v/vy9
         Um7A==
X-Gm-Message-State: ABy/qLa6E1M7AkXW18q92k1lUZW4rFuvv7vK+hV+sxOae9RSSRuzznqX
	0kOQBVbxGcwb4h7ZKWPN1w8Tgg==
X-Google-Smtp-Source: APBJJlGXXWR+7sUNZwfELUHGku1GBmb2Z0Up/m3d12N15W4mEcGvzf3zzmR3Y2DB2osG2hV81y8tMw==
X-Received: by 2002:a17:902:dacf:b0:1b8:9215:9163 with SMTP id q15-20020a170902dacf00b001b892159163mr12209813plx.6.1690192456927;
        Mon, 24 Jul 2023 02:54:16 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:54:16 -0700 (PDT)
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
	muchun.song@linux.dev
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
Subject: [PATCH v2 46/47] mm: shrinker: hold write lock to reparent shrinker nr_deferred
Date: Mon, 24 Jul 2023 17:43:53 +0800
Message-Id: <20230724094354.90817-47-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
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
index 744361afd520..90c045620fe3 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -303,7 +303,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -316,7 +316,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
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


