Return-Path: <netdev+bounces-50022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C57F4480
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B528113C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42A52D78B;
	Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyvBS9R7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF722314
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4713FC433CC;
	Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700650824;
	bh=JwVuGcTmcYQlehqkotnDdbNmcVl+I34uPSQBTDYYs50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZyvBS9R7eanca9Q6HLRtgVZv6n0phhRtjhUFg4VoDOZRR73Px+fqunAHVW2ZE/gWt
	 Dc3wHMP9VN8k0RYCUk+hCmOs++6XH8BebIiz+E9V8X4UhBtj2kczKRtSqOvV68HNgo
	 D24zU2vZlJmz3t/+pd9YRX2HF0LDb1R8lK+IItf1icMUD9zUPZNHepyejU6tI17Pe7
	 +rUsvzo7EiPqfGGZRfWbo1i37TRFmhTLjyA0XpUZ/5FWj5gAH6BE47HfeN77p+L8ju
	 2uTQTT8ZkeVRdLVnd5Gk2LRykB2nhVsGDi63UmEYV/UintxUUbeDmo7PDsFNjXD5sS
	 7LRsGxSObFQnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30E9DC3959E;
	Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: hsr: Add support for MC filtering at the
 slave device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170065082419.4259.7747506565091490593.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 11:00:24 +0000
References: <20231121053753.32738-1-r-gunasekaran@ti.com>
In-Reply-To: <20231121053753.32738-1-r-gunasekaran@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wojciech.drewek@intel.com, bigeasy@linutronix.de,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 srk@ti.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 11:07:53 +0530 you wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> When MC (multicast) list is updated by the networking layer due to a
> user command and as well as when allmulti flag is set, it needs to be
> passed to the enslaved Ethernet devices. This patch allows this
> to happen by implementing ndo_change_rx_flags() and ndo_set_rx_mode()
> API calls that in turns pass it to the slave devices using
> existing API calls.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: hsr: Add support for MC filtering at the slave device
    https://git.kernel.org/netdev/net-next/c/36b20fcdd966

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



