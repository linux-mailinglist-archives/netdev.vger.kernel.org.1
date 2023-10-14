Return-Path: <netdev+bounces-40923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB15E7C91D8
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E77B20AE1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0CE373;
	Sat, 14 Oct 2023 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/qeDObA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F567E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F04C433C8;
	Sat, 14 Oct 2023 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697244024;
	bh=RI9r3AFTc3/u91fC8mt61TRwJmZZo5GaDbRZ5WQFe6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g/qeDObA4SkQ84Rhi4SqE5DFWGbEvoUurqqQiD9tEBed1Ks4GS4+3RkRP60WjCeN5
	 sZDkiQCVd4qHrFcjPd8pdUOV8cn0O3ostQlR2bVUma44PZpLIAGJWUX4nXuKxpmO80
	 RWIq4o9BYBKOdHqvGlgKMqInkpja0La36n1EPnJq/awC0nuN60jtzVarEwpdlgZHqF
	 hV7h2dmNSHlHQ9fTqeGIsQ0HDqJjljWck8o8Zzl2PVtG0vXz3Dmpnl0tYe8pBLkMAz
	 AsVI9GlIMZ626W+Vex7lYtW464NKxUuPwDZ8CnQ1ZaSYlj8tfHt1L9VIb12TOpbAEs
	 2ILo/2obz+wHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD40BE1F666;
	Sat, 14 Oct 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] docs: fix info about representor identification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724402470.30425.1497986707572942758.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:40:24 +0000
References: <20231012123144.15768-1-mateusz.polchlopek@intel.com>
In-Reply-To: <20231012123144.15768-1-mateusz.polchlopek@intel.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 ecree.xilinx@gmail.com, wojciech.drewek@intel.com,
 przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 08:31:44 -0400 you wrote:
> Update the "How are representors identified?" documentation
> subchapter. For newer kernels driver should use
> SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
> callback.
> 
> ---
> v4:
> - changed the docs description
> 
> [...]

Here is the summary with links:
  - [net,v4] docs: fix info about representor identification
    https://git.kernel.org/netdev/net/c/a258c804aa87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



