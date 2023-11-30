Return-Path: <netdev+bounces-52320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A657FE492
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0835AB20FFD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C30385;
	Thu, 30 Nov 2023 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JInX25ci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC49369
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8090C433C9;
	Thu, 30 Nov 2023 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701303026;
	bh=wkTad22Gy9j+phPlLWNB06HVQjcKkKcp52tB/CPdvSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JInX25cidzucRzuNGnN+uwaaEDIz+ym4ccaCIIa+lv4BxV45NPi5yifBxW4hanUG4
	 U+/cnm6mjMJbf0+OzetRm5+6+c8/aiK1J8c1Y3DvjuEn807c9bvxl0TtjVVZ2j1+i1
	 QB1z4QTGwFbfcdYQUZgz4Nct2RLEQpCPR1YEmlGE3UR3GrSYALTQO15jMPfq4PD1Z2
	 dbrUDUS6n9V0OSdFFfgHJsfU1JL0jPiIGsnf2MjyIiUu2X8HSrlhFfPBNpx74zHvVX
	 b2D2ks3oQ1EHmEz6Zf48HgKAPmHZM86f3oo0W/027NL3JxXzsMpEHwmEqq4hl3W+Ch
	 55cIoTKlgggPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90B0BDFAA84;
	Thu, 30 Nov 2023 00:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] tools: ynl: fixes for the page-pool sample and
 the generation process
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170130302658.22113.4324422152795472587.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 00:10:26 +0000
References: <20231129193622.2912353-1-kuba@kernel.org>
In-Reply-To: <20231129193622.2912353-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 11:36:18 -0800 you wrote:
> Minor fixes to the new sample and the Makefiles.
> 
> Jakub Kicinski (4):
>   tools: ynl: fix build of the page-pool sample
>   tools: ynl: make sure we use local headers for page-pool
>   tools: ynl: order building samples after generated code
>   tools: ynl: don't skip regeneration from make targets
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] tools: ynl: fix build of the page-pool sample
    https://git.kernel.org/netdev/net-next/c/ee1eb9de81db
  - [net-next,2/4] tools: ynl: make sure we use local headers for page-pool
    https://git.kernel.org/netdev/net-next/c/929003723f6d
  - [net-next,3/4] tools: ynl: order building samples after generated code
    https://git.kernel.org/netdev/net-next/c/9cf9b5708241
  - [net-next,4/4] tools: ynl: don't skip regeneration from make targets
    https://git.kernel.org/netdev/net-next/c/a115b9279f48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



