Return-Path: <netdev+bounces-164013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77AEA2C475
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A34C3AE4CD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0417236436;
	Fri,  7 Feb 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnCJv/Lx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55C23643B;
	Fri,  7 Feb 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936784; cv=none; b=Az/mUBHs+CoEdb0gzH6Cq2l0NFHCt+5mRT5PndGDGKrTMKR4sonwdhHbj+nbBxEDYCTXHnaI2cORBOJEfRHMV3pR9js9iIU+D+sILIp03RhgFt84JGhYuRDr+NfN2ixUdggEJW7+uVprdXu9ZJOgDj0AGBNDvwpAG+ArSwNwrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936784; c=relaxed/simple;
	bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5hiDcfmi1EKiLVkJwaDhECGmmps7zABwG5hiGSWABkzNF7TrDnKorSjTaOx3uGzJM1lUSml92UptHKNeSdmOl1dcO+0/4sI5f0lC8Gg8Y1IDzgNVx0pgjXrw1SiewkYJQ78FdEb0AmysYzPRKKKU+jofEqH4TjhDtVKVcOqGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnCJv/Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068CFC4CED1;
	Fri,  7 Feb 2025 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738936784;
	bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DnCJv/Lx4ZaigJL2VFjfCgDhVLQR6qf4jTsRwOKMKLBH855TH5VWK6wIQeBlZYv+r
	 DctFc2yHa2FCKG6zF9ebbBqt/Qprp3foD2ZkpSlEBRgh3pyEvdP+cxcGRvSc73I7Ac
	 bbbdHbNiRXddFwXL0T8ptfF+3MS/Ol/i4bxUIgFJhICkLbvhcpRFFF68gGlCiSwu8I
	 0NE+ZpL6hKgRooxWzwg1miU2Vs68ighbSxD5VcQmVWvPio+SkVMh+PRn848VcuUYhl
	 Hg59VTDYmtq/tW3ZFXCPjflnlH7Tb7IeIMvQyyjvZ+J+0+u5dZQoyqwYtIuD/lvagZ
	 TiAktnyisU3Ew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Feb 2025 14:59:24 +0100
Subject: [PATCH net-next v3 06/15] mptcp: pm: remove duplicated error
 messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-6-71753ed957de@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnphG98rr3+gAsUA5Q0DEPhHG+JHyAdOmEILbMF
 ysE0sdgsMaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6YRvQAKCRD2t4JPQmmg
 czXuEADqSnnD32pcFtEvTibreBFzzT8eKIrID9zs33kGP9Ni1uhbnBPYLSCAi4ag6VcTQEtrwAM
 jsGZVffKhig372xK2qwt9V2kxPQ53g3YV7PB/9Nmt8cD2M14spkdYYt3MGJB4r2gwoi1s4P8X+7
 5TU6mya1l08/ThYyI+YyYlx8kaPDzlQi3i+SUPcGyWVTRaT+bunNPhfHO77HWkNg8rYOAA1Vyqq
 70YaFX2xEMZoI7QWD2ZjQ5Y9B8cFcCvdCYFoIyIyHvvjK6gg7pMANV+0OAT6gFjnfU/IsXqkOc3
 f+qJwjMH2zl+9XV44i4ttIHhxAHhJ1x9FqW9eiPKnaZ2qeCU5uP+lhTIQWYwT9UoXArPiZZ+BsT
 Z855Sx/aUhpd+q9Fx0dbjFjIOGd113wHfeLSqrgGEzAS5zCfif0ygijvUN9fLfFWeNyYkqFr39b
 agUCn3GIQLKNILwHhLuZPmcE7EuniTnMuy4kJD9kYmAtvFmi5Xg6QA1ubGW4szmFdWqWMDZf8VW
 daGD9juHhKmiHb5QKzuErolmsAOqEldGVUXBpzD13FwI575q8WgSz+6twLQXr52twJUtRdYwoE0
 E9HvmMJNIfPCcNTs9Zqm/u9lqi/SuxrqwPEAUlOa/SzQvs5ZhaCqlOlXE9UJz0d5smRlpl3B495
 rMvbE0AikBo+B+Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_pm_parse_entry() and mptcp_pm_parse_addr() will already set a
error message in case of parsing issue.

Then, no need to override this error message with another less precise
one: "error parsing address".

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4cbd234e267017801423f00c4617de692c21c358..ab915716ed41830fb8690140071012218f5e3145 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -216,10 +216,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
-	if (err < 0) {
-		GENL_SET_ERR_MSG(info, "error parsing local address");
+	if (err < 0)
 		goto announce_err;
-	}
 
 	if (addr_val.addr.id == 0) {
 		GENL_SET_ERR_MSG(info, "invalid addr id");
@@ -386,10 +384,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
@@ -400,10 +396,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto create_err;
-	}
 
 	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
@@ -509,17 +503,13 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+	if (err < 0)
 		goto destroy_err;
-	}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (addr_l.addr.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {

-- 
2.47.1


