Return-Path: <netdev+bounces-172888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF9A56685
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD751723B9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7821883C;
	Fri,  7 Mar 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp1UeZEJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C8218821;
	Fri,  7 Mar 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346522; cv=none; b=U7o9wJf724qz2rH0fqU6s8r/7SMBdPdSJljjjH7MHM6RbSfG7q5Pihq5bNE7Y30AAImdWPiY6ZZbJdMBpl2367gWUnNhWgOc/cbeFKCrrRgghQSlvilXTGZ0VOkA3g3cxsjNwe4K9T8hKUfPT+5tijH3GSX/513ipmkFpHeBL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346522; c=relaxed/simple;
	bh=wraKJjcQIEI8spB+CPyktQ15dNJmNDCdNNJAay6Qw3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCu7/kxTr5I/23G6ivrfpiJ0zgvsSY87gzZV1f0D2k3a3POKusKKDg9VBWhd8IBKjA+KxTPhDhKBaSaimFtMLbCStkst/2K44wUU+ijwmJV8J7M/WbHLA+3+Jm6SKvukF2HE8vIdzbKW19/5zghXFw1TX8lEkXdKkteS8cS5qhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp1UeZEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C6C4CEE5;
	Fri,  7 Mar 2025 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346522;
	bh=wraKJjcQIEI8spB+CPyktQ15dNJmNDCdNNJAay6Qw3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dp1UeZEJLsQm+zSXn45Xz9w7oHNKpHt7rnRqBIZbGbDuhBywyZ1B8wVyg9rdIh05I
	 sXIDDoLi+meOLrSZpgNtQkAkjr+PDa+besLMsbuK9b5/8rGlOXe7DP7yR6qD6ySx6Z
	 BcEw0ayVZFGeJOe/8tKACDpSjHcz8XSXfPnk7zERmmC2c4rnlq93AGU1MLiWr1wx9k
	 xMmEOq9HVTcMDf+Te+4HoBseqvU7pP69T6CG9pw1uG0vb1mol+UJubWM53I55fV1/K
	 f+5ktCUTgpPjpjQ8lNkzr6xn+08VK1ODMOGrATPebCwqm36/0raSRzSOq3LYa8OaZc
	 jgrGr20BTG4DQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:46 +0100
Subject: [PATCH net-next 02/15] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_addr_send_ack
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-2-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3983; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wraKJjcQIEI8spB+CPyktQ15dNJmNDCdNNJAay6Qw3U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbRYsPkLDj7xxWsM0PS90RJTgNf+QfBZ7WDJ
 GFyFyyUp3SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 cwh0EACuvG/0vHZKqsz9BAhVK66Zz6xP+oiqmdJJRk4j1xHFMGBMGUOrympgVEAXywXkzLvcfG0
 1rCNKzN8wK4YVrs2shGJsXASHzAq0uG5LTjvnEtkFTQHE4vng4I4pVilji2h+THnaJlyVN6Quht
 W0+iBTQXX0fd81xJcRaj18rlsz4mOQ3EHpOxKYLMoCzOZ9cuTBguKE7U6M67tRIp1r6fSYGIPk/
 Cnw/JtDSVoWUfQXMAl7kvUU1WneqthOy+6mNJB1mheLw5O4m9Q6rHOrwmjWiQ4icu83OCAUG/CY
 0gfLyN882a9i58shtIizVxi/vfE0tkrst29cOZ145wkBffcKhKIGDGChNfuGej5lJJK/hYBDqH1
 TMHl2iAqFzlZSQ85MsSkD8NLk+Keag5f9zBILHbalkViMRPt3JaD6AEch24Rtmy474ZAab+7R8i
 UJSGe96d6MHE2KS2OfD/50PIkJi3FlTdo8rG9FTWGBhx1MtLJQrrc/aQz5EAwk6ffCJ2LvP7OBE
 oY4ZEQhde7ORmd1NUpfSzDbhowlqjkHdxqUT9yq0jPmpMdP7lN4scCWdPrh1F1V81+Fw+XDiMMn
 BYi9dbmDQkvGI3DyCeNav165AdZF1lVWxSkuq6+nRX72llf7CFbpCLcTzqScAC14377bEdFFdqx
 FuztpmbNHqapskA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_addr_send_ack()' is not specific
to this PM: it is used by both the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 2 +-
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f6030ce04efdf20b512b3445fb909b4dec386b1a..ece706e8ed22bfd10249f6e655a0d790dcee34c1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -57,7 +57,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack(msk);
 	return 0;
 }
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 23c28e37ab8f1befb391894e465635ee523d54ed..a70a688eae845c562c03caa0f3e20169c5f5be11 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -606,7 +606,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			local.addr.id = 0;
 
 		mptcp_pm_announce_addr(msk, &local.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 
 		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 			signal_and_subflow = true;
@@ -740,7 +740,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 	remote = msk->pm.remote;
 	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_nl_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack(msk);
 
 	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
 		return;
@@ -781,7 +781,7 @@ bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
 }
 
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *alt = NULL;
 
@@ -942,7 +942,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
 		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8c45eebe9bbc755cc11dfb615be693799829f250..b41e1aaa1d1cbd8d185c1951b65984b7e5d64923 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -234,7 +234,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
+		mptcp_pm_addr_send_ack(msk);
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 333d20a018b42e8881b8ad62466a2f196e869bdc..2a3eb2392b3bb0f465948a0a881dafbe800efb3d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1008,7 +1008,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *remote);
-void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);

-- 
2.48.1


