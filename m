Return-Path: <netdev+bounces-40933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0347C9200
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71760282E68
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3BD10F2;
	Sat, 14 Oct 2023 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUifR6U1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7437E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5478C433C8;
	Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245826;
	bh=HNiQU2GeRkiOXncEDTVcbyNdu52RSQS6LR+wpowB0aE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZUifR6U1HSizpshrggOfskHhs2SBkIkrJ7WfkR/mmLABSM9Ft/wAsCD+fiSzCiX3V
	 cKJ75mazclMc/RKLwssq1Fpq6dl0ewtcjn0twcKPgWjc3RxJ7jNydeC+R8O+sXevHS
	 WoOrlNNLPGTbVuNf9WrkSOtTIEAsMC4it2YW4wx55M1SYdjY/AVAzX6oZ4/M6AYZZ4
	 Y3MnAxxA8ETbmWO/AJyOXB19sr1vm+kY0p/1lJb4UiV2fUfU2cIKZ3wEvAWd9Bi0vC
	 7MwHCWT8fppBt3njW0Dtmen+OKP0v/s/8OdaCr5SGTYfF5AravyYW7jO8ZSBgTA1Ly
	 /FMZzuQkt9/pA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2642C691EF;
	Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2023-10-11 (i40e, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724582666.12217.506072166071786467.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 01:10:26 +0000
References: <20231011233334.336092-1-jacob.e.keller@intel.com>
In-Reply-To: <20231011233334.336092-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 16:33:31 -0700 you wrote:
> This series contains fixes for the i40e and ice drivers.
> 
> Jesse adds handling to the ice driver which resetis the device when loading
> on a crash kernel, preventing stale transactions from causing machine check
> exceptions which could prevent capturing crash data.
> 
> Mateusz fixes a bug in the ice driver 'Safe mode' logic for handling the
> device when the DDP is missing.
> 
> [...]

Here is the summary with links:
  - [net,1/3] i40e: prevent crash on probe if hw registers have invalid values
    https://git.kernel.org/netdev/net/c/fc6f716a5069
  - [net,2/3] ice: reset first in crash dump kernels
    https://git.kernel.org/netdev/net/c/0288c3e709e5
  - [net,3/3] ice: Fix safe mode when DDP is missing
    https://git.kernel.org/netdev/net/c/42066c4d5d34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



