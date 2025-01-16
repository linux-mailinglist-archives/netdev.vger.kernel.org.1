Return-Path: <netdev+bounces-158968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202FA13FE5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138C0188DCEF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0B222DC41;
	Thu, 16 Jan 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6UIBwkW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8322D4F2;
	Thu, 16 Jan 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046477; cv=none; b=BiQLxmNmMWVjn21lBsOiGdfShZ/RlPond4fruhCIPYtJExaB7G9Kzu4iRcfgYsLp9qscNl0NTkvbTThZHe1/iBx34IgahpmmOxnYgbc8SvdvEsGqgnILD7P8CiwpTIMYVH/LD/sQ8ben2htkBNnQuv0dO9GubleELOpKshL9xVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046477; c=relaxed/simple;
	bh=8G7twJP3JZxNmu7hReZPonWiPiIdhHNGTM+TQzqkMBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0gal/wWgnj6QAq5gVfGzkWHlNZGqqixHV8Miag6UvwbAqNo5SsOaugb8zU3YvAMYEqT5YOf/7DO1BjwpQCKkMABHsgYoj5kVJorOCmAZsqHWGDttbUV/ux4sUFIsvLyVyeguizmWgyY/+s0RXbihCe9YaOuyGuyv9dNi07mIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6UIBwkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA28C4CEE2;
	Thu, 16 Jan 2025 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046476;
	bh=8G7twJP3JZxNmu7hReZPonWiPiIdhHNGTM+TQzqkMBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K6UIBwkWh+zJjFJ2Apb7WdVNtcjNGtZFSslN+w0J45eb2jQ5uhbOPygCAWb3BIIPe
	 EJscv8bLVBy7RsqXZiMztshzqIEfd8VkgHIQgJEzrNYxN4kQXGpUMKnKsk+MK2oEgF
	 IeCEHfY/Jo2WtnJwWiV0nuPOJsgJ2EdWGGqQr7bmbDLdcnR/MvhxJ2rArzSaXto4yl
	 uGR2W2Nc4rcKUb5TtLFEe4uLZc9JgV1ULA5Ck/VS38vtCEH4muvNidpYofZFYmMc+x
	 Cc0djT0Fl7DwWTDAS0Syw8nd2r3s7fN//onbi8+agXecDFN9dz19NQyGW42RN1C5PR
	 L+ys/saQ8LLeQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:23 +0100
Subject: [PATCH net-next 01/15] mptcp: pm: drop info of
 userspace_pm_remove_id_zero_address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-1-c0b43f18fe06@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SnxuSp6YUyRM6PZLIJsCP27P8V93DanF7P4jRs0o2fg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnGcJpIVPIiFC/QvpeyHsU4abcZGVpWK6QJR
 i/kaZ6MQsuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 c9Q+D/9n5YbhzQqbpDvNsZM7ziFTBKqt9X5BRORy4VL+Lu9VUuh5FUzTdds7zeteIrf4L1/eTJQ
 yCzsOcA/ELRPOCeirAmevkWIeCFR2Fad08A8bI85tEPOZ3kSoexY+i95Hqxnslc2AXEL0WmfzAi
 B6fSSN0asofVy8r/UyQ+hFURmFX9PpkxLlyYdwI4v4zVYqXaaESRxrt3UStrYgQzjOiDc0NY71P
 08Kgh1h66MDrRlQR7xFiUB4kBqxlVE3SexFp5nggTSblWlLj33rj0vPLLNaLo19tyi9VwMRyueg
 nxp0nbj2ziD6H1JQpJNVnJjP3dIXd/DgNAKUCVtPv80u5thPuqHAT32NLe0KfnwoT2dg3cI/t2g
 yS9xYcr6778AGXKtMjSwQgrpAsomrmUacBQ+QmZtK794f4B//Pd+nwgLbJXxcC3BBxNyz8xm7oi
 ph2fHtECJwrBrK7GIvRRHQ6SP6ds4NLVAGPd/RwdL6/FTO+Y71VkpMowRcU4+PrWnZSKYkiBbE6
 RS69cosWAEKnrCZ17vmIt0qqrMbbyWlQHAlfvGEMG+UR15oaiH/xMpEU8YFr7o0Kppd8fOc+d+h
 KQrGvjPsb05qpUa3mei3JzAMo9OM73Md+CLfL2QF4I616Wo6F8uFbPqa4h0llpIn0QE0naYui1y
 lKYSpZOYqQStaqQ==
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


