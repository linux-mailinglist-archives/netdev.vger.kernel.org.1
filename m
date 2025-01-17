Return-Path: <netdev+bounces-159430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A3A15779
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFB93A3240
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A171DF75B;
	Fri, 17 Jan 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twn9jh0J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEF1B425C;
	Fri, 17 Jan 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139325; cv=none; b=hXh9iBrGKUKkIsj1v/JRYLXzBoHjzHv32cMZh1XeYosderfvRHS3gUN6lqPyA1udMmZs2zNiPs66n3N/JvpOS+7j1ED8uUt3SukslA/TylCvmOBmfpbHJ1rS5YQt2mu9EUGpmEKHZVV//vBRX85Ptcnz0wwXQybeu/rPj77Ixg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139325; c=relaxed/simple;
	bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=im8VZ4y8krelG3AAq/0qb0pQlVPPl4ab5ZU2s2lT5hHSdiFBMjOOUb4ZvEuuHAapdahSjkaVYkWwIcBt/Zc2Zd2IKvJ0SbOXeEVFL3Wygt3S2/PVaFbVVFYmkicN+4TueAdxzXQIAVP/Fz7OqC0yMkppEPmIru7MsV+V524k5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twn9jh0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35176C4CEDD;
	Fri, 17 Jan 2025 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737139325;
	bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Twn9jh0JNfLZhnnCpJZ5LLytognEGeyiviu6/QO/koRF3rwhXpHF/IxbwY2wbqR3/
	 d6cLg9t0YHHmyOcWMpAyFYnZj/6l1+HcK61olW9ICigG7gdxZPtCOoQg1gIPvX7Tra
	 sSIUdaVPiwueNk0t9zXP7hPEYucLeAVgTXBH2qjZ70D/GGmoMmPIxFDxOeOtvvWy4p
	 opzjOwYHTC6ZR+ENGzhjcjyI5P9z5RrEFfCldETxuVlsHsrDlJYgXuoz015IvNjpA1
	 p4qLekUjWbueSLji3Gl8Vhpx9htbSLoQincFI21pRjT4Dxn+0FtlRKsqhGkO4UHFv1
	 VMCLXGZ65SqSA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Jan 2025 19:41:38 +0100
Subject: [PATCH net-next v2 06/15] mptcp: pm: remove duplicated error
 messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-6-61d4fe0586e8@kernel.org>
References: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
In-Reply-To: <20250117-net-next-mptcp-pm-misc-cleanup-2-v2-0-61d4fe0586e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniqRqJ5mQzCfhMQl3A3TFXuBqaa+1JlHSIfV9b
 FHvLzIOloCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4qkagAKCRD2t4JPQmmg
 c7cmEACaUk8u2VPvgp1TYEyyvLw+QPV4ldHyePbaOkPSbR6m8HBvvR1taMMz+4j9ydc9Q4E5vm6
 o7HAIJ3L0Z+9b0uAAxdw8Zaog0pT8BDQZm98lOXSmg9gYto4dH5jE23RH2WymlWzvCdGUj5WF7A
 9UmAQJoDssYG5ayyg3lQzbDwaqsy8JHQn/a0D+/u0pEstKcWOt9QbmsLz7Jh+vpSRAowI2+gkaM
 2se3srmD+vBbEqgS5mdgsq9KUfg8qdPT5AM8Eh8sd6cHSbNoBkTtFrIez2LJc5djRMW2Eo+Xwfv
 pFowzng+tWtTS637gi5szMCUwohFN0Ea8TOSEx8yopA503LpFHDccErs6vg3kUQxjJTmdq8ogCP
 p4tLyecKG0bJpqzgT+1xGWdKrTUhaSbZ9sJ0KOt4X7ob3iBw7ohIeaW7bhcwb+6HV7s0WukB9i/
 tbaQz/76Zr5msa7uJsncpiSLdibQiWW1mbdPdVlFazCR6TUQzL0hq8sBeRy7inMrNO8Fkp0ruIX
 Pvwj3QW4qLQP0j4MDtgUkYZFw3zgZ03Z5/vBsJa0I6FCDckReFEcNq1T5KDCRmqYz5ZwzUARdxZ
 bxXEfdjhg7iHHkLmkxOxz5fJNYaj9oS1+qEFw6piOpSq7JH1qBgipG+IdghnxQL1e5qRZciizX/
 LRdNfQYg57PYO5w==
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


