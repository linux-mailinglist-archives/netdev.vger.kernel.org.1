Return-Path: <netdev+bounces-158976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C5A13FF4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B4B188E570
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C14241A15;
	Thu, 16 Jan 2025 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILehBrD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164EF241A0F;
	Thu, 16 Jan 2025 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046498; cv=none; b=m3lkzJT8xAnmYzKxMZ+dNPim3qIAO3AgVt8F9UAkRhGB/yMBZdezRmSa2RcRDu4OG1wx8HJ8fuegAlEdUeLb6WTFv5PjYz0IUDmwbmBXd0LT66qInIUQj1bkaH9nQhDECbSh0ATJpvwb3MwnOyBUI6NclL7Oc1tNnSuOAO3bMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046498; c=relaxed/simple;
	bh=hMA76qbYEKp2YrrM197S/JumQHpn+bPtipoM/dTb2KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPUsBdsMHiG9sge+5Y2qiWxdpyRyyZF5VnvBapQssg9ar/uxVH+iBwn8CG0ujTuC4C1RldLdZBYXcCdSu9RVXXQcKOgPT3cl8eMI+P+5s7aTvajVCScgNUxuOciglVTu3RZo9D1ixCJPxtDOFgq81mC9H9bxA5hN0taApLk4BUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILehBrD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8396C4CEEC;
	Thu, 16 Jan 2025 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046498;
	bh=hMA76qbYEKp2YrrM197S/JumQHpn+bPtipoM/dTb2KU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ILehBrD0f08vKTs0SO+W+zRda3ErsuyRGWOUagWw7nBNJRBgCnrjZglt9Kek6weEo
	 +5UUwbLOITJm99NtT4qyxl4BmEouiUHI4wNc3xz1e1SRA/Af9nbGv54o316BBgwBHB
	 /x+yj0itYOWc9td7MeX06ZOSqtIjylC+HYnLFv9Ph6xKXDCQtd3+e3ruloAX+9CcBy
	 TAw0xHv/wjSqrtXkQcbSKngI1ZaVgxWBaeqB4zgh7KQSBD0K7KIWmYeMPjGWunOv3F
	 OFxo217sDT5RgkXFMxGmvqvjcNdRnQlp1f/1we9nHUGM8OfPYChaW5SQShkCEuFbzC
	 XVQBomi1YuSEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:31 +0100
Subject: [PATCH net-next 09/15] mptcp: pm: make three pm wrappers static
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-9-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5676; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=plRm5q+b0IuVvggnzam7j8Wkrm7SvY5zh4+UeiXI36w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnHwokGmQhH4ySZpNKO/S/jDkTu1mLcnSp4v
 KzI3beU5oeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xwAKCRD2t4JPQmmg
 c5yGEACjI/kzX55LgjEYHodfqIihWNpKPlgo8bx5zeYnOiVO8B59iuDU59QEWPwez1lciyYOnKI
 c5/anvz/i4HdzdtR4WkJyIlTjfh8RwOGg5W4Usf6dzfI1aRWVawBVHLBMcbe5KcwqaOz8JJY3Ao
 y671c577i1OQQZmpStubbpWlaEh6hWLAijFzwc0mSzcNSTukPKFGqoRl55AqlXYOE05UbB/Vy4c
 9ehXZW+FD1hb77bhqF651kMKXPOtL0tp9Gfz68qHZZGkZ/rlPwffv3QGxTnv73pxS3AkhSss1gz
 O9ugIvaoxotcr4XMkUXlqj5D8XnPuknwBapi2zymoeXa9XAIEDSosz+CLja3RwBklsnn6PcbFEa
 XkYfEcSzPrBCbUgU3QBO3rlFZlcG0Eb+0oDYmHia2CUaQCVhjVxqo6uIU3Qtjqh/gFBp3ev27ES
 oPb944D58SKW5af0SeiR412vr9ADR/s856pjKjSNEylL0kb6dbrNbLPsKz7nZCOHMwffl0ZqUcg
 2oRJm3S9NbsY8Q0DogrjBc12IURjYa6jgLl5gZQ9e0iZEh+ei1nUub2QZEIeODAGuKdBNy59T3k
 e+Wh38KJJIgSOToZEJ4dwe0yCo33Zg29LLyRBZ4hlvo1Qxmvg9e2Btlu9lGZBhfo0E350wkJhnd
 tkmkfzgwChhGWDQ==
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
index cd5132fe7d22096dbf6867510c10693d42255a82..98e7262c6b06f96b9c3a8a711e4bb755015c118d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,7 +1031,6 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -1124,12 +1123,10 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
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


