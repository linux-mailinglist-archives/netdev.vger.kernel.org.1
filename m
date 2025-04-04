Return-Path: <netdev+bounces-179316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CBCA7BFA6
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23881171E27
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF251F3FD3;
	Fri,  4 Apr 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk/3pWgD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A21F0E36
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777598; cv=none; b=lUqaZaxGIlCetFsusrUMHnfCl7Krv3pYZoeLBMDmO+LpcYvsEuzFm3H/TkM1oiKlqpb+GqKk+plbK4Ni3Ok0oLkwDuB5Gfls9XVOauWbywK0wwBENiBEKs8NRF/3uTJgLQYjuuFMXJHpWvjOwCC2n/W+LaueXgBN/pfP33sYdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777598; c=relaxed/simple;
	bh=MvoES9PMJoM0jwCVYoCEaD1ChB+7N0NjlUyVI4qUBLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Si83xIw4NLlAaHJZinb8FxabaGEI5yRWtenHtAjxtGvbI6Vs/nnCdYxQsJ1AnddARF/3fOJWtjbBFuo0cHpnX7ECX3csQJPVHq8tJHREyXcxxLkJAr4AR2cJP6HD9e7fy8r394zy4Zfkwe+HGgeWIcSUnadXUK+AE/9Cz8fx1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk/3pWgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07B7C4CEDD;
	Fri,  4 Apr 2025 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743777595;
	bh=MvoES9PMJoM0jwCVYoCEaD1ChB+7N0NjlUyVI4qUBLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qk/3pWgD4TH97SCoebSsE+chd06UbyLTCKZf3P8dWFBKqBw7rrCdt2HXVOd9Lwdb+
	 kFFbcXljhhsVvjDRcnl5BVsF0iIgvoPNay6MRi3ydorYI8LYh84OzfPPu6g8pWmoVa
	 Q8gkkD8gWjv1lbDVw3uKqYHOoAX77lX923nnG+/0QehfEyGFy9sTuC2B9WWrBMkow8
	 gEvoL1VHeqH4RszwtpAgdlo0tRn5LYV3MEvdifqm4qDorQZjalpwauAHjqroQ0mpa+
	 13Z7ivusKRne9t8XTrw5LO64fypNihsucRAy+GjCzzHm5K2UA7Y5b1L/OEEieoT2YK
	 41epbmS60bNhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE03822D28;
	Fri,  4 Apr 2025 14:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ipv6: Multipath routing fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377763303.3283451.9282505899516359075.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 14:40:33 +0000
References: <20250402114224.293392-1-idosch@nvidia.com>
In-Reply-To: <20250402114224.293392-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, horms@kernel.org, gnault@redhat.com,
 stfomichev@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Apr 2025 14:42:22 +0300 you wrote:
> This patchset contains two fixes for IPv6 multipath routing. See the
> commit messages for more details.
> 
> Ido Schimmel (2):
>   ipv6: Start path selection from the first nexthop
>   ipv6: Do not consider link down nexthops in path selection
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipv6: Start path selection from the first nexthop
    https://git.kernel.org/netdev/net/c/4d0ab3a6885e
  - [net,2/2] ipv6: Do not consider link down nexthops in path selection
    https://git.kernel.org/netdev/net/c/8b8e0dd35716

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



