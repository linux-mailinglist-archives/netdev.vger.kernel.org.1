Return-Path: <netdev+bounces-219836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2D7B43502
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E11BC6022
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84172BF3CC;
	Thu,  4 Sep 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbC+jPYN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC92BEFF0;
	Thu,  4 Sep 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973408; cv=none; b=dCm71BLKPIUab87EV+I/U0IAmE1uWZjvsyFc/bzuAi+mh8yI5pY0WzUpRNFiAIsGhxbdda3SQHhO6Kox9gGlNqn0vEkXzZQCm3ryvJNvyif/O6X599+gdCx3rrmM1NS2o3yF01f76DGuSVdJ+VWj/1UwUDAfjud0AUuhhuFpICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973408; c=relaxed/simple;
	bh=BQ7V2xp7jUKaeizKmqJ0kfnjDQD8T5sfY3BibjSKZJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bTtLRDg8p5ETIEf8474df/BPWZvuAD3nOdVp6Lnci/rLjejmutGFCi0YEKraW8291mmpk/29734OIywL964rggLj7fyekrblMAjfdgvUXXXBURV5QnnH0SZILStC2HcgHmtO0LL4JMAP+SyM+qzBZXd25kUidzvHrqcxj0ySD6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbC+jPYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C48C4CEF4;
	Thu,  4 Sep 2025 08:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756973408;
	bh=BQ7V2xp7jUKaeizKmqJ0kfnjDQD8T5sfY3BibjSKZJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kbC+jPYNE3IXfTfr8Gwi4KVsQbuKyzDDK37Kmi1wdHAdtBT2WvRfv6/STlKF4bV6D
	 HwBNr1JottO6EE+Yp6/bOoHRG1vQdP72m3lQ5YxPJMf7mQ69Ay0+51SflkAID294w6
	 fZ6myHsuvPGpDzumTisUtW3fR0gjo4SJzd0hGxwg4EpIHHtPu2B3JTZM7jfaH9JhmY
	 TAa+ol0tZpjdAykCtDiCbHmM4FaUBrIHRGNHBhzkhlcN0ki+62Gi9/iqI6BZ3WsG4A
	 eWov0H8oQbNjAOosGcDxCCv+MfYb78gISkGlXOH8yU02Za67r8kcc3pfvuqvO2v74u
	 iuVs6m7MSImFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE208383C259;
	Thu,  4 Sep 2025 08:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175697341351.1714378.13034285357110080826.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 08:10:13 +0000
References: <20250901114857.1968513-1-yuehaibing@huawei.com>
In-Reply-To: <20250901114857.1968513-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 1 Sep 2025 19:48:57 +0800 you wrote:
> Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
> ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
> No functional change intended.
> 
> On a x86_64, with allmodconfig object size is also reduced:
> 
> ./scripts/bloat-o-meter net/ipv6/sit.o net/ipv6/sit-new.o
> add/remove: 5/3 grow/shrink: 3/4 up/down: 1841/-2275 (-434)
> Function                                     old     new   delta
> ipip6_tunnel_dst_find                          -    1697   +1697
> __pfx_ipip6_tunnel_dst_find                    -      64     +64
> __UNIQUE_ID_modinfo2094                        -      43     +43
> ipip6_tunnel_xmit.isra.cold                   79      88      +9
> __UNIQUE_ID_modinfo2096                       12      20      +8
> __UNIQUE_ID___addressable_init_module2092       -       8      +8
> __UNIQUE_ID___addressable_cleanup_module2093       -       8      +8
> __func__                                      55      59      +4
> __UNIQUE_ID_modinfo2097                       20      18      -2
> __UNIQUE_ID___addressable_init_module2093       8       -      -8
> __UNIQUE_ID___addressable_cleanup_module2094       8       -      -8
> __UNIQUE_ID_modinfo2098                       18       -     -18
> __UNIQUE_ID_modinfo2095                       43      12     -31
> descriptor                                   112      56     -56
> ipip6_tunnel_xmit.isra                      9910    7758   -2152
> Total: Before=72537, After=72103, chg -0.60%
> 
> [...]

Here is the summary with links:
  - [v3,net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for cleanup
    https://git.kernel.org/netdev/net-next/c/61481d72e153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



