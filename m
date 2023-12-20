Return-Path: <netdev+bounces-59212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF51819E12
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02DA1C2270A
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36E21A14;
	Wed, 20 Dec 2023 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO1Yb6H8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456D21A10
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 11:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9844CC433CA;
	Wed, 20 Dec 2023 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703071825;
	bh=O/p1Qqq7yeCORWa0g71jiyTtq5zc+zT+tFTZi5RjVTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZO1Yb6H8/TecwKwYy1MdTtlmHYu5wbusjSaC9QYL21Sd7Z9RYbxyideU1c/qZiaE0
	 M8chrfQZUwTlL4n5dEOsFAYLAYoJLnQiCj+kAUrXaE+QcJUvZywKl2vKjM7NionrUV
	 j3YrtTushJc11+VKgVnpcdf6QrlJXN3blejt01EPTdTWrJafuMYkPSx/8/KGQm+VRj
	 CKNCloqdbPA5CXV3nnu3QxK0/O3BKXxnMqLVWoY6kG/yHrsTowN7OgtIScklCGvete
	 JwfWkOfZYMqmD87xw1jF+TnQPAM40R/OgW3iEGK0V1dsLdLME4nSmVoNvSIVrn5oPD
	 vVXoVar+StZlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85005C561EE;
	Wed, 20 Dec 2023 11:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] Add MDB bulk deletion support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170307182554.15860.11229847127578380886.git-patchwork-notify@kernel.org>
Date: Wed, 20 Dec 2023 11:30:25 +0000
References: <20231217083244.4076193-1-idosch@nvidia.com>
In-Reply-To: <20231217083244.4076193-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 roopa@nvidia.com, razor@blackwall.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 17 Dec 2023 10:32:35 +0200 you wrote:
> This patchset adds MDB bulk deletion support, allowing user space to
> request the deletion of matching entries instead of dumping the entire
> MDB and issuing a separate deletion request for each matching entry.
> Support is added in both the bridge and VXLAN drivers in a similar
> fashion to the existing FDB bulk deletion support.
> 
> The parameters according to which bulk deletion can be performed are
> similar to the FDB ones, namely: Destination port, VLAN ID, state (e.g.,
> "permanent"), routing protocol, source / destination VNI, destination IP
> and UDP port. Flushing based on flags (e.g., "offload", "fast_leave",
> "added_by_star_ex", "blocked") is not currently supported, but can be
> added in the future, if a use case arises.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] bridge: add MDB state mask uAPI attribute
    https://git.kernel.org/netdev/net-next/c/e37a11fca418
  - [net-next,2/9] rtnetlink: bridge: Use a different policy for MDB bulk delete
    https://git.kernel.org/netdev/net-next/c/e0cd06f7fcb5
  - [net-next,3/9] net: Add MDB bulk deletion device operation
    https://git.kernel.org/netdev/net-next/c/1a36e0f50f96
  - [net-next,4/9] rtnetlink: bridge: Invoke MDB bulk deletion when needed
    https://git.kernel.org/netdev/net-next/c/d8e81f131178
  - [net-next,5/9] bridge: mdb: Add MDB bulk deletion support
    https://git.kernel.org/netdev/net-next/c/a6acb535afb2
  - [net-next,6/9] vxlan: mdb: Add MDB bulk deletion support
    https://git.kernel.org/netdev/net-next/c/4cde72fead4c
  - [net-next,7/9] rtnetlink: bridge: Enable MDB bulk deletion
    https://git.kernel.org/netdev/net-next/c/2601e9c4b117
  - [net-next,8/9] selftests: bridge_mdb: Add MDB bulk deletion test
    https://git.kernel.org/netdev/net-next/c/bd2dcb94c81e
  - [net-next,9/9] selftests: vxlan_mdb: Add MDB bulk deletion test
    https://git.kernel.org/netdev/net-next/c/c3e87a7fcd0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



