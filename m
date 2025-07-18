Return-Path: <netdev+bounces-208263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9941B0ABF5
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248F7562D6C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E12264BF;
	Fri, 18 Jul 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFQbtlrK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D92264B8;
	Fri, 18 Jul 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876453; cv=none; b=pmP7E2n0V2pcqGAtbHZ0Ex++PEpmsXf032dDof0y+d05PQkGk//cT/G36FlGHe6uWs8dd0+XWqbqx8n5/IH7Ta5WlQCvsLmmnt21LQWB0pqTr/i5wzG4wyqc0JlA314yNFCExW7Yj+5kIsrW4LrAODjWLCJaiajgWvovkm99I+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876453; c=relaxed/simple;
	bh=VFHMq/5snyRulbgLVAfNm9sRY7pyS+dRYaYaXX8B1VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZixMP0psDCYRNxR8qrsncVCuAQmJFGjIksEGwbBR02ZtcuTUHle8mNbCcR5ikHBo+OAZTH/GRrT+QUYX/7uUpMJfO2zE+V8863dIvU7G0rg4CSrO3b3/WHYY9V9yxmhv6MCrkXOhy7B1y+/8Ym63GvEcNjqfJO/klx9MovNvk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFQbtlrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ACFC4CEF6;
	Fri, 18 Jul 2025 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752876453;
	bh=VFHMq/5snyRulbgLVAfNm9sRY7pyS+dRYaYaXX8B1VU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rFQbtlrKbOtJ78EDhQc926qkTbp64JUNdYHEi4WL2T1s8rjzJgROQKTQtUYPp2rV4
	 mJ6m6YzLLhTEVnvtG8CIS2Sui8zEhw2lBTWe9rdlzLiql0I1sLxxhTQ2UzgFt5kx5e
	 HVU4tC7OctOdM3y3U/7k4hg7ePFKturK3bYME0G501AlaIdvB6QXPMGWdTn3s8sMtT
	 5zEp/9ZMlXwPV985ZvgebYJyMGyqY27WhQ8IffS2iWP2lVKbdFYJcRP5mQMtYqSTIo
	 NLT7F1vrx6iDiMfIjUYp6fPTy/AGsQIoD2M9mPKe6tUpMrmPz0Ghs1xRpkJZCB/W1S
	 tKlUdBNmecAiw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Jul 2025 00:06:59 +0200
Subject: [PATCH net-next v2 4/4] mptcp: fix typo in a comment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-net-next-mptcp-tcp_maxseg-v2-4-8c910fbc5307@kernel.org>
References: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
In-Reply-To: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
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
 h=from:subject:message-id; bh=kXxCpxBoe193+fin7GD8gP/kJaiRnrkRTpUKWV/Vk6Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKqjk59pfNNaHJe4KUHRdycUrZyrdWXO/s8vpSucd10/
 eAsHTOHjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlclWT4Z/N+dk3j9F69/xsq
 jy08s2ZFyOOoT7ERBpvmzxS+xC3Ebc3wT93yodOmrSZ7DTLm9L9x+XqDPXVLzsvJNdPt3pxPLEk
 yZwIA
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
index 2ad1c41e963ec30cccd8387201f622c4f4d4c471..6c448a0be9495b22ced4a2b51da2f80831040aba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1387,7 +1387,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * - estimate the faster flow linger time
 	 * - use the above to estimate the amount of byte transferred
 	 *   by the faster flow
-	 * - check that the amount of queued data is greter than the above,
+	 * - check that the amount of queued data is greater than the above,
 	 *   otherwise do not use the picked, slower, subflow
 	 * We select the subflow with the shorter estimated time to flush
 	 * the queued mem, which basically ensure the above. We just need

-- 
2.50.0


