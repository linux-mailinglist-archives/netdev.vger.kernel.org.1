Return-Path: <netdev+bounces-25085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E80772EA9
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0F91C20C51
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773BF16414;
	Mon,  7 Aug 2023 19:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41215AC3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E08A7C433C9;
	Mon,  7 Aug 2023 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691436623;
	bh=sCkiyEpUe2efr+ydTYgHTRPeS49XVKVoqVAOsVhNboY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PzpyCo/ULJgDN6KeGZxFTDlnD3JgFxXS/H04q4nt8mrYfd8euEdS9b4ApoOHvDb2Y
	 3PXVnIydiKkDjxm/wrQuo4vPRkhviBbDNrPkTTBLNXAMULERfDjGjeRY0jMMX75/vO
	 JWmP7ARtU8bOU+A+HVGfHyaXPohu4gBY4gLzYoHyE2wjvu0PDcimjIP9GrAzh4gLxX
	 hHiVdVYY5zX7qFRW2zfY1lC9ch4SquotirfJ2Vcwkj02tblmoL68h2TvPl7HEm8EWL
	 JclmGZ6mRAEwdHSfD2O2SlqoccFmaM4sSlDtPDlMoNAx0IVNu+PDrDVefpCGoONOzZ
	 0pfX74HSQCFEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA16CE505D5;
	Mon,  7 Aug 2023 19:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] wireguard fixes for 6.5-rc6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169143662375.21933.5848342512933671292.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 19:30:23 +0000
References: <20230807132146.2191597-1-Jason@zx2c4.com>
In-Reply-To: <20230807132146.2191597-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 15:21:26 +0200 you wrote:
> Hi Davkub,
> 
> Just one patch this time, somewhat late in the cycle:
> 
> 1) Fix an off-by-one calculation for the maximum node depth size in the
>    allowedips trie data structure, and also adjust the self-tests to hit
>    this case so it doesn't regress again in the future.
> 
> [...]

Here is the summary with links:
  - [net,1/1] wireguard: allowedips: expand maximum node depth
    https://git.kernel.org/netdev/net/c/46622219aae2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



