Return-Path: <netdev+bounces-34072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F37A1F6B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AEB1C208DB
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1B1095B;
	Fri, 15 Sep 2023 13:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086E101DD;
	Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9B86C433D9;
	Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694782826;
	bh=xqj4QRqO55KywEoX85nsOwjXLp4zs8awExP+e9hTfw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r2vvDkgOcTnfhCa6pwsvekB2TPv8uQQx1JSHYnKpR8+8dsFOOnZZ3SPJitEYx64ac
	 /+ACzjUGYafLevq74JPFr/LIfkeKtlAIReWdBIG55dcIuCUrGE7dA131iB7lxNwnMs
	 vY6iA0nujDJFXt1RRR6u8A6eo896sxSGl70uTTW+S4YC4M0lAIHB2XLTXbVqLfiXQb
	 O4GMv/hzKsA3EIVPPSzdieAHGLjR97O0P43zrH8J5bj8jp/71P8NR89UW+YzMRtbBC
	 pH9VqasJrdlqdx8MSHv3U+lcE3gvfyDyP5m+tCQtSXbYxkGDC5K40UpFhj+Z/ZSiXH
	 ToaFP6ZWe76tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9643EE22AEE;
	Fri, 15 Sep 2023 13:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Add Half Duplex support for ICSSG Driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169478282660.10241.3855414468809647924.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 13:00:26 +0000
References: <20230913091011.2808202-1-danishanwar@ti.com>
In-Reply-To: <20230913091011.2808202-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: andrew@lunn.ch, rogerq@ti.com, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, vigneshr@ti.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 14:40:09 +0530 you wrote:
> This series adds support for half duplex operation for ICSSG driver.
> 
> In order to support half-duplex operation at 10M and 100M link speeds, the
> PHY collision detection signal (COL) should be routed to ICSSG GPIO pin
> (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal and apply
> the CSMA/CD algorithm applicable for half duplex operation. A DT property,
> "ti,half-duplex-capable" is introduced for this purpose in the first patch
> of the series. If board has PHY COL pin conencted to PRGx_PRU1_GPIO10,
> this DT property can be added to eth node of ICSSG, MII port to support
> half duplex operation at that port.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: Add documentation for Half duplex support.
    https://git.kernel.org/netdev/net-next/c/927c568d6212
  - [net-next,v3,2/2] net: ti: icssg-prueth: Add support for half duplex operation
    https://git.kernel.org/netdev/net-next/c/0a205f0fe8dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



