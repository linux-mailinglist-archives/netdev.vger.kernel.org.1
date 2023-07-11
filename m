Return-Path: <netdev+bounces-16683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF974E545
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 05:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ECF28160F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 03:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8CD3D7B;
	Tue, 11 Jul 2023 03:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AD3C28
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:25:33 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F283EC0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:25:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66872dbc2efso1379429b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689045931; x=1689650731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTPICtZv0ey6kXaVeAxcQKq3vO1QN6CzNYrpdY3BizQ=;
        b=TPMULHxXWeZsxKUOsrkhb81Wg5kYvZQfwbx9vby5fn6GOu1JcP2YwoC+D/pk7bwBaa
         e2xD7O5dvEeuJnFhPdnHAVpv6LA3x/iV8fQDSfmwuUSHwi2otZGULt3BFaCLYdiheamM
         GpFwQP7+lv168wXoljF41uOHNsZsJdEX7UH9eVILjZIWipLrubZthzx4YWnB10CMkiwn
         F4Jtyt9RQLvWNkLVCg5kk0+nlkBqCXtck8dF6mp0Tbo4zMWRX2qQn5nq2lfxQVm8CaR+
         b14KLP4n4H/PzkkpWGstvCRKN/6RRBFTw6Fw6TDXsh+8TBQcsnsfqaJ4PLcEPjVAHPsf
         z0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045931; x=1689650731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTPICtZv0ey6kXaVeAxcQKq3vO1QN6CzNYrpdY3BizQ=;
        b=W2zTzPa/FscZb4vfDChP2sjn9WnnGfRYZK7MCZ6lvccPiW78Nuz+A1zOmvXnqgD+WS
         BjauVq/wWslwTRVbV+qT8fTrM7oskofxZ05pYATneIULncsr32foIKJBzsMoNlOEfTdB
         zYZy/5iCTpUTLbvlD/LuH6bG2m+o7nIOWUNkIkjUoBMqbfUAmKRsF3S60Xs9n/vRrxNt
         JnxOJsHKqHFoJ7dyK7xL3LX/l6kh7QFGt1p6lMUwKzJqQRdq9z90V5gOeF/8HfFR4MMR
         hUextCDb7IM79v3+6ciFkc1SF3Let4xaAVBkHBv7x63f+pN1Vn0p1QWVPEnIaXf9Ea13
         FhfA==
X-Gm-Message-State: ABy/qLaUzerHncNL34QoOkFNBbxqt72NcytParosZLyV0o0p1S3bAPHI
	qslosOBYrgfFBActjcZCiUQb8uN+s3oo4w==
X-Google-Smtp-Source: APBJJlHf3bMFh+8WeO2GieI+Pb1L27Cf6i/f3ljprdmuaUVS3RsLEYaWDeRkDIMVROPxtIAVZ3Av4A==
X-Received: by 2002:a17:902:da92:b0:1b3:d8ac:8db3 with SMTP id j18-20020a170902da9200b001b3d8ac8db3mr18054611plx.6.1689045931267;
        Mon, 10 Jul 2023 20:25:31 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902b68200b001b9be3b94e5sm610379pls.303.2023.07.10.20.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 20:25:30 -0700 (PDT)
From: Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To: edumazet@google.com,
	davem@davemloft.net
Cc: Jian Wen <wenjian1@xiaomi.com>,
	netdev@vger.kernel.org,
	wenjianhn@gmail.com
Subject: [PATCH v2 net-next] tcp: add a scheduling point in established_get_first()
Date: Tue, 11 Jul 2023 11:24:05 +0800
Message-Id: <20230711032405.3253025-1-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630071827.2078604-1-wenjian1@xiaomi.com>
References: <20230630071827.2078604-1-wenjian1@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kubernetes[1] is going to stick with /proc/net/tcp for a while.

This commit reduces the scheduling latency introduced by
established_get_first(), similar to commit acffb584cda7 ("net: diag:
add a scheduling point in inet_diag_dump_icsk()").

In our environment, the scheduling latency affects the performance of
latency-sensitive services like Redis.

Changes in V2 :
 - call cond_resched() before checking if a bucket is empty as
   suggested by Eric Dumazet
 - removed the delay of synchronize_net() from the commit message

[1] https://github.com/google/cadvisor/blob/v0.47.2/container/libcontainer/handler.go#L130

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 net/ipv4/tcp_ipv4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd365de4d5ff..cecd5a135e64 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -57,6 +57,7 @@
 #include <linux/init.h>
 #include <linux/times.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 
 #include <net/net_namespace.h>
 #include <net/icmp.h>
@@ -2446,6 +2447,8 @@ static void *established_get_first(struct seq_file *seq)
 		struct hlist_nulls_node *node;
 		spinlock_t *lock = inet_ehash_lockp(hinfo, st->bucket);
 
+		cond_resched();
+
 		/* Lockless fast path for the common case of empty buckets */
 		if (empty_bucket(hinfo, st))
 			continue;
-- 
2.25.1


