Return-Path: <netdev+bounces-230257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D0FBE5D03
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8C8D4E25A4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819E261B60;
	Thu, 16 Oct 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtODAcm1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F1334690
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658631; cv=none; b=LrYwQ7vu2v4nY8auOoWGYdqPGbS+J5uRvFQcyyPmnzwuYLI+A61MWZ1cOEA/WCnKV4yEFhJ6Y08sM4rGH09zwvunUUOGkTBb1xX9Dn7ZeM1nRRjMaT9UHtUZEQNx9dqoVsGHMNidZMDw6uD32gdUGkGhVYrEPi4yiq6e6o8LwFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658631; c=relaxed/simple;
	bh=ogwGYSgexfeKykEc2Z5vEctJN/a86HEfYmQGOWXsSNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HbMHIzxnDtS3ESnxOsN0SZ9vMQKPVsPII0Bg84I+5w45Td6z4ETNv5HWp4tezLZIziPP2RxZVW9OZDD12DnbSVPk1g/XPV+ziFpfNQA15MvEMTqEu7B1W8whkALnfbvIana/Qklpo6WeECe71kBvXTMGJPasYytgnEkohYT0QHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtODAcm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D78C4CEF1;
	Thu, 16 Oct 2025 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760658630;
	bh=ogwGYSgexfeKykEc2Z5vEctJN/a86HEfYmQGOWXsSNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FtODAcm13m/AK3ZFHBZ8X6v8YZwD9/UgYotCOUtmvYf6f/W6Zhr40iH7YX32TeKDN
	 RHAbPiEmeR87lo+BVTp0mlNNg9SSWPaJfruasgpT3qQAVbPWZR1L+XiPfI+oZDgkxf
	 a3qaN81OJOCOh+d3zg7yHxS3IjqlUbDolkV/lWYfnv09eHBZCXj2ISIDie0iXuO03u
	 DOrwUzC7+zyd4/QmCv98b3SGr3a3VbBSqiJxorkJ8YPWRYqd8utXFtfZzfBr8il9OW
	 FL+ASPQYcXG+DuIYd6C+/wbpwbF45f1KUYT9R8Zb5sF3IAqlXFCmk6YUt5y0bkAssl
	 ysTmmoQ1E6vtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFC39D0C36;
	Thu, 16 Oct 2025 23:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/6] net: optimize TX throughput and
 efficiency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065861500.1949661.4930155614616755528.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 23:50:15 +0000
References: <20251014171907.3554413-1-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 17:19:01 +0000 you wrote:
> In this series, I replace the busylock spinlock we have in
> __dev_queue_xmit() and use lockless list (llist) to reduce
> spinlock contention to the minimum.
> 
> Idea is that only one cpu might spin on the qdisc spinlock,
> while others simply add their skb in the llist.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/6] selftests/net: packetdrill: unflake tcp_user_timeout_user-timeout-probe.pkt
    https://git.kernel.org/netdev/net-next/c/56cef47c28dc
  - [v2,net-next,2/6] net: add add indirect call wrapper in skb_release_head_state()
    https://git.kernel.org/netdev/net-next/c/5b2b7dec05f3
  - [v2,net-next,3/6] net/sched: act_mirred: add loop detection
    https://git.kernel.org/netdev/net-next/c/fe946a751d9b
  - [v2,net-next,4/6] Revert "net/sched: Fix mirred deadlock on device recursion"
    https://git.kernel.org/netdev/net-next/c/178ca30889a1
  - [v2,net-next,5/6] net: sched: claim one cache line in Qdisc
    https://git.kernel.org/netdev/net-next/c/526f5fb112f7
  - [v2,net-next,6/6] net: dev_queue_xmit() llist adoption
    https://git.kernel.org/netdev/net-next/c/100dfa74cad9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



