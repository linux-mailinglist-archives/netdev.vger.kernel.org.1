Return-Path: <netdev+bounces-95645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BBE8C2EC5
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CC9283394
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF617BAF;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5iytCr7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C9179BF;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392830; cv=none; b=H+M54fpgpFzEwdPHZ/fld0RloqQ/kOMUpEpQo+tKeGqNlfWdRrs5HSBB+1E4LId+tx+9Z1+NDsBPpAvfCR1xLjQDdSCVkHTFzurjX6MnMUFTKXafs1KOXQUP8v3PRGRAK2M+JnLXDwYx9Yg7nBZJmG66Cy2AGxAthQntEhfiynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392830; c=relaxed/simple;
	bh=Yuwm1/a8iGZhCbhXxZBFNy7CnIg7IU5RtKXHX8JlBL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jyDhouMR/V4qASSJsQv5btlj/heUztiRTNR1WfF8g0VFGiRUixtFMpANFoSOLcwaKbi4C6d7yKfQplD/wGYT4UDr1exSy1wmirA/OCfNyXEurb/KwvxX1GRxFWGuY//Z2ooc4UYZ27rI09HcUOpgS76lDikAHkZdwwkqzA2+O98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5iytCr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20675C4AF08;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715392830;
	bh=Yuwm1/a8iGZhCbhXxZBFNy7CnIg7IU5RtKXHX8JlBL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e5iytCr7OkXOzSdxy2wclp9A8wwJwVf5Mt8IxQM9NH3VSgYYSHodSaF4MznU0APbF
	 QmsJa9MC4QPGZmagFeBNGP/R73O9m8Khkb5TQLedYxeFSQWIgmjPbmzV2e2oGsNOIh
	 NvfXzva7lYqaU85fKbMcsxOrvCD0kGZvi4D1D1+TnMd4JJdQOg2pgTeWOiFzznxMdw
	 Sr1HbgXJTwvNb04jVc+c6+YGjD+HV/tLBQJ8rk+8T9UFlATorGhJIwmgNhvaUgZhVW
	 OL+6LSJyVKmDtzGhQUJOWVeEdncPGl0hdsd+sqSXJUDPC8mCtc9dtZ8/FeUbkp08ip
	 fmKlihY8R8dlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15D10C32759;
	Sat, 11 May 2024 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: ethernet: adi: adin1110: Replace
 linux/gpio.h by proper one
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539283008.14416.409480541220579877.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:00:30 +0000
References: <20240508114519.972082-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508114519.972082-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 14:45:19 +0300 you wrote:
> linux/gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/adi/adin1110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: ethernet: adi: adin1110: Replace linux/gpio.h by proper one
    https://git.kernel.org/netdev/net-next/c/84c8b7ad5e74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



