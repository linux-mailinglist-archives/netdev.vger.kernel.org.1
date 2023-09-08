Return-Path: <netdev+bounces-32620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7098798C77
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9101C281BA0
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3BF14AA2;
	Fri,  8 Sep 2023 18:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1E14A9F
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:14:50 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC922108
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:14:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d9e327d3aso26441127b3.3
        for <netdev@vger.kernel.org>; Fri, 08 Sep 2023 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694196841; x=1694801641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0RLm5ta3TzXSRWdgzSlQ/2STQqaYv7B3pKmfp0gY38=;
        b=5WxpACBB0XtsyMtcRfHi/m/LsOIwxqn98h45FW5h5pyzQVA1s11rw1BPKoyCHUAiHL
         WncEy6xrslxfMwZzF0Uroq0tW/GaRTFrY/siCefAFqWFazkT2+iy8XX5D4ysAsx02Mgl
         /GecKTYp1fkbH8fy6V6oqMYMA5Xl48cwPvi/7S1uGM3boM4zVNSvIL/fLeAHvAltfmoU
         SlPtF2iv7JzcckVjN4FCewx8iGoe5EyZpFrHoEDHkGtjSDGt4e4ZxKCfBPKbdbfO+B1l
         mEkjW+1agCO3fOzK69nWLfuaqJdbfjmnmKNBMAa8J9TK4oJta/rgsA5Gw25fT1BAn2YI
         QjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694196841; x=1694801641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0RLm5ta3TzXSRWdgzSlQ/2STQqaYv7B3pKmfp0gY38=;
        b=Zdm6K5HI8Jrmv1KDVPRqUcl8E35EZe8S1sk2t4w9N+hGZqxdiaeQN0SVYH10p4oi+E
         2jLXqcibIf8JP/GOL4KGJBqWKSKe714QjEGt9PZEHvddH2BYnLmQkLYKk8IyhYywcoxZ
         M1hWSm7A2Z5eiUmAJVRryKm6315J2fM/C4geNOCwiHtV0fzEVcprPNn13oOeAbypl3pA
         EGnIseR/VQubDSSeFBz8R3UFQsOc2LaoBzoJLpx+MfUukoCIPfiBfs1FgmxttfxOvtNu
         pj7jH6tRMNJyENmyC820OXHsCEkCS3Qx+PBOYez/f51x/mdfx+6dGnbj+xSl3wD17dqz
         Ygjg==
X-Gm-Message-State: AOJu0Ywwqrp0CYMDuhsyWKtbcsDqoamn1k6EcOeZC0v1qLMU58cKLXcV
	cQZ3cOXARDFTBmJ0B9+5STBtbj3OXB5BLw==
X-Google-Smtp-Source: AGHT+IG1Pd3wX0pmUNNgZb2VMQ+CTk7wGdyL8u/fDqAldhrDFagc/y1K+B7AdTyZH9PUia1yPWN12SrywMYd5g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:a2c8:0:b0:d80:183c:92b9 with SMTP id
 c8-20020a25a2c8000000b00d80183c92b9mr70693ybn.4.1694196841090; Fri, 08 Sep
 2023 11:14:01 -0700 (PDT)
Date: Fri,  8 Sep 2023 18:13:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908181359.1889304-1-edumazet@google.com>
Subject: [PATCH net] xfrm: fix a data-race in xfrm_gen_index()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xfrm_gen_index() mutual exclusion uses net->xfrm.xfrm_policy_lock.

This means we must use a per-netns idx_generator variable,
instead of a static one.
Alternative would be to use an atomic variable.

syzbot reported:

BUG: KCSAN: data-race in xfrm_sk_policy_insert / xfrm_sk_policy_insert

write to 0xffffffff87005938 of 4 bytes by task 29466 on cpu 0:
xfrm_gen_index net/xfrm/xfrm_policy.c:1385 [inline]
xfrm_sk_policy_insert+0x262/0x640 net/xfrm/xfrm_policy.c:2347
xfrm_user_policy+0x413/0x540 net/xfrm/xfrm_state.c:2639
do_ipv6_setsockopt+0x1317/0x2ce0 net/ipv6/ipv6_sockglue.c:943
ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
rawv6_setsockopt+0x21e/0x410 net/ipv6/raw.c:1054
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
__sys_setsockopt+0x1c9/0x230 net/socket.c:2263
__do_sys_setsockopt net/socket.c:2274 [inline]
__se_sys_setsockopt net/socket.c:2271 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffffffff87005938 of 4 bytes by task 29460 on cpu 1:
xfrm_sk_policy_insert+0x13e/0x640
xfrm_user_policy+0x413/0x540 net/xfrm/xfrm_state.c:2639
do_ipv6_setsockopt+0x1317/0x2ce0 net/ipv6/ipv6_sockglue.c:943
ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
rawv6_setsockopt+0x21e/0x410 net/ipv6/raw.c:1054
sock_common_setsockopt+0x61/0x70 net/core/sock.c:3697
__sys_setsockopt+0x1c9/0x230 net/socket.c:2263
__do_sys_setsockopt net/socket.c:2274 [inline]
__se_sys_setsockopt net/socket.c:2271 [inline]
__x64_sys_setsockopt+0x66/0x80 net/socket.c:2271
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00006ad8 -> 0x00006b18

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 29460 Comm: syz-executor.1 Not tainted 6.5.0-rc5-syzkaller-00243-g9106536c1aa3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023

Fixes: 1121994c803f ("netns xfrm: policy insertion in netns")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/net/netns/xfrm.h | 1 +
 net/xfrm/xfrm_policy.c   | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index bd7c3be4af5d7bee4c63a57a2b0bf283b81bc4bf..423b52eca908d90009889b64764fbd4008a29529 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -50,6 +50,7 @@ struct netns_xfrm {
 	struct list_head	policy_all;
 	struct hlist_head	*policy_byidx;
 	unsigned int		policy_idx_hmask;
+	unsigned int		idx_generator;
 	struct hlist_head	policy_inexact[XFRM_POLICY_MAX];
 	struct xfrm_policy_hash	policy_bydst[XFRM_POLICY_MAX];
 	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d6b405782b6361c4da2e06fae50befbd699aed15..a73e4b66c98f9db98d94a146bc963fa29979c592 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1372,8 +1372,6 @@ EXPORT_SYMBOL(xfrm_policy_hash_rebuild);
  * of an absolute inpredictability of ordering of rules. This will not pass. */
 static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 {
-	static u32 idx_generator;
-
 	for (;;) {
 		struct hlist_head *list;
 		struct xfrm_policy *p;
@@ -1381,8 +1379,8 @@ static u32 xfrm_gen_index(struct net *net, int dir, u32 index)
 		int found;
 
 		if (!index) {
-			idx = (idx_generator | dir);
-			idx_generator += 8;
+			idx = (net->xfrm.idx_generator | dir);
+			net->xfrm.idx_generator += 8;
 		} else {
 			idx = index;
 			index = 0;
-- 
2.42.0.283.g2d96d420d3-goog


