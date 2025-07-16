Return-Path: <netdev+bounces-207436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905DCB0735E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FC71C2479D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B512F5097;
	Wed, 16 Jul 2025 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYcQbXxG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF662F5093;
	Wed, 16 Jul 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661711; cv=none; b=oEuZMys7TeU0Q8dwWh/cxqdInK79uHaVvMBaambL6j/mSXnc7dZ1IYs8kkzMxdqpwa901Ie6n5vf/JuCquFleiufJiOBfJfcG4rGPIlb/DwP8vxcPsZVpfxZ3d0rZQcVz1Mdu11jUOvBmj4SrJFRFG/4EqthuUblTY+TdPfYSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661711; c=relaxed/simple;
	bh=ATxwF3oK0AHq0rXjzmSH/f3UnehAxyGxmt7OLGdPkmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9UYqrIzeb9viZqFoZqsQIBq4q68WHCsqhF3n0+CJY7udQ8UrxbHrt2xvdMYos508IyS9U1xxH7Gn7jU7oreNqbmpYvXQA5eV9cnN5JXJVKoVSWkCWuXG2+TbLS6DUYHi59ruSOwdVRwFmT5Z8nWdWVHdRU8yEjZOl7E0asQylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYcQbXxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20169C4CEF1;
	Wed, 16 Jul 2025 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661710;
	bh=ATxwF3oK0AHq0rXjzmSH/f3UnehAxyGxmt7OLGdPkmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mYcQbXxGtb1oAsBu7hrvRL8MiKu5qcMJm8rztJIBHtSKFwrcXckcdNnxLHFxq6d+q
	 xULshS0b4cD/g4A6YwJLfM2shtVbpDWPEuSo3LGKJhHt4rpvNkzYuUs0LoS/rGSVTw
	 x7kOWJo49ozFTNyVnv2Gooc+JHD8e1t3pU8OweKRkFwRdd0ODEmWuNACcgFG6Mbmaa
	 nFk2zw7aMDeJw0k69MrQx6SSWOhpannQfJBu+IXxChr49Gh5JzztMkYzz+fw1myz7F
	 JWZoMcr9nYQWbCN+tgNxhcicT0UKjOBV6Aao/BaH3UR6x69F3XMxPUWQZjnoJ10/EE
	 oSKVbuGVTRn0A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 16 Jul 2025 12:28:06 +0200
Subject: [PATCH net-next 4/4] mptcp: fix typo in a comment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-net-next-mptcp-tcp_maxseg-v1-4-548d3a5666f6@kernel.org>
References: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
In-Reply-To: <20250716-net-next-mptcp-tcp_maxseg-v1-0-548d3a5666f6@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 moyuanhao <moyuanhao3676@163.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ik5twdxPJJpwUw1wx5+zdFE+/xcyShWLAB0UWSDSQCY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLK6/Yr7A6LzDKVuiq8TLFL+QZT//dFC1uLZ1mem/uBc
 1rMayeZjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIksDWNkWLazomR2icXrXsut
 BbUbc544Oaksk+ZoqvOv8+Zd0RbTz/A/1XbPLu9f0SuezBGuOFBxzHHXIxn3iL+bfbMtsmbMKfB
 lBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: moyuanhao <moyuanhao3676@163.com>

This patch fixes the follow spelling mistake in a comment:

  greter -> greater

Signed-off-by: moyuanhao <moyuanhao3676@163.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - The same patch has already been sent to the netdev ML, but when
   net-next was closed:
   https://lore.kernel.org/20250530181004.261417-1-moyuanhao3676@163.com
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5f904fc5ac4c63e8b6c7c9aa79f17e8dcdf1a007..fe3135cd778a98d4f270d684c101af30d261ee71 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1377,7 +1377,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * - estimate the faster flow linger time
 	 * - use the above to estimate the amount of byte transferred
 	 *   by the faster flow
-	 * - check that the amount of queued data is greter than the above,
+	 * - check that the amount of queued data is greater than the above,
 	 *   otherwise do not use the picked, slower, subflow
 	 * We select the subflow with the shorter estimated time to flush
 	 * the queued mem, which basically ensure the above. We just need

-- 
2.48.1


