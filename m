Return-Path: <netdev+bounces-42700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 288FF7CFE22
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4D4B20D01
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1856F315A5;
	Thu, 19 Oct 2023 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohVx8xPM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EC30F82
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7682FC433C8;
	Thu, 19 Oct 2023 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697730022;
	bh=RXleMGUABnXctBgs2bSXk7hwLIx2O6aidlEwNJw1R+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ohVx8xPMSLc2bJXDB8tRTPnIZXsFXaen/7bBgD4Cb/I9idU7Whp0Tdl7dCXsuukt5
	 bPXq9P7cRyGyPP+OIp57xhvozjhA4nBv0fHTbapsx82MvEY/cQoTs/KvZYH5u/YYS5
	 pIaidIolo2KuoNgQuM8hl34nDAi3Ii11qlpm/FBbQyQZTClZCCgf1eqL4LKUCH9M5e
	 GHhT336wd9IutVscEpOe8zNMyX3GP1AkK2q+equEUw0PSZvaa8ykEPVpw4XXp4KYeZ
	 VK+MPz3TxNVVxL8kcCW7tH5sn9m2rtRn54zQfslJaNYEEIFPBD03dikMglZuOA71WI
	 eb2dqfBYiTmpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58FEFC595CE;
	Thu, 19 Oct 2023 15:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v5] iplink: bridge: Add support for bridge
 FDB learning limits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169773002236.10915.7572793107235329470.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 15:40:22 +0000
References: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
In-Reply-To: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: dsahern@gmail.com, roopa@nvidia.com, razor@blackwall.org,
 idosch@nvidia.com, petrm@nvidia.com, bridge@lists.linux-foundation.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 18 Oct 2023 09:04:43 +0200 you wrote:
> Support setting the FDB limit through ip link. The arguments is:
>  - fdb_max_learned: A 32-bit unsigned integer specifying the maximum
>                     number of learned FDB entries, with 0 disabling
>                     the limit.
> 
> Also support reading back the current number of learned FDB entries in
> the bridge by this count. The returned value's name is:
>  - fdb_n_learned: A 32-bit unsigned integer specifying the current number
>                   of learned FDB entries.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v5] iplink: bridge: Add support for bridge FDB learning limits
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=48cb4320487a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



