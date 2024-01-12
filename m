Return-Path: <netdev+bounces-63171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8682B898
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C392884F9
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BFC651;
	Fri, 12 Jan 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFbIVb6a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08314EBD
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95A05C433F1;
	Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705019430;
	bh=8nGB2BK9z/NbVd0a/HCUDtdJ33TiRtqQDkRKIEeac84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NFbIVb6apYsRLEfVrHugsPcW7bMo0n5o1olipZRJHahcAo9Oc+UJUf0HOzHf52NM7
	 W+4uRJ8Rq2R+RNtmje5BphRiS7JtYwuWSVzdq6A57qkgpqvQx4r46o+tb4SGCb16OQ
	 YhRPATbQw8AlcRscZGMjlj5QF8fRZPRDDCezF5/7QO/NwkPU2xfzlx6eXyioFps6w2
	 LEl53TNk+r8KPjGpqmtAFVFDqL3MgyY0UWwNjCS1Hi97lpq71meSZXvN139RvIGLJ4
	 OuiBqwc7gZ1gWnYUEwOmMamC1x/h6jOq83d78hVf3PJYcg7USQZ3/cdI0RHG7Dltov
	 nX5SRZ/GedcVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C3BFD8C96E;
	Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] Networking MAINTAINERS spring 2024 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170501943050.11195.11187145837664799882.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 00:30:30 +0000
References: <20240109164517.3063131-1-kuba@kernel.org>
In-Reply-To: <20240109164517.3063131-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jan 2024 08:45:10 -0800 you wrote:
> Starting in 2021 we had been using Jon Corbet's gitdm scripts
> to find maintainers missing in action [1]. The scripts analyze
> the last 5 years of git history, locate subsystems which
> were touched by more than 50 commits, and generate simple
> review statistics for each maintainer. We then query the stats
> to find maintainers who haven't provided a single tag.
> 
> [...]

Here is the summary with links:
  - [net,1/7] MAINTAINERS: eth: mtk: move John to CREDITS
    https://git.kernel.org/netdev/net/c/da14d1fed9c1
  - [net,2/7] MAINTAINERS: eth: mt7530: move Landen Chao to CREDITS
    https://git.kernel.org/netdev/net/c/b59d8485fe7f
  - [net,3/7] MAINTAINERS: eth: mvneta: move Thomas to CREDITS
    https://git.kernel.org/netdev/net/c/009a98bca634
  - [net,4/7] MAINTAINERS: eth: mark Cavium liquidio as an Orphan
    https://git.kernel.org/netdev/net/c/384a35866f3a
  - [net,5/7] MAINTAINERS: Bluetooth: retire Johan (for now?)
    https://git.kernel.org/netdev/net/c/0bfcdce867f7
  - [net,6/7] MAINTAINERS: mark ax25 as Orphan
    https://git.kernel.org/netdev/net/c/bd93edbfd70c
  - [net,7/7] MAINTAINERS: ibmvnic: drop Dany from reviewers
    https://git.kernel.org/netdev/net/c/f9678f5825dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



