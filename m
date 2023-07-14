Return-Path: <netdev+bounces-17868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29237534F3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90A11C215CE
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6AD313;
	Fri, 14 Jul 2023 08:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E74D2E8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD753C433CD;
	Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689322820;
	bh=H9U0qqTJn3MA7ez4KLxI1hnCbYJTzbxfSNFtUYz2bQA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eXsySg3bh+pEtmDg/kffaWOVJMavb0GIx+XtnBjEdtgBZVMKPNnMjZxLw+debCFFu
	 tetpQ6GSbhf1N7zM45/9YL6fqgtW5xWZC0B19/yEbM4lHNPQd8uy35G6pY8wzHsnDO
	 FaQwqDhLF+2A53hExfjIuPPW1rTUBaTeP0Fu3DVO7wIlEuc0IN2b/g0AbLhxlHwiIJ
	 NT+Mx166u5mGIu7CknVI40k7pjPu0aKX6ub8D401AeymWInR6JYwwiYicc5JQzcwrS
	 MfBfcfkie6PT2WFkCckhcr+tpDX+Ghr5i8Qw6+NkS2/nq+CNVIrZH4FYgeM3HqkxxX
	 SPOtVAlgnzQww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAF9BE49BBF;
	Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] add MACsec offload selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932282082.1632.13701675853325201374.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 08:20:20 +0000
References: <cover.1689173906.git.sd@queasysnail.net>
In-Reply-To: <cover.1689173906.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, simon.horman@corigine.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 15:20:22 +0200 you wrote:
> Patch 1 adds MACsec offload to netdevsim (unchanged from v2).
> 
> Patch 2 adds a corresponding selftest to the rtnetlink testsuite.
> 
> Sabrina Dubroca (2):
>   netdevsim: add dummy macsec offload
>   selftests: rtnetlink: add MACsec offload tests
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] netdevsim: add dummy macsec offload
    https://git.kernel.org/netdev/net-next/c/02b34d03a24b
  - [net-next,v3,2/2] selftests: rtnetlink: add MACsec offload tests
    https://git.kernel.org/netdev/net-next/c/3b5222e2ac57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



