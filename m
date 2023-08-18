Return-Path: <netdev+bounces-28670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A61780388
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58341C21573
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC90654;
	Fri, 18 Aug 2023 01:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC139C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 01:51:36 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B69100
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:51:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58ee4df08fbso5210167b3.3
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692323494; x=1692928294;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eygHBAahEoUzQmxXlbLdk6cONeRtusfU8hq6lvO0V3w=;
        b=qZGR4ewwTk7yqgF3Bx5sKDYh4g00iFHH6rqdDPvYK966+lSfH8c+lBHfpviRnRq2Nl
         tdCe/qc/jc+xbNc94oef3jxXDV3UyHNDFInX1YrKuKXTdWIYiII3tRbZksKgny9asO4L
         qLCzEES2XEGQJVtk+lnpxdf6zWYcTvSt3TPAlCaPFKbwXJE8nfCsbLhG/3oQC56V+Nml
         sMYL8t6P536ysl7H2PlMHsYDP6WrqeM+wbQyYuguCh9HebLO+BXxyGNGp4+C3pPhsi5u
         VyaA2AQT38yzUdXATGIXuwiFUKO4uwxLXVZfm1aclnujFFHbOKsn4KREEQTXR2YbpPdt
         0FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692323494; x=1692928294;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eygHBAahEoUzQmxXlbLdk6cONeRtusfU8hq6lvO0V3w=;
        b=gNTVtchJYneyoxP7zANsF7KBpLj5ncRRldsfKBKY3zItD4PX7FZAJEspRy6dvIKefI
         cVvGmLeZ6ILSEP/0lqFkIcE9HHoToh/nMwHYGCLXapIVwfvKBbIKB3AyZ0O9akvUbNYa
         FDtaukwmLu1DTdPdeytsODbzf593MQMMi3R7W5ip7AwJP5rQV58ACrkrBj2oWh5tXEuF
         dpCT6Ho/ZrSMluDv+R/lte5JB8PcDBKQfXCYaKnXhR2xkyVYnlVhQxsJnhWuFqsBZ3cF
         rE/+J6sCHuAYTh1jDJvsihNaSepZFkzWHUk9uN/Wk3PvmpqOsGyNYMK71/lDWA7EOdah
         DXXQ==
X-Gm-Message-State: AOJu0Yy9kWTFHQm3Wm+6j9X2VgN6dL3NG468LtFQULLKGFaCYS+eQ42j
	twT2zQ5IKXezlYp50lLw6xQ4B0rlL1SHxw==
X-Google-Smtp-Source: AGHT+IGQTWo4w+3aA31HlTA/opeBabetp//R2DQYPbs+eBlJTKG0yXda4FyvrOEnHuf5xpuVBgVuI+hDjHqIlA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2604:0:b0:d62:60e3:2387 with SMTP id
 m4-20020a252604000000b00d6260e32387mr16261ybm.1.1692323494575; Thu, 17 Aug
 2023 18:51:34 -0700 (PDT)
Date: Fri, 18 Aug 2023 01:51:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818015132.2699348-1-edumazet@google.com>
Subject: [PATCH net] sock: annotate data-races around prot->memory_pressure
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

*prot->memory_pressure is read/writen locklessly, we need
to add proper annotations.

A recent commit added a new race, it is time to audit all accesses.

Fixes: 2d0c88e84e48 ("sock: Fix misuse of sk_under_memory_pressure()")
Fixes: 4d93df0abd50 ("[SCTP]: Rewrite of sctp buffer management code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
 include/net/sock.h | 7 ++++---
 net/sctp/socket.c  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e3d987b2ef124024110a0c67c4c4775742d3eb2d..690e22139543fb6eaf3ccd08475d2c6934231dbf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1323,6 +1323,7 @@ struct proto {
 	/*
 	 * Pressure flag: try to collapse.
 	 * Technical note: it is used by multiple contexts non atomically.
+	 * Make sure to use READ_ONCE()/WRITE_ONCE() for all reads/writes.
 	 * All the __sk_mem_schedule() is of this nature: accounting
 	 * is strict, actions are advisory and have some latency.
 	 */
@@ -1423,7 +1424,7 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 static inline bool sk_under_global_memory_pressure(const struct sock *sk)
 {
 	return sk->sk_prot->memory_pressure &&
-		!!*sk->sk_prot->memory_pressure;
+		!!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline bool sk_under_memory_pressure(const struct sock *sk)
@@ -1435,7 +1436,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline long
@@ -1512,7 +1513,7 @@ proto_memory_pressure(struct proto *prot)
 {
 	if (!prot->memory_pressure)
 		return false;
-	return !!*prot->memory_pressure;
+	return !!READ_ONCE(*prot->memory_pressure);
 }
 
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 9388d98aebc033f195e56d5295fd998996d41f7e..6da738f60f4b534d12245455c39bf4db18d8cb5a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -99,7 +99,7 @@ struct percpu_counter sctp_sockets_allocated;
 
 static void sctp_enter_memory_pressure(struct sock *sk)
 {
-	sctp_memory_pressure = 1;
+	WRITE_ONCE(sctp_memory_pressure, 1);
 }
 
 
-- 
2.42.0.rc1.204.g551eb34607-goog


