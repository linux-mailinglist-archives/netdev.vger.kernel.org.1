Return-Path: <netdev+bounces-18999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B375947E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4716B1C20EE6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255F13AF1;
	Wed, 19 Jul 2023 11:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19181429E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55A0DC433CA;
	Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689766820;
	bh=iW/wY6IXsINxSp0RxmTTr0pltUrRCYnqRAeox/7HdBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PneJgMLEub3R21CAb+KI8H+VvqtF+a3O1asQyM2qWdp/9HtHRmuG29EE/QWNZvfFb
	 nN3omiZ+lg5c8XcyIB2UYHAHwlhCG3QOPEk/k1Y/tA9odapjxIR0TTXhsqg88WXyDN
	 t2z0c/vznM56fptTc0S5OLe5h67a1MfYR60ydWFReKOSAeyI22TgpTaCpBM1mE+lQT
	 Bc14+Vg8aBJpBdZxHpPwPOvF0VR+9D6USiuqJO1pHnwXVsmHTySXfmy3JPSXUGnq58
	 NeoPmzhPp/noFbz5NGV81Gq7fr/rMjGuB5bc5vNgdT1M0sgkOZFcueO6kBNO6XX36S
	 KX4U5SOvehs4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 342F6E21EFF;
	Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver Updates
 2023-07-14 (i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168976682020.23748.8273277474530562675.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 11:40:20 +0000
References: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230714201253.1717957-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 14 Jul 2023 13:12:51 -0700 you wrote:
> This series contains updates to i40e driver only.
> 
> Ivan Vecera adds waiting for VF to complete initialization on VF related
> configuration callbacks.
> 
> The following are changes since commit 68af900072c157c0cdce0256968edd15067e1e5a:
>   gve: trivial spell fix Recive to Receive
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] i40e: Add helper for VF inited state check with timeout
    https://git.kernel.org/netdev/net-next/c/df84f0ce569d
  - [net-next,v2,2/2] i40e: Wait for pending VF reset in VF set callbacks
    https://git.kernel.org/netdev/net-next/c/efb6f4a35954

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



