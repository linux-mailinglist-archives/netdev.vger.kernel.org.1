Return-Path: <netdev+bounces-158973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF965A13FEF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D18E3A410D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E8236A79;
	Thu, 16 Jan 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDOCjhAq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE7236A64;
	Thu, 16 Jan 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046490; cv=none; b=Zuh76W4e4zjF7V4LtQN7OziGq+oQdm008YEOw6GwcvUFLYRqvtACfzLxM0+rzKncw+KskZiO/9ZonqZBZaBHEyH55g9EsDywiRTaiJPZ4hkxL9a+bXlOZc+2x7/6FxpRBTDYBWQHMwteUXYfS3/fKndrrEOKTBNFcYawpPmRpMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046490; c=relaxed/simple;
	bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/7Fny97U5Nhvb7G8s6Qr3llCY9bsAZNSikw2k+9Aqw3D9NV18V11Nm3zjMtAzJqiujX+a2aezKMmZ88hkWYcwPsbm4aFVjldbJ/xO97PFqwD+vpNA7YLrvfnTeE+lftX6MDK6CMSNkZPrgomG682gvKixvBw1aij77xMhUNJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDOCjhAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC3C4CEE6;
	Thu, 16 Jan 2025 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046489;
	bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cDOCjhAqwsJSfrIsUAQOvwJyHuHD1cmp4DNPwwHUVAPmagp1VnCWjmmAmEyLrkAOt
	 tk/Tj2Q7eVWvsMVlvQI9Vp0DaBnD262Oq6uHhLRfOxbegKmnFfXYKN/ANdOhYiferp
	 eRI+D+4Ju0vcr3/+6vyJADvYtHmUMpwqOu8IPo8qYo4PlbwwtlHoQSwWkA7dZ01dyG
	 gvkWQ029gAWKFGRu4GuVgme05Qi1bgDdAZnyUXj8vLNivxrfXCvh7egwzdOo7W5XlA
	 gb8e7nl39FZQ6UAyt2M1oeQrpsCL+9h3ovFdHZ3FA034VIxKA0acJBM3ISuDyR8XXB
	 lMVG59c/KSXgA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:28 +0100
Subject: [PATCH net-next 06/15] mptcp: pm: remove duplicated error messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-6-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B4EoGp6iIdIcXqT3mYInhSvXfXsv3hE73F8zcYqYI/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnGxaYLs1TiVRC6j/u7BoWWE7o1He2duD+i6
 0v6100Sy9KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 c7ghEADZibm1B5keH3QNWL2BFKGVkglG5GMkIfhpIy+QH82FvbPTLj38h6UbBKmfN2dZvI+M3V2
 M2VZwFMOOIUk2AhWW4PVGmeMEVwfSwPOJzVmv2IEkeXcxxVpAbkd/xM/D3oYwCv8lpRtZVX3Yt7
 c23ILvStgQkmNisE7G0nsBguriKbQx/sEo8m2bqwrwJJA1VFhe1vdfnc8HIZq0Bs6GVzPuFbWlZ
 o6cxRHfT4HOiO/juKATPAK67VPddFyJrxJKip5XbXrExGo1tKgcA6Wx2XbxYu9BfUCMs9R+zXDL
 G4dqazq7xiqC7NzABRSbdkz0J0lb/EK3GhycHlLnvBptUIB0MsKYRx8YmIYulSixQGQExsZpg7Y
 rauSTW/FLkBquEs+qRlt9CPUXLso8LC2Ki6B/+95+sPfNwE1KTbu3PVYW3YZHOm4K2L02WBA4jF
 5y2XQOK6fxuiZHdkJATFFI0KtQpHrNsbmDaW/4MIxZeCCDRN9twhVZsEqpqG2t0zzkLBPWFSBB7
 KmvvSr4KxyyS5QwDzvwfXOvZbgNpBWlHt0W7rThOgDAKs5HaPAB/reVX9dyGAut+5zHE1brfQ68
 /3SZlpGrdJaKEpt9n7M9MP6p9L6nHLkDxLHnQ+sAFICfIIzu6Vuux4cuxA4TmlKX/2oon9xcpaB
 xeH1CQJJZpolTTA==
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


