Return-Path: <netdev+bounces-26760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB0C778C8E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DD61C215E5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46B6FC2;
	Fri, 11 Aug 2023 11:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB853B6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4088C433CA;
	Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691751627;
	bh=UzjF6fh1YEK5/Z7ZLL0bXEOg58ckSlnmV1gS8Ge9gaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJ0ebWAdYKQrUcrnnCiX1XaqGD0fbsnaFK01wOmdknt8jSKxfT7L4CUjX+DyXZSy6
	 B6ckyazoZniMATUh7qxA4gmQ0xrscDzLdfZmpFm1fMgeidkxQ0ElSRStFNwlQaUi4B
	 ylPadHPHBxC43kVmSbyFOrs+c04JK/bfaEoeNt13AfYqRMKA1SHqlMP7cKSdEpBmQC
	 Sf4Gw7dH9kRXoodNTTNhv+aePEfMYjgfSTiVcEgZxP4YuP46S8hd8XVXjvWOuSYkTd
	 U5fOL36hDvSOBUj/OGmLLPWTtpdrQlJK8FhSjXE5J7SnwubfdAsFZ8P5tlu07tr5NW
	 EU4jzs9V6r/Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6676C395C5;
	Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next Patch] octeontx2-pf: Allow both ntuple and TC features on
 the interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169175162774.30809.2069762629972609202.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 11:00:27 +0000
References: <20230810171119.23600-1-hkelam@marvell.com>
In-Reply-To: <20230810171119.23600-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, sbhatta@marvell.com, naveenm@marvell.com,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 22:41:19 +0530 you wrote:
> The current implementation does not allow the user to enable both
> hw-tc-offload and ntuple features on the interface. These checks
> are added as TC flower offload and ntuple features internally configures
> the same hardware resource MCAM. But TC HTB offload configures the
> transmit scheduler which can be safely enabled on the interface with
> ntuple feature.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Allow both ntuple and TC features on the interface
    https://git.kernel.org/netdev/net-next/c/61f98da46984

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



