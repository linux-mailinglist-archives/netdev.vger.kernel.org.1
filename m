Return-Path: <netdev+bounces-35650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4687AA75E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DD6611C2096F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7271844;
	Fri, 22 Sep 2023 03:42:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C117E3
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:31 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF27E8
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c4ec85ea9so23526127b3.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354150; x=1695958950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAXfaDq5o/U4CNkRJJ9vfHLNSgkjhaG3ePlNPBwX+Zc=;
        b=CyXDIPrjDPais0uJYZIabKZw140eWv1DC6J1CKZ0QchslFzo3kqn88gJCGk1K1rzRA
         WhDOV1YPCxhOz7hUNWcG7OKXIMW6LaibHbdzC7BwoPVt9F+cGPULFjX370SYB3N3n6nQ
         yeYM5gcB1SrnNuhUtKNRT9X6ZrqMIkMd4nGLShKP9gTpymsKyupQo4eVuwO7274VUy/e
         1Xqlp+NuBUxtuHqi8k0Y+Atpp6Kwjd/ZrXJhLDR0i+39t/hqWa+R7iFdc0tZ1pMzjGkR
         nHmSQXHgmOqEsdQJLwuz01qdIaDlauarhzaJj7ucrmmjOyEOiObQjE4h8/myQNUQH7Uz
         GA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354150; x=1695958950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAXfaDq5o/U4CNkRJJ9vfHLNSgkjhaG3ePlNPBwX+Zc=;
        b=Vqt+f8ttCls6Lc0CGjI8MZNtV/wZoUTjHIOblDvUHknYFscHVIqo4j9Ds7NGuYJy4b
         xzCNAOTvaZG8Z206VIGU/NYPi7zzEgjd4btpMFDrln0A3ijt0f8YCplPLZ6fSHrWaAvQ
         TVxhSICL1rpVV1X6qbeUCKBVn8PjqNomgGg9lIsGlQuzkEKMOehxgYA+zLzghQucprQ5
         QYWVQP7vRz4umxeNSsC/wX+FZxp6avOQJPwBPnjidl2kQRSRx/LOuzMta3KjdJNLiu3w
         /DeUUdIozka6aHM+Pvi5735hrMilsINWJl5iRJlQnFv7sTc/R4b0spBKfTqgBIQdZ8X9
         HykA==
X-Gm-Message-State: AOJu0YyFPSSO1GQ2Vl0MrRoINi7/XLOb+QWZDHqtVKoCXyyFAuEiVsqh
	f8+NZMb9sHAw3Ko410z2V5D5RyQI1+C3RQ==
X-Google-Smtp-Source: AGHT+IHxVhCcWE7LDM/Lsrw5TGyKrzYfGzh6LY1G9ocXyBovGcD3Np2GwqMTLqlZEhQ4W4KaTfhSxPBzGCoMTA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:c549:0:b0:59b:edd3:fdab with SMTP id
 o9-20020a81c549000000b0059bedd3fdabmr97970ywj.4.1695354149896; Thu, 21 Sep
 2023 20:42:29 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:17 +0000
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/8] inet: lockless getsockopt(IP_OPTIONS)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

inet->inet_opt being RCU protected, we can use RCU instead
of locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/ip_sockglue.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 50c008efbb6de7303621dd30b178c90cb3f5a2fc..45d89487914a12061f05c192004ad79f0abbf756 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1591,27 +1591,20 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:
 		val = READ_ONCE(inet->tos);
 		goto copyval;
-	}
-
-	if (needs_rtnl)
-		rtnl_lock();
-	sockopt_lock_sock(sk);
-
-	switch (optname) {
 	case IP_OPTIONS:
 	{
 		unsigned char optbuf[sizeof(struct ip_options)+40];
 		struct ip_options *opt = (struct ip_options *)optbuf;
 		struct ip_options_rcu *inet_opt;
 
-		inet_opt = rcu_dereference_protected(inet->inet_opt,
-						     lockdep_sock_is_held(sk));
+		rcu_read_lock();
+		inet_opt = rcu_dereference(inet->inet_opt);
 		opt->optlen = 0;
 		if (inet_opt)
 			memcpy(optbuf, &inet_opt->opt,
 			       sizeof(struct ip_options) +
 			       inet_opt->opt.optlen);
-		sockopt_release_sock(sk);
+		rcu_read_unlock();
 
 		if (opt->optlen == 0) {
 			len = 0;
@@ -1627,6 +1620,13 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -EFAULT;
 		return 0;
 	}
+	}
+
+	if (needs_rtnl)
+		rtnl_lock();
+	sockopt_lock_sock(sk);
+
+	switch (optname) {
 	case IP_MTU:
 	{
 		struct dst_entry *dst;
-- 
2.42.0.515.g380fc7ccd1-goog


