Return-Path: <netdev+bounces-223437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5119B59210
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2E3B647B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A0D28467B;
	Tue, 16 Sep 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDPBgD5u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11A21FF26;
	Tue, 16 Sep 2025 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014679; cv=none; b=mYbpH5rpdOXubtPXA27K2CLSPRqV8zDhH7czEXtJyaSJhz5uiJ6xav0KWFDv3Ym7QoGGxf1fdMv9avXcPA50uqnY//HLdaNp4SSUxcLnzt0mX5nwuzdP+CP493acZYaqzGaCPcfczu52m9hDbYVzp5GkYINb3Vrme0Tqxaw5z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014679; c=relaxed/simple;
	bh=AnX7zxFGiyVOnoqXI9inEwlM0tnpL/1wWccRXpRvCCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ADaCa9enMPsWDZMWJHIdbYm4IjvBHFwKrM09A2x2g/DWifPrADv9Ixmrlpz8ELnVmuTTxhmsWF/K069hkxowRz4IvlkMlIfoiVatzG/lanuY8PCYe+gHZSxGToh0pjc6eZlm/anm/9YLUDy5lodVgwUDnUm+amgS5OHSe/daHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDPBgD5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E36C4CEEB;
	Tue, 16 Sep 2025 09:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758014678;
	bh=AnX7zxFGiyVOnoqXI9inEwlM0tnpL/1wWccRXpRvCCA=;
	h=From:Date:Subject:To:Cc:From;
	b=UDPBgD5uQQtr4YYQbHhYP5Jer9tPD8oVfjVRHHcMELrhsC8E0oLdB3k95Jm30AqT1
	 eZlSarX8mANLnjG9/aww9XiIxRt1hBhXOhcieYu4LVde8rCCK/6qhEc9BdIdGui9bV
	 JxmcH9Zmj6e+J1tanYc1uPnueNbnF4/w+6ilWExXvvZZM05EwL/ojwUjiI69QvzOnu
	 dWakFHLLs1xmiueFjs2cHly6Ovxr9N3+zGMV6A8EqVkG002Rd6U0USEFVwmdt+EP5+
	 9KYKR1U4I/ptIpvfWaHzTDEEiO8J0r0DIoYLR5YuZZn4Ca5tzXltiKG109QSTct0AQ
	 Su7efqeLg9KIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Sep 2025 11:24:33 +0200
Subject: [PATCH iproute] mptcp: fix event attributes type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-mptcp-attr-sign-v1-1-316aa96b93ca@kernel.org>
X-B4-Tracking: v=1; b=H4sIANAsyWgC/x3MTQ5AMBBA4avIrE1S9ReuIhbFlFmoZloiEXfXW
 H6L9x4IJEwB+uwBoYsDHy6hyDOYN+NWQl6SQStdq65ocPdx9mhiFAy8OrStLqtaLZM1HaTKC1m
 +/+MA7OU4I8H4vh9o+/W4agAAAA==
X-Change-ID: 20250916-mptcp-attr-sign-f723450dbfa9
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, netdev@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AnX7zxFGiyVOnoqXI9inEwlM0tnpL/1wWccRXpRvCCA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJO6lzlcr68K76gjqvuyJLP8jIX5UVUZn69cyvjwfs34
 ss/9rTM7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiI/0KG/0HLSnuLVH3K9rtv
 WhiSOsnQz60q5e9Liz0TU9//PVFwJ4yR4Uz+rYIrMydOOGfkK35rpfS5XQp+3wXXtRj8cjdJdJ9
 RwAUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'backup' and 'error' attributes are unsigned.

Even if, for the moment, >2^7 values are not expected, they should be
printed as unsigned (%u) and not as signed (%d).

Fixes: ff619e4f ("mptcp: add support for event monitoring")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 118bac4a42a1ea3ce9710510df1353683eb29c89..2415cac8a36089da0e1c42995c06535a08305de7 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -522,9 +522,9 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 	if (tb[MPTCP_ATTR_DPORT])
 		printf(" dport=%u", rta_getattr_be16(tb[MPTCP_ATTR_DPORT]));
 	if (tb[MPTCP_ATTR_BACKUP])
-		printf(" backup=%d", rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
+		printf(" backup=%u", rta_getattr_u8(tb[MPTCP_ATTR_BACKUP]));
 	if (tb[MPTCP_ATTR_ERROR])
-		printf(" error=%d", rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
+		printf(" error=%u", rta_getattr_u8(tb[MPTCP_ATTR_ERROR]));
 	if (tb[MPTCP_ATTR_FLAGS])
 		printf(" flags=%x", rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]));
 	if (tb[MPTCP_ATTR_TIMEOUT])

---
base-commit: bd63ac4980f3d405f4b785fdfe45ba9284b052af
change-id: 20250916-mptcp-attr-sign-f723450dbfa9

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


