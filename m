Return-Path: <netdev+bounces-159438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EF6A15785
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869261607CA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EAD1EC019;
	Fri, 17 Jan 2025 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5vv66EZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214A1EBFF8;
	Fri, 17 Jan 2025 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139347; cv=none; b=rVSKcMKyIayPePWkR2YpcrDVbl653SBCUQ6kRRvFQbhhl5y+uOAyrVGsIZLgAmXALNcsU5uaC1aY2vcgKIDrZFSJgcALgSoXU3Sp2NX2WqFb4w6+zGJAEvh0IvfDf+khphKalBkujhVZYzU+eAyNtxPerb1uoys4SB+X9hWEUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139347; c=relaxed/simple;
	bh=gBNXX9ppG946EXfwDDL/S6hzfb1PJK8Xt2CCfsMNeRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNbmezHNyKeebSRzCcGLXwiowH2y/JLw0Qr7K10yaG9T7PceC+Lorcs42bTihY2GGZMhsb1YC7RKidHEkRaTUaZxwo0tEE4UxoaHbmQ490L9eByH67VgUWGUlNo/XFQfMZYDB2D1J1vhHSo7yLRa/7z3uH/b0O0coshaFqvbcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5vv66EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D39C4CEE3;
	Fri, 17 Jan 2025 18:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139346;
	bh=gBNXX9ppG946EXfwDDL/S6hzfb1PJK8Xt2CCfsMNeRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h5vv66EZpbw2frzQ5mMMj8iaBFYdOKYNFVKb4GmvkkgdwT8subbBsemlVGcEBeaOR
	 ypF6fSmCP59BnZHH8RepA5vcOkmet7t0z46IbfToMs4FuB+PWIpO7aBIb9eB/nr/dZ
	 JK3w3i69lHyXfqy6wqEYT4w9eVZwBxOVswT5YCyglHzOEN5VmcaEwf4Gz7KcWY9Oyt
	 o3tCfdLdcyCJ6qkZxCQGVjC44/TaKF8D4wLEfPXBcB9TevHDLlkThrt7rjO/jIgHPP
	 fWhZbx7wDvYi+6cRifKPmLOOD5q9/Mo6QfioDOBG6LAlSBfAeGw/YE2GyA4aR3B7dn
	 e4c+cKCcwwDyw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:46 +0100
Subject: [PATCH net-next v2 14/15] mptcp: pm: change rem type of set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-14-61d4fe0586e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CVowOfogh0VIETqdYsiGlawSG6f73txjSRWz/bdF42w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRrVWAOiYAFe+ymgVjCLDSfV8y3CEFNWe/kE
 SK8DZuqy3SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkawAKCRD2t4JPQmmg
 c1/jEACP9yO1Eot9s+qMwdePso1MzeWnd+sUh5VxyRBj1Pea7TmqgJCINxdkpMPDUOjXV4FwMBv
 WXnfTSQMQfdfyjupMsDPaODpJRPffelT5QJfmi36YMwmM2kfNtXXLhY9qi0k9a08A8ZPxjClAhW
 q1dHjxE8LAbsbD+tuyif1AtgHJO3EyPT+SyVom0qtvKKp7SprwJaIQXITR2lz8dIdM/6POkpasr
 dR/u3Zun+DDnCqmBj6umMtzuDjS2PBLNcnUNLIYsk0xa0j/DxnwYHIBIRSgPdQkVjOUjXTi/1vQ
 6b2M6JUUEwj1GojW8rs2ORy+N/o3eYzEQ3AKMMuDnwNwfTjPxAUmYsBtZE1k7kql+h5by+cvzbM
 /hgoWOELG3ry7WuuNf7jdEOcdJfyVRgJJ5ghHhe1vli8VsvqeMdD8Yp3ta4ve8DL9gf3lLFYelI
 ADk7/PkcTc8I5sVpLZBej/ZyVjUhUbRDT15tM0LMEs5uaQX/ZebGrPf7dkvTtIE4k3TwGIVLHWw
 TKkw3XxslTPZJ2w/KEWNMcms9qyx3mSihq7128hvxJRMg35mOwvyNeqVQxe6cNPzVAq/3hKWucl
 h9F3+EIQtIWV1/QHcuzeZFQQ2xq9RzSDKIhQP05ik3b8KOrEsm6vctm4UCcXd8xtXE5dhWul+cf
 +zS5CcrJxzB/iYw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined
as an mptcp_pm_addr_entry type address, while the remote address is
defined as an mptcp_addr_info type one:

    (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type
parameters.

This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4fa3935c5b477dcb50260b3a041b987d5d83b9f0..1af70828c03c21d03a25f3747132014dcdc5c0e8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -567,7 +567,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
@@ -598,11 +598,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	}
 
 	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (rem.addr.family == AF_UNSPEC) {
+	if (rem.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
 				    "invalid remote address family");
 		ret = -EINVAL;
@@ -623,7 +623,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */

-- 
2.47.1


