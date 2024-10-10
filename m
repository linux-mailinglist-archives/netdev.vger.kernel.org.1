Return-Path: <netdev+bounces-134043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE05A997B60
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582C81F23767
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AC81922E3;
	Thu, 10 Oct 2024 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN0ng+1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33F191F88
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531629; cv=none; b=YQtaZS3jebqU+u75RpF6ZpSIUzvNZnU90tXRHhJ7qveaz6B6GvJRO5TDQ0CJ6Zy/9EcS49noZwPhHIq7yFqIGLi/r+1LIJH7hIYNbc+nJ8GHjyDmTugUBbK5mqA5n7fpqg1tF2QykE8FDuQGC03XOXrZQhNCy2oyY4HL1D81ID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531629; c=relaxed/simple;
	bh=jJkQiDhrBP7fqjOrRvy6q9uO+NM5Kl2p10Xmh/KUDLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tD29bTtZRcYGojjBheQJNfDV6K/y/W8sZ1rMyB1I3RQgAq+8xdN5CM3qu4s/jMagiB6XaigQE/epdWubivTOvOiv5tRm0JSjMXgssyV7XOnh/fdb/oxSUJVbuD2PeyMXwShALg8SkINaOe8L52SggA9KSil2r14tukB3t/Dy1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN0ng+1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DB3C4CEC6;
	Thu, 10 Oct 2024 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728531628;
	bh=jJkQiDhrBP7fqjOrRvy6q9uO+NM5Kl2p10Xmh/KUDLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qN0ng+1RrVLd106GzpwPAFKUG0NoKhmkV+daui+TvEBvM3HWWYbCUIpk712grVBrt
	 zVFjmKrA1piIqkKWB6BAvgtmGU6E86ofOG5CBTSKsTevmP/a1nhpbTgtVvH8DyHYII
	 o3jMJhtyeQQ56c7tF+OQmuHtJ9dnZcTZ+X5ZGb8OieBTTe5hy+Mnh31h11bWULyrzG
	 4JymNnSkNoZg4+EATCMA73S7kQ93LAmq132GvYndpKh2mYaHaOx84aOsbfLKQD9uBo
	 a+z+wkj9kw2waO2pn2vSfjHOV8TMYdDMy7eyMEdD9imKS7Z6/HHGwoMGu29N6I4qfL
	 ICmu09j9YvISA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E063806644;
	Thu, 10 Oct 2024 03:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/4] ipv4: Namespacify IPv4 address hash table.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172853163300.1557327.15401459906919976815.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 03:40:33 +0000
References: <20241008172906.1326-1-kuniyu@amazon.com>
In-Reply-To: <20241008172906.1326-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Oct 2024 10:29:02 -0700 you wrote:
> This is a prep of per-net RTNL conversion for RTM_(NEW|DEL|SET)ADDR.
> 
> Currently, each IPv4 address is linked to the global hash table, and
> this needs to be protected by another global lock or namespacified to
> support per-net RTNL.
> 
> Adding a global lock will cause deadlock in the rtnetlink path and GC,
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/4] ipv4: Link IPv4 address to per-netns hash table.
    https://git.kernel.org/netdev/net-next/c/87173021f158
  - [v3,net-next,2/4] ipv4: Use per-netns hash table in inet_lookup_ifaddr_rcu().
    https://git.kernel.org/netdev/net-next/c/49e613194292
  - [v3,net-next,3/4] ipv4: Namespacify IPv4 address GC.
    https://git.kernel.org/netdev/net-next/c/1675f385213e
  - [v3,net-next,4/4] ipv4: Retire global IPv4 hash table inet_addr_lst.
    https://git.kernel.org/netdev/net-next/c/99ee348e6a41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



