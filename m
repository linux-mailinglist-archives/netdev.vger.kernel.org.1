Return-Path: <netdev+bounces-38156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E437B9942
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id DF9D6B2097D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C42182;
	Thu,  5 Oct 2023 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGb+h+jX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53381390
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C1FAC433CB;
	Thu,  5 Oct 2023 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696465828;
	bh=C71E9jV0/5P9BFfjMb53X2iDS2X84LVKvmaUWSJvAZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGb+h+jX8rVGYy96addL7tr1tMGhtpAe25WIuQxWuSLzOoLnciO/pA4gAXkoz1roW
	 FdbRrRDuA1QsL2Nbxg6XbrFQpunmYlu802+0ChZwqdlod5V2emGUUc17LbntSH3yhm
	 G82obiDoKqK1Ng3RxHS5KJ4VTzU0xNtRHGw2oCUcKMiPmphcB2tfmMOqMm9SUswntf
	 wGec2re+2yH4gqWHPivS4j0HqOqFbUvrE969mblclcPGkerGSNXwAjXiyjhBf70h9q
	 nKtYyAtNagRTyxfJj9YmXBuJXb6hUAvb8fkYNQkA7KbvQEebttqMT0FObwSILeXMTy
	 YLZcLF1TyGlTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E907C595D2;
	Thu,  5 Oct 2023 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver Updates
 2023-10-03 (i40e, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169646582831.1612.15989179714660721631.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 00:30:28 +0000
References: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  3 Oct 2023 15:36:08 -0700 you wrote:
> This series contains updates to i40e and iavf drivers.
> 
> Yajun Deng aligns reporting of buffer exhaustion statistics to follow
> documentation for i40e.
> 
> Jake removes undesired 'inline' from functions in iavf.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] i40e: Add rx_missed_errors for buffer exhaustion
    https://git.kernel.org/netdev/net-next/c/5337d2949733
  - [net-next,v2,2/2] iavf: remove "inline" functions from iavf_txrx.c
    https://git.kernel.org/netdev/net-next/c/70dc7ab7645a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



