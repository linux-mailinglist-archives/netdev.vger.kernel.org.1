Return-Path: <netdev+bounces-168599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D6BA3F945
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8521E424011
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCDA1DDA1E;
	Fri, 21 Feb 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3xfLFHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20291D88A6;
	Fri, 21 Feb 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152651; cv=none; b=U8zzr5WU66BVS8Z+/o5D4eV3IGbgBRxHWiuHSRhNzAD/s/rOy3eWE47iZJsiCRoN1d1QYiF0R3tQDP92JdVcq9h8mdWvhWspt9+9u6vTYGV6l2T4xWYIBiZ8fT2wGeulmy/vVuiMR5bslxLECJTkgwDHWTQy+CAtCPd3jD3LEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152651; c=relaxed/simple;
	bh=5xIZs9W549Xl8TwcsXMDbVpU7kZ56K33008AxiD5hAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rkCZXOJB3pcgFDqJpcQTbqv2qYEQpzswraqrnP3LYRql7mdhW5FUWzIgVrmIt2HNNgKc0VErULX4qlMIHIgmPQnN415wPdNM3G+i5eh8380AVGjBHxdBS6fy7yKVivfLFICyWpOZiIX0N9pDbApspuomL5dOGymCSn5AUn9LGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3xfLFHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366D8C4CEE2;
	Fri, 21 Feb 2025 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152650;
	bh=5xIZs9W549Xl8TwcsXMDbVpU7kZ56K33008AxiD5hAk=;
	h=From:Subject:Date:To:Cc:From;
	b=L3xfLFHaTXNPRSgBEBEB7wDZXFIxpLfqHQG6E52G7wanftxnUhcfB4cqyJ5tBifAD
	 yD+T3SErGxaa3VzeBZwqxrbwuwfwiww9i/sRwDPsFzrr9+/hmWQ1UBLsmSDvPhsWEC
	 7DXDqQBz23Gbn3prceUaEHKsY8Ag/gu/6WeC++ZgIMnL5qd3nbPX2EZwZkr8LyoP3s
	 qvmBxjwp8yDMozvF3D1a02OFRxlBB21U5zAIQIhNDqqCTi51UfLp3cNVexs94TCwoE
	 PZJikR1C4HaTOKaa66ws1Ik3DLeSMXL+kR34G3KQbrxplLZPNdVVv+Z9I+JBqy5D9/
	 nX6HdjkAYT3oQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/10] mptcp: pm: misc cleanups, part 3
Date: Fri, 21 Feb 2025 16:43:53 +0100
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmfuGcC/zWNQQqDMBBFryKz7oCJRLFXERdhOtUBkw5JFEG8e
 0Ohi7d4i/f/BZmTcIZnc0HiQ7J8YhXzaIBWHxdGeVUH21rXWmswcqmcBYMWUtSAQTIhbezjrti
 hMzxSP/jR+R7qjCZ+y/m7mOBfw3zfX5CZzTx8AAAA
X-Change-ID: 20250221-net-next-mptcp-pm-misc-cleanup-3-51e9c67a95a6
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5xIZs9W549Xl8TwcsXMDbVpU7kZ56K33008AxiD5hAk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9HhkFtcSdI0pq/r71f3+yfnMsMTWMaANsVn
 pw5f989CIaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c47LD/wJvbAHFVUh74E/WMql26dDfM539dzX27+2+Deoj5pLLuRW7bxzUFZa+U4hvUP04f6OnTE
 fL5W5u2OyDn2oSZuu84Gn4TlxmtP88+W+o6XGc8Eoh60RtdocahunuVkrw7zsICBY/6nC5VY52A
 lBh/YSAOHmf8xfNoezYy9+eWKEKuFyrMxcaQh0I2qIUYrWooaJc/mwjy5IIH7TxBpYdacNBZ6sz
 PLpB6/1PUokyL161xf8d1uTFfVK5LtnKszyxKBIrmnrwHsFUHy9gRFvNeArkueIkPmbXR72bT89
 3fFOg0N8OskzfZ//mja016HZ2hqoEPa4pFHB6eQ3GTUkh6MhhZRdAOKWcj5L6w8tTJuvRWwgMEL
 utVBk2o1yzUB9Q9FZxbJgglz3Q5TgE8+EsV0zV4M04VOK/zlMgw5B+V9KC5bKh015vuaq1yJr7k
 GH2JX5kjMsSC4/YIc2CIjwXsCIW1lH5sMd2BFA6SKUqjbM1H4skhFAVr3t9ALWPYK8gUsNPNZBj
 9UPBTD6JV74PxqWk8qJMo+PAyVp5ntL2YDEA1vHR/WBj3XRA0MdLAG/uf9MyAjZnjauqSjCEcF0
 XvZ7VzdRYLaFbhjDzoXmU49CIoZgxRhDGName8IWWJU5qd0JBYsa2Zyk5M78/xnVV/6Dt9taZab
 CxLgBqLeaxxYmXg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These cleanups lead the way to the unification of the path-manager
interfaces, and allow future extensions. The following patches are not
all linked to each others, but are all related to the path-managers,
except the last three.

- Patch 1: remove unused returned value in mptcp_nl_set_flags().

- Patch 2: new flag: avoid iterating over all connections if not needed.

- Patch 3: add a build check making sure there is enough space in cb-ctx.

- Patch 4: new mptcp_pm_genl_fill_addr helper to reduce duplicated code.

- Patch 5: simplify userspace_pm_append_new_local_addr helper.

- Patch 6: drop unneeded inet6_sk().

- Patch 7: use ipv6_addr_equal() instead of !ipv6_addr_cmp()

- Patch 8: scheduler: split an interface in two.

- Patch 9: scheduler: save 64 bytes of currently unused data.

- Patch 10: small optimisation to exit early in case of retransmissions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (6):
      mptcp: pm: add a build check for userspace_pm_dump_addr
      mptcp: pm: add mptcp_pm_genl_fill_addr helper
      mptcp: pm: drop match in userspace_pm_append_new_local_addr
      mptcp: pm: drop inet6_sk after inet_sk
      mptcp: pm: use ipv6_addr_equal in addresses_equal
      mptcp: sched: split get_subflow interface into two

Matthieu Baerts (NGI0) (4):
      mptcp: pm: remove unused ret value to set flags
      mptcp: pm: change to fullmesh only for 'subflow'
      mptcp: sched: reduce size for unused data
      mptcp: blackhole: avoid checking the state twice

 include/net/mptcp.h      |  5 +++--
 net/mptcp/ctrl.c         | 32 ++++++++++++++++++--------------
 net/mptcp/pm.c           | 21 +++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 46 ++++++++++++++++------------------------------
 net/mptcp/pm_userspace.c | 29 +++++++----------------------
 net/mptcp/protocol.h     |  3 +++
 net/mptcp/sched.c        | 39 ++++++++++++++++++++++++++-------------
 7 files changed, 94 insertions(+), 81 deletions(-)
---
base-commit: bb3bb6c92e5719c0f5d7adb9d34db7e76705ac33
change-id: 20250221-net-next-mptcp-pm-misc-cleanup-3-51e9c67a95a6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


