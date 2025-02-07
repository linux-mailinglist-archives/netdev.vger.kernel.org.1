Return-Path: <netdev+bounces-164008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBCA2C45D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E43A22C5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F012066D7;
	Fri,  7 Feb 2025 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV5WFwb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF371FF7B7;
	Fri,  7 Feb 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936772; cv=none; b=Dr7TVQnpXYYOnyQwTgT3JLkHG2o2K+fn8TOtk6jY5wKc8ujmECcT0bniTSuBxLp5k9nFDtakWdzEKt08c3eLinQtPiOLbu3FhiaT71+3VlXKalmmAh1IGurJFYq6cVdkNJs57KRS9/d1vhxU7WlNG+qyHmJYVwMmcG/scyuSKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936772; c=relaxed/simple;
	bh=8G7twJP3JZxNmu7hReZPonWiPiIdhHNGTM+TQzqkMBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFj7LIjS+SV2ffx1vdFCK/nJMk5mcq8PVpnZ9i6BmvfSoryRpIh/+XlvN4QLcU0y43DDTNWU/LH1w2zHVUA1/4zRzZpN0XxRqnWWJGPDxHsGU9wphOCXmJOmFhOogp5vvh6Oj6n5WzzQ27DWoIgTEqTneSeX+Ecqim9eH6ThzOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV5WFwb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8360C4CEDF;
	Fri,  7 Feb 2025 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936771;
	bh=8G7twJP3JZxNmu7hReZPonWiPiIdhHNGTM+TQzqkMBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AV5WFwb2SD6u13LgxroMbVw6+/f5Msf2KZ0ELFPU2XApqMWNutVVHgSX1NVz7Dm3Y
	 t/vOxrov4/d5MvOXCJyXJLax26kwuNoQb12qVL8ZUmkUppJjLXIIKFQUZe0X+MdaOb
	 ubJ7XgguzUNs4OWXAICzfJHUrCgftdJiLEtBIUr5BLHOtGofuwSC2K0owtg5N5kFHw
	 NUfgG6U+lsVp9uTUHU6vQFF4ngD2oVhBt/VVvA4MXYbUXKsvIa842A5xomoOeopFE2
	 GrVbhDvHKoqoSjxPcwWWwKhSx70+SpX2TLC+I7BAcThCGgu4GWRwHb5a01PTL+kYYD
	 BjT411IEtYJYg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:19 +0100
Subject: [PATCH net-next v3 01/15] mptcp: pm: drop info of
 userspace_pm_remove_id_zero_address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-1-71753ed957de@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SnxuSp6YUyRM6PZLIJsCP27P8V93DanF7P4jRs0o2fg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG95yUvMfTLqrLRlVSzW6YN5nsWxCQuRe5aL
 BL8hHzyDPiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 c5snEACPFECu+UiQ2A68W84Dw/2xzL+KDlOhZ3ShBt7VZmmE+Ovx3KEvGmJFHfZSwyqMVNi7UJj
 xLgb+DuEG/DsDu5eoiK4QaM7pxhH70KdPVzwVKUrnOO61SBkuMuJyo4DGL6Bee9FH9ZrCLYnY6f
 qWcBp/dzXmc8FanP56Ggco6pVZqytyIx0IWbr784KmapUT4qgNPE6d2JjJy4m5ZQrFcucyr+QWg
 HRnfZriFJkrK3eTaVOdRZ4BZZT4Z7P2AHgzKAFavpGD0o29YbjcItOOGs+sWWFEj9fypPw5lN8A
 tjnWFAgn09cmquTZLmO/6emTZw+A0wxagQyPIiZmYx8VCdXJtQnDIIa0MmLRcinAP1/ury0GiC4
 KMBsWKnAc0z3309oDDrkGulK3TRLD3BzDL9h0A2DHh+zt2z8eEj7jMue5s+wWnLX+Pv4CJqBhhw
 AoeK3d8ng9yEg2mq1CfcpKAPlISKAnYkoAKgpIfX+6OgXl/6pPZhCoKmxYfLgnF+rpPM2H8muUd
 36hS4+cCZqCmjUFNCUdljqRm2EDoY2ygXn4WfSzIbrJCkW9ssuQhftMLz2wjFnP9xjeSuOPlP4l
 UsSYkFgUra2LY7cCfU1h4kOU/s5TcW4hOg3Jsq7Pj05Jz1Lgf/JCH6LNN+OIidF5uobWPAdco0r
 tsS6OYwL3qMS0PQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The only use of 'info' parameter of userspace_pm_remove_id_zero_address()
is to set an error message into it.

Plus, this helper will only fail when it cannot find any subflows with a
local address ID 0.

This patch drops this parameter and sets the error message where this
function is called in mptcp_pm_nl_remove_doit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a3d477059b11c3a5618dbb6256434a8e55845995..4de38bc03ab8add367720262f353dd20cacac108 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -253,8 +253,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
-						     struct genl_info *info)
+static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
 	struct mptcp_subflow_context *subflow;
@@ -269,10 +268,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 			break;
 		}
 	}
-	if (!has_id_0) {
-		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+	if (!has_id_0)
 		goto remove_err;
-	}
 
 	list.ids[list.nr++] = 0;
 
@@ -330,7 +327,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
+		err = mptcp_userspace_pm_remove_id_zero_address(msk);
 		goto out;
 	}
 
@@ -339,7 +336,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
-		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto out;
@@ -356,6 +352,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = 0;
 out:
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info,
+				     "address with id %u not found",
+				     id_val);
+
 	sock_put(sk);
 	return err;
 }

-- 
2.47.1


