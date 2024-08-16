Return-Path: <netdev+bounces-119277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1D955095
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961AE28789B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB71C4610;
	Fri, 16 Aug 2024 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8TCzzZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316C1C460C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831842; cv=none; b=gHDq32eT8xJnPsI2fQAODUhH4pOX1IZmHpxwz7AHl9Df5vyEgVK2MPOp1wbEenQuEfMIyqb0PviT+yWnMwAgfp+I1vnQTMRK8kNssWzW+3YEtaoJSvYf/oeIo2v0w+Gfr5eeqrylKa1cUp10rUp6kn1elFTpuP/4RItt2ELP/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831842; c=relaxed/simple;
	bh=kiePZnOrSYBCU2QUgPW4afzG5xvJHQYXJotwac7tUSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CMM7Wg64xgxgDPdMVvROc/WEgVAo9wJdviffGfnSv7oQa8aIvUw8RIQvn/Y6bEkM0n8+uCzBbifw7K3GpdAdM8wevXdgBZ936U5MeGr6GmT64bojwAjPlQ4nMIuNtOtxsTaCM/deyH+8/zaRHh8RC455wZSrrRhBVtFw5lEfqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8TCzzZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F3CC4AF0B;
	Fri, 16 Aug 2024 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723831840;
	bh=kiePZnOrSYBCU2QUgPW4afzG5xvJHQYXJotwac7tUSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S8TCzzZSsrDRG/OZIvl28WbKSEzrcW9yVm+uelPGRN63B+rEwhLAmpoRFF330ir4i
	 BCm1Wrq4tc7NTfpzbe4FX2IJYeVDCo8LAHzhfXoB4U2rRxzmribr8Ct/rrJKSGGzwZ
	 1nqgZmVgjTQVL2JuhJ8ZxQ3rgJho/JGBbTE1IX48VxO/7UVhKoaje+IB60lNrK8pSe
	 FNqo7v/NIOOLe8BfYnpxEyRiRPVBh5YC+xIWw8hlFXaCmA8b9K3kuVYLG4A4SMNI4o
	 5BAYu9VBvvUAvmzQIRGbB5bNbnQNovj+9rxvf0QHON5hafXW0McrwDL3yPiYD3StuF
	 XyS2Cur/ZqwLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F4D38232A9;
	Fri, 16 Aug 2024 18:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] selftests: fib_rule_tests: Cleanups and new
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172383183999.3593066.2595045508928136516.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 18:10:40 +0000
References: <20240814111005.955359-1-idosch@nvidia.com>
In-Reply-To: <20240814111005.955359-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, gnault@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 14:10:00 +0300 you wrote:
> This patchset performs some cleanups and adds new tests in preparation
> for upcoming FIB rule DSCP selector.
> 
> Ido Schimmel (5):
>   selftests: fib_rule_tests: Remove unused functions
>   selftests: fib_rule_tests: Clarify test results
>   selftests: fib_rule_tests: Add negative match tests
>   selftests: fib_rule_tests: Add negative connect tests
>   selftests: fib_rule_tests: Test TOS matching with input routes
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: fib_rule_tests: Remove unused functions
    https://git.kernel.org/netdev/net-next/c/30dcdd6a3a6c
  - [net-next,2/5] selftests: fib_rule_tests: Clarify test results
    https://git.kernel.org/netdev/net-next/c/b1487d6abeb5
  - [net-next,3/5] selftests: fib_rule_tests: Add negative match tests
    https://git.kernel.org/netdev/net-next/c/9b6dcef32c2d
  - [net-next,4/5] selftests: fib_rule_tests: Add negative connect tests
    https://git.kernel.org/netdev/net-next/c/53f88ed85bdd
  - [net-next,5/5] selftests: fib_rule_tests: Test TOS matching with input routes
    https://git.kernel.org/netdev/net-next/c/5f1b4f1be2d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



