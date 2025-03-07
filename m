Return-Path: <netdev+bounces-172890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B241CA56689
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132753B2E2F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660A218EA1;
	Fri,  7 Mar 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sodBnU5H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED3218E97;
	Fri,  7 Mar 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346527; cv=none; b=AYSchBMdU6EGufkE6/SrVve/2op4BVgY8rBLd/ML6mY2G6kFjcZENS692CUsglz9AVbZJPnjFTwztganvIPFh+2KTzCVAhjJaaeWKxs4OipS4Umap5BoLehv6JL2iO7LRAbXIXRnN/+92xqJ023r0+h82ThHV7YuTZ+NO7LHsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346527; c=relaxed/simple;
	bh=CjrY1RNbFszjRunoHo+IGOyVetFJQRPfEGje4rJsH6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5mOwIQK/9LmqzFXzHzG7I2Lga6rFmVMqyRmhzGgKzqGJZMoxOg6TBxx53JgMfiulCphtwlXsntsySfG1TZFpHCVYJB+gz5gt8B6GTSR1wZ6dE7W+fF8Id5n6RFYVrSKAwNjTzhQH6qPTEnZzgMdpb4LfZvSkxS1mvamEVSTeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sodBnU5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3371EC4CEE9;
	Fri,  7 Mar 2025 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346527;
	bh=CjrY1RNbFszjRunoHo+IGOyVetFJQRPfEGje4rJsH6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sodBnU5H4ceKW7XqMPOjbPC6IXeDFja0wJ1l/Vb0H+W4GFYErN8+vAnR8VXmFQyXT
	 3jRAaT8PToLMee55xQlAitcZVJoURSVFYPmhfskz4lgKj/5leL+P6vT/u80aYhNz/d
	 ybdYXmDCnossgll449rK5rkHIKdWl2YikTb0zvrO+q60ERsdXi3iQS/1OkurivWP+N
	 zhTMzum3cY0cJ6aTNqk53YoyEe34p7bSZAPvE8mB1/rVj7M6AklA3vuad8QYku+2H6
	 4Z1+scctzoxu8X0WVa04VbxcNJ5AFKDINiyjMrVsJGCSNiFcQ9+tybSiQ3VtbAnUHR
	 VmX5dbqYhBOdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:48 +0100
Subject: [PATCH net-next 04/15] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_work
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-4-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CjrY1RNbFszjRunoHo+IGOyVetFJQRPfEGje4rJsH6c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbR4J6d8BgfZoqx1lLykQY/XIIje6Mh9B4kR
 +F+IxEsVsKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c/19EACEfAHmsCowwwm3o+GxXym9/kNJh4AGgrRruaZVvM+sB19C8Io0ILMvCMj0wHztvSMWDUz
 NGB5o6xlPaolpmAiWDCDOkRvzMVH3lbjsF3j6gFmkv+3JIKsLDRjXjOvaI88ZuoU+jHVityLUSl
 zDLn3x0jjcn8q7QACKxfC9ms4kmtldBBnEN0W5ikZzhqwU9OkDe29btUsoKhOXirlO/Fws+SS9l
 Qg+Rnv/vt5z5Cio+Qp8Dz2/xXH531Lj8yDd7EHTN7V2wYBvEpPcVKeEoSgdeSKNpTIY9oR3wtvZ
 j5gGPWbiWocDckp8uncyoH66IENDmL0pvxuiDkCPbfXOKYm2bh4c3oD86Fau1aNDCb26qXDLcIN
 0rqSqqtWAjyT3PG9xvLofltn8mNbudxiA3Ms/5r2vfx2jld1csA0mSjb0WxHvCD5dTud4IU7JSu
 TNHZrV5K9fr9N0HqyjWsrqbvmwQxox3NQ7rWLUOp3ohwxVyZ75ryJo6Z0M05B1U5XOUrvId5HQA
 fZISnbTh6k8RCjbV7I0hMbh82lzjcy9IQ24xKdUaNwZrptjehd8D5C+EGyCwbKNEb3B+RdFNmi2
 z5BVPwT8ap2QPyLXPv34xzwCvKOa5wpxTaDo6m66lEJrw2XJRe3bkCoJAZDxWQQOOO++30+VBNp
 LnRGJZuKMuZZtWg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_work' is not specific to this PM:
it is called from the core to call helpers, some of them needed by both
the in-kernel and userspace PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

Also used 'worker' instead of 'work', similar to protocol.c's worker.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/protocol.c   | 2 +-
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5494b5b409dc478dc783844b9cfdef870688d17e..f6f7ea25640b7f0f71fc6cc3217ea278e15a4c13 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -924,7 +924,7 @@ static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
-void mptcp_pm_nl_work(struct mptcp_sock *msk)
+void mptcp_pm_worker(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ec23e65ef0f11928c35e3c992b8f750266b504f8..ac946263ec64f2c0fc5e53dd50f14c721ee463a1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2681,7 +2681,7 @@ static void mptcp_worker(struct work_struct *work)
 
 	mptcp_check_fastclose(msk);
 
-	mptcp_pm_nl_work(msk);
+	mptcp_pm_worker(msk);
 
 	mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin_ack(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5508343f2c698e997a7c22f4511a036888993f7a..f29f4dd28fc5680b3021154e8999743f08658f37 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1147,7 +1147,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
-void mptcp_pm_nl_work(struct mptcp_sock *msk);
+void mptcp_pm_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

-- 
2.48.1


