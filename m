Return-Path: <netdev+bounces-29237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E3782417
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 09:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688AB1C203BF
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A90185A;
	Mon, 21 Aug 2023 07:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58608EBB
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 07:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C846DC433C7;
	Mon, 21 Aug 2023 07:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692601221;
	bh=YSJcUqDoqRIghm/a2UQaBwVpuWJ5r7NaRXvSdIYHKuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iTbT3XRSHoEPncvGIHUx6AuCgoTFOJE+IpqHl9bQC1dKwSbINMs1TOAUKx82aka3T
	 sTtKJCNjQFG+eER9/9KSEesuXbq0281maobXlsMZ4US8RtAZGnCoAJEF5cHYy7dWJ8
	 NxqJTyErrgKHqv88Hj8/EnMJc1YoRFbxypVK8MOc5OXW5GxhQgUOOUJF01OrelckOg
	 fZBEF9kriMhKUPYpqQ8M7/gHlcOAkCP+qoDe3nU6CxOunSuA1ErcIICBOfhjgHNqvm
	 O/PHnzdWtt+QhtWojdylNC/NF/0caVGXaZdUfMoPTvXhZ35HjNBWOgEmsnav1oIcF3
	 ec+anYTiwGEog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE31AE4EAF8;
	Mon, 21 Aug 2023 07:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add entry for macsec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169260122170.31725.6798623719642261134.git-patchwork-notify@kernel.org>
Date: Mon, 21 Aug 2023 07:00:21 +0000
References: <7824cdb3ca9162719d3869390de45a2fc7a3c73d.1692391971.git.sd@queasysnail.net>
In-Reply-To: <7824cdb3ca9162719d3869390de45a2fc7a3c73d.1692391971.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 22:57:49 +0200 you wrote:
> Jakub asked if I'd be willing to be the maintainer of the macsec code
> and review the driver code adding macsec offload, so let's add the
> corresponding entry.
> 
> The keyword lines are meant to catch selftests and patches adding HW
> offload support to other drivers.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add entry for macsec
    https://git.kernel.org/netdev/net/c/d1cdbf66e18c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



