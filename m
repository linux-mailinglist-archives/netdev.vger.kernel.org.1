Return-Path: <netdev+bounces-31591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B73D78EF01
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE73281479
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F8611C9F;
	Thu, 31 Aug 2023 13:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77E125AC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:52:23 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550BCE4A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59504967dc4so12357087b3.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693489941; x=1694094741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1rohJgO9V9RywEMCONGSDywmCR8GITkhM4zCyaAbRg=;
        b=zVl7sDJOSfDScEacy/m9k55zPo3/hpXSJ1OeM/oTadcp2btAyt/GcFkWyGIL/IsqRz
         SYpSD6utxJvZAySrwUXy0IxDXnqiy0erPGPcS2YAEMJrI3LKWI3WGuiArSRJsoPwNIeX
         /B6FLbQ/fzaCR27EDESxOgERMPNXoo1dIb4w8gnaReDfGLFYhRThq0AXTYMEH4ij2i2S
         asDrWymbF5tzduAVrlldBd8tBlDrbX3spKuJXjE2GcKfFiRMgQTc9nqqY8r3WQyGTe8W
         LuXLdiOSfgBRDEX1+GfBNU65RxCPnQg2lgRHuVvcDr9bXVxzqJESXDrJ2OiCvtW3Xtzo
         BWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489941; x=1694094741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1rohJgO9V9RywEMCONGSDywmCR8GITkhM4zCyaAbRg=;
        b=MTp/4ma/sqATAlAdhwoKugo/08YhYSpe/sKiLRexmM3FtncLzjA5qcZ1XpIcNeoFVC
         +CnoYySyL/GH/hLwlcquqjz+qKih0sTAndKnI0erRUEYgC4Bpk2mZgzS18KOQZ5xxz5z
         W2RYiqW0KO9nrzxOl5FL4MKJWD+ZYB2C+Spd1CaZAEEcX4p5cSP58pPoIbcQCgJSXxRo
         AB80UgBg0YDJabmoVxxfblfcCpqBlPuKamqlgeVmcyeXoAmBwnBMmJG+KJQoLADn5ySh
         XB0YdlJ8TzS+NItaVD2WFxfMrx0Dt3Xmpp5lS9K9iVsHfAVPsUpmW5nGCMA4Av65RZmm
         2HIA==
X-Gm-Message-State: AOJu0YzyP05qS6ep0lBzFbx8wJf6MmdDSabHaSULZ5ExwSEj81G+iUdK
	+740K9i0V/GwT8ZSMmyY/kfHZwM7Xe0mNQ==
X-Google-Smtp-Source: AGHT+IEhlB9mxhBHoV703yYMqVF+/J/UZhIHw/key4DNSUkQjFJ/ovZ7YowERwf/2T8s9jcPWWeNdpr226f5XA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a884:0:b0:592:7bc7:b304 with SMTP id
 f126-20020a81a884000000b005927bc7b304mr149676ywh.8.1693489941608; Thu, 31 Aug
 2023 06:52:21 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:52:10 +0000
In-Reply-To: <20230831135212.2615985-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230831135212.2615985-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831135212.2615985-4-edumazet@google.com>
Subject: [PATCH net 3/5] mptcp: annotate data-races around msk->rmem_fwd_alloc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

msk->rmem_fwd_alloc can be read locklessly.

Add mptcp_rmem_fwd_alloc_add(), similar to sk_forward_alloc_add(),
and appropriate READ_ONCE()/WRITE_ONCE() annotations.

Fixes: 6511882cdd82 ("mptcp: allocate fwd memory separately on the rx and tx path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 625df3a36c469d9b8e71a2f0463a1ca5ead2049d..a7fc16f5175d22a4e741c79edd84f1ea72c676bc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -134,9 +134,15 @@ static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 }
 
+static void mptcp_rmem_fwd_alloc_add(struct sock *sk, int size)
+{
+	WRITE_ONCE(mptcp_sk(sk)->rmem_fwd_alloc,
+		   mptcp_sk(sk)->rmem_fwd_alloc + size);
+}
+
 static void mptcp_rmem_charge(struct sock *sk, int size)
 {
-	mptcp_sk(sk)->rmem_fwd_alloc -= size;
+	mptcp_rmem_fwd_alloc_add(sk, -size);
 }
 
 static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
@@ -177,7 +183,7 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
 static void __mptcp_rmem_reclaim(struct sock *sk, int amount)
 {
 	amount >>= PAGE_SHIFT;
-	mptcp_sk(sk)->rmem_fwd_alloc -= amount << PAGE_SHIFT;
+	mptcp_rmem_charge(sk, amount << PAGE_SHIFT);
 	__sk_mem_reduce_allocated(sk, amount);
 }
 
@@ -186,7 +192,7 @@ static void mptcp_rmem_uncharge(struct sock *sk, int size)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	int reclaimable;
 
-	msk->rmem_fwd_alloc += size;
+	mptcp_rmem_fwd_alloc_add(sk, size);
 	reclaimable = msk->rmem_fwd_alloc - sk_unused_reserved_mem(sk);
 
 	/* see sk_mem_uncharge() for the rationale behind the following schema */
@@ -341,7 +347,7 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
 		return false;
 
-	msk->rmem_fwd_alloc += amount;
+	mptcp_rmem_fwd_alloc_add(sk, amount);
 	return true;
 }
 
@@ -3258,7 +3264,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	 * inet_sock_destruct() will dispose it
 	 */
 	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
-	msk->rmem_fwd_alloc = 0;
+	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
 	mptcp_free_local_addr_list(msk);
@@ -3522,7 +3528,8 @@ static void mptcp_shutdown(struct sock *sk, int how)
 
 static int mptcp_forward_alloc_get(const struct sock *sk)
 {
-	return READ_ONCE(sk->sk_forward_alloc) + mptcp_sk(sk)->rmem_fwd_alloc;
+	return READ_ONCE(sk->sk_forward_alloc) +
+	       READ_ONCE(mptcp_sk(sk)->rmem_fwd_alloc);
 }
 
 static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


