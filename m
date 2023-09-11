Return-Path: <netdev+bounces-32786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4B179A6E2
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187461C2094B
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A2C131;
	Mon, 11 Sep 2023 09:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2138F47
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:47:52 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE87E4A
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:47:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c3aa44c0faso1784705ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425670; x=1695030470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+dyOdEpvdrL2eUxAXXyGxIB/NcoZnEV+TKBfmBMmgQ=;
        b=fPaC9EAUYalffszD3hRRgazLNMEK9qm4ndUZC6m65bAdOtNemq0DISEDKQnkDoLF63
         2VnYneZGKHtMaWTF4GywyKohNXZkwEehmSPYhN7wnwJBkf+QEtT/syKn7AHVbDea/z5w
         YsjsqlHEoTm442ae6vU9iirPQFH5h9TmOSN3xWQxUPsuupD8/q0wek/7/bVGJGkVHlls
         Od9ws817GuViLEFSzgSc/NTphiXMk3zdIcSpf48tUyw3hYdkGstq+srxvWh6LxJuO54w
         VGz89I3HZfLpm47+TffPhew9jYk4YyyU7gBM4Ej0VllMBtXU4353yQ7qjEm/g19ZEMG3
         vL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425670; x=1695030470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+dyOdEpvdrL2eUxAXXyGxIB/NcoZnEV+TKBfmBMmgQ=;
        b=bqN4DnwdHe80uSsqpvHU1gf9eg3ke8pUwOXkWf80DI2RGS+tOH1mS1kI43NM5XKwWO
         em3qVOek0LKDp3BR2YbPQwahqAjRUF4ZCLun4rUf5FF1sNYJJbDYV1ZlUk74NMygss53
         4gVj1/W9feC/bGscpPrubwCVsaVhc8ifZ21/+es5BpviMh8go6LGCgz51APqGQ/BA4fz
         vSF9tC2BPlxkOcaj3fp/Iv7lk9ehb7D5CUpw88cP3VGC9ciBTFXOiRuloV1WQFI09UZy
         tG1zcPpnL61eFy48cjmZe6nIoqsNA7k3nF7wZLHB45EF1UD9F2Jj0riLKnefhGQY2RjM
         vRNw==
X-Gm-Message-State: AOJu0YwFkeaTtXAtPA8LUl9lLvmKx1g+HC244KnXGgf/kmMm8qQtpdMd
	5IVvJGmo0njj92wBBWt34Tv7Iw==
X-Google-Smtp-Source: AGHT+IFJHaBKDBa9FsHXtzux2UkvFgC3UTp4BhhdsEjv8fCLAr/6/KNue5g8DvDfgdf99+Ek70M0DA==
X-Received: by 2002:a17:902:ec8b:b0:1c0:cbaf:6939 with SMTP id x11-20020a170902ec8b00b001c0cbaf6939mr11608160plg.3.1694425670620;
        Mon, 11 Sep 2023 02:47:50 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:47:50 -0700 (PDT)
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
Subject: [PATCH v6 18/45] sunrpc: dynamically allocate the sunrpc_cred shrinker
Date: Mon, 11 Sep 2023 17:44:17 +0800
Message-Id: <20230911094444.68966-19-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
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
 net/sunrpc/auth.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..c9c270eececc 100644
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
@@ -874,9 +870,17 @@ int __init rpcauth_init_module(void)
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
+
+	shrinker_register(rpc_cred_shrinker);
+
 	return 0;
 out2:
 	rpc_destroy_authunix();
@@ -887,5 +891,5 @@ int __init rpcauth_init_module(void)
 void rpcauth_remove_module(void)
 {
 	rpc_destroy_authunix();
-	unregister_shrinker(&rpc_cred_shrinker);
+	shrinker_free(rpc_cred_shrinker);
 }
-- 
2.30.2


