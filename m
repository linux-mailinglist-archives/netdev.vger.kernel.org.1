Return-Path: <netdev+bounces-159425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA46EA1577E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9997A3C65
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B71DE88A;
	Fri, 17 Jan 2025 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnXqqILE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECB1DE4ED;
	Fri, 17 Jan 2025 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139312; cv=none; b=ui6s8cMJ6pSwA+pU2x1qutuwCeE791POJ+y+IDNho/zQ08jgvybqyHpIg8EStA2iwL7az/sek7BuczEpU0SqmfkeI6Y8MNGkFnalAnpKaCvb27nkTV27xfpFTsE5qmCSVqoXrSd+UgqfJUhh0ED23Tk1liCyLAXpDmlhQA5G2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139312; c=relaxed/simple;
	bh=8G7twJP3JZxNmu7hReZPonWiPiIdhHNGTM+TQzqkMBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBv1rVLqIE0N0N0QsloD6GaGRIDMpvLjCdkVY1rkqzyE9n0N+o2pdy5MUkshnkND4L/WxFduhA1Pj/IHSGfifEYZS9dbRFp6g1W6L1iEVyGiOo22J7gLydJ+JPbXnCKGq8rWQPG2/ccJ2E28/+L9bke5qQqKWfB8yDsHW8HNBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnXqqILE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1391EC4CEE4;
	Fri, 17 Jan 2025 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139312;
	bh=8G7twJP3JZxNmu7hReZPonWiPiIdhHNGTM+TQzqkMBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PnXqqILEXzIgkznJVWgIfptKMztCNpIE4hj1XcWmG0tgN/N1Oiik5jfoBENILk8rP
	 wxWozg7J8n+6TNYv87jeYkxDZnGat5C8DSzw4mhPKvP5BbtiqBS43lIHGyKDdhJ3OB
	 8Y4ghub8RUqKT2UyyjTPZ9qESlS7zKzf4lOIy8U35vVL5qvEutdtJsxrFMXN8mNgOY
	 TIi2tlGcSvqBd588HXSuHS4HENmojvmrsMURH+uf9Mtgrh96YaWTDrV+K2IMW+Qeje
	 63VYQh1jdAigpoM5vKCDkUtlBCCVCUxHN6sE6C+N69v8h+pEmMf5etv1QPwNBW0vMD
	 V3kJDy478/FYw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:33 +0100
Subject: [PATCH net-next v2 01/15] mptcp: pm: drop info of
 userspace_pm_remove_id_zero_address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-1-61d4fe0586e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SnxuSp6YUyRM6PZLIJsCP27P8V93DanF7P4jRs0o2fg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqVHC9cNjLkYJaygiLnZZ/NjkubDiJtyv6q
 JwmblsnGDSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c2YvEACb4hbefs8H2jYFmpjkNRo1Tgcj1PocY8bdknFHc/TQxvxgsoZ0C2Qbbp9FERjuS/7snG0
 2aRdnni/++e16H0LX8r8EF19ISoEOPfhjU451gUOhviFG8n5KftPMJ1O7LuRcTvuaOav0SvFNaF
 64udLx9RwVvPO1AovOl9Rm90YpT4bTvdMwG1riYA1RAJV/aPywMJ+Lz/GRWkzvZ024XUcGzPpU9
 0SeUY27rXeTiKt9gUkiruel5gcpObYzfFt1eEFvJD/9TK1FNMThfPYxzyutGi3OQw7M1lEV6y66
 Yj6cJ/EC3awU/Y7rsr0Bw/4C9PN71So4nIyYoRJelZnHIPNkvVIzJSGyWLUIxhHLkkNOod+Fo0H
 mHaPZUK686fNCAu0KMmbTI8IzZvdKW6Ea51irdQAvmtMQAtgG4BSwucG6GN6zLZuz7NLN7huIX/
 fRnLEocr+E54aCzflnNUbTPVMLoQQsNPlNUo5ls1uim975HyJU+6RwNP+L9/b2c/y4vBj/eu3kO
 Uq+g2TzvFcbUgyVHneQHp93KSX7o9SoNF6fzBL3GBedmyQEmgd+QVoBxpQcK2QVelWctvZ0y9Wq
 KpIUVnySzTqoMQblBmXkdMzhGYLQ4WWQ7KyjA28gWBAod+HtRxXVqgZhreBymQQ0Vp7+0jV8I0s
 G4jZ0M+sWPSoEgg==
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


