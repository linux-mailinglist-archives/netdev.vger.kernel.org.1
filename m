Return-Path: <netdev+bounces-13755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3DA73CD43
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652B528112D
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED43111B9;
	Sat, 24 Jun 2023 22:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FFF9DA
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF8B2C433C8;
	Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645220;
	bh=fUeIKoGWA1WFc8cmbNYmndj88NKP1V6FAhxZpP0ubhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rmE00fpzeRkeHswcCShkOQD4rG+6jWrvLig6JJbwRoTacZpFsM+fsAMLJGdVPHUnh
	 n5UumTctjgWw6XpVzSEENy2jdy3Ri+2eUtWjdYRTq/nB2uLlqkp3S6+C4/GQ0QoMab
	 2FDWfUB3Mbu9Y/mhpaacCU689H+8WNhqss1n9tC7BxdXYI1CcOTRE783HjdGbNl7os
	 f6aNV7GWWJxfALADGeBzKDMtdt8LEi1l2PIIBKtYDLBcDrIInH0v2j4DCDsMfONPQY
	 Kehx+7OT2cdjj07RcyZy1ULDvejlHtKfYtSDOPROl+7GeAQh+asTwV4/wDfvWAdKbB
	 rrkcobR+QgoKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6730E26D3E;
	Sat, 24 Jun 2023 22:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates
 2023-06-22 (iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764522080.22804.2741090372378824006.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:20:20 +0000
References: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 22 Jun 2023 09:59:11 -0700 you wrote:
> This series contains updates to iavf driver only.
> 
> Przemek defers removing, previous, primary MAC address until after
> getting result of adding its replacement. He also does some cleanup by
> removing unused functions and making applicable functions static.
> 
> The following are changes since commit 98e95872f2b818c74872d073eaa4c937579d41fc:
>   Merge branch 'mptcp-expose-more-info-and-small-improvements'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] iavf: fix err handling for MAC replace
    https://git.kernel.org/netdev/net-next/c/61f723e6f3d2
  - [net-next,2/3] iavf: remove some unused functions and pointless wrappers
    https://git.kernel.org/netdev/net-next/c/b855bcdeb897
  - [net-next,3/3] iavf: make functions static where possible
    https://git.kernel.org/netdev/net-next/c/a4aadf0f5905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



