Return-Path: <netdev+bounces-44998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A37DA689
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE6B2138A
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27DD516;
	Sat, 28 Oct 2023 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owc/SJEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083F4422
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A954C433C9;
	Sat, 28 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698489624;
	bh=X75zLeBn8ki4HTmhl6sACJbY7nQ047upEUkUR+RIVGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=owc/SJEleDhNC/kILpjfU75++/NAx1/PhISuOw3bRMK0CYnDKwQxUteMS8zwJP4/J
	 zmeQiCDYDHw4WJ2sDKxMhuNhD74KwxG24B5fzYZqRgFLcTCT4CNwzF0IZCvO6jSIHc
	 cyK0RF6k0g7e1g0A/ljdibPNHY1HGr60FCgdZpadoqDdzd7GuojGUYxZDqKwln3Soy
	 tc0Hnj6ElyQ471hKzARHd8QBgCx2jfFT4r8GMhbUGnHjvYZqBKCiP/CFLhjWfRYBEN
	 T69bYhtPu/S11zeXV+nnX4MMptClO8djkQE+KKwR/U90WNGKnrX+5KUWtQdUZRxjZd
	 rGlFdc+6Q6dqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F8D4C4316B;
	Sat, 28 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: fill in 18 MODULE_DESCRIPTION()s
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169848962405.6989.4848757267411658289.git-patchwork-notify@kernel.org>
Date: Sat, 28 Oct 2023 10:40:24 +0000
References: <20231027211311.1821605-1-kuba@kernel.org>
In-Reply-To: <20231027211311.1821605-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 27 Oct 2023 14:13:07 -0700 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> 
> Fill in the first 18 that jumped out at me, and those missing
> in modules I maintain.
> 
> v2: s/USD/USB/ in patch 1
> v1: https://lore.kernel.org/all/20231026190101.1413939-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
    https://git.kernel.org/netdev/net-next/c/1fff1f799038
  - [net-next,v2,2/4] net: fill in MODULE_DESCRIPTION()s under net/core
    https://git.kernel.org/netdev/net-next/c/beb5eed32a73
  - [net-next,v2,3/4] net: fill in MODULE_DESCRIPTION()s under net/802*
    https://git.kernel.org/netdev/net-next/c/ce1afe280419
  - [net-next,v2,4/4] net: fill in MODULE_DESCRIPTION()s under drivers/net/
    https://git.kernel.org/netdev/net-next/c/55c900477f5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



