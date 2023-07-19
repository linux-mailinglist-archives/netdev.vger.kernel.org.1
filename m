Return-Path: <netdev+bounces-19253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FB75A098
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBD11C2111F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB63263A5;
	Wed, 19 Jul 2023 21:29:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BE22EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:18 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997131FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57a3620f8c0so1506597b3.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802157; x=1690406957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PaMw4lLmDE5ptC37NZHqgKzfleydxGcAvK4wjoKKyoo=;
        b=wJYogLUCSE/zfclTdicoPGCW9K3lRD75sdjMDfoC/UThBWigGgidbwxj9WVYd/xcI1
         PxwR78U/rOk8jdImfWYJF5s4lTvBjfpa9a+fU35G1pNNx2geO36CPtsd7LW9RXa6MZY7
         oaUKH5glYlPJjsios/TyrxD5BptSquLYg0+cFqJtatDBi1rT5480IUgWYYr4RKt6GVGU
         oMDsQutSou6f5MpTj2IUe1+aLf5PzRUjV+pwS/zZiLQzvsOtA6nAO6n6yR76FxFfoScw
         k4uEZKldhHt9SWoIb6k+dcFCTXc0MnDBeGh+XzQF8K3DoKGc4NS3H78aDl1Y4aK0MVnl
         OWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802157; x=1690406957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaMw4lLmDE5ptC37NZHqgKzfleydxGcAvK4wjoKKyoo=;
        b=gtZJ3UsEqIZNFVm65AXNCK1CKAVpHqWeVFIGaKxBJVnw5EQuvzlWLBocI82r2yyC79
         JccgofkJLVkkBUPmL5eJCehs8hEeSUWOn7hNozkZGYQ/MGptHYQIwWTkjU+G7Dd8zGUq
         T/qQcV7DLn15/CPWnYY/S+J/ZbETbVsC7RJ4/KA3DNrzQ9ANv60p/PKpDuA9tjJHrL50
         zO7LG4X0tWwqS5tVTsjn/eWodkc9vMumz+gNPb6aRIHa3w0U+Mz6TFCW72Kt3GOyh0BZ
         m6/WzSATQovieoFdlj7jrmaVzGljw+0YF6Y/usqSAnjPZVGsevRaIpfGzFgQo6fHROlD
         k1Xg==
X-Gm-Message-State: ABy/qLa7dpOlolt1L4RT2KbJSz9sW+mHe6Ho2RKOMVWwYLTY3NxVUdeX
	uZrqkLBhLQ4fEwMBN+w+Bs1RcTYqMWljBA==
X-Google-Smtp-Source: APBJJlFeIaMtwSlGm3txh5eN7NIfEpBDsiJNbnTrC4Rs6XsMWJCR1TZ4OXSrT/C2d/UQTZEis3GVKzhexqdOtg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:69ce:0:b0:ce9:97c6:6e45 with SMTP id
 e197-20020a2569ce000000b00ce997c66e45mr32752ybc.4.1689802156935; Wed, 19 Jul
 2023 14:29:16 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:53 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-8-edumazet@google.com>
Subject: [PATCH net 07/11] tcp: annotate data-races around tp->linger2
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

do_tcp_getsockopt() reads tp->linger2 while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9f74ac16f1c1e53353bd14c6a04e1fa9e3de0c15..2cf129a0c00bfef813e1f1e12cb247ef8107fa88 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3585,11 +3585,11 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_LINGER2:
 		if (val < 0)
-			tp->linger2 = -1;
+			WRITE_ONCE(tp->linger2, -1);
 		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
-			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
 		else
-			tp->linger2 = val * HZ;
+			WRITE_ONCE(tp->linger2, val * HZ);
 		break;
 
 	case TCP_DEFER_ACCEPT:
@@ -3997,7 +3997,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		break;
 	case TCP_LINGER2:
-		val = tp->linger2;
+		val = READ_ONCE(tp->linger2);
 		if (val >= 0)
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
-- 
2.41.0.255.g8b1d071c50-goog


