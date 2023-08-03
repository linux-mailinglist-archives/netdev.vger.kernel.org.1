Return-Path: <netdev+bounces-24192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005EC76F31E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39281C21637
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA1A2517D;
	Thu,  3 Aug 2023 19:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284892418E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86EB6C433CB;
	Thu,  3 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691089225;
	bh=8+HYmQJ9GRRXVK9utLM+h1h/UlUGv6oDrvEhBYmiyzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CrhGrf15YuZ0ZtNww9cNCRhtWWeYF9E4H4dxBRpNkfOjMiDZ+3auKlRRPg/RyGOEv
	 qZaZJ75CXkFXSWl7AmqxKGbIoc2Lcw9e+OgzViB+LfPg5iccRSVYpamTV1pCE1+zkx
	 BE3sJc9fTxf7pMtQu/SA49kPKlAQ5wi6DOKFFe03SYsldmzgEX4iIb07SxBG3rUKxl
	 K13/3Am3i2/RBG6HoB3uV3VKerr8JtjZBYZRwUVitQPHIitVOHmZBXb8xgGK4xSOlm
	 2AQ3lFwa3F0b9cYqwZOBCQq7zwR/PJH7EPN8SsWoNUi5GOdPTPSqCK5gcMqY23MCv3
	 /URKrP2ZKUIXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BC30C3274D;
	Thu,  3 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: update TUN/TAP maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169108922543.22436.3567144743259850623.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 19:00:25 +0000
References: <20230802182843.4193099-1-kuba@kernel.org>
In-Reply-To: <20230802182843.4193099-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, maxk@qti.qualcomm.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Aug 2023 11:28:43 -0700 you wrote:
> Willem and Jason have agreed to take over the maintainer
> duties for TUN/TAP, thank you!
> 
> There's an existing entry for TUN/TAP which only covers
> the user mode Linux implementation.
> Since we haven't heard from Maxim on the list for almost
> a decade, extend that entry and take it over, rather than
> adding a new one.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: update TUN/TAP maintainers
    https://git.kernel.org/netdev/net/c/0765c5f29335

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



