Return-Path: <netdev+bounces-164016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD01A2C47D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51D2188E56B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7739237190;
	Fri,  7 Feb 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNn+Gf5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27221B19F;
	Fri,  7 Feb 2025 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936791; cv=none; b=fGQS+PiHYjE++/yIoCdew8P8OEyUH7ge6qqnGM5l3dO4mtp1lf09wwOrz/IZYBrb4gVbSkWWC49gtdXMWNKDYkClbd4PqVbiAipAetv4LLOh73L88IGB9e95+dKsS0SaUGehN2KBQ6KIPZAQJLPX5PG5b7KQXxWVtKei32RitQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936791; c=relaxed/simple;
	bh=wCPpMDWHdoz7dX3xFDF3ZrwfXwNwryRxHCwb8iZL568=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3+2sqi1yeBxT3T8mPckIMIU54GW9XMgzexteRazJ6IUdKh9nGkkyJicKeEmC4gnyhsXggMIfzXwtPKbNz4ZHCiunEOHFLumDpectTh/O+nS6hPTPHzFyPFwmCr2LrvvWP+2OVnPIAeMjMFT2p33aUGz0+Sws0lhDfWF+K+3GkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNn+Gf5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BBDC4CEDF;
	Fri,  7 Feb 2025 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936791;
	bh=wCPpMDWHdoz7dX3xFDF3ZrwfXwNwryRxHCwb8iZL568=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GNn+Gf5pZkRykJrn415HKELLfffu8fcwYDGSZDkPPpkTlZJPvgBtMkIL02O1/QBuz
	 RSYrETgYWoVYM0VDxlJbPrJTpJVSJO2HlBGg12bFyKae488podBELvVUSBNXTJb/J7
	 FmzivHtzvTLmMN9dYVoE10BQsJA7pP/JNShU7CGniyrL4UB/XOye9Fh9d0CJ4R431a
	 YUE3OX8tDspQt23vWbYmCl8FJdxW8Uc5XSkphr+GVwhTOlOwJhjyb9/gftkciW6blD
	 Ir2cCwIGYM4Psb+/nRkGghlNYhcKeoUPAlWoMKKAfCzP3DxF3LJTTvuKH9WM2EVWYp
	 7jq+r89EkMoHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:27 +0100
Subject: [PATCH net-next v3 09/15] mptcp: pm: make three pm wrappers static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-9-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xPkV7ab/k292qOjMiW3wjSm8TB1Q5o1v7/i0nm0h7gc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG9LWCc+ddgqunpgoeVNZ5fcWwJzfALPGwIJ
 NsoftTlvWyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 cwblD/oDkCYcamQH4cmbVXxealsiRsDXk7q2RjszvdkLKw4c6Gm1BWdb3bK6in5eMrPBIn3hh7/
 qiftiAayS1iBm3XjFkmXzF1WS6Y1MV0O7FCX4XzRdUadIP+XU728WlhLMD82ZM0PNdWt323s2HS
 CTMEYgiq7+u8hy124ZbdF9Uwh+f1JcvtpWl2Xs7Aw3BA84uHWkfK0+WzQo5gLndWtC34Oe7QGZC
 wk+QjMv/Xi2BF6FriRFkJewSoRwa4Q/9Ww+ANO3BTL85Bh+6dBNHogkNVpQvgfs9genJRH7FCSB
 aCWAhl7lt9QnmkorZ/5OALmH7BjwCMgjNMJ6UjEkM7lLIwpFrmZ53GvB7a4GcQAqj71Uh68EIh1
 MHNbCjkIEVQDL42zzf5E9Gw+2zQ/+HqyOOu8z3VIQHPK/hF9mYzcto/YiYv8x9w5jQk3gPoLaYe
 47FFqD1ILNDCs2VS7L9apW5uxphcAl7xPgsm5lU+IKgvRdhW1Ygpz4A9VA7e1zn7SU9feSLH3pD
 CF0Gi6BzXDqOV+vMs287b+5hcI1Rj2DRKDp0sBi1f4bRz5/40+vVTZcMmwc9dc6sS57217pmipP
 5IKbWU9KhLZCooijliEbcPenZLTWn0CyDAe1Ko8gcpd3/gRxxWAdsWm68RPFxhJv+8Oa46rmTBW
 ewSUaWI3xCqBjSA==
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
index bbdfb7700538e6570f5b743f8b3e37eecc3742b5..eb8f68ee24cfbd25db1a3193a164d75bc9a9d1f6 100644
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
@@ -2058,11 +2047,6 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
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
index f6a207958459db5bd39f91ed7431b5a766669f92..6bfcde68d915cf221109ede3ac334c7b2cc51131 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1038,7 +1038,6 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -1131,12 +1130,10 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
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


