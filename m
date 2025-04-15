Return-Path: <netdev+bounces-182540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFFBA890A3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BAF7AB07D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D215442C;
	Tue, 15 Apr 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkvKQBHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00342154C17
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677002; cv=none; b=n8bCx1yv1v2O4FaECZpJE0BECzD1EZgPPboHsuvtlMdW/efsJJ7Jga3qczKbvwGCd5eVNQOddxfDd29Y/OAoa4OEk/Z2SKvdpfyh4irhZ6Mp8OA67gBhrq0yiUQO38Zmz+W4fLzJikzjW7YWy96ESIi17dKe1w8t9zq848iwji4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677002; c=relaxed/simple;
	bh=YjeXSP6IN4WOqA5vHf5i4+FXKLYhf3d4UaTmg+2dLV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=My9DpC8M/x0ylwAP8gOOiv9QR4LUhE/WLowM7O00riMji8QER+RkKAUq9H/chx0uJv8se3DgCe2TAyYNjuufHWcw4EtnJAyelR7rCov9s1TNQn/Evzjv05ptlhIUsY+V7rfxarukXXUQNxVgcObXEbGdkl4VUK2luf70+839+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkvKQBHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A39FC4CEE2;
	Tue, 15 Apr 2025 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677001;
	bh=YjeXSP6IN4WOqA5vHf5i4+FXKLYhf3d4UaTmg+2dLV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rkvKQBHVgTV1xFWrB3D2Z4GX0DEOMixwgkzM4RD+g16Dd7YBaKoQ0uuuVk/GPLNHL
	 vIFDkzT4+g7kPjhc240kURa1aXwGotjgrQXfW9jkoLZCp7lFJhbzbjD/lC/RjHBWMx
	 TttYUd5sIfdolpgSA5NSy6DqEFqQKfjnXNZ5s5J2bY8YDiUG/svuofBKpjbB6NONHy
	 lVRVIxfJkP9Qm7Cwq5JlU/zwC7/Z6GU5tT8mmRM+BHE9qoK2yffjZvxJrz9TTE6jMw
	 GcgO4MI9WTM5SBzZiwpWyQlFQWe0hOigV56xgkR1F2ZsLnvEchc3p3IqMN5GFeFA1j
	 XXe9Gvw3FVVJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7101E3822D1A;
	Tue, 15 Apr 2025 00:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/14] net: Convert ->exit_batch_rtnl() to
 ->exit_rtnl().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467703924.2083973.8091264853407510978.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 00:30:39 +0000
References: <20250411205258.63164-1-kuniyu@amazon.com>
In-Reply-To: <20250411205258.63164-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Apr 2025 13:52:29 -0700 you wrote:
> While converting nexthop to per-netns RTNL, there are two blockers
> to using rtnl_net_dereference(), flush_all_nexthops() and
> __unregister_nexthop_notifier(), both of which are called from
> ->exit_batch_rtnl().
> 
> Instead of spreading __rtnl_net_lock() over each ->exit_batch_rtnl(),
> we should convert all ->exit_batch_rtnl() to per-net ->exit_rtnl() and
> run it under __rtnl_net_lock() because all ->exit_batch_rtnl() functions
> do not have anything to factor out for batching.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/14] net: Factorise setup_net() and cleanup_net().
    https://git.kernel.org/netdev/net-next/c/e333b1c3cf25
  - [v2,net-next,02/14] net: Add ops_undo_single for module load/unload.
    https://git.kernel.org/netdev/net-next/c/fed176bf3143
  - [v2,net-next,03/14] net: Add ->exit_rtnl() hook to struct pernet_operations.
    https://git.kernel.org/netdev/net-next/c/7a60d91c690b
  - [v2,net-next,04/14] nexthop: Convert nexthop_net_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/cf701038d1c8
  - [v2,net-next,05/14] vxlan: Convert vxlan_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/6f2667b98ef2
  - [v2,net-next,06/14] ipv4: ip_tunnel: Convert ip_tunnel_delete_nets() callers to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/a967e01e2ad2
  - [v2,net-next,07/14] ipv6: Convert tunnel devices' ->exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/f76758f18fb8
  - [v2,net-next,08/14] xfrm: Convert xfrmi_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/9571ab5a98fe
  - [v2,net-next,09/14] bridge: Convert br_net_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/b7924f50be15
  - [v2,net-next,10/14] bonding: Convert bond_net_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/baf720334c02
  - [v2,net-next,11/14] gtp: Convert gtp_net_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/bc7eaf7a40bb
  - [v2,net-next,12/14] bareudp: Convert bareudp_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/fc3dc33f668c
  - [v2,net-next,13/14] geneve: Convert geneve_exit_batch_rtnl() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/4e53b32d74f0
  - [v2,net-next,14/14] net: Remove ->exit_batch_rtnl().
    https://git.kernel.org/netdev/net-next/c/c57a9c503543

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



