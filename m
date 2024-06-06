Return-Path: <netdev+bounces-101387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A38FE559
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC31B231F6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF313D2A2;
	Thu,  6 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzHcSKPJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE5745E1
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673430; cv=none; b=nyfBdcK2pxEXbWIrgBYrexs3nIQWoNIFIrOf5jEP8wCIzM/b2Ff55++tVOvnwlXuJuoIh8bWHoaAHM31HD6+Q5dvlDi4tffzZAccB1jyemBzzcBj1xGJnnvMjKL+wVt8gGox2NQl5cTaAtJutZwIcZ22Bk71vTei3G1cQJvaSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673430; c=relaxed/simple;
	bh=HO6HZwEWY81STQd/+84K4zMIa/6QrjAijWV1QfSyPs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T04zxqDvXAkWE694ip6APg99hRtwCJpvrHuPNfAYrEluZwZAj0OUDVCUGjz6ej7oEdQMXV0YHpV16uJgqOd2KNusoKeeaq2xAaVuaQLKNYijsFmFLNg0E8SCEdrUpeuoI3c5PUo6untxIj6I8JAyRRdTk5+9UZbLHUWc49badrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzHcSKPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED142C32786;
	Thu,  6 Jun 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717673430;
	bh=HO6HZwEWY81STQd/+84K4zMIa/6QrjAijWV1QfSyPs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JzHcSKPJPezHoUlP7Nr9xbr90QmbQvx9W2VJ7TWttW3ZJrqwJYXOBtHCrXdbjvDUe
	 +jI6TN6+GzXk0VUcCzubBiRw8KXICoEFtgEXuun024Pgmqp7LA8UbdCErzLvs2oDnq
	 aBRtyBSkAhedxWOX/YtQYC0e97nv+vnJJChhHysJ6Gl39vX36F1NEtPfo+Fwoi5kGo
	 lAZS93UVrGAG4yOe27QUJXAtLA6ly5UfKDnAbUcXJ8BAwYvUBepbhMJb22AhOraNyt
	 aFQxH0VxsQgNG7WNBgjEEXzP74dR43AXU/EXO6/nIPdU0kVHrILpa72Flb4q14tsPJ
	 e4k7KB28WnXmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB5BCD2039E;
	Thu,  6 Jun 2024 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: allow rps/rfs related configs to be switched
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171767342989.6972.8362768417389427107.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 11:30:29 +0000
References: <20240605022932.33703-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240605022932.33703-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  5 Jun 2024 10:29:32 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> After John Sperbeck reported a compile error if the CONFIG_RFS_ACCEL
> is off, I found that I cannot easily enable/disable the config
> because of lack of the prompt when using 'make menuconfig'. Therefore,
> I decided to change rps/rfc related configs altogether.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: allow rps/rfs related configs to be switched
    https://git.kernel.org/netdev/net-next/c/9b6a30febddf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



