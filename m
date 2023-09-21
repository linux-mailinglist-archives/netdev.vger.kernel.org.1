Return-Path: <netdev+bounces-35631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9967AA5C6
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 01:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B6CDE283233
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 23:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C429422;
	Thu, 21 Sep 2023 23:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124202032D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 23:46:51 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38889F4
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:46:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d859ac9ea15so2268505276.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695340009; x=1695944809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2po5KMytqzs1aZq0Zn6CcoUcUJMoRpPcm+1a082rpbc=;
        b=L/6izN30+9ujTWwjQIFXlwmlA7h/L0AL6UFtjg7BJce1bZdjmHUNukVhKwiZNjRHEi
         5iMln9MYk6EvHYhcgPzCG6/HLF7yWV4VMcxFQjGO0I/IiSPs7nn6ujx0K5BCh04zjPIA
         eWuVNXd4QAxO6L5WD08O9Kphin5YSrbNOX2bULH0Ha80ra2a35JFOHlSG9MeGu+bbUsX
         h1Ck5Nv4mnjgfe+L4mBbQLABSlkzj4TV6D1noyjoY/Tya6QSJz7GyaufkhcjoWNpX4vn
         Qn4Lz8YHJ/f+cwJFcgdy3/N91uV9iCYr9oao2p64fvgMMwXKLNUCjkSqjEUNK4slcL+r
         Hr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340009; x=1695944809;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2po5KMytqzs1aZq0Zn6CcoUcUJMoRpPcm+1a082rpbc=;
        b=Uc3R+wwgxsCWWiiPBlJ3VFgJYkjJ8NuwTHhi1BV23WZ+gnkyA6GakJ0vU6RAa+NACM
         CYEoVj6BsCa7i1mEtUSvSNE/9S2NcxEvUgtd+7pO9bzaiwIp7c8y3EmdtKJp5Je0ZUOy
         asVUsS89ZAOiSAPtAFbW1JBVM2fvyPmMgaykBbUaN2E3A63y7JUaki7zjmSS0VS/o59z
         41KfyXipkA+0EK15IdC9GnExSqcb8Q36IpLd7+FqfI/U3Pw0Mgvt8jReGBfiEAxX8UQF
         p9lI8rKhV8Txor8An/IhhUDELX/yAJ2KQUyKpZ53UURnVXtc2aJDBxGzdUEKz+vwsj9N
         eV8w==
X-Gm-Message-State: AOJu0Yy4W9TImac8jSF78qX3s2v42Hq6qDDfA2AEE2irgy92sI1GZb20
	+rZiIbyPgSpEtmy4opZyKwenjxir0w==
X-Google-Smtp-Source: AGHT+IF1RdaT9gzc+LmBDDlflKDiJNFtWmEg1sp6goIT3q1y18gaTPqpGUvLDbhLN4VUn9B+GeHsxh/Kzw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:100c:b0:d40:932e:f7b1 with SMTP id
 w12-20020a056902100c00b00d40932ef7b1mr117253ybt.7.1695340009466; Thu, 21 Sep
 2023 16:46:49 -0700 (PDT)
Date: Thu, 21 Sep 2023 18:46:40 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921234642.1111903-1-jrife@google.com>
Subject: [PATCH net v5 1/3] net: replace calls to sock->ops->connect() with kernel_connect()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, horms@verge.net.au, pablo@netfilter.org, 
	kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com, 
	ast@kernel.org, rdna@fb.com, Jordan Rife <jrife@google.com>, stable@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
ensured that kernel_connect() will not overwrite the address parameter
in cases where BPF connect hooks perform an address rewrite. This change
replaces direct calls to sock->ops->connect() in net with kernel_connect()
to make these call safe.

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
v4->v5: Remove non-net changes.
v3->v4: Remove precondition check for addrlen.
v2->v3: Add "Fixes" tag. Check for positivity in addrlen sanity check.
v1->v2: Split up original patch into patch series. Insulate calls with
        kernel_connect() instead of pushing address copy deeper into
        sock->ops->connect().

 net/netfilter/ipvs/ip_vs_sync.c | 4 ++--
 net/rds/tcp_connect.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index da5af28ff57b5..6e4ed1e11a3b7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1505,8 +1505,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = sock->ops->connect(sock, (struct sockaddr *) &mcast_addr,
-				    salen, 0);
+	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
 		goto error;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index f0c477c5d1db4..d788c6d28986f 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -173,7 +173,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
-- 
2.42.0.515.g380fc7ccd1-goog


