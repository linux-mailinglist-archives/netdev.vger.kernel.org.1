Return-Path: <netdev+bounces-158981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C47A14000
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1FB163B78
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98E244F89;
	Thu, 16 Jan 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY3SF4nR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5D244F81;
	Thu, 16 Jan 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046511; cv=none; b=tpWcSRDWqblKEOYTmbw72B7knQg4eVMaZa5kvzCoimy0pQpdR9euAGHzmyEmdXjITp4ErYxfYT1HHSCaIdvvT+aKMfm3ARdm35hqGxXVw/AKz1i1c6xiy2bbdTQb1OK0ufojko1O9YU5zWO4dQw73Ydzsg4/G7AV1NwIf0wY7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046511; c=relaxed/simple;
	bh=gBNXX9ppG946EXfwDDL/S6hzfb1PJK8Xt2CCfsMNeRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTSG0g1KeECqYwgyNmOwc+5alThrtl4X7nzL+IrgFAkyAD58R3QOgesTwFQLMmPVd3+6WI8PtGSjpF8ShTEDGRxEDzz8wrRxgZnF3KvLAi56yPZ8SKWV43q9zsFrjFiheB2lfXiHFtC9ucZi2XmseHIKghHRZKT1SfWpfzc5EVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY3SF4nR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E347C4CED6;
	Thu, 16 Jan 2025 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046511;
	bh=gBNXX9ppG946EXfwDDL/S6hzfb1PJK8Xt2CCfsMNeRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GY3SF4nRAaQoCrhdZJdCtmQoRgvUvgDIExB3fS2syIbRA/tWsNjmy4iOplHrVrom3
	 s02s8KN32kN4vJtDVlEUAFpyzcqUtH47cTdbDfE0TND6u3O2GKx0a1mm4QnGs1oqvL
	 F7Cm7413thEjnjBn5lJIggM+ZeZ6eYYd0sdJSdL1pY6WhA0Agn8GH3941uLhnwU9Ys
	 XNddZN4c2+UXORxjjIx19vr4UGTIU9g3gkANZiU1VnV+JiMqHp0vhkuta1JkpmTZTi
	 pt0w9v8D8upcG63BJOJyLmTaIT8yKuficBSGfRTlYZfR5oDY/uEkAJ3DSN/bEcq38t
	 adNia9Q6qqVDg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:36 +0100
Subject: [PATCH net-next 14/15] mptcp: pm: change rem type of set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-14-c0b43f18fe06@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CVowOfogh0VIETqdYsiGlawSG6f73txjSRWz/bdF42w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnHSjysYDrQAoRYgqp+2ChhXg62V7R3EQbUH
 PsoVsRQ7IGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xwAKCRD2t4JPQmmg
 c7CHD/9VsOHKqR7735lpKiBhUId9f4FpLwDNeaTHAdt4lGFVKD0Ehi9e/3q8/h9Wsx0BbXUk7sy
 rSev7iaD1r3uv80JBJv4X4nUr5SP/vypgJS80m7UQkklFI7mMoUkTxU4CNuaGFJ3jFzQLaG1IVv
 fqf6dEkWHsKn/4VIBzS6n1NIdzQTRSQmmI9C8xwMRhzpVGRX+VW3bCgu+pi4B/uc0AKKY9vDMD8
 gc3k4bY84aoVz2pbEeFLkvfByphwbF/+qdU+rfkYRWOAOeVbfTKLpvK04Fcw+0SG6rK/lMBVTg7
 EsNHANTRc+WmiIWGub1P9WKTpCFKpqVY7X7je0OGHIkQ0lJZOL2amcc1vWn1tXtWSYxQfCcOrhR
 mycoV2VYxCfToJe2S5fVLfuXyrJpGCPH2Z/mC1MP6x1VGha8YHS/LQegvlWWuu0XGjvVqYM6FEA
 LgihIe5MbmDOCjSbKMpL6Zq9dFnkhvfqI6FccreAOBvRU/h0KD8fD4HdOMQcxmFduxyV31UvWVy
 vekwO763lwSwqGs+yDnqmGMONn+w41Gjpga7jGMbBZ5Js+R+E8erGxI8KMVKbxwxZFg65lXSJOj
 p545cRMXwkjmstaf6AGRmqk3Tfj8+4Twd6CQFIqqcXuAOC6G4Jkjv7Lh263IOagjZBTAYrImSsv
 V/GCXEXKsEVCpIw==
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


