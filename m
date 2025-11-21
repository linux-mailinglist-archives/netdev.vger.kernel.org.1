Return-Path: <netdev+bounces-240835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E6C7B01C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ED824F2E99
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745435581C;
	Fri, 21 Nov 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ5eIvcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36625355808;
	Fri, 21 Nov 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744579; cv=none; b=l0MQNcYpC3AOnMCTxxxi/9G/f2M7FSbSIl3ggWrSZVwkznD/6NQtYdO3xmmSCu1ha7cmRfiHFv9K8MlKAZ63uwDjPmf7EZl5rQSoR25dNeWJV/vfJfbEP3dWMtknz8tVl+6y9UEj6VB5M4g62V+c3yYzBAv4B9ceyuRAzUci8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744579; c=relaxed/simple;
	bh=XLpfj1iPnlktIIm2wFnxDVZ3YyEzVgDp9AF5Vh/cX6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0V+0WNquXPL8lL0hoDLutup2W/k25e7CEp66DPMwcHyxhnYCwOePujpE8mojfLVmj/4kIwsQgN4XlFgnh8k2vDjDPWIIACPyN27VlGtOZTR6yASihfwFL8DB87jSi0fgPAEkHCZsuWhRrmh9tXQQbC12g5YuCX8bfCgjZeY7M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ5eIvcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14721C116C6;
	Fri, 21 Nov 2025 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744579;
	bh=XLpfj1iPnlktIIm2wFnxDVZ3YyEzVgDp9AF5Vh/cX6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GQ5eIvcNTjb7yHsIJWzj/dJTzJaBI/aSgWUrsN/HEtr9MfmaTd+rFyNUxxY3GJ9Tf
	 0SGqC2SpyQ6+8KL/gqqLXpAvnIrQpZoNgUQGZ3iQXG2wvPA1HDOk30tdqmaf5F6JjO
	 RUqjhXHIOSf7gPjNknxuPOAlxYu0eUQB/xIu1CbBHlvd64nMBN2Lko9za/2Hjqdpco
	 9nH+SWF194j7z4N6oWYI6iOWa87FxEYXqo6epiicgqg/la+51Vi3VzLytugkWkOzrN
	 B7bkfstkxzF0zJpdQEppx9WY4IMd1Bl45o3xCAP8KhK+SJr6GW+cVvBMfWqS0Yg9vP
	 gjqALyivD2/QA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Nov 2025 18:02:08 +0100
Subject: [PATCH net-next 09/14] mptcp: make mptcp_destroy_common() static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-9-1f34b6c1e0b1@kernel.org>
References: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
In-Reply-To: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=b+ZCnRM0+Jr50ht0mP9uLm5IRFiMFB1h4Upl9hCGY8E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZkvtDL/n9KG0SLnevl9vbqOgy9UQd/Vq6UTxjuWX8
 zUCFi/tKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMibuwz/lGZM3a+iHFe51cmL
 Q/GNjUHLSb491h/MnkxconBL+4THY0aG2dpT1D7tYPqavfBcvfmfZp5mzk0ui6SO/Tb2Yfneotf
 CDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Such function is only used inside protocol.c, there is no need
to expose it to the whole stack.

Note that the function definition most be moved earlier to avoid
forward declaration.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h |  2 --
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2ee76c8c5167..29e5bda0e913 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3222,6 +3222,27 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 	inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
 }
 
+static void mptcp_destroy_common(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk = (struct sock *)msk;
+
+	__mptcp_clear_xmit(sk);
+
+	/* join list will be eventually flushed (with rst) at sock lock release time */
+	mptcp_for_each_subflow_safe(msk, subflow, tmp)
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, 0);
+
+	__skb_queue_purge(&sk->sk_receive_queue);
+	skb_rbtree_purge(&msk->out_of_order_queue);
+
+	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
+	 * inet_sock_destruct() will dispose it
+	 */
+	mptcp_token_destroy(msk);
+	mptcp_pm_destroy(msk);
+}
+
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -3427,27 +3448,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow, *tmp;
-	struct sock *sk = (struct sock *)msk;
-
-	__mptcp_clear_xmit(sk);
-
-	/* join list will be eventually flushed (with rst) at sock lock release time */
-	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow), subflow, 0);
-
-	__skb_queue_purge(&sk->sk_receive_queue);
-	skb_rbtree_purge(&msk->out_of_order_queue);
-
-	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
-	 * inet_sock_destruct() will dispose it
-	 */
-	mptcp_token_destroy(msk);
-	mptcp_pm_destroy(msk);
-}
-
 static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8c27f4b1789f..3d2892cc0ef2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -980,8 +980,6 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 	local_bh_enable();
 }
 
-void mptcp_destroy_common(struct mptcp_sock *msk);
-
 #define MPTCP_TOKEN_MAX_RETRIES	4
 
 void __init mptcp_token_init(void);

-- 
2.51.0


