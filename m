Return-Path: <netdev+bounces-54261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FBE8065FA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219212822A6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E9DF78;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRwRF6gt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2846DF52
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40878C433CA;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701835824;
	bh=xdf1bzlblVQLnU4KL2E57Ep3XZ6MK+ZBFiyl4fAGBWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aRwRF6gtTWJsyW6A6MwLMiGFdn7W0feRW/N85AKa+4KArwByGOtjfgKoBLxL5jJMh
	 Y/+coCgSuI8BMgTqtdR0FhT66NqAHIgSQ4PNEW4rRfVD9E5ucJ4KTx1R8vUsm2etxQ
	 RCoATewEHBCUb0GV5UvvU9nTwPbJbDWlRtR6YoYXZUaS+LGuURrA8aSRFy+LCltxAe
	 L1YjxIhJjuGXrrYNDjCW0ITKPSwU7UMuX5TnYat+dVT51+H0cMgOb3rAHzVqTXlyvP
	 T+56kxdAl/6BwVK1W90WjINx/YG0mX1I1QIG8Qevedc49lcB0wPZ49NBojpqKBKz+S
	 bT30lZF3qyS6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FE57C395F1;
	Wed,  6 Dec 2023 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: use strerror() if no extack of note
 provided
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183582412.5454.9963314211038672900.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 04:10:24 +0000
References: <20231202211310.342716-1-kuba@kernel.org>
In-Reply-To: <20231202211310.342716-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jacob.e.keller@intel.com, nicolas.dichtel@6wind.com,
 jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Dec 2023 13:13:10 -0800 you wrote:
> If kernel didn't give use any meaningful error - print
> a strerror() to the ynl error message.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jacob.e.keller@intel.com
> CC: nicolas.dichtel@6wind.com
> CC: jiri@resnulli.us
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: use strerror() if no extack of note provided
    https://git.kernel.org/netdev/net-next/c/f2d4d9ad809a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



