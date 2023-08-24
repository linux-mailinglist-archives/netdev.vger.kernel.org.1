Return-Path: <netdev+bounces-30207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B2C78660D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 05:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541791C20DB5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 03:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5CE2452B;
	Thu, 24 Aug 2023 03:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90024528
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 03:46:50 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A7F10F9
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:46:28 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a8586813cfso655554b6e.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848786; x=1693453586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqY1sW48iQ+/RBGCoAIbrC2fRJNneg9gualmoKm4Jhk=;
        b=N0bEBg41B2iY9D35KYwN2/tcoHlZC6rvdfxQ8MjWAAVsJrbSe5QQ1AloOksBp+VCG5
         ovzTjRjVhwYuCbijaYbBr/NoEX2DBF86HPD3n/LRoilc3AMqFdIYMudsb9GeM0FF8+WD
         vfzr6oFXwaOrFRMP37o0w+E2VaPjRYmk8vIEBd08PbPCV3/5qCp0ZssMbZGvzPANUGFF
         l6D1M4RhmrFVV9Agr9KolhbMLgXrKCLvdCdLgkrxKJwEQ6ETcv90MZzzfe8Jv4mnChvc
         gVqnqZEKx20VOlCNLIRQDT+wJCga0Y5MKoKyPRqMPQvG3t3uAT+WeS34pYjowcn6IWJ/
         hSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848786; x=1693453586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqY1sW48iQ+/RBGCoAIbrC2fRJNneg9gualmoKm4Jhk=;
        b=QJlnG8Uiyln/NTqXmC1w5jJXP643SNARowTVccRiFXIfOefgMawibLL8jIbdhlwUoE
         ULwlehJS4wRc5nxMCW63bHttUGcVtYwanJMoKZt4XPICTkEf/n/pQLsUc3taDWASb7np
         aFfboVJujf1nMQlvKd6GN57LyTsqdG5aGO25b3xFOfsQYyowlr1rdqHnFLglKF/Cu5Ud
         a6fDP0uX8bZaaGkWDdQmLRfDoJ+KSR6YJJ+nrluvC7nEwNG0X1nuB5C9ecdl0L0ixSAB
         Cn6A46LpqLRVF3tF22UlzKXCcKfC5uqLVyNHFAxc5KdHb8vvuwkTs6lqG++AWkoTCYAe
         GJkg==
X-Gm-Message-State: AOJu0YyMxnwPq6/OFUH0Wharo3ZqZasFCM55VSZZ9I3rJLpdvXkCIx1v
	CzeqkwTnOGs4yFuXfu/rKjQCEA==
X-Google-Smtp-Source: AGHT+IFDAy5Zu8VOU9YTeKJefKe6vLUB7EXbKU3yEeM/VZ53vwtmd2t8ca1mHqoiwq14ODWnet2Fmw==
X-Received: by 2002:a05:6808:180a:b0:3a7:8e1b:9d4f with SMTP id bh10-20020a056808180a00b003a78e1b9d4fmr16975412oib.3.1692848786259;
        Wed, 23 Aug 2023 20:46:26 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:46:25 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 18/45] sunrpc: dynamically allocate the sunrpc_cred shrinker
Date: Thu, 24 Aug 2023 11:42:37 +0800
Message-Id: <20230824034304.37411-19-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use new APIs to dynamically allocate the sunrpc_cred shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
CC: linux-nfs@vger.kernel.org
CC: netdev@vger.kernel.org
---
 net/sunrpc/auth.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..0cc52e39f859 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -861,11 +861,7 @@ rpcauth_uptodatecred(struct rpc_task *task)
 		test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0;
 }
 
-static struct shrinker rpc_cred_shrinker = {
-	.count_objects = rpcauth_cache_shrink_count,
-	.scan_objects = rpcauth_cache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *rpc_cred_shrinker;
 
 int __init rpcauth_init_module(void)
 {
@@ -874,9 +870,18 @@ int __init rpcauth_init_module(void)
 	err = rpc_init_authunix();
 	if (err < 0)
 		goto out1;
-	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
-	if (err < 0)
+	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
+	if (!rpc_cred_shrinker) {
+		err = -ENOMEM;
 		goto out2;
+	}
+
+	rpc_cred_shrinker->count_objects = rpcauth_cache_shrink_count;
+	rpc_cred_shrinker->scan_objects = rpcauth_cache_shrink_scan;
+	rpc_cred_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(rpc_cred_shrinker);
+
 	return 0;
 out2:
 	rpc_destroy_authunix();
@@ -887,5 +892,5 @@ int __init rpcauth_init_module(void)
 void rpcauth_remove_module(void)
 {
 	rpc_destroy_authunix();
-	unregister_shrinker(&rpc_cred_shrinker);
+	shrinker_free(rpc_cred_shrinker);
 }
-- 
2.30.2


