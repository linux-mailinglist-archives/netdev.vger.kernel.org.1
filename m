Return-Path: <netdev+bounces-44247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91D7D74C6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFFF1C20DAD
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A431A98;
	Wed, 25 Oct 2023 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnd0eggR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299C31A92;
	Wed, 25 Oct 2023 19:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6FE9C433C9;
	Wed, 25 Oct 2023 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698263425;
	bh=HLU3b2GLkMtECIXBFhOEcYQW9+OOCtm46MgkMy7Sqqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dnd0eggRFfcXRGO4avZUwQY5pukekB5e70EYtI1tGc4OP4+htspjMQAzOmLTQ2gLZ
	 x8qmMpfHK4ovfRnz/9jZ0c6mX+zHQ+V+H+jrVaIt2g9Ko5Qu33MQY1YPaML9+Knt+/
	 tncIpsyYqup7sy2b1Nwj2LhcZlN2zJCiUnXBR4Pyan9aLs9uVLO+9Y2le3IVvF2j4u
	 TC+HUcmvchyiZd+qNU4hdgGWUOmbT/xR12sa8NZNjjVn6gpvJ7vgX7ONyvOj42Zb2I
	 fzoN6AkFRdD2Hdw8oLEHQRRCUhY2c9pnf7PqC66APi/J4nDarQYGGdOQpsx7T7NpKB
	 P/tTlJwM4BnKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD775E11F58;
	Wed, 25 Oct 2023 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] mptcp: Features and fixes for v6.7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169826342483.24198.5669935259131850057.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 19:50:24 +0000
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: matttbe@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 13:44:33 -0700 you wrote:
> Patch 1 adds a configurable timeout for the MPTCP connection when all
> subflows are closed, to support break-before-make use cases.
> 
> Patch 2 is a fix for a 1-byte error in rx data counters with MPTCP
> fastopen connections.
> 
> Patch 3 is a minor code cleanup.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] mptcp: add a new sysctl for make after break timeout
    https://git.kernel.org/netdev/net-next/c/d866ae9aaa43
  - [net-next,2/9] mptcp: properly account fastopen data
    https://git.kernel.org/netdev/net-next/c/bf0e96108fb6
  - [net-next,3/9] mptcp: use plain bool instead of custom binary enum
    https://git.kernel.org/netdev/net-next/c/f1f26512a9bf
  - [net-next,4/9] tcp: define initial scaling factor value as a macro
    https://git.kernel.org/netdev/net-next/c/849ee75a38b2
  - [net-next,5/9] mptcp: give rcvlowat some love
    https://git.kernel.org/netdev/net-next/c/5684ab1a0eff
  - [net-next,6/9] mptcp: use copy_from_iter helpers on transmit
    https://git.kernel.org/netdev/net-next/c/0ffe8e749040
  - [net-next,7/9] mptcp: consolidate sockopt synchronization
    https://git.kernel.org/netdev/net-next/c/a1ab24e5fc4a
  - [net-next,8/9] mptcp: ignore notsent_lowat setting at the subflow level
    https://git.kernel.org/netdev/net-next/c/9fdc779331bd
  - [net-next,9/9] mptcp: refactor sndbuf auto-tuning
    https://git.kernel.org/netdev/net-next/c/8005184fd1ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



