Return-Path: <netdev+bounces-20306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5475F023
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDA2814AC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9957466;
	Mon, 24 Jul 2023 09:48:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FA79F4
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:48:38 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B84B268F
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:48:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb85ed352bso2234825ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192074; x=1690796874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qReDjbjFz0xyiV7re04rgbBc1uubNDIxQ7QKRYWZSRs=;
        b=ENVLEGhvMjLiUvisyoHJontwb50xfTslV0XVCIZNbj3XxjFa+A4sTXO4Rw3QqFmux5
         XbznTWGuyuir8FMQeIa7tywzBJUnyvYSwuYJ02HBKdcTkSJdAtoOPw44n28eP8zUKucc
         q8yY+ysDs6yXU3SX/8XFuGMKyo+SMyS0Zlg4rwVloT2TyOVOz/Imh5E9tEAGm8xg8jyO
         QATQrcFlR17SUbjRuc1dqQxPY8algfDWOcvmKhvXGbaXm39iJYJiLthaOzWAxzJVeqgh
         fJOtvB6CBEjtg12DSwkb6lmHRDFIhGbGsjcgpxt8MGvrxNBdwtVQD4ot+/N3ASfLH/lS
         XEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192074; x=1690796874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qReDjbjFz0xyiV7re04rgbBc1uubNDIxQ7QKRYWZSRs=;
        b=a6WLgFrcnn0Xp74mpbzy80IIvi9TQ6a9pxr1s4eK/513AOMdBREgrThnbSBrEBRKBo
         U61F04iJK+XJ9cHJQTO4Rvp7EClfZFXe/jLKwjWaXpv9XrM549oGtP5CngvQofRkZfAL
         4mMYKhpnqNvegkMjSW3M18M+zR4UfGDFUGdCYKMQPheSutXXFCdVdtyh2rAbkfyBAcVe
         +/PklYSEtfQvq8ecQnfTK4Fbh1u3cpQpMOnDlOMu1RDX97qN5UFGDbuRWvOysRGW2k4f
         xh4xAyEeP+ayu6p12SBx7Z4lz7Gi0v5KBq8PjW5Cmi0Lcol+vhK55I7ClUl6TnAhTXMZ
         t60Q==
X-Gm-Message-State: ABy/qLZH/dG8YeRccWkn7YQY7Jpi1t56jph9LPasrIXORhrF5aiRll4j
	GA5mKq5JAc9IhuDjFVcUpme2Iw==
X-Google-Smtp-Source: APBJJlFmRr0YS7/80cQjb3Wv0/ryy4A2Bv0/hjBc48SsvJ3Rmt9/pUa2TTT24oRtgj6qJ02D1OEnuA==
X-Received: by 2002:a17:902:dacf:b0:1b8:9215:9163 with SMTP id q15-20020a170902dacf00b001b892159163mr12197474plx.6.1690192074491;
        Mon, 24 Jul 2023 02:47:54 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:47:54 -0700 (PDT)
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
Subject: [PATCH v2 14/47] nfsd: dynamically allocate the nfsd-filecache shrinker
Date: Mon, 24 Jul 2023 17:43:21 +0800
Message-Id: <20230724094354.90817-15-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the nfsd-filecache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/nfsd/filecache.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..50216768d408 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -521,11 +521,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	return ret;
 }
 
-static struct shrinker	nfsd_file_shrinker = {
-	.scan_objects = nfsd_file_lru_scan,
-	.count_objects = nfsd_file_lru_count,
-	.seeks = 1,
-};
+static struct shrinker *nfsd_file_shrinker;
 
 /**
  * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
@@ -746,12 +742,18 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-	ret = register_shrinker(&nfsd_file_shrinker, "nfsd-filecache");
-	if (ret) {
-		pr_err("nfsd: failed to register nfsd_file_shrinker: %d\n", ret);
+	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
+	if (!nfsd_file_shrinker) {
+		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
 		goto out_lru;
 	}
 
+	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
+	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
+	nfsd_file_shrinker->seeks = 1;
+
+	shrinker_register(nfsd_file_shrinker);
+
 	ret = lease_register_notifier(&nfsd_file_lease_notifier);
 	if (ret) {
 		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
@@ -774,7 +776,7 @@ nfsd_file_cache_init(void)
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 out_shrinker:
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_unregister(nfsd_file_shrinker);
 out_lru:
 	list_lru_destroy(&nfsd_file_lru);
 out_err:
@@ -891,7 +893,7 @@ nfsd_file_cache_shutdown(void)
 		return;
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_unregister(nfsd_file_shrinker);
 	/*
 	 * make sure all callers of nfsd_file_lru_cb are done before
 	 * calling nfsd_file_cache_purge
-- 
2.30.2


