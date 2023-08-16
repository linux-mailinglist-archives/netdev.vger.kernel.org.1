Return-Path: <netdev+bounces-27892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E62BC77D880
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BB81C20E91
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EFD138C;
	Wed, 16 Aug 2023 02:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4606A41
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53DB8C433CA;
	Wed, 16 Aug 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692153625;
	bh=jB48mtjOpin9SX39ynkO3Yzz30XNgIcFIYnE5PBGfc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MKka+85Vv1BMxwT5IKsTmj+h2qysG2P1gqi0+xbLVbiLZk1Gymuum3tmpS8+2nasv
	 rMBE5uXVfCP8lwqTKq0m6287QfbZdfDfilH/SJgrR+rgyVCGFUmLlpHyoQM1kvNtWN
	 OpOm9lztv9wCnCBQHwI4qXmeb4kTWQ8LNb8eiVuvMEtkVFYO81aDYJ+0sBJMWXgugJ
	 n5Rv3ROuveP4AhIkvyEfuJnAd3n2BphLjJGQ2acmNuycRYiAGCTbvMk19gFXzIXI2Q
	 pDVZidC4dTSGai8hES2cmcEDOV5h0RoDpYZZIt3XXbQWhA/XTvLJR5eko2Nb647se7
	 q7zsheunG+zlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BEF4C395F0;
	Wed, 16 Aug 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: warn about attempts to register negative
 ifindex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215362524.5089.9169791857582963856.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:40:25 +0000
References: <20230814205627.2914583-1-kuba@kernel.org>
In-Reply-To: <20230814205627.2914583-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 13:56:24 -0700 you wrote:
> Follow up to the recently posted fix for OvS lacking input
> validation:
> https://lore.kernel.org/all/20230814203840.2908710-1-kuba@kernel.org/
> 
> Warn about negative ifindex more explicitly and misc YNL updates.
> 
> Jakub Kicinski (3):
>   net: warn about attempts to register negative ifindex
>   netlink: specs: add ovs_vport new command
>   tools: ynl: add more info to KeyErrors on missing attrs
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: warn about attempts to register negative ifindex
    https://git.kernel.org/netdev/net-next/c/956db0a13b47
  - [net-next,2/3] netlink: specs: add ovs_vport new command
    https://git.kernel.org/netdev/net-next/c/ded67d90815a
  - [net-next,3/3] tools: ynl: add more info to KeyErrors on missing attrs
    https://git.kernel.org/netdev/net-next/c/7582113c6917

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



