Return-Path: <netdev+bounces-14066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FCD73EBF3
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843CB1C209A2
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5A912B99;
	Mon, 26 Jun 2023 20:42:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FE125DA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FA1EC433CB;
	Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687812134;
	bh=mHlcb0Ua1eTbQHqkn5Em11auw5sTp5f396Wun14CE84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oGkGKMmRtDpIPuSwwIhadEFYhaEGOxYzVGLPXWDbJwY+Wehfut4AwpcW7Myaif3L8
	 tFXuyFOwv3vWc6HYQUhoI2STTTmB3Bw/2MVHzar6SIzzVM6MH3UIA+5YO3WT2UJql2
	 sSFCTUL1+W1DaYpW1tR7/fL3Dw3L6UFkqduIdaR9u0DrIsuTbc41jpL3IsfX2Imdh5
	 xFUF5fR9mcLntpT3yx6Ym03d51hmlY/jp39CEExi/pA4k3/asYemWoTGW5DNKCCKSy
	 u44qS4C0+QEsut30ZwR23vNzH5vsscJSyoWBlybhJ/U0tw0kQLcf8QeFz7SY99yElH
	 es0pml7isvVAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B742C59A4C;
	Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-06-05
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <168781213443.29844.3540247436138409374.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jun 2023 20:42:14 +0000
References: <20230606003454.2392552-1-luiz.dentz@gmail.com>
In-Reply-To: <20230606003454.2392552-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jun 2023 17:34:54 -0700 you wrote:
> The following changes since commit fb928170e32ebf4f983db7ea64901b1ea19ceadf:
> 
>   Merge branch 'mptcp-addr-adv-fixes' (2023-06-05 15:15:57 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-06-05
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-06-05
    https://git.kernel.org/bluetooth/bluetooth-next/c/ab39b113e747

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



