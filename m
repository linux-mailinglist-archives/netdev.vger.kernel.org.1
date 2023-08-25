Return-Path: <netdev+bounces-30545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5038A787D8F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C191C20F35
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F236649;
	Fri, 25 Aug 2023 02:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AC7F0
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 685B9C433CA;
	Fri, 25 Aug 2023 02:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692929423;
	bh=RG43pbnA0RIHO8HtvAbKo+KCmiTaxYplr/9Ki3LTzbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tWsU71rnfd8UcFrX3Fltifbzi/blfIwVUZOmhL9ht0rWYIWaqrExRrokTPpV0uONe
	 RaH9NKb3h3CohXiQYKqZf/hEak4zCeOXo21LUkxXo+rgMdYd5ZLGxn91gFh3IKS3PN
	 ZDnqVSW9bVur5yekQF8rrXpBreG4qVZN2H+WBRRX3SrbTiIEIJ4DOVWRwyCHhD853b
	 ziLE1YGDDcEixl9nmL+k/fYFBHONeEyCBIPTvXm3595KOoM0m+DEoQj2LaJzNxKmDs
	 27UBWPuJJiZ088COXVm/bYit205ZoIouqtqUJ9cuebSU1PR1/Lcfb8iGdBDjMe8QkB
	 Fah+JuUU5eJRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E521C395C5;
	Fri, 25 Aug 2023 02:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] tools: ynl: handful of forward looking updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169292942331.9464.9535663039531462509.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 02:10:23 +0000
References: <20230824003056.1436637-1-kuba@kernel.org>
In-Reply-To: <20230824003056.1436637-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Aug 2023 17:30:51 -0700 you wrote:
> Small YNL improvements, mostly for work-in-progress families.
> 
> Jakub Kicinski (5):
>   tools: ynl: allow passing binary data
>   tools: ynl-gen: set length of binary fields
>   tools: ynl-gen: fix collecting global policy attrs
>   tools: ynl-gen: support empty attribute lists
>   netlink: specs: fix indent in fou
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] tools: ynl: allow passing binary data
    https://git.kernel.org/netdev/net-next/c/649bde9004ac
  - [net-next,2/5] tools: ynl-gen: set length of binary fields
    https://git.kernel.org/netdev/net-next/c/a149a3a13bbc
  - [net-next,3/5] tools: ynl-gen: fix collecting global policy attrs
    https://git.kernel.org/netdev/net-next/c/dc2ef94d8926
  - [net-next,4/5] tools: ynl-gen: support empty attribute lists
    https://git.kernel.org/netdev/net-next/c/4c8c24e801e6
  - [net-next,5/5] netlink: specs: fix indent in fou
    https://git.kernel.org/netdev/net-next/c/e83d4e9b2d0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



