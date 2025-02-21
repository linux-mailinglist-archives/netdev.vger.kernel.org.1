Return-Path: <netdev+bounces-168600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E458A3F949
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0132C4244F7
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061A1E570E;
	Fri, 21 Feb 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp0YZpns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A61DBB0C;
	Fri, 21 Feb 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152653; cv=none; b=Ejt+LPf9XZTKrmN99maNDhMhwyYXSfAxi8msrfSVeGS5y/BAuxsjuh9Nta1CvJubd/PCIMhwV6yd62FbVsSTVffQTUZ66Azt1yOqbZNpGZE5hfT0Dc5RL5JRmvXJkUTnqGWZVCllk8jPnTViQLMala14IjgGWM8QnjKx4ngoQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152653; c=relaxed/simple;
	bh=nTY0AoEf626hk3bDfIL98/ogDyGvSyTa0s0+ixLE/18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MStu5U3acllh/mupiH6IhFfL7U/v7QRCln+Clf/Vf84dfB5+X/VLy1Y3DyyXg+MXTFQBfFH3dtXpMbZSO2fD3Lf4LcUyqK7wx/9snHISrp75d/QhNCpfO+hrOWQmCUIaNq6MPJJkq6U/OgWWCt7J8yYAMGxZQKVg0Zg8tcVfsj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp0YZpns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4543C4CED6;
	Fri, 21 Feb 2025 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152652;
	bh=nTY0AoEf626hk3bDfIL98/ogDyGvSyTa0s0+ixLE/18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rp0YZpns+e2+2h0FizGL838vFjMu6TNEfrzID319KAzIKo/Nl2VyL9KWXmjTcRUgh
	 xFRcRdFrLOWoiDUqyR2VKhZ/dTzlxYNuExHrydevbrAw7KDWI0MAn3AXe/yHOd7qxY
	 JM3G2ebYnQcsgakOeG4qSQubgWFn9FtU/wc81GUgD6c5JMzeRLyM3XutLViHsnH1iZ
	 n/puprImXULOPssstd2uD9J0gpCXYlSweWoO0r9Fd85zlLCGimTht66uQOPipgYjmh
	 dtwQDSG4gXEGnIKw12KNy8X8niaIv0zOXLv0zINGUvh07pt0qgXTVdYM5fqbt84g/Q
	 x5LGvd6Zjygdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:43:54 +0100
Subject: [PATCH net-next 01/10] mptcp: pm: remove unused ret value to set
 flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-1-2b70ab1cee79@kernel.org>
References: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
In-Reply-To: <20250221-net-next-mptcp-pm-misc-cleanup-3-v1-0-2b70ab1cee79@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nTY0AoEf626hk3bDfIL98/ogDyGvSyTa0s0+ixLE/18=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJ9Hjzhmm/kHONJh/qVhCK3dXllW6av+mFC6J
 h8I3E3r9++JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7ifRwAKCRD2t4JPQmmg
 c181D/oD2aaKKTBgk5W4fUnr6hL/m+fqfcmEyStfbs0JJLwbuehvSEF0tWovw8yNOws7lnHd7Ce
 g2XYLLL279MFYWdvJ9TSIX9l0jIqA5IW9vkQ1Co8ZTDWunXimTmo2aqkmxMgRR7/Qpc/k67B4zh
 kMvm2oPyzQrwb07C2vbQkOpka2PCSX+ZjAV61M8N8fDUfDab/9QXmDRtj93TSZcTFvEdhCc1n/r
 UmOcJDZIz4NbBBUpiTZo5yDYdVr9jA2rGOsL5+daHnm/WvIWWCJW0XrRV/dCsmjdjjOP0oAoSX2
 wfMsQWTjhgplHUS0YYv2zTBdN+iWl5M0+rZnB9ZrYv1/pt1TGpTYJ18C4zt611StPGohbbVd31E
 3MCa+iFQDng7+mWs0VQqk5H23qT1CxIj7W7DEVfVhJY3XQZpz+kzYC4+gOmqbvzIytGmgi4cKrC
 7aP6rTo2uqRg9lGcuEO6nsNPARns1uFxDhv4dT90LaFlCnEk4ghGCgCwzFrReczbcYiIVmPuMvJ
 +i6Q4t1HE8bm3mIkscPF3mhgyLr0/1LyYzUjNoIampKmYJ77A0+yqbhdmYpJ3CW4jPJJK+j8/7v
 38z0jTob5Efo3GlxgMLMIV7PIYOKIP/sWRxScFXiV31Xv0PP75sOHOJhLiKZ2iqk+WDfb7d/WMb
 vrjWhEclKap5jaw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The returned value is not used, it can then be dropped.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 99705a9c2238c6be96e320e8cd1d12bfa0e0e7f0..ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1922,13 +1922,11 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static int mptcp_nl_set_flags(struct net *net,
-			      struct mptcp_addr_info *addr,
-			      u8 bkup, u8 changed)
+static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
+			       u8 bkup, u8 changed)
 {
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
-	int ret = -EINVAL;
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
@@ -1938,7 +1936,7 @@ static int mptcp_nl_set_flags(struct net *net,
 
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
-			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
+			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
 			mptcp_pm_nl_fullmesh(msk, addr);
 		release_sock(sk);
@@ -1948,7 +1946,7 @@ static int mptcp_nl_set_flags(struct net *net,
 		cond_resched();
 	}
 
-	return ret;
+	return;
 }
 
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,

-- 
2.47.1


