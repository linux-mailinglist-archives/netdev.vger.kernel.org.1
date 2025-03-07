Return-Path: <netdev+bounces-172892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B989DA5668C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59759177ED0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5A21771E;
	Fri,  7 Mar 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMCGqvJT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE151219A8D;
	Fri,  7 Mar 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346533; cv=none; b=fRbjiW3NBT0CM77Z0rDPkIzNemAl4Rn3lf/7cgLqbSW9HFVxYhoBZc1YIn5KouBjQRLt02auoG3KfgUKww6wu7xbPbhKggRAMgrwXUHlLpuqs2rAsmgIKOWaU02t5O30VrLg8Ar4BnCuYLDls7GJZb4GFlKcdqxYYcHgPsKhSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346533; c=relaxed/simple;
	bh=lllgLDaQsikbG+Vl3Zz+icDTHhKM3HQAr1lmgZE3Hhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYSu8I1Fi4/y6dbrryF344/MixF1ncqkHAxmNhkLRvsA9j4cfiQ2I5Bze2vDvH1yRFe2uXivU93Bz8jnTQW1dgo9j9DnAzCmJPfF+d+jrUxyGdF6BECDm07VwszFCsxV2lTM2fnT/m4oSxt0KAM2ewo1ayAIaafnp1lUM8usO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMCGqvJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E249C4CED1;
	Fri,  7 Mar 2025 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346532;
	bh=lllgLDaQsikbG+Vl3Zz+icDTHhKM3HQAr1lmgZE3Hhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iMCGqvJT5zwcEhw5y45poGc03x8AvFmW9nmJBcI0Dw+YI/pNa6JFh7n+g2wX3GXR2
	 T3sFKYL6Emj/Z5nkeR4IPTPXYCvLKxhlU44NARPAYQdW38tSs6nv7uO6XzPE9swAQ4
	 LVQtK0t8v2/EBvz4LlFhemMsQafqAsPxy2NmfVP2D4klL9XzKw6W3ecnNuO2b/gLKx
	 SVnx4T1UDOvpaWwRLmAEM1r1pDf+hVfL/nEYEzEOD7t5sJjYW8rkZq1r9jLMqr3i/S
	 Y/T4atyzraSIvRENsLBFS5n6iYdlMDmhjYeK7jC7xhjuEexz2TkrGyIUhNypqAqfwb
	 LmcrDAgE6QeMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:50 +0100
Subject: [PATCH net-next 06/15] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_subflow_chk_stale()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-6-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lllgLDaQsikbG+Vl3Zz+icDTHhKM3HQAr1lmgZE3Hhs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbRSvU5ghTg4jpF4FYLXiL43S0Wie+DG63gp
 igidbrgLXWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 cyHrD/9PhuOiBbwKA0Qjin7HrahmhBTnuVEc6EbEz/I6DNh8I+s+TXk32X1jfOQQ/uSi6p57kee
 o0xaGqcuZhhZ/WnHh2LloTDIZ+TU+W8Yfqyqur2u9Wrn+1HJ5OFVcI+odJQ1cLXprp1sMCCYjiJ
 cCJgkL5A2bpLCb1k46MtDLxZX76e4nIRTcysx2VTsSR2RbHZtqCc3QVwtUiVkf4oFbrFLrusmut
 6pNadCdMvx1AiT7DKYEyRHVKPRf8AnEp74UmGrnVLVTWm2lmibTFAev5Owg2S8dCCnRcr6yWs6A
 SYcfnadrsRfNb9aXz8URLtnQZrOlwBJipa0b9VE2gJqhlaQUWqIisQdil9E870NLZB4/dtz0aQ/
 ISgSMbztAHTEJU9FNRIk4GIbAa6ijLff4P3sRk1VJ7VTREK4HQwQi7lIOEKDMTVorAjYvlgUOB2
 DSmfELJRR4vsPI0ZkIGqts5tTwHwX4RnytVymGKU9sz+AWiU415NuLPXakfmkHU6sjhuxMwQgui
 YBqZjmPQBxwfb5o89IT0LOpj0hduy95gAVca3mDaSpKO0c7+4TzpyHW+0f7grO4oTYtqhqHW5hn
 F2gMLMEJIs/FZh92x/AmOQm9zgWbN+YiV72VoOCmw0M3RAN8kqBas/3dlDfHEwRPE8zxAprrqAa
 tER1atE5dwLcVNQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_subflow_chk_stale' is not specific
to this PM: it is called from pm.c for both the in-kernel and userspace
PMs.

To avoid confusions, the '_nl' bit has been removed from the name.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 2 +-
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ece706e8ed22bfd10249f6e655a0d790dcee34c1..14c7ff5c606c4ad4b12ff5cbe96c1f2426fbd9c9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -567,7 +567,7 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
 		if (subflow->stale_count < U8_MAX)
 			subflow->stale_count++;
-		mptcp_pm_nl_subflow_chk_stale(msk, ssk);
+		mptcp_pm_subflows_chk_stale(msk, ssk);
 	} else {
 		subflow->stale_count = 0;
 		mptcp_subflow_set_active(subflow);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 09ef3aa025e7094392badfcc24a964c0a530ca5d..43667ad4c4aeb6eb018d18849ff14b600a21816f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1203,7 +1203,7 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 					  },
 };
 
-void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f29f4dd28fc5680b3021154e8999743f08658f37..a5db1a297fbca84249c89757ed0001d01bcff169 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -992,7 +992,7 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
-void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
+void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);

-- 
2.48.1


