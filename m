Return-Path: <netdev+bounces-28627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD7780008
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C601C21526
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F417F1B7F8;
	Thu, 17 Aug 2023 21:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A86168D1
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE18DC433C9;
	Thu, 17 Aug 2023 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692308423;
	bh=g/XZGYwubki2lk0ZkRI3kmD1dVhpwM2boYavMZrOAM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GLeyMG8jKZIErUiHwJIGJC36bLfh21YE+fULCnU4xLsj+y2XM9Cc1Ug6MbHI1mJYB
	 Tvh3ZH1GceSMKpuqLBO/Hk6SiLBmQpdP1TS+Ad2ayQTPeeObna4ZhIiZ3U7wJM9FV/
	 hT4EwZawRN9CIDFBIbbkR3rfTLCqH2xEP9YllxqPxS7udCLFGRKeLAAzDBhTkGRrGO
	 lEmb2VxYXuoKx8hvh/30BxEbNyX3NGLVZ1T6KCZH5640tJBEi/jJtuNAmm8gcsAh08
	 Afx3TGd1ClbIVUf9sUpXifrUZCj2+RItPnV8yxu7ZUFHdJqqM+JJnkQXvyVpT3641y
	 cOPsCtqjfKCPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0BA4C59A4C;
	Thu, 17 Aug 2023 21:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2023-08-16 (iavf, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169230842284.3362.13997780506655266620.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 21:40:22 +0000
References: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 16 Aug 2023 12:33:06 -0700 you wrote:
> This series contains updates to iavf and i40e drivers.
> 
> Piotr adds checks for unsupported Flow Director rules on iavf.
> 
> Andrii replaces incorrect 'write' messaging on read operations for i40e.
> 
> The following are changes since commit de4c5efeeca7172306bdc2e3efc0c6c3953bb338:
>   Merge tag 'nf-23-08-16' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE
> 
> [...]

Here is the summary with links:
  - [net,1/2] iavf: fix FDIR rule fields masks validation
    https://git.kernel.org/netdev/net/c/751969e5b119
  - [net,2/2] i40e: fix misleading debug logs
    https://git.kernel.org/netdev/net/c/2f2beb8874cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



