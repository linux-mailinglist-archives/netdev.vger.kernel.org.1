Return-Path: <netdev+bounces-29014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB778167E
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64C1281D7F
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADC65F;
	Sat, 19 Aug 2023 01:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA46652
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 01:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91142C433C7;
	Sat, 19 Aug 2023 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692409820;
	bh=1xKOo8e+yHe9yBvf4r8j1yhlME4v4ZCTxC16aU0cd78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CkBoF/x+7S44myTvhVD2plfaBPWcr7AjJZCYjiYQp+JsWkwY4Oo5n0dYASUY9J3Hd
	 qBO1wYtnDCaD+LhSCAE/W97tBlw4ep+bCvRWalRTTkIC1KjG0rhx3cQvqd8cB9kpa6
	 7IbZn/csBnxGdbxO7bvfpQ+R828vzX2wZ174hJVS6sgE79g61IuMwUN9ZGPCubDdt4
	 WW0Pkn6Qr4INtkYcFJnIUuB11B6NYFQ+A6V6srP6Tft/uoJqyaciR6UojmFV8cU2Pb
	 cZ9WWjJxWjszkbN7/HQH1wegzqzBJUv3LFoCsrUg9lA3XoejD/hJbQ58q3j1EnnUWi
	 9P4ogWrNJeCFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74351C395DC;
	Sat, 19 Aug 2023 01:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: felix: fix oversize frame dropping for always
 closed tc-taprio gates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169240982047.25977.11170971681748850525.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 01:50:20 +0000
References: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiaoliang.yang_1@nxp.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
 michael@walle.cc, richard.pearn@nxp.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 15:01:11 +0300 you wrote:
> The blamed commit resolved a bug where frames would still get stuck at
> egress, even though they're smaller than the maxSDU[tc], because the
> driver did not take into account the extra 33 ns that the queue system
> needs for scheduling the frame.
> 
> It now takes that into account, but the arithmetic that we perform in
> vsc9959_tas_remaining_gate_len_ps() is buggy, because we operate on
> 64-bit unsigned integers, so gate_len_ns - VSC9959_TAS_MIN_GATE_LEN_NS
> may become a very large integer if gate_len_ns < 33 ns.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: felix: fix oversize frame dropping for always closed tc-taprio gates
    https://git.kernel.org/netdev/net/c/d44036cad311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



