Return-Path: <netdev+bounces-43218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D357D1CA0
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4282B1C2096F
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B3DDA7;
	Sat, 21 Oct 2023 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap3CeC5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952418A
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19345C433C9;
	Sat, 21 Oct 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697886023;
	bh=EGGs2rA0P7U9N9aLbE/lY/EjgINVOXULfVH0cySWkuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ap3CeC5+7iOeBoD0fcxnyUMsmfCWcXOinV7vMR404J+5p/GAfN0tt/iRahwah0Brj
	 2sCYOn5zbG04/p/0yzGO0Wd61BBNKvNsKu2a/SE3UBHfDe1chjBkOe3H3RPlfC7jFp
	 ugIZ3S8E0+oOkzx3d8rGctM1hsaBMnXUSpDXfk4gq2pJlzQba2JP/WI+C5l8HO7jJK
	 SLQOxfYZe0UVWi6bGfUSiWH9jHqS08VdiPmg0iaBCu6SnMLbDtGUMSFHm+e86Zh0WG
	 /PoaJG0MYH9c8Pt2CH+QOM+RG9shzIufHGLGkrESvrT//s5CDtn1lhkzoppt2rJHtW
	 dxpGPLfLG4+1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F21FBC04DD9;
	Sat, 21 Oct 2023 11:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: stmmac: update MAC capabilities when tx
 queues are updated
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169788602298.24143.12150015949890853801.git-patchwork-notify@kernel.org>
Date: Sat, 21 Oct 2023 11:00:22 +0000
References: <20231020032535.1777746-1-yi.fang.gan@intel.com>
In-Reply-To: <20231020032535.1777746-1-yi.fang.gan@intel.com>
To: Gan@codeaurora.org, Yi Fang <yi.fang.gan@intel.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, linux@armlinux.org.uk, boon.leong.ong@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 hong.aun.looi@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 11:25:35 +0800 you wrote:
> From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> 
> Upon boot up, the driver will configure the MAC capabilities based on
> the maximum number of tx and rx queues. When the user changes the
> tx queues to single queue, the MAC should be capable of supporting Half
> Duplex, but the driver does not update the MAC capabilities when it is
> configured so.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: stmmac: update MAC capabilities when tx queues are updated
    https://git.kernel.org/netdev/net/c/95201f36f395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



