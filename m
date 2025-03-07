Return-Path: <netdev+bounces-172894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847CA56694
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795013B31AF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D9217F24;
	Fri,  7 Mar 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTDHXgYQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A26215197;
	Fri,  7 Mar 2025 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346540; cv=none; b=H2aX5OkP94XKKPZObkUm7OWM0CzWiHiNTkUf9c/galEwyB/5ZZCbHAzGr9gTNEhuMNJz6SiYmMOmvWWva5/gHw1Jg8pXWbDU+ZTlaEiMbzwTfpTRZqOA0suRyDaEHsJABYxusBxBXbhq6+0CbHi5E6jgZwedEycxAwWtoLKx3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346540; c=relaxed/simple;
	bh=dnqhHyazv21Tt9Cf5+3m+xYsH96tfUn3A8mmRanJyeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWgXRamkDd1Cr7NZrZZB5VBs60/DOT5MFsUbEnAg3A6z88GYr3uc9K3lP6p4306q+OqT7XMrjHkzhueVktbBKu+Q3MaLmeF0neQ3Z/aTgNqvyj1hJ77TuJCPm3G6UiTcKcb+xGkD++JQ/CGUfZ2CdjqAAP9TljK/6SlUcXDVWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTDHXgYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C96FC4AF09;
	Fri,  7 Mar 2025 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346538;
	bh=dnqhHyazv21Tt9Cf5+3m+xYsH96tfUn3A8mmRanJyeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jTDHXgYQNhl+nV3aeylQFqSa7V8hXzSOvh2tmeLYQ9pcC9o7n/XUQN28a0/RWoS/U
	 BcBZ/iMX1ExYcnoO8tl1rrWfU841FUdtRDOGh9PQl0tNQutCc4PvgZv9lVfKeL5ZmM
	 VZAq3KVpz8qgOhYeVcTvNUBk0exWD6e7WORV3H6BB5UZ0wTnEVZq343TUFRfY0cIeG
	 dlwUr5jUXGueAcKDGP6XoaMYlUO7PPQUOmOGbSAvX5PiHyM0tS5dlYA73WdC7AcgX+
	 RFFKGjybjw7RVskr1KDfn9XilBFe5wTWgpDkl/L1lbdKZ7IyRtQbF9BVu5RDBOiPmZ
	 iRsAqzsjzJwxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Mar 2025 12:21:52 +0100
Subject: [PATCH net-next 08/15] mptcp: pm: kernel: add '_pm' to
 mptcp_nl_set_flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-8-abef20ada03b@kernel.org>
References: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
In-Reply-To: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dnqhHyazv21Tt9Cf5+3m+xYsH96tfUn3A8mmRanJyeQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbRUNMpENJxF/KuJ9pPy+n42mv/kHJmJplpR
 otJng6R07yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 czYGEADDT+0gr0xBMwyuY6wFOkNPyXhuhmHsY+5nJ5o+sMC9KfTc9+ZHChZE9pfWMVGo2YQKThG
 4xCBswNbgWrXikwubwOw7ynsSGaEL+k7vQf941rHB20megYbPHIgmFFpItJGk6mtnY+eG8/CEJT
 iN8wvvU9ZpJtUMzvuupS8HfP2dILrRwVzl5ZVcyeaukbFK4/z92VRNGR7Hgw/YNPSNDpCJ1+mu7
 apXBEvJxbqis0HPwPkMmDimI3R9JvyGSECZtmyCkPG4hGgvTXULWvahEWpZi3HymNcpj9aBGky6
 O4EyysYn1J/BpUMRGWSVLebYIvstTfzSi0/vBsU7D3xXZDZRKxMLDGI54RNfuo4sodC7oFG4NFz
 9CzlIaqkZ08QgNEGBhHPBzXAnsoKcW6kwXPAq65LCi1M9e+reVQWScmB5oqTGm5hy7WshnCRuQw
 DgYd921I/jMDkQjo06bK52q+VINQLWPN+YsTv3R2sGlBPn0yLzUp5XWt1PbhAyHGY580Kx465pY
 iPVVIGnGqiGqSTwEUBK0SdQmk0Z3nyrwwxH3bGgYU3Te93M+fM0WEEOLMOj1H+2bLZhmunKB9Ns
 g2+gclqyFhKldPfXqbbgOPWOADFkeoMm01xCDJY6UkvqUJScJZgoXmCKW+8McPq+vjLpuZwUtX+
 hoyFaeaB3p4vJuA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. Here, '_pm' was missing from 'mptcp_nl_set_flags'.

Add '_pm' to be similar to others, and add '_all' to avoid confusions
witih the global 'mptcp_pm_nl_set_flags'.

No behavioural changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 029a74162b0bce0d3f34f0aeb854ef1b99c020dd..781831c506918cf3c4b93549cefa1a54373935bf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1915,9 +1915,9 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_nl_set_flags(struct net *net,
-			       struct mptcp_pm_addr_entry *local,
-			       u8 changed)
+static void mptcp_pm_nl_set_flags_all(struct net *net,
+				      struct mptcp_pm_addr_entry *local,
+				      u8 changed)
 {
 	u8 is_subflow = !!(local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
 	u8 bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
@@ -1992,7 +1992,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, local, changed);
+	mptcp_pm_nl_set_flags_all(net, local, changed);
 	return 0;
 }
 

-- 
2.48.1


