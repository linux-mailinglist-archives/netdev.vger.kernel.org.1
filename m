Return-Path: <netdev+bounces-172897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8FA5669A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E171899ADA
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359B21B91D;
	Fri,  7 Mar 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmKM1U7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C82185A8;
	Fri,  7 Mar 2025 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346549; cv=none; b=IPV5PzCAe+4ykz+afzyajoJRxhnYcdhcmJmpmXkOuQLp++6USgzW3Cf7sli9BTtKcm29yqh2tJqfHCMp0lUYOuVrsdpJ0wVJmQ7b4qI6SEseJo/BNQchGonXIDMQ6lhzwhLRhW+mS9gMclC2o8nbOhfYBOOkA0PGmg3PtEtk/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346549; c=relaxed/simple;
	bh=PPfK/VTRkAcax3nPDPEwX4l6GH97+UW8KyR5jOc+9S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6Osg1C2xvj6dUWAfCselpxArGeEE3+n1iSmWUdZS+GR8VSnJnG/dVKM+0GZMNYsWaMNqDK1YzxoP1JGcoDMFd1iXO/dv+4OM4oMCTP7rVVxXBoRlyvO6ALSqG7FmMeH6axLExED9hDH1cGlDQblIet0ah287OzmJScNyxsjfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmKM1U7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D48C4CEEB;
	Fri,  7 Mar 2025 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346548;
	bh=PPfK/VTRkAcax3nPDPEwX4l6GH97+UW8KyR5jOc+9S4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JmKM1U7xfpZgUQggswqwdorAkuuo1MV+D8H39awZEA4fXnrqeA6bVwx6mYc4OJ9bv
	 aC6DW4v1xUD40iTauZXaCPbdp0j+9TSt2SJFPfdXzIqZZDNlRQsdgmOuJIfdUQ8jA2
	 h3ZtWT+UWr2PcoEG534L+Q3qwtSn3zlJvwcbNaqNEtMqg5+bHID3KBh4nrId0OuQ8J
	 vT4u5NRz6G4h+VCk7t1GCT1VozinoRvhZc5kllaLXBVrdAerRSDAa8b+Ayg49RSUkL
	 Iv/Rvo0fydX+1PCSoqyD1c9Wqml3AyOxP8RWEP/oTyW0ewrH6cfcYue4qMgPo1zfU4
	 twDN0BgOkzoOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:55 +0100
Subject: [PATCH net-next 11/15] mptcp: pm: export mptcp_remote_address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-11-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3712; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PPfK/VTRkAcax3nPDPEwX4l6GH97+UW8KyR5jOc+9S4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbReDcaDbzaenv1ywRZUO5jj0GBmySsSDLpk
 KDnPMbUCE2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c9CoEACz6J2MxYSou0i9QaCm8sbwaL7SxYxD3gOnNfbitAxzfap8VyDThN0AWYc3PcKqDSnDUhR
 AstOk+8Ec8z3gfcyV50Kl+9C+Fg03fVWlsVqPI8uCmbr01Ha6aDjiRkzn5yh5XAqSKy/ZWzZ1xv
 sbQIRDQitzAI6riXBtma8bZSLjRzjIFaXRkVGsQH1OhRInvOhwQg09oFVDGTLaZhSucQPX/2DgU
 UdVF4uQBga7iMsXs3UTUrozTxmlmmSI66NBOJlaoSrSXlBkXst1yvkVGVoWLEMBoqPhQCU0WIA4
 tvxSAFHYg2W5C2XJUHgXRISZ0iany8tVgMQkM6fcm/fPKCrGJsS6/wz/z7zOSt8dEuoJ+1fLPku
 OZg44WB3QAZ59XRAddWGs/C6aYViZ8BzIzRlj+yYwVfxxXJMTTi8jUZsd4Q7fd4DUWxEyCvpJ8o
 b7gUjDJJgTUuRtgzmcEZQM/pvJAdXHoSY1v4k6nI9WBSUSuNM0lYt1TRHojUVXgQD5OthGqtAmA
 mKhCIvGhb05bD7Ztg4ruFpsUqf5K7SCP+DVuqRxCmXs8J4tdkexmgtliISm6eMvqasT5pxKh6L+
 cWZuGdV9QFxxlwQQdQizCMO+YS/2Izpy7ZckkCEC0iR2Cga0x3WobDXgoz9dKxZBqFZSouuecuv
 s/p7QkVwRkw9rqQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In a following commit, the 'remote_address' helper will need to be used
from different files.

It is then exported, and prefixed with 'mptcp_', similar to
'mptcp_local_address'.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 14 +++++++-------
 net/mptcp/protocol.h   |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 37986208b9c0aac48d9a7b29fb37e11e947f0d66..27b8daf3bc3ff550b61fc9fdbd6f728804ea43bf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -94,8 +94,8 @@ void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *
 #endif
 }
 
-static void remote_address(const struct sock_common *skc,
-			   struct mptcp_addr_info *addr)
+void mptcp_remote_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = skc->skc_dport;
@@ -138,7 +138,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
 			continue;
 
-		remote_address((struct sock_common *)ssk, &cur);
+		mptcp_remote_address((struct sock_common *)ssk, &cur);
 		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}
@@ -428,7 +428,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 	int i = 0;
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
-	remote_address((struct sock_common *)sk, &remote);
+	mptcp_remote_address((struct sock_common *)sk, &remote);
 
 	/* Non-fullmesh endpoint, fill in the single entry
 	 * corresponding to the primary MPC subflow remote address
@@ -455,7 +455,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
-			remote_address((struct sock_common *)ssk, &addrs[i]);
+			mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 			addrs[i].id = READ_ONCE(subflow->remote_id);
 			if (deny_id0 && !addrs[i].id)
 				continue;
@@ -777,7 +777,7 @@ bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
 {
 	struct mptcp_addr_info mpc_remote;
 
-	remote_address((struct sock_common *)msk, &mpc_remote);
+	mptcp_remote_address((struct sock_common *)msk, &mpc_remote);
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
@@ -826,7 +826,7 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			continue;
 
 		if (rem && rem->family != AF_UNSPEC) {
-			remote_address((struct sock_common *)ssk, &remote);
+			mptcp_remote_address((struct sock_common *)ssk, &remote);
 			if (!mptcp_addresses_equal(&remote, rem, rem->port))
 				continue;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d4725b32aa567806ebf720347ecae80e22169828..f66c3d28333fc6abe4ea285207fdc0b78dbea9d8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -724,7 +724,10 @@ void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
+void mptcp_local_address(const struct sock_common *skc,
+			 struct mptcp_addr_info *addr);
+void mptcp_remote_address(const struct sock_common *skc,
+			  struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,

-- 
2.48.1


