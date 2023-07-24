Return-Path: <netdev+bounces-20337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1C75F19A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A132F1C20AEB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493579C2;
	Mon, 24 Jul 2023 09:52:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FE8460
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:52:43 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C663C3B
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:52:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51f64817809so328141a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192266; x=1690797066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVZBD26n61nILm1319d0FZlD/fP50Fwp7YtrZB2yUEw=;
        b=iUPcJgUMyrTLwgrjrlC+a27y9vEWwy56+puOu64xedJv2ncHtSqDNqiSeynerud5CA
         SLWVqH1nGCnKkpkX8dkzmoG0eMRym5h6Xzfw/4y3ynxDe9x5fP4GtDEbYlXCEU4KGmnh
         J8JMlwHQENpmCB/IBQ5Kj/D3RaklR5mhQ3KWpjAIq5ncgA2kgZ+m8lyKEtRUg3xIXkRf
         1Y+VworbTR0lkfVEfm55Dde1LFRd3k61KtabNyesWRzHMD8tamW6ciBekSSPn4dMEieQ
         RK4Z2ABaXDMl+MwOvSJ5/Kn72pZwCqkmqC5YhlHMVnLFWPN8jgdPeYJAkwxf5yUyP5GW
         rA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192266; x=1690797066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVZBD26n61nILm1319d0FZlD/fP50Fwp7YtrZB2yUEw=;
        b=Zqvm8DQNUKPIAHwUdVtlgd5ff22B3xwK6eeLtKAoqiN71yW+P8FOqaiDLBFrN9V08D
         dr7QuVruEAcj91dIi3pD3eijh+fOfnE5JV+DrHVzosrj+jsoDpqHKzI2XtAITYkQ05nR
         9mTbE8ur+xz3wZjyDuckAtc2xim2FbQ2UQYPdV8+ws8n8WaoJuygamPn3YEiDzTgGJ7u
         eFKj+DBDUgkuqemsl4cKJbaz77zTNvjuzuqC5KiMcliHNlBLVKrJxlWGKbG1AW9xwgGU
         rSLza4MPE8ZwLIIcFg+0trcbGjukwxYMe/BWcRH8nE8sVxardXyLjlQpe2/G08VnJECv
         KLug==
X-Gm-Message-State: ABy/qLacwEKJdICtQxOphFyDcVeDWlemwAthJN2z2yTGk8LIoV17FuPJ
	OyeU6ofiyWKm56v/1zy0V9HjHQ==
X-Google-Smtp-Source: APBJJlFQ+sAFI6LIZ7PgU9puTnlNzbjLYXvmJ0kfMmGkS9XBnuUvcLZ7El1l1GYgUvVEvdh+XgkfrQ==
X-Received: by 2002:a17:902:e74d:b0:1bb:ac37:384b with SMTP id p13-20020a170902e74d00b001bbac37384bmr1242952plf.6.1690192266338;
        Mon, 24 Jul 2023 02:51:06 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:51:06 -0700 (PDT)
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
Subject: [PATCH v2 30/47] virtio_balloon: dynamically allocate the virtio-balloon shrinker
Date: Mon, 24 Jul 2023 17:43:37 +0800
Message-Id: <20230724094354.90817-31-zhengqi.arch@bytedance.com>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the virtio-balloon shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct virtio_balloon.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b15936a5214..d773860c3b18 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -111,7 +111,7 @@ struct virtio_balloon {
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
 
 	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 	/* OOM notifier to deflate on OOM - VIRTIO_BALLOON_F_DEFLATE_ON_OOM */
 	struct notifier_block oom_nb;
@@ -816,8 +816,7 @@ static unsigned long shrink_free_pages(struct virtio_balloon *vb,
 static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
 						  struct shrink_control *sc)
 {
-	struct virtio_balloon *vb = container_of(shrinker,
-					struct virtio_balloon, shrinker);
+	struct virtio_balloon *vb = shrinker->private_data;
 
 	return shrink_free_pages(vb, sc->nr_to_scan);
 }
@@ -825,8 +824,7 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
 static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
 						   struct shrink_control *sc)
 {
-	struct virtio_balloon *vb = container_of(shrinker,
-					struct virtio_balloon, shrinker);
+	struct virtio_balloon *vb = shrinker->private_data;
 
 	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
@@ -847,16 +845,23 @@ static int virtio_balloon_oom_notify(struct notifier_block *nb,
 
 static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)
 {
-	unregister_shrinker(&vb->shrinker);
+	shrinker_unregister(vb->shrinker);
 }
 
 static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 {
-	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
-	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
-	vb->shrinker.seeks = DEFAULT_SEEKS;
+	vb->shrinker = shrinker_alloc(0, "virtio-balloon");
+	if (!vb->shrinker)
+		return -ENOMEM;
 
-	return register_shrinker(&vb->shrinker, "virtio-balloon");
+	vb->shrinker->scan_objects = virtio_balloon_shrinker_scan;
+	vb->shrinker->count_objects = virtio_balloon_shrinker_count;
+	vb->shrinker->seeks = DEFAULT_SEEKS;
+	vb->shrinker->private_data = vb;
+
+	shrinker_register(vb->shrinker);
+
+	return 0;
 }
 
 static int virtballoon_probe(struct virtio_device *vdev)
-- 
2.30.2


