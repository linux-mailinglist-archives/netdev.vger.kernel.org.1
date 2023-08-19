Return-Path: <netdev+bounces-29134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC9781AC8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E76281616
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73117740;
	Sat, 19 Aug 2023 18:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3871398
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A648C433C9;
	Sat, 19 Aug 2023 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692470605;
	bh=UpBN9Gf78piujGrFdKz6/w84WEkjfVvhqbG8SMAy9vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nGE6by7Yd+pZyFp+bhIpTSWZeKNuI/Pz1mly9sKbwyoCWRUlMUJG3//PFTTbOS13d
	 sui9iHJ52x9cb38wwuVhJaTdbL+QQQ4xAR0sNZRw+95AGxTXoeTP6X5nPXacHCO2gD
	 i8rD1M4YCcQ2q4RYduTDepoR+4SJ+Y9sR2L7LhzsbKMGkbbClX8l+BEMezucZPOnPd
	 kjLGstSxI7iFLblzEUygKZiW6xF8uCM21gFU2dLy8wLGMfMMGz4in2OSZ4vO85KibD
	 wFee10X3OFYIoGVnDkoa9VhXE3MDCwf4jebHsKU9EzWI9gGdjiWb8eRCg4HnLkTEbN
	 AXC332lRDGkIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60BDDE26D32;
	Sat, 19 Aug 2023 18:43:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: Update and fix return value check for
 vcap_get_rule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169247060539.23973.13349509787024032773.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 18:43:25 +0000
References: <20230818050505.3634668-1-ruanjinjie@huawei.com>
In-Reply-To: <20230818050505.3634668-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: horatiu.vultur@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 richardcochran@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 13:05:02 +0800 you wrote:
> As Simon Horman suggests, update vcap_get_rule() to always
> return an ERR_PTR() and update the error detection conditions to
> use IS_ERR(), which would be more cleaner.
> 
> So se IS_ERR() to update the return value and fix the issue
> in lan966x_ptp_add_trap().
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: microchip: vcap api: Always return ERR_PTR for vcap_get_rule()
    https://git.kernel.org/netdev/net-next/c/093db9cda7b6
  - [net-next,v2,2/3] net: lan966x: Fix return value check for vcap_get_rule()
    https://git.kernel.org/netdev/net-next/c/ab104318f639
  - [net-next,v2,3/3] net: microchip: sparx5: Update return value check for vcap_get_rule()
    https://git.kernel.org/netdev/net-next/c/95b358e4d9c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



