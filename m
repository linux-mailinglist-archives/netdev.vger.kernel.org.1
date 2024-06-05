Return-Path: <netdev+bounces-100852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2CF8FC456
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F711F21C2D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8A21C19D;
	Wed,  5 Jun 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUklBisJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71021C185;
	Wed,  5 Jun 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571783; cv=none; b=Ojbx/YxMay+N8nuEWD5OYdjWCN3KeLwE4GvYgGZRGAdXs1UMXdT6YLc9LkXihE5GXSPkHH22N3g2kKU1nMufFkDtHkLbi2J+gpvnyP3vvGb/oOdlrHBx9chfvn/JOfJVxkvzX1FZs2wSeGnGgcDKOpcgR0msbkFtFBPmrAmyvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571783; c=relaxed/simple;
	bh=sxhJ+EeYfFnndf+P0KauzX3XfZr2LhOzY9YOAHJPD6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TG5NDo3POV8GRiovSBWb3dyJR3FxdEzJFS27Fsrm4xLc0gNK5vCCk4fWiYJBWbXxeUdMGPzemr+y0YhjheAa8XnDx0LgNJKTHxmxQELl1+WHFUPqEVq8YSD8fEcFoFgriMLAK7OTAN+HgHje4Ewc9ohY7Zr6mOpo50LKrPJ7/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUklBisJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7577CC3277B;
	Wed,  5 Jun 2024 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717571782;
	bh=sxhJ+EeYfFnndf+P0KauzX3XfZr2LhOzY9YOAHJPD6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PUklBisJrytmGj0XZcFRcCUwkYjPhYLL94hppWLuh5QfRoN6zA+hCICCGgdiTu6Et
	 911xlyTYvfzLPe6SuFOxIPxd3ULHjWhh8g9zrzPRFgeDJAhmOTD4YRipCPBDViiHCx
	 tYQBDGmtBTRVfpSvnDuPXhqn+bWBOZhgaMFYZSzAAdQQFVkLn8eSoEmLblLhkAsKjL
	 LdeUP89jg+AnbK9CJbG2xTb90Nd9CTwXmeYArpTjPPT5VA04hPjhxxr7xumyvM8VD3
	 J7bRzgYTL/FGQebqmotT7Dpm5yBDDiYDS/jG9kqSipUZ5afWHpzRYXYqbhSf/gZykw
	 B0kFO25eBXwDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 09:15:42 +0200
Subject: [PATCH net-next 3/3] mptcp: refer to 'MPTCP' socket in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-upstream-net-next-20240604-misc-cleanup-v1-3-ae2e35c3ecc5@kernel.org>
References: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
In-Reply-To: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Xd/BOnYnE8h1Cykv9cgIddsDI+Z+77oERfzWjuomB9I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYBC7HWWH3TEifZf4FmGVMWHnhruMbJ29zUlzn
 U6p/LIDWnyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmAQuwAKCRD2t4JPQmmg
 c5eUEAC2A6lQb6MHH4HnEJYrktKf4J/aM5++jxUXVHo9qmpgGdUTeCHtJnlYEUWWtNEZnUw3MTY
 iXC9SoqKo/ReBHdsqROzL1hG4tXoC9z4+SWjWogCQ5mf1AGmA55R2GqZNgtQPDNaiKZke/aGxTS
 p77YQg7OKhMvDwHPocOEmJSc2RLAa46xiLC8bCUrYaf9vxszaoAivinzzGFGXcAKQBBupHEBSqS
 WBpIjlX8zJ+MgFtr4BkGQB+fJDQiCVrArhMt2yrxJUbUgpRhiE612WaGqHxfrS00kqp/Y9HMw8E
 shS3h5jYhiuTT5A5+Uv5wIJXunyDnu/R8GiqBZtx44kBrh3I4FrFK3SOJ3rGvStLysxRz5PR+m6
 AGjNJc3kXFrmlqE2tFP+ygNuWk0eB26QGGjtrCciK/nS+ruxeuSChOjvXybRoOUcvvbwtYBjXab
 G/uoujC7VRzBbEnyOXZVJPVpLKtLWpDwigATMIN1did+tVzK9e4YNA57Mdsycg/Rfi2NFPL6UEj
 32DLz7aCI8EgXDKr7d7A5/qLP9+RF61eYE6HojwIyF6YlIH64LTDguDp84QgguShL7qO95mIvi6
 YdJkmS2iqcrPXSB0Q6wz3EBQ9eJcixU0HN5HvGSwz2JsB11xT//vWqaBFktteMGINQtOLG78Qwy
 GSIuOFbF8NM+xUA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

We used to call it 'master' socket at the early stages of MPTCP
development, but the correct wording is 'MPTCP' socket opposed to 'TCP
subflows': convert the last 3 comments to use a more appropriate term.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/subflow.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ce11bee3b79..ead0bf63cf95 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2202,7 +2202,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
-		/* only the master socket status is relevant here. The exit
+		/* only the MPTCP socket status is relevant here. The exit
 		 * conditions mirror closely tcp_recvmsg()
 		 */
 		if (copied >= target)
@@ -3521,7 +3521,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk, long status)
 static int mptcp_hash(struct sock *sk)
 {
 	/* should never be called,
-	 * we hash the TCP subflows not the master socket
+	 * we hash the TCP subflows not the MPTCP socket
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 612c38570a64..39e2cbdf3801 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1719,7 +1719,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	mptcp_sockopt_sync_locked(mptcp_sk(sk), sf->sk);
 	release_sock(sf->sk);
 
-	/* the newly created socket really belongs to the owning MPTCP master
+	/* the newly created socket really belongs to the owning MPTCP
 	 * socket, even if for additional subflows the allocation is performed
 	 * by a kernel workqueue. Adjust inode references, so that the
 	 * procfs/diag interfaces really show this one belonging to the correct

-- 
2.43.0


