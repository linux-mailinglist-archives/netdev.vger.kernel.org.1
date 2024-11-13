Return-Path: <netdev+bounces-144538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C810B9C7B8B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B42896BC
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787CE2064E3;
	Wed, 13 Nov 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhH3KB4Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DE206047;
	Wed, 13 Nov 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523628; cv=none; b=s333uKLa+8uTP6YlTKKXM7ggkQcaMiWkIg9yIEzsMo+cksMJFEJVM8Qg76JSrVSi2ya0bpXKAmVgp1FwQAwHYiW0z0joWBIuwhhvzVAqrZHodlhxJAmbCgQAxjQhn6NW9GfPCvaw5yiBYZoPQLf2U1IKqSNEph2m/4hn9kDKSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523628; c=relaxed/simple;
	bh=hUXnHZwdxyXGHKs/xhNvNy/CJiyEexLZlYu0RRseBcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EpSN1iouxtyg7XQ0tLDoUWk0R1wzgO6TeKB8PaqcgNbI3pVBYute8MilLocN/41swRxwnYVl2LM3RoBdffyicSf5QXIzlDl5YDN9LzvGcF7tXxmU7t+Ug9UpBEkWM7ygqN5HlXFZsEtlPSj8bkHWUdPjnoKCyaOhmuEV2wCqrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhH3KB4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB11DC4AF14;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731523627;
	bh=hUXnHZwdxyXGHKs/xhNvNy/CJiyEexLZlYu0RRseBcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RhH3KB4YlqYuUEsbYmOXihEuV9SB9syrhTOud0q86nvJwKwAUT9KESvyNa+v7HdlT
	 sb8bILLP7iND7/y+QQsGgYF7RykfspyrzEYgR/y15y9g9ny4yiLnT5C/ttoIa4Sa5a
	 3G8X1OnbpCMs0V0I+z17+UPqOSesDmw94cOkI0st4GKwXdpYuU0TmbmV87mBf5fvgy
	 RGrx6TVUGZdewrf7/QnIwSXAfwIXNknIodQlJRXWpNUd6JvE+OLP6pboSb0FK9mSXx
	 OAP2Qjcho96iARpDyTxI6/khmehi7zUZtmy2+8CXkcbSgg+pAqrGwZMoBlHvpyjf5U
	 1So3eRVEyIkfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC09D637A8;
	Wed, 13 Nov 2024 18:47:07 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 13 Nov 2024 18:46:44 +0000
Subject: [PATCH net v2 5/5] net/netlink: Correct the comment on netlink
 message max cap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tcp-md5-diag-prep-v2-5-00a2a7feb1fa@gmail.com>
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
In-Reply-To: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731523626; l=1447;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=Kmj21DwNJNOs65kiQumd7s7cSWkgFWMCJrFg+lJ9ggE=;
 b=qNnWzbuC5xOp5vDnjdmcYD7+PMI4g7cI0hr6QqKcmXoyiNDod483tlWaRYVCE3U4sTJ+LGrBu
 jKpN8Mpm5yjDybByujZIIDiDPIRZV0V/hk8F1EkCqsEdnDLLhTY120p
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Since commit d35c99ff77ec ("netlink: do not enter direct reclaim from
netlink_dump()") the cap is 32KiB.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/netlink/af_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0a9287fadb47a2afaf0babe675738bc43051c5a7..27979cefc06256bde052898d193ed99f710c2087 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2279,7 +2279,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
-	 * required, but it makes sense to _attempt_ a 16K bytes allocation
+	 * required, but it makes sense to _attempt_ a 32KiB allocation
 	 * to reduce number of system calls on dump operations, if user
 	 * ever provided a big enough buffer.
 	 */
@@ -2301,7 +2301,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 
 	/* Trim skb to allocated size. User is expected to provide buffer as
-	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
+	 * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
 	 * could fit within the allocated skb. skb is typically allocated
 	 * with larger space than required (could be as much as near 2x the

-- 
2.42.2



