Return-Path: <netdev+bounces-31008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E778A88A
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2801C208BC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932D74C8C;
	Mon, 28 Aug 2023 09:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428A62591
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CD02C433CA;
	Mon, 28 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693213822;
	bh=+wWRJuF6zpwzycLF5hMliLOvycFkNHXy2NQX6pDQBzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LQ8fbqC6qI8HnljwBTWWBzWF9gyo1SYGjSXx9dt9C8cu80am2qP6+PlU67Mh92SOq
	 xSOEoktSPWY+I3xT1dpYuJAdBvrOW3n722ZUb5uIshKtz0CWuBdb9hIpjr0psjLNFC
	 rU8lJfRDiwmL0PMnd1WC3BVbakZqmhjPd3JvrlgbyA+c0buhHLPkmfJt4QLjNqiLkI
	 j8KS2LW8QBrpSW2CdC85oU+Hcj2PLgvksQ3Rk4gKa5SZdqjYU6DO5yUs8Z50TMpEic
	 Xh6VAEP9mZ+AWgbFlzjFuo5VlYgc0RCHXWrT7p6DQPCRc/lJadYGxhwnw114oWVbJ0
	 25Wvic0i72uCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8318DC3959E;
	Mon, 28 Aug 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: dsa: marvell: fix wrong model in
 compatibility list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169321382253.1934.4875969409159413370.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 09:10:22 +0000
References: <20230825082027.18773-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230825082027.18773-1-alexis.lothore@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 thomas.petazzoni@bootlin.com, airat.gl@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 10:20:27 +0200 you wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Fix wrong switch name in compatibility list. 88E6163 switch does not exist
> and is in fact 88E6361
> 
> Fixes: 9229a9483d80 ("dt-bindings: net: dsa: marvell: add MV88E6361 switch to compatibility list")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] dt-bindings: net: dsa: marvell: fix wrong model in compatibility list
    https://git.kernel.org/netdev/net/c/72dd7e427e16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



