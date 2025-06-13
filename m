Return-Path: <netdev+bounces-197392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03AAD881D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A91C3B9865
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D329B77B;
	Fri, 13 Jun 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KADZTM+/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BE291C3F;
	Fri, 13 Jun 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807603; cv=none; b=Kr3w076cIeBQHbB9t7q/L2D87yxHT4SVqErnzBywQqQTA343rLxMULYf9Ig6T0oWM1eRgjYC4fxM63nMlks1rJ8krKXb9sdMh9gSjInFDz2tVq1dSNei9MG//nZTePpQZ/5WX2XpRNdXSSNh241qWnPYvqsDMoIPKj2H/VKKmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807603; c=relaxed/simple;
	bh=za8/vpwkReY5XqUs1welIaOGqWewUieTwjva2NznrQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zn7usJTPV7SmxJ0C8cfyDqLWBKphCuHUGz73CWj4OoSIm+KSsIwvVm93/fhAn0jKwUw/DHhuQpPUysB14KhjNDO3nXx7o2/AOWggd0mmoUemMySoxrQdkgShyAOi83QO9+Z3fjFShLBjaMdI8rBM0WEGsMcgfqL5PEwW88T7sEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KADZTM+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE67C4CEEB;
	Fri, 13 Jun 2025 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749807603;
	bh=za8/vpwkReY5XqUs1welIaOGqWewUieTwjva2NznrQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KADZTM+/gfCOnhk0JqBuzr6sMlXwXX9kxWx/dwf++iUX1ioznGGUxmrjjL9j55KBm
	 jC4axalDiomZwO1tJa4TOtTXnaOYOxpN/Uagx24voUw+J0A81cqp8mImkfO6X9cm2q
	 F59skeKEZQHi3rPQIG9coGShvTleb95OtacwPGuu7AC2EsUULYKf/0Fw+Dm+cxRDd6
	 KubDwm61mneOlMtdRsGGJB9E8xDu+RddupMvBElStFlMQhtLFaeMTFexXMH9ZEcBaA
	 OmQhERXuzD1NcXpHE56TEPVX+3Yb6SMJ2LeHSPlHeXs7diU0CgGaEuSpIBXu+4mvj3
	 EvIcN04lnWlOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0139EFFD0;
	Fri, 13 Jun 2025 09:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] ionic: three little changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174980763275.655581.9383760132126182573.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 09:40:32 +0000
References: <20250609214644.64851-1-shannon.nelson@amd.com>
In-Reply-To: <20250609214644.64851-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, brett.creeley@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 9 Jun 2025 14:46:41 -0700 you wrote:
> These are three little changes for the code from inspection
> and testing.
> 
> Shannon Nelson (3):
>   ionic: print firmware heartbeat as unsigned
>   ionic: clean dbpage in de-init
>   ionic: cancel delayed work earlier in remove
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] ionic: print firmware heartbeat as unsigned
    https://git.kernel.org/netdev/net-next/c/696158ff4dcd
  - [net-next,2/3] ionic: clean dbpage in de-init
    https://git.kernel.org/netdev/net-next/c/c9080abea1e6
  - [net-next,3/3] ionic: cancel delayed work earlier in remove
    https://git.kernel.org/netdev/net-next/c/52fdba899e6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



