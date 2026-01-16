Return-Path: <netdev+bounces-250430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E262BD2B217
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C863061B10
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3222344053;
	Fri, 16 Jan 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhFTMV8q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84548344039
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536235; cv=none; b=K1kdeEl6p+e/LCeD5Y3X9GRDVlFj+MjnfP2itjwp9wSpHVqkJyAdv/34do/KKSs3o7MV5DkQU5LsgS52rX1h6by/L9gH79fH7wegmsHYOvPO8GGoRGuKYZ/79O/0NyRV/gYdHtInMgeJzl0zE/pcuj4LDzpvVDodc9EExYu/hFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536235; c=relaxed/simple;
	bh=fYzTbfxVTtV5LS8V03MhQ6nqdKMWWJsdeLTuzYB7kZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rXiPViHmNhn0F+CMH5tpssYgUIulKpiX+y0TRM4F5iVleilFwTeWvS9Js3wSt/gxXiobPw3j3c3V9Fc45Cd7uUFXvZQLW3prjsjHW78a7eCzyYD7e0bibkc6aP0wLb+CbU4K6GLVGU2PaoUY1T2FuV+xKBZMm9nFkjYiVpCRAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhFTMV8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB67C19421;
	Fri, 16 Jan 2026 04:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536235;
	bh=fYzTbfxVTtV5LS8V03MhQ6nqdKMWWJsdeLTuzYB7kZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LhFTMV8qsaafdcimeipr/f9zeMVer3k1yUq1joYQmtG3nmbEa0N0MNZztWmZOIg02
	 952PMiTGe+97aNtC547sezIY8/rUDx2+DcOwBIl3Cl1qRzBkvUNUbCB5K6ZBMYA4cH
	 zGTy1hdiXEleBcxcBRtAnGMOmGar4ytL0Mlv6s1Cq7zamdGFarspYuzqYwWFFimyb4
	 5ziDx/JFKcWWo8WGsU7ZgIsqFQgUfxXvMYkldCIEgGGGgRt3gw5rJ/XsyC1iqK1Xzt
	 eE68hl9SA5wabQ56waeueiUuJLCRnxgqZYdnVmRpoS9UnzEVjOu0waLcXZ2Ov6E9Uu
	 T0+Hn3us4UoKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B8D0380AA4C;
	Fri, 16 Jan 2026 04:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: limit BOND_MODE_8023AD to Ethernet devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853602702.76642.11671647474281733726.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:27 +0000
References: <20260113191201.3970737-1-edumazet@google.com>
In-Reply-To: <20260113191201.3970737-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+9c081b17773615f24672@syzkaller.appspotmail.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 19:12:01 +0000 you wrote:
> BOND_MODE_8023AD makes sense for ARPHRD_ETHER only.
> 
> syzbot reported:
> 
>  BUG: KASAN: global-out-of-bounds in __hw_addr_create net/core/dev_addr_lists.c:63 [inline]
>  BUG: KASAN: global-out-of-bounds in __hw_addr_add_ex+0x25d/0x760 net/core/dev_addr_lists.c:118
> Read of size 16 at addr ffffffff8bf94040 by task syz.1.3580/19497
> 
> [...]

Here is the summary with links:
  - [net] bonding: limit BOND_MODE_8023AD to Ethernet devices
    https://git.kernel.org/netdev/net/c/c84fcb79e5db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



