Return-Path: <netdev+bounces-23776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A476D7A4
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60435281E32
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF01078C;
	Wed,  2 Aug 2023 19:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C121078A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E6FBC433CA;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691004023;
	bh=eJBVIUPwElNet12bWRaGG3t+j3G5OPai8Gde4uhTE9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sh8yYR1DdJAHkjYXcrKVhJr3RkcmfBcfa5ezQZ31vIabaYyYGDRnxwbi1/VgPU9qh
	 6jCv5HCt3WajiwjD63zrxYmKoAILKqHe0gO9ryYKLY00JQe2eI2R4s4xxiP/XUHiUf
	 dZtVHS5FVkpCK6x7QuE8LkgQIs1Jk2OAE1EfJPlda4ex753mkY/xLnZG0u5vhpau7r
	 BRb9m11CCDXr1zU0tsMNi9jiZnuos1DkNP+US+Sx6SEMQXy7z0M3P9TohYi9g/0lhE
	 SYZDJkFKbABC8E/v+dyeYcWaINcD4/qk/LB3fWrqXltSmOJSQuJfevea73J37ZhlWS
	 NjIZlyyAwb/ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13DB6E270D7;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeontx2: Remove unnecessary ternary operators
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100402306.28133.889108276372526303.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:20:23 +0000
References: <20230801112638.317149-1-ruanjinjie@huawei.com>
In-Reply-To: <20230801112638.317149-1-ruanjinjie@huawei.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 19:26:38 +0800 you wrote:
> There are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics. So remove it
> to clean Code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2: Remove unnecessary ternary operators
    https://git.kernel.org/netdev/net-next/c/c7606d49e609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



