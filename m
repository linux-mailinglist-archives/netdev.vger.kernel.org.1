Return-Path: <netdev+bounces-54275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AB3806669
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1981C210BF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E814D523;
	Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsZGf+2t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78763B8
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B809BC433C9;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701838828;
	bh=zcDRQmSycTcrwMXlNRfpFfg66gWCywN9nB6ketOM6p8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RsZGf+2tOQ+jcEk8I4Sm8sNGr5iVfolagXNADQVfyINElnRDMmf2lGxwkC/kAHlB3
	 eVp9qpbK0QUaCFpUbZce6LM83CC7jrBPanbrxIHN18VrO4MBvSPyzsid0eVApT/Rh+
	 G+2eSHKXwFnhEpt6jAAaIJnlLAepwDDygiJEeBef8zy9DvHSatCLSQ1yDhMgOEzBqE
	 wHw1/g33ec/vaCqHAR++8w79S1DQO1HYX7QsFSKug/lmGiHs6U+x9wEFZPEuG870RQ
	 w83wPs0C0Suqrlbt+N8zxaE716/Jq1tPHttn3iYL5YvgGYce6y8DdoOTGwl5pCdCYt
	 2UrmkGP8PIklA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D64BC395DC;
	Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeon_ep: control net API framework to support
 offloads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183882864.31476.7857996414730874839.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 05:00:28 +0000
References: <20231204154940.2583140-1-srasheed@marvell.com>
In-Reply-To: <20231204154940.2583140-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, konguyen@redhat.com, vburru@marvell.com,
 sedara@marvell.com, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Dec 2023 07:49:39 -0800 you wrote:
> Inquire firmware on supported offloads, as well as convey offloads
> enabled dynamically to firmware. New control net API functionality is
> required for the above. Implement control net API framework for
> offloads.
> 
> Additionally, fetch/insert offload metadata from hardware RX/TX
> buffer respectively during receive/transmit.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeon_ep: control net API framework to support offloads
    https://git.kernel.org/netdev/net-next/c/5aa00e9e41f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



