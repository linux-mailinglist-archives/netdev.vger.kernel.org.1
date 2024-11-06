Return-Path: <netdev+bounces-142495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922179BF5AE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E27281A9D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68320B1E0;
	Wed,  6 Nov 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhmxUkMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B541209695;
	Wed,  6 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918996; cv=none; b=ci39HK2VrM0PYZ/ljTy7z9/iZZKHbqGkJ2YJufCOcatss2BrT2M21MR59+L22PwrZzhorLnOknvuDWbh+6+Mxxig5wJTt8fW8CzElItkkH0BFKPutZ7iL8TEnDXjfGnKtzK7Yt4jdqgyabq48dvMCvi24LrManMxOFyAJUG4SMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918996; c=relaxed/simple;
	bh=hUXnHZwdxyXGHKs/xhNvNy/CJiyEexLZlYu0RRseBcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XN3TJRcMoF/PoP6unCwVVq6WHjB1/rFpSPeKB/2GAxF0lwXrH9hvmOTH4SlC7SrKxceqf4NV/FgDaTnAal3XB25+59Q1ter/eWXJxB1xGR0SWrSS4ThOTooikWWirDzbhrNEusNrnuj+DSjpVPAJnRNPG8I4BAa2fws4rgImTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhmxUkMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEE18C4CEE1;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918996;
	bh=hUXnHZwdxyXGHKs/xhNvNy/CJiyEexLZlYu0RRseBcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JhmxUkMG9i19apfIq+dUrff90TNz5ygITK22+ILWBtJOjLiLKs7J/dunyG9Y5ICG8
	 v0t9/D7kHGrpVyoXEUsCIUftXvrfrl8/YFXyV/nBC6kC0s4wshkZi+k/GjWa8ZpcEV
	 D3TuBObS6l3IwbPXdm5ZSCwDxzDidv7hQ4AfAm4BSAGn2T7QzTdy7r8yv2rWUJDrLj
	 8lF8sIRPtNdvoRAC2OtddRzCM8GpluTlJqD84Hl0u1dBmZzyqPmuPbTvwZDUuHvfKX
	 LPx6TL8+yZH2MhamG6QyavjUY92B4nbkjPbsOPctxOw5ckm5NTeHPuVunDEPWqv07I
	 P6XaQzlV7CpeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2807D59F65;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 06 Nov 2024 18:10:19 +0000
Subject: [PATCH net 6/6] net/netlink: Correct the comment on netlink
 message max cap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-tcp-md5-diag-prep-v1-6-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730918994; l=1447;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=Kmj21DwNJNOs65kiQumd7s7cSWkgFWMCJrFg+lJ9ggE=;
 b=ITm5BD/vJrJwTvNmV1V6c7esw02waru8s1F/KcRHpnPwih8VvLb5zrhOJkimS2VHKQBziP56v
 jdM9oPDoaHECjZpmFpJOoueAzKPXBTDCuVXLCz8+ouoidSykBvuUtd8
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



