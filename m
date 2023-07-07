Return-Path: <netdev+bounces-15950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC27974A8E2
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18081C20EF6
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 02:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214332107;
	Fri,  7 Jul 2023 02:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748015C2
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8075BC433C9;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688696424;
	bh=QX8ydS+01RAznifunMEpbyUhZSB5I5EmS3nsZGI1KWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CBU+Pjs/FGudG/pjhRZwN4Fcmjq/H0/IWM0KmFKskPrJW1SC9cuboyRy0BLBZP92v
	 32hOr747366R93tRGfR5FqbMELzo/ZSvG8QWmCEvqu11JnMqiACmjjduZ03rlyNey/
	 BHeseK0Evvmhc0Xog/YVJgsKaCVve1zTTY+B/WSaOBjsDPoBhBvPzYyd3HofqRfbuf
	 MDkst9NkfvFRma8QQ/vr9keeN5SGygyAFq+68YvZJs6MrEREYQAy2/0/UGYuZZv+dB
	 SJWAgANmxM4u/fF2e+Xf83CymCQLkeAtrr5CzBxLvp6uEH2ZC0gaK87qyoA0YJdDD1
	 0L2WlxxqJzsiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E17FC73FEB;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] Fix dropping of oversize preemptible frames with
 felix DSA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168869642438.27656.6734580798991464812.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 02:20:24 +0000
References: <20230705104422.49025-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230705104422.49025-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
 UNGLinuxDriver@microchip.com, xiaoliang.yang_1@nxp.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Jul 2023 13:44:19 +0300 you wrote:
> It has been reported that preemptible traffic doesn't completely behave
> as expected. Namely, large packets should be able to be squeezed
> (through fragmentation) through taprio time slots smaller than the
> transmission time of the full frame. That does not happen due to logic
> in the driver (for oversize frame dropping with taprio) that was not
> updated in order for this use case to work.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: mscc: ocelot: extend ocelot->fwd_domain_lock to cover ocelot->tas_lock
    https://git.kernel.org/netdev/net/c/009d30f1a777
  - [net,2/3] net: dsa: felix: make vsc9959_tas_guard_bands_update() visible to ocelot->ops
    https://git.kernel.org/netdev/net/c/c60819149b63
  - [net,3/3] net: mscc: ocelot: fix oversize frame dropping for preemptible TCs
    https://git.kernel.org/netdev/net/c/c6efb4ae387c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



