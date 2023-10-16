Return-Path: <netdev+bounces-41334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C603B7CA953
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E097B20CE1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961AA27EDC;
	Mon, 16 Oct 2023 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lXfrO1fs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BA26E16
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:28:36 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECADD9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:28:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso5574765ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697462915; x=1698067715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4aBj7JQ+keXNLTEJI81zHdQbbGhY/4fEWPU2oi6ixMU=;
        b=lXfrO1fsMGC5QLgGqwDORzAfq3rDCA3w7RGXyf2iWe3WmQWfS44Lf+j+p+44eXbyls
         o1R5kvy5gbTf20U9X1yBdcu1Bd8GOAVfAHvVWO9/R98BQRSyJDmED7IUFJnEc5DhvQjL
         nrOOOO+V3jXUJVWnfpMMLKnN/Wdbc+YxaUKl+aGBZfoTWZ61hNyHRoWvdrv63EakqxYC
         X9FZo5jchidkdqa8fl5bUixZE9gaY96K9J866QLg4u6Q0w6RgPmyF5RIyL9V4fhCwKwd
         Kcppcid4aFkRU0kITziw+Z05zPvg5BykAk8c5zwzuo2FQd6ZF18d2OJtQMIBy3kemfaq
         JDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462915; x=1698067715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aBj7JQ+keXNLTEJI81zHdQbbGhY/4fEWPU2oi6ixMU=;
        b=pB73+udb58q2B5EE0aWIkRMM1uqjO4bJLIj/YdLh1ga5AjUDk9Q8S+ycH49c1O/tpG
         wNLa+ztHZPv9oee2zTpxnYNORiAxcyNDiRPHJxaLjOh/xvATydPU8jXZwaMgiMRXXn/o
         d96+MXjgB8xOXR5KryvvTwOutWsqEcAuR1CdodSjU3LHMyElwksGPx8px9Y+dwtEfAZI
         UfMpl0zOfjNnFo0MqAV1G1whWKgWgPdO4MF6wmJ0A8gyd1cfxxqnK3fYdTZfOmBXLOqy
         PKCCbi6SvVz9XtcowR4ztOqNdGSFYSh0aMGWrxW1z/42QEpz00PRNe3KWxPvyEPrgWMr
         8u5Q==
X-Gm-Message-State: AOJu0Yy5O5PLSOTwYg5hZDucoNx9H3y5iK2LOxslecxcsLc0dmOvaQ9s
	6U2eMLkj4LjZvpdwquKUBCr5HQ==
X-Google-Smtp-Source: AGHT+IGJ3DtPhfQwjYL4m3gc8AKJVML01Aff6rf6yFGw99xFhjdJoNkI5UMftZbSgs4Sf+513AQsog==
X-Received: by 2002:a17:902:f907:b0:1c9:e6a0:edb6 with SMTP id kw7-20020a170902f90700b001c9e6a0edb6mr7341216plb.2.1697462914871;
        Mon, 16 Oct 2023 06:28:34 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c737950e4dsm8476287plk.2.2023.10.16.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:28:34 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v2 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
Date: Mon, 16 Oct 2023 21:28:10 +0800
Message-Id: <20231016132812.63703-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Code cleanup for both better simplicity and readability.
No functional change intended.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 net/core/sock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 290165954379..43842520db86 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3039,17 +3039,19 @@ EXPORT_SYMBOL(sk_wait_data);
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
@@ -3104,8 +3106,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
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
@@ -3117,8 +3119,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg_charge && charged)
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
+	if (charged)
+		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
 }
-- 
2.37.3


