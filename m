Return-Path: <netdev+bounces-172893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B43A5668F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE37C177F4C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB0219A8D;
	Fri,  7 Mar 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffYAaFMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8321A42B;
	Fri,  7 Mar 2025 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346536; cv=none; b=sJTSIX//9BmNzJZtV2lpzKUIqZQ0TWqi/p93LtlERTXMkRqHiLnoOo0akm4eDQOWHzWdlChlA2klUPWlSDpC+j2dIme5qgOve6MmEkNBZYvTv7wBDSGvvIyWpwxWsTO4orT8zTZbjZTzc+ul4olLOEsjm8GQqfNiyv9+fEOPVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346536; c=relaxed/simple;
	bh=eTvXn9NsZ1qerZ7/LNfZc/QqeHuQhfgwRr+TB2qtlJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=opE9MOQE6nhwg6hAMr+JzOu4l6wAOParA6z9Y9wM4N+q81d/zJGGWkDq/Te+m07T8oraCQ0jV6pO4oxC+HZRfJUg23I7xPUV4EzedtiSSc9m9Fc8Uuz7XumCvXOB9eoQ6sKdS5rhMhBwhoXVKCV6HLibQzzcxeWWQmAzF3c75cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffYAaFMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC3EC4CEEE;
	Fri,  7 Mar 2025 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346535;
	bh=eTvXn9NsZ1qerZ7/LNfZc/QqeHuQhfgwRr+TB2qtlJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ffYAaFMfGW4kJCa9chC0+dPL/bLv7Dc3y1WIrhsiWvy/U8IynoR+N/DNAdGLLylDz
	 5qg/gHdsl/Jlhas5LGbLgczAgmE4Q4+e4R5gZw23oIbuHPSpa2uLqBR5TbQx+xP8Od
	 0Vbhflxh5z+N1BvP6t8TjAWE8QbGLT9tY21MjEvoIcOqY74UXLsnO4KahQT5WE8JwR
	 utlC+HPDqW/dQ3WRU4O0cfU/7jZcdBaGIFjh/BnjFjGE2gdQkYJ32l7Mvg/Y/hiAOS
	 +jPKoHaPlsZiwytTyTgZ6d4kySnRBGydZQ/kdR2lfOe9j7QxdJJ15P0h4CSLw5QSBL
	 56lt97Zaga8DQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:51 +0100
Subject: [PATCH net-next 07/15] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_is_init_remote_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-7-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eTvXn9NsZ1qerZ7/LNfZc/QqeHuQhfgwRr+TB2qtlJw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbR5orkyrPhK/XFDv/nwoLtNQiUyfWWwePNU
 31WZPrkzrCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c3RCEADia0K++SpOZpIGD8OfxdAKh0klEsVsqtMG4khKHPXk0af/+DrAKs29eSnC5CPwhBZNZwa
 xgjyUwsp5y7yOc6JOasF/p0sqGkl6IiD63Lt/zj+PNt2Ji1qfqtmnJNoSby3kUUDkCmjE3kJuKm
 W6u+SEZfv47o5FInkKrgZbZr9rLnrWbpDoVldBKntXoKzmOSRZtamFIu5NP9cTH/fJyk8R6u4Ip
 ldvd2Dus/m/AYmJ6HuZ34AqMBImr0pRl9MMaZoVqEc7fXqyaU2sTtSKmyeqL4WmJQ6OndjbPL8P
 Pjd6sCuad4LsuTcjEc9zaerIZB4ED6DorATtLDFlZZ72wONbVdcijcRqqKFzBejVo/rAZOqo/zW
 8ytgkJ38L/0pYjuc5f4525jOhjBE2DwBGPTQa8WF9NBJ9ae+InwJVMZKMD33CSSxpiosWJALfF0
 GoARRZlQL7am9+tu5Ts1/kGlnQDFZ2RwF1IYioxedzbufsEa6ONqgOdJTENfDgWFsGv1uwWxxE8
 3aT/B9kG9BzBzQHubqHxSrmoeRGVXF/N3sxJ+oZxhjgcEBp5VXDhjec0ZN95EaPtPmhty6v+xuU
 f+SFtG6XSfqLUfvXUrvuKWDxlXLfwICtzCgO60wSrU1UQ9Lc+egI2meUi2Gg1L5kfSwa0eD6EYt
 Uk6BObq2y/ypWYw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_is_init_remote_addr' is not
specific to this PM: it is called from pm.c for both the in-kernel and
userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 2 +-
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/protocol.h   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 14c7ff5c606c4ad4b12ff5cbe96c1f2426fbd9c9..ab443b9f9c5f28e34791fa75ce42ee013ed70d78 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -231,7 +231,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
 	/* id0 should not have a different address */
-	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
 		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 43667ad4c4aeb6eb018d18849ff14b600a21816f..029a74162b0bce0d3f34f0aeb854ef1b99c020dd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -772,8 +772,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	}
 }
 
-bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *remote)
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote)
 {
 	struct mptcp_addr_info mpc_remote;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a5db1a297fbca84249c89757ed0001d01bcff169..39bcad1def6bc97a3eca91f5c409b50c8fa2cd8e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1006,8 +1006,8 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
-bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *remote);
+bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *remote);
 void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);

-- 
2.48.1


