Return-Path: <netdev+bounces-12322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB40737175
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A8A281322
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FF17FF6;
	Tue, 20 Jun 2023 16:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8A17AB3
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:25:01 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562D170C
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:24:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f86dbce369so3690013e87.0
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278296; x=1689870296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3a0+HPdXBokM88wtbe02geibk8kOEolLxUIWRz8mL0=;
        b=Sy4vUS7Z/Aqo2IuZdtlW7MxkfOU7ZkGZYKKfkrwXjRFz3ZY4nXHLxaYsTVju6b2NRf
         uSDcqKf3zvlW34g21b1Gnfxwnf+K+PO15NEGT3gSRhO9NV5BqbhwsCVelaXpFu1HlQCN
         n4lUwT6mOZ70Qlp7MtLsVEQhHqzXvZd6htEaHHS0xFWo86UHuzklTr7Fm3GbHZjgExS7
         YLQPGZ73cPTQ8SveKiDcAZ7ae0/r5EE3Q41guJjJgE1BFGsEQoZmt/qjI44XqJzgH5tS
         +kTzqzY7oOjTD0Y+xoL33yU2mgZdZYtshd9N0UYguC+7N60jckmZr+n9W5RaK2wiSGPs
         kItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278296; x=1689870296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3a0+HPdXBokM88wtbe02geibk8kOEolLxUIWRz8mL0=;
        b=PGae7M+iDwj4gnSgn5aqZiLErFr44wBmZJhaKcsY6kUGFbkmOZmWHHThj6OQGf4ylm
         HXMyYycrvU0mCKCgDQzQxpMkUj/dX0bOF0O9gkq+tpQwBmy93MwoScU+tNeyeoqKAnEH
         L2khsvd5/RjSztBJKT68AHq3o1Blh8U67NoSBX2gglpTWxnqM6B8YC0H6AyIeublYYRW
         awHA+RryfQrRe5RZg1BRa2IEf8l6deQY9k3pzGQWaoZZMjnu52ayvC2Hy8qt9LF57Hu+
         ZDI5ztGFQsC3cVQcyzK1tUOh7XZ2cHAfLuIxF/2NUBx/f9upSM3PX4qU2G1nCEaqLWaI
         z1ZQ==
X-Gm-Message-State: AC+VfDw8fW6/U/2+V6S0GY0KMAPGby2U8fyIBfYYwldvHnNOtnhUxSdo
	lbYGdDT+/XlqE7Qp2sBpJQ84gYZcrlGCFAR0SqSvxg==
X-Google-Smtp-Source: ACHHUZ4dlmoO/fvoHNyPLLlgLGv/fyp1+OB9CAxaUNenQ+qZOPbh7Gc8XZsn2k7KeuatyWL0ABCCUg==
X-Received: by 2002:ac2:5041:0:b0:4f8:45aa:f848 with SMTP id a1-20020ac25041000000b004f845aaf848mr7921486lfm.25.1687278296047;
        Tue, 20 Jun 2023 09:24:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:55 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 20 Jun 2023 18:24:20 +0200
Subject: [PATCH net 3/6] mptcp: fix possible list corruption on passive MPJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-3-f36aa5eae8b9@tessares.net>
References: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
In-Reply-To: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=F1v/IAl8pf9wJXckMVZE8kEUbcCuPEXAOGNwGHK55p0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLUMiBdtNeCwtyqqS1KCTT1CYhzIQcRKEaNR
 i8iolq5kK6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS1AAKCRD2t4JPQmmg
 c31gD/4yKyrmDx/4ZXjeFIDFZpVBLmZ/yrKZRGGII9nc1aaA2m8eXbMEuhEKwwEKCFTT2/3wwMw
 T9AlXiQ7EcRrxAo7+qlfmH8Bj209+H8ga1WZ69akqveR/qW6A3XRJPgTNXCu/1a8eiy+otmHwlx
 NvKttCmv0SGhD5hyoVigTXpfNzSlT2SyoIemcnK/oz05j5/dQZHUegYbbH7UTDIvevTXdRcjOMt
 tEkIPb7WLeve/PwRrehJlysklcHfR1v9RXXiGbZa8070cH4K2PingDnLyEad4x4xHNQEvefK8th
 xtZ+hfLWJHf4cZtW59OqmapxQo7yHD6lno/t0wWxIOaoVzR36BuSSnUSKupj+e9nYUBStWWy8g8
 e18zqfKKbErCugDPA2A1Bt07qLfUXWGIy7+fWNdrZ/IJEOfckJoDcfpp8luuwCq9h3eMyhnlYR1
 7CSG2a5y3P3N4w3qN04WQR+Ki2otZaSVxofTP6KuRJaYPqXKwkmI26GipznMQyUDjwFFtFWSaAs
 LrTUx+ge6KEprAWNkxx0zrZhPLg192g7jsjz5ko/c37r34Y/bJiZVqp4bAmuAFb7wVehb12JEJc
 BzEfdvEmQuzeMKSG+KI2nrhfKy8Hj5ztPggkhVI87ENmY+iYUoK9HAKK8hoQ5OjL/1/kpy+9R7F
 WwqHaVm44Geo3Qg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

At passive MPJ time, if the msk socket lock is held by the user,
the new subflow is appended to the msk->join_list under the msk
data lock.

In mptcp_release_cb()/__mptcp_flush_join_list(), the subflows in
that list are moved from the join_list into the conn_list under the
msk socket lock.

Append and removal could race, possibly corrupting such list.
Address the issue splicing the join list into a temporary one while
still under the msk data lock.

Found by code inspection, the race itself should be almost impossible
to trigger in practice.

Fixes: 3e5014909b56 ("mptcp: cleanup MPJ subflow list handling")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ee357700b27b..9a40dae31cec 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -850,12 +850,12 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	return true;
 }
 
-static void __mptcp_flush_join_list(struct sock *sk)
+static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list)
 {
 	struct mptcp_subflow_context *tmp, *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	list_for_each_entry_safe(subflow, tmp, &msk->join_list, node) {
+	list_for_each_entry_safe(subflow, tmp, join_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
@@ -3342,9 +3342,14 @@ static void mptcp_release_cb(struct sock *sk)
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED) |
 				      msk->push_pending;
+		struct list_head join_list;
+
 		if (!flags)
 			break;
 
+		INIT_LIST_HEAD(&join_list);
+		list_splice_init(&msk->join_list, &join_list);
+
 		/* the following actions acquire the subflow socket lock
 		 *
 		 * 1) can't be invoked in atomic scope
@@ -3355,8 +3360,9 @@ static void mptcp_release_cb(struct sock *sk)
 		msk->push_pending = 0;
 		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
+
 		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
-			__mptcp_flush_join_list(sk);
+			__mptcp_flush_join_list(sk, &join_list);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))

-- 
2.40.1


