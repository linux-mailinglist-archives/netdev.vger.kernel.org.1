Return-Path: <netdev+bounces-159433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD5DA15781
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F2B3A4289
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B061DFE0F;
	Fri, 17 Jan 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STLBqNTy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFA1DFE08;
	Fri, 17 Jan 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139333; cv=none; b=QV7qXAZU2r2efK1nloIisdSFO8OHIw2XSNccPh45HICDRHXMjVez7azF0lw16g5O6frcM3tR9toiTuVq3YabfuO6w9zpVqMwaJCuJpd5RNJ1kPacr7hfRH2yw/+VbIN/lmNFq23XtFUfQacAFY8JtY5H2p5jyLPX7UVZiiJMKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139333; c=relaxed/simple;
	bh=Xid79KRezN4YhYfSBbXxnXGqy4sFTqyai8Nz2wwthIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VT8siEsTzIw5F7X98LAo7sc0EONbKQSHmWJNQFNfqLN24+9PqDHIcufk0JDgggQqFxlr1atdJMo7J+yFlQNO7qLvZiXLoPC4g8yoJbC/SdzGnrs5VBZTsZ2sDL0jEdXJYwDRhHFSlLQosHoTaiKqYYUvDMa7D5qKApGoAcqssa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STLBqNTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198ACC4CEE2;
	Fri, 17 Jan 2025 18:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139333;
	bh=Xid79KRezN4YhYfSBbXxnXGqy4sFTqyai8Nz2wwthIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=STLBqNTy1SehVCmKzzsXHu8lpvDJtIuod++bEnoXJK8GY2pegDlBlwek8E7DnZGcn
	 Tc2z4TqwXRRG4OfOO8ifb5QvXw8tCJBgX7NAOLls9zorZXaeoIC8cvbCCQyM9zLVAr
	 dGvHxIatnmuDjqowILFGWCPMdWu6/o5zE/ABrFhSnEldh5E6sspaSn4oJ8Uqp8xdGD
	 3IHqEU7sHTuIZNj+3y9r2la9Mndz7PYRiYnKDFYYeGG3NKSO9WaxlKrLRFMreqMBsN
	 GiyQn7r2zMkcl9PNgAn2Ms3Y6TssRKXMC6iEUAIs1kNtLjJFdEu2Kj7Thw4vPu268E
	 66SubfbecoOMg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:41 +0100
Subject: [PATCH net-next v2 09/15] mptcp: pm: make three pm wrappers static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-9-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XWiaBBltaqmw0KW541qBtTILXfEM/Eu9eAIsZKblGzA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRq0m3v3b9wiJ6ZgAifofSDPJP1j0QSzYQrA
 SuY9dvyHwWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 cz/pD/9ZBDnHvK7xlIPl6LIGKQrzfcsLlL4osNrXvuowGSZRvllEckIRMT5KLHNeswdcJkYSVRm
 wjbsXLBOiL5CB8xeywzaMRiR5hZQAQsBSK2zaxL+60mjhpmCH7CZrkzH8xDC4I74WxrCNdWXgrN
 Es4XzC6HDicpOoDI2lRYg4LVnmYWHptuoaq/WhcaBsrEthuz4dmkOIMZx0TnGEi7ozK/1iJV3IF
 mjjIROMQTS5aolQNDIAO8cH+wqP0JTnkW5vfIWfkV4Yt6B0dKiZUdfKALZAFS6QgbI1dNrRHLXb
 3KF5ZoQqRGuLZDsHNMk/5T+2fI02k1syOYK9+7fXA8vSaOjeLzyfEEcSxMOj4BiqFGhKe6FDAfn
 vC6lNjBq5xOruLWnDASerRFPuQndt8yETiCMOjBf7+LqoLUsyY5BDATFEe9twNZDwmbnq8b9lyJ
 CpXrc2jgE6gnVX8egFpk9UxkFURH7TuDb4cpzOi5kXNEr7QqcmLO3F3LBvIbAauv8fVVQYsEksg
 Ubo9I6/IUB8zHBmeWjnd2SBvN8xnfFUfAht8s1gHs1U8ZQB0yP2bHYn4khBKyVj9+4MH/AsdhM3
 e5JXDiXHhSSZOO4hMjGyid4WckOBUKmr4GSCJt278qyM8V7GpLwiVw4JrIWEq515Ejj66wYp+zY
 xY0eXwPmBc9o7sA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Three netlink functions:

	mptcp_pm_nl_get_addr_doit()
	mptcp_pm_nl_get_addr_dumpit()
	mptcp_pm_nl_set_flags_doit()

are generic, implemented for each PM, in-kernel PM and userspace PM. It's
clearer to move them from pm_netlink.c to pm.c.

And the linked three path manager wrappers

	mptcp_pm_get_addr()
	mptcp_pm_dump_addr()
	mptcp_pm_set_flags()

can be changed as static functions, no need to export them in protocol.h.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 23 ++++++++++++++++++++---
 net/mptcp/pm_netlink.c | 16 ----------------
 net/mptcp/protocol.h   |  3 ---
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c519403d0147c5a3ffe301d0238c5b250a..a29be5ff73a6b5ca8241a939f9a029bc39914374 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,6 +10,7 @@
 #include "protocol.h"
 
 #include "mib.h"
+#include "mptcp_pm_gen.h"
 
 /* path manager command handlers */
 
@@ -433,14 +434,19 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(skb, info);
 	return mptcp_pm_nl_get_addr(skb, info);
 }
 
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
 
@@ -449,13 +455,24 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
 
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
+static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_set_flags(skb, info);
 	return mptcp_pm_nl_set_flags(skb, info);
 }
 
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_set_flags(skb, info);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 04ab3328c785e804322dbe4fc56da85a58b8e0ea..460588833639e88c51a6e1f417bd4ba1a8039d47 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1827,11 +1827,6 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_get_addr(skb, info);
-}
-
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
@@ -1875,12 +1870,6 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
-{
-	return mptcp_pm_dump_addr(msg, cb);
-}
-
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
@@ -2057,11 +2046,6 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_set_flags(skb, info);
-}
-
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
 {
 	genlmsg_multicast_netns(&mptcp_genl_family, net,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0174a5aad2796c6e943e618bb677a2baff6eab22..0b531b7a226d4e34bcd2314a6f2c94cd1dd49870 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1036,7 +1036,6 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -1129,12 +1128,10 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);

-- 
2.47.1


