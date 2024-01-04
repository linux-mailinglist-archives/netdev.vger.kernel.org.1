Return-Path: <netdev+bounces-61421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC30823A27
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BE21C24B15
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E7382;
	Thu,  4 Jan 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkJgG9Xc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9A4C65
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC2F3C433C9;
	Thu,  4 Jan 2024 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704331231;
	bh=YChIEbGFDoT/ZpSbW6yjsZdCQMaJkeK4wqe1T60Hzqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nkJgG9Xc+oVa7qtB9aTatv38jFcip/n6yNHvXS5Ko27WJLlLgMs6DBwGQRkobE74f
	 VYrd/BCAsQHr74dE5XsjS/vOTHXXV9RzBT9RkzGGqdNAqqeD9SqoHkneG1alGQK1HI
	 NSLo5/5/wuy8LUolcIXMGxeij0/9kHYXxholQ8N5e/4CpeqXHQmLGwpAcvYenl3B2Y
	 pAbIHWlQJ6CiKKSml10UA0uiQoAwUiRA1wZavSJPcgXRYuCnLW1PBKc8niLUZN59ZT
	 EbShfN44JXqP60rtWX8heXMDQGH3X2p3HcW/gpeTBYKO2CLd8R8IjyLWxgmdCR1JSz
	 G8TI+i9328cog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD0EAC43168;
	Thu,  4 Jan 2024 01:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-12-27 (igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433123083.16806.12702971520647373006.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:20:30 +0000
References: <20231227210041.3035055-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231227210041.3035055-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 27 Dec 2023 13:00:37 -0800 you wrote:
> This series contains updates to igc driver only.
> 
> Kurt Kanzenbach resolves issues around VLAN ntuple rules; correctly
> reporting back added rules and checking for valid values.
> 
> The following are changes since commit 49fcf34ac908784f97bc0f98dc5460239cc53798:
>   Merge tag 'wireless-2023-12-19' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE
> 
> [...]

Here is the summary with links:
  - [net,1/3] igc: Report VLAN EtherType matching back to user
    https://git.kernel.org/netdev/net/c/088464abd48c
  - [net,2/3] igc: Check VLAN TCI mask
    https://git.kernel.org/netdev/net/c/b5063cbe148b
  - [net,3/3] igc: Check VLAN EtherType mask
    https://git.kernel.org/netdev/net/c/7afd49a38e73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



