Return-Path: <netdev+bounces-37193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B07B42DC
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 20:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 94323282F33
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FCC182DE;
	Sat, 30 Sep 2023 18:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C0B678
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 18:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB8BC433C9;
	Sat, 30 Sep 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696096825;
	bh=A5g2oArzuoNuvkRjvZ7vBIfY/eWRRQ+8KeiPaGNPJoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AIlr9dIhnGx16YBUYxI23rwSlTJ/dwGe5Lj/Q7z0rFa+xMzhT34LYPXBYh/SSdDmm
	 OnCiTSBW9ZDL0b3O4Y1Xg2V0zu3zL4/gjy+GbZmbMYp9H87b5WAnMeBaMPl8OjfxQ2
	 I5VMh7oOvtPy2sIwsGmnyteWzBAKXG/u+o7h9iJE59d0CrbmY6co7KdW7vEPUmWYev
	 0zo/F9g9FTj/E1WXoYwNfQbL8irllQ7Et5BGxSQ17bXRmgLvjC1/XQdlAacXbZCRGt
	 yglbwJ7wy8tZR6WYsrfBtRFFY9CRactfzFpb+ndQjpX0MNoWHsJ5KHKXDPrksOdfB6
	 0AWQZec7zBG9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FA16C395E0;
	Sat, 30 Sep 2023 18:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4][pull request] ice: add PTP auxiliary bus support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169609682565.13826.5979393394764413441.git-patchwork-notify@kernel.org>
Date: Sat, 30 Sep 2023 18:00:25 +0000
References: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, michal.michalik@intel.com,
 jacob.e.keller@intel.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 20 Sep 2023 10:19:25 -0700 you wrote:
> Michal Michalik says:
> 
> Auxiliary bus allows exchanging information between PFs, which allows
> both fixing problems and simplifying new features implementation.
> The auxiliary bus is enabled for all devices supported by ice driver.
> 
> The following are changes since commit b3af9c0e89ca721dfed95401c88c8c6e8067b558:
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ice: Auxbus devices & driver for E822 TS
    https://git.kernel.org/netdev/net-next/c/d938a8cca88a
  - [net-next,2/4] ice: Use PTP auxbus for all PHYs restart in E822
    https://git.kernel.org/netdev/net-next/c/af3c5c8748e6
  - [net-next,3/4] ice: PTP: add clock domain number to auxiliary interface
    https://git.kernel.org/netdev/net-next/c/fcd2c1e3139a
  - [net-next,4/4] ice: Remove the FW shared parameters
    https://git.kernel.org/netdev/net-next/c/170911bb1b04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



