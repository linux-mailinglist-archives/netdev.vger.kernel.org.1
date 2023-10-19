Return-Path: <netdev+bounces-42474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0037CED37
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EB2B20F40
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6857F5;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEfV1j5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99460659
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54638C433C7;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697677823;
	bh=EwrWPmTIuJC9fy5vPzq6yMPr3EEKXcp8VEm7PHvNBfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bEfV1j5b6Oej8AwevMWR0aUyT8OGYupzo9lIz87hreCvQ+gDFr0h1qs4gtm6KabUs
	 6pZgEjKSPlgd9h6SrKk0rcwQ04Fe8zyWkfi2mm+NrYGaEkl/r0Ri+x3WNlhkJ3aIFS
	 YRO/+HcXOCyS6l0LSfJzgTWeu2BFG+oBvdb0uxQgwtTONP9WoJyT5yRzK+vnkozDKC
	 ah6JoESspsp0oQjeYCY+AgeLDbyyVdaq1TGIq/K7X7SR07rRteoDBwV3RilFZTfjMj
	 Kj0k28G46DMbtSn1F/L6rV1WG+x9cOTcjQ1NQjRcJukqXTQwbA8XQ+BF7jPKnyd190
	 fLFPlI0CFAnQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42860C04E24;
	Thu, 19 Oct 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] selftests: tc-testing: fixes for kselftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767782326.12246.14771729515318402025.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:10:23 +0000
References: <20231017152309.3196320-1-pctammela@mojatatu.com>
In-Reply-To: <20231017152309.3196320-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 12:23:07 -0300 you wrote:
> While playing around with TuxSuite, we noticed a couple of things were
> broken for strict CI/automated builds. We had a script that didn't make into
> the kselftest tarball and a couple of missing Kconfig knobs in our
> minimal config.
> 
> Pedro Tammela (2):
>   selftests: tc-testing: add missing Kconfig options to 'config'
>   selftests: tc-testing: move auxiliary scripts to a dedicated folder
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: tc-testing: add missing Kconfig options to 'config'
    https://git.kernel.org/netdev/net-next/c/f157b73d5114
  - [net-next,2/2] selftests: tc-testing: move auxiliary scripts to a dedicated folder
    https://git.kernel.org/netdev/net-next/c/35027c790970

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



