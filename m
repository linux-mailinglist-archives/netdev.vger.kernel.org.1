Return-Path: <netdev+bounces-96182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA98C49BB
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F6E1C2134A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D084D1F;
	Mon, 13 May 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJMfoPPK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2E433C5;
	Mon, 13 May 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640628; cv=none; b=uWhyUBu0ikWGcG8H/cDbDfkHaXQoXH8ATFCLKvm4AxhnrEtYxm0c8604DUbtGhB3u9PlBjR2au/0RdJQ5Edn1z/5V49dzPqhgZAbKTKbOrtXRX5uj4SNi3No01Uafk/7bSmuzxFLUUAzv2Jr5cGLG39vfV+B29YIiJz2h9eZNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640628; c=relaxed/simple;
	bh=CMZtSqJgd+gtCuO8YISn8F+G6w3l27AmZSYW6HaimyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O1ayvUDALcENj1QGjh+HOg3A53wr8y4eEXPNoOpl93AUVrxVRkoneoaFWKGTpFu0n6PuLp5jLtIJ1RxSUU3s6IqsDIc78wmWpr+j6xtkDfjpbM8id41rzvkKanDbMW/LmFDUyyhprUWaIvcxRyimAz43Q28mYrYGSaaR7h8dcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJMfoPPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF515C32782;
	Mon, 13 May 2024 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715640627;
	bh=CMZtSqJgd+gtCuO8YISn8F+G6w3l27AmZSYW6HaimyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJMfoPPKoU+eRxMAzYkfBXAKmTDytO8/2mIGxVmFajjSKkzjEzxKSbueN3bF4/jpX
	 sRvZGmLGC8veWyB8o/8IOrWg3oQU1lF3hdj80WP7r5IGK1sVROtyLsPkGJDH9HOhFl
	 g+2pb0qMVn92rFE7YJJSwxAk3ARVCQ0BQyzgewY/f92mSSWn4ZDRBL4gqLMXqPRvbK
	 /fOTtPaqTaxG8XnvC3i3JUjCFRSNY0nCpO1Ftyvr4Zz1MlwxPZlyMcTMmCfrkWiNyh
	 QS5ssyO8uV5jlcH6BZdhYJ/ArDj4rVZ3cDZmuJxFpxh1wrTM/ig4aWFk4zaX8y3DBq
	 LBgqth/CYoZ1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3A87C43443;
	Mon, 13 May 2024 22:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564062772.28873.2934906371203677711.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 22:50:27 +0000
References: <20240510113054.186648-2-thorsten.blum@toblux.com>
In-Reply-To: <20240510113054.186648-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: andrew@lunn.ch, arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
 gerg@linux-m68k.org, glaubitz@physik.fu-berlin.de, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nico@fluxnic.net,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 May 2024 13:30:55 +0200 you wrote:
> Compiling the m68k kernel with support for the ColdFire CPU family fails
> with the following error:
> 
> In file included from drivers/net/ethernet/smsc/smc91x.c:80:
> drivers/net/ethernet/smsc/smc91x.c: In function ‘smc_reset’:
> drivers/net/ethernet/smsc/smc91x.h:160:40: error: implicit declaration of function ‘_swapw’; did you mean ‘swap’? [-Werror=implicit-function-declaration]
>   160 | #define SMC_outw(lp, v, a, r)   writew(_swapw(v), (a) + (r))
>       |                                        ^~~~~~
> drivers/net/ethernet/smsc/smc91x.h:904:25: note: in expansion of macro ‘SMC_outw’
>   904 |                         SMC_outw(lp, x, ioaddr, BANK_SELECT);           \
>       |                         ^~~~~~~~
> drivers/net/ethernet/smsc/smc91x.c:250:9: note: in expansion of macro ‘SMC_SELECT_BANK’
>   250 |         SMC_SELECT_BANK(lp, 2);
>       |         ^~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [v3] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
    https://git.kernel.org/netdev/net/c/5eefb477d21a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



