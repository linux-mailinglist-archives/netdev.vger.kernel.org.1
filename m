Return-Path: <netdev+bounces-170405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E4A488E0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 20:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A3F166EF2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBFD26E940;
	Thu, 27 Feb 2025 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEEBmo0O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A16270054;
	Thu, 27 Feb 2025 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684026; cv=none; b=ZFPQ748aSKrZStag8W70UW46p8EPsOhP85gauW+6sFfCVBNa54G7tx2gmqGDHjVKG3YFd7mXngBcTMb0h85rRx6RSzR4Pz/NxZN9vfVQYqDcxqdZksk1ZU0uaGiy/XJD4tHYL8aV/5n0d8e1f7Itzz2oatscnfIpjWnaum0+Kd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684026; c=relaxed/simple;
	bh=xtfpr7hHwam7QkTVY8/dfHG6gdnWBz3qmp5PmCCeyqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h7v+BHRsMU0hL5GrNiV0eRPUmYO3ncHF3u0JGVkzw7ppvA5uNacm4HjCv5tDAZTL4cTO1tAkJPEr2SGDUWrH+7kQ3DzGt0rVKTnTXYU1cmRD3zJaJy4N4J0tZrapXJlT6IlkmXNYYhcpGJC2DTR0v1eFPsK2fKfbtC63eYzd4Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEEBmo0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECFBC4CEDD;
	Thu, 27 Feb 2025 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740684025;
	bh=xtfpr7hHwam7QkTVY8/dfHG6gdnWBz3qmp5PmCCeyqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JEEBmo0OJyq4tnv7HxVytge08ygjACWegFDvH/0Z76VYA3+wdt+KYF0HTXWJYeduA
	 lHaOmZtcPf10yU0dg4Px7QwiM+K4Qwid7qkzC9LKXrDSDPpXFNjFXQDH4QKcqk3M82
	 aPpdOG6UMMpSPoBJdM30jDsMGVfVwyNHMbpsgrtlYBna8GvzrCa90ORgrmEW/oDPqH
	 HdIcDg0/tf1bnyujbbPermj1gIm+9x+gsJHl182cv+cFq9HNALPBN5tlNCe00A5qGH
	 AxywRT/o4IyPybiT5lD04RW3qGbXGDG97ujivGRuMK8Wxu3BcLu0DmzJCP9LYDeY5+
	 zAHIhsf85xBig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF31380AACB;
	Thu, 27 Feb 2025 19:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] afs,
 rxrpc: Clean up refcounting on afs_cell and afs_server records
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174068405775.1535916.5681071064674695791.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 19:20:57 +0000
References: <20250224234154.2014840-1-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 brauner@kernel.org, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 23:41:37 +0000 you wrote:
> Here are some patches that fix an occasional hang that's only really
> encountered when rmmod'ing the kafs module.  Arguably, this could also go
> through the vfs tree, but I have a bunch more primarily crypto and rxrpc
> patches that need to go through net-next on top of this[1].
> 
> Now, at the beginning of this set, I've included five fix patches that are
> already committed to the net/main branch but that need to be applied first,
> but haven't made their way into net-next/main or upstream as yet:
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] rxrpc: rxperf: Fix missing decoding of terminal magic cookie
    https://git.kernel.org/netdev/net-next/c/c34d999ca314
  - [net-next,02/15] rxrpc: peer->mtu_lock is redundant
    https://git.kernel.org/netdev/net-next/c/833fefa07444
  - [net-next,03/15] rxrpc: Fix locking issues with the peer record hash
    https://git.kernel.org/netdev/net-next/c/71f5409176f4
  - [net-next,04/15] afs: Fix the server_list to unuse a displaced server rather than putting it
    https://git.kernel.org/netdev/net-next/c/add117e48df4
  - [net-next,05/15] afs: Give an afs_server object a ref on the afs_cell object it points to
    https://git.kernel.org/netdev/net-next/c/1f0fc3374f33
  - [net-next,06/15] afs: Remove the "autocell" mount option
    (no matching commit)
  - [net-next,07/15] afs: Change dynroot to create contents on demand
    (no matching commit)
  - [net-next,08/15] afs: Improve afs_volume tracing to display a debug ID
    (no matching commit)
  - [net-next,09/15] afs: Improve server refcount/active count tracing
    (no matching commit)
  - [net-next,10/15] afs: Make afs_lookup_cell() take a trace note
    (no matching commit)
  - [net-next,11/15] afs: Drop the net parameter from afs_unuse_cell()
    (no matching commit)
  - [net-next,12/15] rxrpc: Allow the app to store private data on peer structs
    (no matching commit)
  - [net-next,13/15] afs: Use the per-peer app data provided by rxrpc
    (no matching commit)
  - [net-next,14/15] afs: Fix afs_server ref accounting
    (no matching commit)
  - [net-next,15/15] afs: Simplify cell record handling
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



