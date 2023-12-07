Return-Path: <netdev+bounces-54814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE965808588
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2B0B220E3
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C131728;
	Thu,  7 Dec 2023 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3mHWfUK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521631DFF2;
	Thu,  7 Dec 2023 10:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB676C433C9;
	Thu,  7 Dec 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701945024;
	bh=pFq7j9bon22etyXf7357E7ITfs/y8T8hPp68MYGgsiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s3mHWfUKPYNJHk5O/3Q3wAceBPtFFF+wY1g+7puzKxTD8GvT0Behe870JMZOGAAs/
	 g38w4QBBpTxCjdG8J6Nt1fpJ+EDIt9xPN/6l9OQ5iLpX4Nn5ZsJa/pCHhNVefCxglo
	 /X5Int80ZxfAohDqrWe8HQZY33xAGGFOBxQJvZo7oEwiI3fGUvDTWtqxdCwy4pjEVQ
	 +QmC2yPnODNy2D3Hz2T2gYMnziIbe6tMAZoQ4Em9HfNPSnxO6kj8rEx5u4f49wgYb3
	 g+nWeafi2jwbXpmsps2JEPaaIA9niqlXxviMWGUbZLuXAkQnfj/hxlZuVnsT5tJ269
	 fuYmWrbTC2dPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D22DC43170;
	Thu,  7 Dec 2023 10:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] net: dsa: microchip: enable setting rmii
 reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170194502463.8570.266673785548513310.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 10:30:24 +0000
References: <cover.1701770394.git.ante.knezic@helmholz.de>
In-Reply-To: <cover.1701770394.git.ante.knezic@helmholz.de>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, marex@denx.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 5 Dec 2023 11:03:37 +0100 you wrote:
> KSZ88X3 devices can select between internal and external RMII reference clock.
> This patch series introduces new device tree property for setting reference
> clock to internal.
> 
> ---
> V7:
>   - adapt dt schema as suggested by Rob Herring
> V6:
>   - use dev->cpu_port and dsa_to_port() instead of parsing the device tree.
> V5:
>   - move rmii-clk-internal to be a port device tree property.
> V4:
>   - remove rmii_clk_internal from ksz_device, as its not needed any more
>   - move rmii clk config as well as ksz8795_cpu_interface_select to
>     ksz8_config_cpu_port
> V3:
>   - move ksz_cfg from global switch config to port config as suggested by Vladimir
>     Oltean
>   - reverse patch order as suggested by Vladimir Oltean
>   - adapt dt schema as suggested by Conor Dooley
> V2:
>   - don't rely on default register settings - enforce set/clear property as
>     suggested by Andrew Lunn
>   - enforce dt schema as suggested by Conor Dooley
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
    https://git.kernel.org/netdev/net-next/c/8e3bfaab2ad9
  - [net-next,v7,2/2] net: dsa: microchip: add property to select internal RMII reference clock
    https://git.kernel.org/netdev/net-next/c/9f19a4ebc80a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



