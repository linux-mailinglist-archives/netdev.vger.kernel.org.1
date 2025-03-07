Return-Path: <netdev+bounces-172889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4184AA56687
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9317424D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8900521767A;
	Fri,  7 Mar 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld9VSUy+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D0217677;
	Fri,  7 Mar 2025 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346526; cv=none; b=TfQCxb0RwfjksKip2maV2UMq7w/xAn8jYSS2rRc66A7Tp2QArdCYOs0bcD5OX1NECI06ZiGgqsy0R40RS6C5VDltJ1FODjCnlcRSytmwDUmDEit6l6sHI9jVobkSlFe25qljVMKcbsvD112QH28FUPDv7TzfvvkgKWNiOVxDzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346526; c=relaxed/simple;
	bh=Ognjss0ARFmH37zOA83f7DzMVpKo1NoZCeLILxiSTh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quIFUpVln1fR0YwvAVdgJhxk3GY+edgBSfT8kwmjvnp/7cqcivkNH43jg8eDHtgd3j9BN+vYL+Asw21y8FNaEIbCnZp5om7I9hgNZ2gRQUd4v3VuflvEfkrP2715jPie2TFftVxdxB3nMERBuVSAL9CLLGAsMAzwQ+dD8zqO62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld9VSUy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810C0C4CED1;
	Fri,  7 Mar 2025 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346524;
	bh=Ognjss0ARFmH37zOA83f7DzMVpKo1NoZCeLILxiSTh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ld9VSUy+MHLqdxi78DfRaky6Zf9ju4bEXLqsdHlDYelC6Ri9U/tKLDeOBPB/s8Nar
	 qi9R2nfty3hUWqHB+cla0NCo++asj8PL5KVkGBxL7dwPNb0g+PbX19uqz6KT9dM4MN
	 kLyyy+yVE6LRgtNdYDlKfAHWf6aZRyQY/feFlHiagNxhahHZOzn0gDHjEl5O7BCvMs
	 GZiWl6YUM7PAzSqPemnoXHS/DFNNAwcyLJoiPGaZhmGsVZbI03C4Pg5veu87HhtSIk
	 L2jYN7A/VQdjlhFPFn50N0K3mY0Mg2RiNzdkW5CLeJOLCHd535dJNKKnweRMyIcNwx
	 b85AAncIrBmbg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:47 +0100
Subject: [PATCH net-next 03/15] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_mp_prio_send_ack
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-3-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3417; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ognjss0ARFmH37zOA83f7DzMVpKo1NoZCeLILxiSTh0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbRxbZIvFQ4ZIBoIOusSHr1dTpbET1lmOmRa
 MlmgZY/zOCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c/kLEACLmAmxkuVcCoomiTrSBxVrFOeg9jkfe3Qh2UQlVR5+m3x/odCCaypdfZ6SDi3XDpBzvep
 3aYvRQoXf1O3dPQzBHUB8Y+5eVk6LaAPxtriPOHeRpm9z6faSpvdOxpM047DJiC0arDj4P8G3hn
 AtcEB449YucCFBPe7ZhZ1dqDKXGNXdtOfTqfsHzxgsKOyRnxgvubUnDqlvtsBJrbn58KviqGdu1
 gpJcyf7SsbO4s6VUWlQuds/k5k2nZssnPOpLXehYO4Dxk/ca6XSaQAz2ar8JSu0arTkcn2xnHWt
 blCHqyx4ISVgne6dDbOJlHt0NcFX/A7W2m1Sdd8JOfc4lrdGibvCNsMaQKo5nQSXODj321K5Kcb
 MUanUiBSIqCJRWrJnTJVnlAxEZDZSLPY8J872jBLG7hr1K9Xcy8dPaYEx9G27bX6SizcLtjWivE
 N1H/VdlFWG1Hx003MnBd1KxqwuW0eOzEystcMYWzzaiFna99bps4LeJg4ryTKK6/+Ye583nti7c
 106g/Rz4ZDUmHg6T3PXnSPVnVQbbSKqm4/PXnIx53dMechH0tJT6lBxr6H+fxF/KTUZGbFVzuRU
 YeWCBnNv96ZEBSz6bY7zt49lZCqr2r7qJmzQDkPeNkQvwtSAjrf/arpI6/E0ZJ9/0smxk9F+WCj
 M2efL6c7P8OixOQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_mp_prio_send_ack()' is not
specific to this PM: it is used by both the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 10 +++++-----
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a70a688eae845c562c03caa0f3e20169c5f5be11..5494b5b409dc478dc783844b9cfdef870688d17e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -808,10 +808,10 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 		mptcp_pm_send_ack(msk, alt, false, false);
 }
 
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 struct mptcp_addr_info *rem,
-				 u8 bkup)
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup)
 {
 	struct mptcp_subflow_context *subflow;
 
@@ -1936,7 +1936,7 @@ static void mptcp_nl_set_flags(struct net *net,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
+			mptcp_pm_mp_prio_send_ack(msk, &local->addr, NULL, bkup);
 		/* Subflows will only be recreated if the SUBFLOW flag is set */
 		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			mptcp_pm_nl_fullmesh(msk, &local->addr);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b41e1aaa1d1cbd8d185c1951b65984b7e5d64923..2626b2b092d4ee901417fca89c0e2266398d54d2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -605,10 +605,10 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
+	ret = mptcp_pm_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
 	release_sock(sk);
 
-	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
+	/* mptcp_pm_mp_prio_send_ack() only fails in one case */
 	if (ret < 0)
 		GENL_SET_ERR_MSG(info, "subflow not found");
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2a3eb2392b3bb0f465948a0a881dafbe800efb3d..5508343f2c698e997a7c22f4511a036888993f7a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1013,10 +1013,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 struct mptcp_addr_info *rem,
-				 u8 bkup);
+int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr,
+			      struct mptcp_addr_info *rem,
+			      u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);

-- 
2.48.1


