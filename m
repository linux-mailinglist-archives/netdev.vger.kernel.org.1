Return-Path: <netdev+bounces-27984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD377DCFE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB71C20DBC
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF5D536;
	Wed, 16 Aug 2023 09:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56837D521
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93202C433C9;
	Wed, 16 Aug 2023 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692177021;
	bh=bmFUkTY0/U/wRBaz9A+ggu1g77MT/EYx3l109QRL4HM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RvOwKvjRcA7MiOm605oQ9KfsL4JHhHFjSu22GxaW1nckK4a0MFIJG9M1wXjieUpgj
	 khzB/PxGs+ZzoAppw58uMaPSARKauo+GQP6k0jS3bmXhxTlSq6uFyzHa7rsvNVINDZ
	 CIkH16n9NTZ0LamMwFnYEtzaRY7EnlOrfAMBgagux+CRL/EvBuMbwoN37LGZ1aLFPA
	 oyEbqJaDuM8QDUVcUafRUL3EdX5l3BPVtwT83rVQfAufBmex5dZ41ALFI/fnb5NCLh
	 81Y7L+84TqwhBNNhA18cC64IEI0FGsAeAv//HEnt2ohi7LlqqPcVpD+SIwOwK/a2DB
	 dGPunp7yioeUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7540FC691E1;
	Wed, 16 Aug 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: Remove redundant of_match_ptr() macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169217702147.13419.3048871621351512255.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 09:10:21 +0000
References: <20230814025447.2708620-1-ruanjinjie@huawei.com>
In-Reply-To: <20230814025447.2708620-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 clement.leger@bootlin.com, ulli.kroll@googlemail.com, kvalo@kernel.org,
 bhupesh.sharma@linaro.org, robh@kernel.org, elder@linaro.org,
 wei.fang@nxp.com, nicolas.ferre@microchip.com, simon.horman@corigine.com,
 romieu@fr.zoreil.com, dmitry.torokhov@gmail.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 14 Aug 2023 10:54:42 +0800 you wrote:
> Since these net drivers depend on CONFIG_OF, there is
> no need to wrap the macro of_match_ptr() here.
> 
> Changes in v3:
> - Collect responses from v1 and v2.
> 
> Ruan Jinjie (5):
>   net: dsa: realtek: Remove redundant of_match_ptr()
>   net: dsa: rzn1-a5psw: Remove redundant of_match_ptr()
>   net: gemini: Remove redundant of_match_ptr()
>   net: qualcomm: Remove redundant of_match_ptr()
>   wlcore: spi: Remove redundant of_match_ptr()
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: dsa: realtek: Remove redundant of_match_ptr()
    https://git.kernel.org/netdev/net-next/c/aae249dfa089
  - [net-next,v3,2/5] net: dsa: rzn1-a5psw: Remove redundant of_match_ptr()
    https://git.kernel.org/netdev/net-next/c/81d463c02b91
  - [net-next,v3,3/5] net: gemini: Remove redundant of_match_ptr()
    https://git.kernel.org/netdev/net-next/c/21b566fda00f
  - [net-next,v3,4/5] net: qualcomm: Remove redundant of_match_ptr()
    https://git.kernel.org/netdev/net-next/c/537a6b992708
  - [net-next,v3,5/5] wlcore: spi: Remove redundant of_match_ptr()
    https://git.kernel.org/netdev/net-next/c/cf2abd872431

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



