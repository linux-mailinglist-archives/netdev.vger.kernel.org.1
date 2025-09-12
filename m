Return-Path: <netdev+bounces-222382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E685B54029
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D83B670C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD70419D8A3;
	Fri, 12 Sep 2025 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8/hSqtN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A217A2FC;
	Fri, 12 Sep 2025 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643020; cv=none; b=CtvVSbGo1SJIcKWBMjPUsTypvxgIrXu0lbncYu8jDN41WY91hUkN46ug/pIxkbX4DHMClb/zqj3o1i9STxITRX9k+ic43Pq5Lv5L1W0YpTx+shW94F95xSZqpJNLXTcRP96FcpSkYEf8OD5tA04yVEvY3c8gk9SyphT8Q4PQtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643020; c=relaxed/simple;
	bh=KCBrEIj2Rbh5x+1wFV0Z2TddUni+Bnd2VoEuE00XlOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=icz5oMgqhcO0EXofZxvENUmnUXsQukRLxW1yZWix/wJIxBl7tpyRUEJKf56RU37Llu97dJ8gKKu7n/g5d3vkswwL8wPY8518RYXlrFKwS4Hj3VjEnmI49CDhLPbZUWthaNyRTI3FKkCvXAODHs1bZGE0pdRRgrNnmE3xMFdMXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8/hSqtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E045C4CEF0;
	Fri, 12 Sep 2025 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757643019;
	bh=KCBrEIj2Rbh5x+1wFV0Z2TddUni+Bnd2VoEuE00XlOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q8/hSqtN4LDepYehtW7pmAx1cyzUykSreBWNzagFF7yuvZkekxqWsN+nOGeveCfAQ
	 nRks4kYn+7/InBeyTTiGApQGNRBAsFCVh4QcTZpjad/l2PBUB3cFjiw9+o0OD6WayJ
	 ML/7g4KRV7OzdwqYGA/xdnFpIjSgfz3GbLHqV3dmprgIkr1N210L4xDu2BaRAhYWRn
	 2b23RXiPMha3EL4XPtInhRiY35IN5czSux3osZgnUA3HoDtb3DasIVTJQy8KR7g0R+
	 6sGzak9O/4rD3fU/bzA58Q83QtokWYwFeRCR/DqfzGvPHmyQix0GT/Lu1mqsg6/Q+w
	 ti1FgllTIl2kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF74383BF69;
	Fri, 12 Sep 2025 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only
 on VLAN 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764302175.2375845.7922892934958248087.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:10:21 +0000
References: <cover.1757004393.git.petrm@nvidia.com>
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 razor@blackwall.org, idosch@nvidia.com, bridge@lists.linux.dev,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Sep 2025 19:07:17 +0200 you wrote:
> The bridge FDB contains one local entry per port per VLAN, for the MAC of
> the port in question, and likewise for the bridge itself. This allows
> bridge to locally receive and punt "up" any packets whose destination MAC
> address matches that of one of the bridge interfaces or of the bridge
> itself.
> 
> The number of these local "service" FDB entries grows linearly with number
> of bridge-global VLAN memberships, but that in turn will tend to grow
> quadratically with number of ports and per-port VLAN memberships. While
> that does not cause issues during forwarding lookups, it does make dumps
> impractically slow.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: bridge: Introduce BROPT_FDB_LOCAL_VLAN_0
    https://git.kernel.org/netdev/net-next/c/c1164178e9a8
  - [net-next,02/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: Look up FDB on VLAN 0 on miss
    https://git.kernel.org/netdev/net-next/c/60d6be0931e9
  - [net-next,03/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: On port changeaddr, skip per-VLAN FDBs
    https://git.kernel.org/netdev/net-next/c/4cf5fd849787
  - [net-next,04/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: On bridge changeaddr, skip per-VLAN FDBs
    https://git.kernel.org/netdev/net-next/c/40df3b8e90ee
  - [net-next,05/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0: Skip local FDBs on VLAN creation
    https://git.kernel.org/netdev/net-next/c/a29aba64e022
  - [net-next,06/10] net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0
    https://git.kernel.org/netdev/net-next/c/21446c06b441
  - [net-next,07/10] selftests: defer: Allow spaces in arguments of deferred commands
    https://git.kernel.org/netdev/net-next/c/d89d3b29ce1a
  - [net-next,08/10] selftests: defer: Introduce DEFER_PAUSE_ON_FAIL
    https://git.kernel.org/netdev/net-next/c/ed07c8f2b854
  - [net-next,09/10] selftests: net: lib.sh: Don't defer failed commands
    https://git.kernel.org/netdev/net-next/c/fa57032941d4
  - [net-next,10/10] selftests: forwarding: Add test for BR_BOOLOPT_FDB_LOCAL_VLAN_0
    https://git.kernel.org/netdev/net-next/c/dbd91347927d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



