Return-Path: <netdev+bounces-42595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85D77CF7D4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87415B20F2C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2C1DFDB;
	Thu, 19 Oct 2023 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bbQ5Rrbx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE68156F3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:00:48 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C4CF
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf55a81eeaso55791695ad.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697716846; x=1698321646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1m9BRSdkNRQ5Yt+ICOw8D17wxDsW5CRYVDGGwLbORQ=;
        b=bbQ5RrbxNDWIPvEhnImaGP7g1m1qLa4QiJU8cEt5/7mEvKzmiHZbKbZkh1haueDNRj
         XDjxfHZZbNZkoZhT1RBlP63eexVbqlzYMXkcI86yiNtovwx1uNgDZ34eL9fJWTv00YK1
         vJwuBiXoYA2a4AUz9LrvAWHfZRe81cu9ZLdud7Cfl0P+QhT6eDAcsUT6rdXAuU9IRd6i
         o95s5mLYVidS0A67ITr1VM9tHxI601kzx5uRDwHKoyh+zLpbIl2WDaNjtTmJ0XKQ2GgN
         Pj+0XPZkuprOq7Lwx6IDLTkOjnji48C2qHkyXWkPgbsx13SZOMy9rhVSM9QoWlvvO6D7
         U9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716846; x=1698321646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1m9BRSdkNRQ5Yt+ICOw8D17wxDsW5CRYVDGGwLbORQ=;
        b=SUrPSEGJGafK6YzoCw7I+1WHrFcQjKpwtyZGH8HUYTbNB9dFUTvbyU7iUMsULZpk9Y
         2daL6s/1LEoexiiwFwSRjIplxXzuBm6YoZJWIJDHir9/xwD85B3rLr4DvFqa3UxHXAUP
         TgkpqN68hP7+Wzn5e7WmV70ADaW8Xxb5cTliOSMpm5thqbgUP14nenHf5gjLtjT0O4/b
         UK8Vp4jTPC5RPtGDpdZ93tKVj+jMpRDMCgehMPs/6pHGZlEE4YWrwXwTeP4rysN89qV+
         QCI2+xgNt0qwXvZGOj/Y8OcE/oTUG4Qm1qx/RYbG6IexaUPnjuDjkSFqmIJKizr81jm6
         kGYA==
X-Gm-Message-State: AOJu0YyoAG+uNzkx1y1SjD50r9Z2UNmVM6iLFkSML8msLHZb/Q/srE9N
	ZgSNRDPMiQulelfz74Nkhx7JUQ==
X-Google-Smtp-Source: AGHT+IFCZDxTxqQcz7j1OJ6WLgnP+lN3GXgA5ClkO+DuonBeR+up4aYygLHSL+ZPHEE08hN4lR/9Dw==
X-Received: by 2002:a17:902:fa45:b0:1ca:3c63:d5cc with SMTP id lb5-20020a170902fa4500b001ca3c63d5ccmr1833983plb.49.1697716846435;
        Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001c727d3ea6bsm1785646plb.74.2023.10.19.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net v3 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
Date: Thu, 19 Oct 2023 20:00:24 +0800
Message-Id: <20231019120026.42215-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Code cleanup for both better simplicity and readability.
No functional change intended.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 net/core/sock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 16584e2dd648..4412c47466a7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3041,17 +3041,19 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
-	bool memcg_charge = mem_cgroup_sockets_enabled && sk->sk_memcg;
+	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
-	if (memcg_charge &&
-	    !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-						gfp_memcg_charge())))
-		goto suppress_allocation;
+
+	if (memcg) {
+		if (!mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge()))
+			goto suppress_allocation;
+		charged = true;
+	}
 
 	/* Under limit. */
 	if (allocated <= sk_prot_mem_limits(sk, 0)) {
@@ -3106,8 +3108,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		 */
 		if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
 			/* Force charge with __GFP_NOFAIL */
-			if (memcg_charge && !charged) {
-				mem_cgroup_charge_skmem(sk->sk_memcg, amt,
+			if (memcg && !charged) {
+				mem_cgroup_charge_skmem(memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 			}
 			return 1;
@@ -3119,8 +3121,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg_charge && charged)
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
+	if (charged)
+		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
 }
-- 
2.37.3


