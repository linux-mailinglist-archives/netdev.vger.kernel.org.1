Return-Path: <netdev+bounces-145812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB29D1049
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B93E1F21E36
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EF61991D3;
	Mon, 18 Nov 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqJ4wk50"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D81991B6;
	Mon, 18 Nov 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931222; cv=none; b=Dl3ovlECGRnCfjSjO/ECmYvMZu2d/K9s7LB9eHoRYeUkh1kDa9RimzIvTEYX1ePLmCYZ+uEMSQj3+Gw7s1YrYArOQtdCJDPIBqhj6fz303gu0EDT7afKWu4Z4ue65whtJsROdBQ7j43uSEf1vG4ZIbRSOfparLNIfNdb6WOvUoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931222; c=relaxed/simple;
	bh=58K5Mi7p8PtQ/Y7nFK0nv/hMpsEMlKPkCJaBVVB+ckc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SfjvM2/yQQSoz/JKHtoJxBQcg9/nww0qODmFtmTeh8EEaVRoRnpUC37Hxicz3YhV+LcwVFdRE/lDrxd87c1iT63z2cWdrJDyQsQCCwecvvIrUp5zkVUglP+RTv7kqAmfFtg1vLx9S5jVX6mwF/DHvHYcisKPPYiQ0mj0xhZ00aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqJ4wk50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C90AC4CED8;
	Mon, 18 Nov 2024 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731931222;
	bh=58K5Mi7p8PtQ/Y7nFK0nv/hMpsEMlKPkCJaBVVB+ckc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqJ4wk50C1bJqWtqK41tLQh63QaEf8ycHLofCOPFSXBynGuuahMxuYlG4uN39NtvH
	 cbti/cC1lVb9BCAg4095BgVE8jxZsxD5tlZvSgScLEbf4IHS/19Fz4HPoR2gTqiU4z
	 zgyNH1T5ys3KB7D2qH3aH2Tso0wvAA98TTXq8sil3qr5XmrwHs3LkQjlJNsx5gIr1K
	 6rn8txyppoSHXbTseieuaMfrm5XicPKoiIKFu5x4Nf+1mqvdeb/F4Bj4j/43a7quu0
	 /gt367W9gSulyyXXkvVvWJuvLN2WO/LsQOREYHmHf/6CGcOV7tKitRcN4Lua6bJWlF
	 v+lpjvMXvAQrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9F3809A80;
	Mon, 18 Nov 2024 12:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 net-next 0/4] udp: Add 4-tuple hash for connected sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173193123348.4012941.3426012832923402876.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 12:00:33 +0000
References: <20241114105207.30185-1-lulie@linux.alibaba.com>
In-Reply-To: <20241114105207.30185-1-lulie@linux.alibaba.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, horms@kernel.org, antony.antony@secunet.com,
 steffen.klassert@secunet.com, linux-kernel@vger.kernel.org,
 dust.li@linux.alibaba.com, jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Nov 2024 18:52:03 +0800 you wrote:
> This patchset introduces 4-tuple hash for connected udp sockets, to make
> connected udp lookup faster.
> 
> Stress test results (with 1 cpu fully used) are shown below, in pps:
> (1) _un-connected_ socket as server
>     [a] w/o hash4: 1,825176
>     [b] w/  hash4: 1,831750 (+0.36%)
> 
> [...]

Here is the summary with links:
  - [v9,net-next,1/4] net/udp: Add a new struct for hash2 slot
    https://git.kernel.org/netdev/net-next/c/accdd51dc74f
  - [v9,net-next,2/4] net/udp: Add 4-tuple hash list basis
    https://git.kernel.org/netdev/net-next/c/dab78a1745ab
  - [v9,net-next,3/4] ipv4/udp: Add 4-tuple hash for connected socket
    https://git.kernel.org/netdev/net-next/c/78c91ae2c6de
  - [v9,net-next,4/4] ipv6/udp: Add 4-tuple hash for connected socket
    https://git.kernel.org/netdev/net-next/c/1b29a730ef8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



