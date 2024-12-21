Return-Path: <netdev+bounces-153903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8ED9FA046
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 12:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BEF167E3E
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C441F190F;
	Sat, 21 Dec 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSDRYgrp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B483F9D2;
	Sat, 21 Dec 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779361; cv=none; b=hvSWfSBcvE8+oi2VkibXlG0SyMWBe4Nq412ITVCFho0ocLhGNv8I+f/fG7AszrzqnVtZFaTNrlPi+BYJVlz9m3veLgateDJLp0tDVuOBsosgRrNtJAuEe2F5U6Vs+f4Iz7ltAS7vbDfDikjPPesfZiBEQzQS8otoHeCFw/ceai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779361; c=relaxed/simple;
	bh=p+VMVhejjD6MxrL25Fa85g0D15NNkDS89g2aKgkhmxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mVhlVSN7Q/qigyl93JRiVPYndCt80J2c8h0S0NbueDQgqKLgfEZWntS7SUlftoWkskIQO2LUeZapIdZuyJ6Xp31SKJWyJOaffr5Rrgq4nIhhTkJJZlDZ2hbIY6dlZW+qxo/4MomutjX98uL94rcpOxYmMfgP3/TMmNEM0BBHxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSDRYgrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B52C4CECE;
	Sat, 21 Dec 2024 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734779360;
	bh=p+VMVhejjD6MxrL25Fa85g0D15NNkDS89g2aKgkhmxM=;
	h=From:Subject:Date:To:Cc:From;
	b=NSDRYgrp6PYPkqDWk4QhFrs/7VutPbL41BPPl5mL2seP/AIn2v7oIWQJh0gP47UBn
	 lsrqzRc/m1G8eEDmaLDIrw+K1SgL5nARUUBm/h0j/L3t9L4Fp8QE3bCf5YWnJtXWi8
	 nRjp8UMEczTRgCKiOdwjg7MIRpeF1Lot1j/P59lNRDqt6QnNMbvy+hs8tVZ/4Mf4wv
	 /aZQgp8wMDnbuIoKOTihoM6LCoH4hh96apWRKpgWl45F2BPU9+usmlJ4zyAREOO6Cb
	 27W+b1RlVci+LlQJ3HbIy6ivoGLqVksVNsBo0oP5ebzHsmyZH6ywpBqvtz19/r8tlE
	 84IqLDowKnQyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/3] netlink: specs: mptcp: fixes for some
 descriptions
Date: Sat, 21 Dec 2024 12:09:13 +0100
Message-Id: <20241221-net-mptcp-netlink-specs-pm-doc-fixes-v2-0-e54f2db3f844@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqhZmcC/5WNwQ6CMBBEf4Xs2TV0BURO/ofhAGWBDdA2LSEaw
 r9b+QNvM/MyMzsE9sIBqmQHz5sEsSYauiSgx8YMjNJFD5RSpkg90PCKi1u1+6lZzITBsQ7oFuy
 sxl7eHLBQZUNc9kXDLcQp5/kEcekFsQd1DEcJq/Wf83pTJ/rvZVOYYkl5d2uzvKd7+5zYG56v1
 g9QH8fxBSzSOoLeAAAA
X-Change-ID: 20241219-net-mptcp-netlink-specs-pm-doc-fixes-618a2e8f6aeb
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=p+VMVhejjD6MxrL25Fa85g0D15NNkDS89g2aKgkhmxM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZqHd8e8rfUDz24fy+pcF9go6eNFfC4BcaIpSM
 0VZMlLf4hOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ah3QAKCRD2t4JPQmmg
 cw7dEADOfEXAXmvKJ/vMPCRQLJmVs/LdLdJlw23kf2qdkewQslvqQDoDOMMch/ptnOnbbOl2LQ6
 Ugml5HkKvAIYA86gUjJd0UUVhZyVyu9fl86fx9s/WW6rEj73KyQMkD9fByC5luJagkzPJC/2sIT
 2GFvfEBJczLBykt62ylhDcGYO+jQkkKn5WF8v/ozczcCUPfHbkXeqmK+hJctkZcZOQwNfMXM+Ji
 u1jDM08kz3es92qhr6zUecDeGWJMjrt+gdenz+WDThN+V0/qebJmfa2CvBcqOEbEVrhCvNXs03Q
 d85BvcE45vchHGNWzir7zGAOJPfQPMMV52YZalzK1qUQgWym39AK+PUOkQ687Y9jUMT99J2z0Fd
 /3bRRjiDdkNDfZ6mHhVj1yjSlZ6qwNCeQKZkpOkb9O+9oVsqdHAvHH8rg/WLzhCFa99HEnJUayH
 d9zpxVzu6iFTD3bjuDkhX7QbPSTbCE5p1VJ916OZrmSLtL/RZmiFLEDHYcKW+lgLwb2T/sT3s0r
 qbqQ1QYmKyzBNFXMz2Pxt7p66/PofR+PuaRSM1Q3SZ1Oi2rypThZqQEYh1OuzhbTQ59A9NsWdA2
 xKSk2tMTO0STmR6aUCB8YorCwPqhuVQQ59J+AYv4OC6WDv/D9xPpqCZwKOlytQISV624C9ImMeV
 g5L1xAGqcoJ84kw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at the MPTCP PM Netlink specs rendered version [1], a few
small issues have been found with the descriptions, and fixed here:

- Patch 1: add a missing attribute for two events. For >= v5.19.

- Patch 2: clearly mention the attributes. For >= v6.7.

- Patch 3: fix missing descriptions and replace a wrong one. For >= v6.7.

Link: https://docs.kernel.org/networking/netlink_spec/mptcp_pm.html [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Please note that there is no urgency here: this can of course be sent to
Linus next year!

Enjoy this holiday period!

---
Changes in v2:
- Run ynl-regen.sh and removed Fixes tag. (Jakub)
- Link to v1: https://lore.kernel.org/r/20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org

---
Matthieu Baerts (NGI0) (3):
      netlink: specs: mptcp: add missing 'server-side' attr
      netlink: specs: mptcp: clearly mention attributes
      netlink: specs: mptcp: fix missing doc

 Documentation/netlink/specs/mptcp_pm.yaml | 60 ++++++++++++++++---------------
 include/uapi/linux/mptcp_pm.h             | 50 +++++++++++++-------------
 2 files changed, 57 insertions(+), 53 deletions(-)
---
base-commit: 30b981796b94b083da8fdded7cb74cb493608760
change-id: 20241219-net-mptcp-netlink-specs-pm-doc-fixes-618a2e8f6aeb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


