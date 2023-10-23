Return-Path: <netdev+bounces-43582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B0F7D3F15
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9162813FD
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746E2137B;
	Mon, 23 Oct 2023 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+XNa7c4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816C21379
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87960C433CB;
	Mon, 23 Oct 2023 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698085337;
	bh=gCocC57bN++I+SiJ/wsjOvqaMIL1UALdkJ9ct+aDoTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u+XNa7c4aFmAhMKuZUkhTtLo01zVF37FVZ3196QE97s6zSqA3bca/2jfpMpGylkCb
	 T1fu3D2T6XKvGXKSEGTlf4xLUwY9EnZykcNNy33ufPrnTP0My4n4ex93JRX9Cn1LBd
	 a0/d6fwMAy6IJeuz+a0fZ/FlkXV8rvdPsBfbbaU1VODzwdPin+Uv9Bf/jhU+atBhTN
	 2cfRN8wTgCPK/6AM1iDQ1MEBHfQxjXr5+GccDx6tqVNCY71IybO+42xagbgr1xiWU0
	 E7uEaVkIFaYK2A4rR3twGB4al8Vy7jTdsWOksAf5CjMpwaXcgies1dM+vW+Ajvdv3d
	 1bn7vS7e6yxxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D441E4CC13;
	Mon, 23 Oct 2023 18:22:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-10-13
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169808533744.4238.5845846756303484819.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 18:22:17 +0000
References: <20231014031336.1664558-1-luiz.dentz@gmail.com>
In-Reply-To: <20231014031336.1664558-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 20:13:36 -0700 you wrote:
> The following changes since commit a950a5921db450c74212327f69950ff03419483a:
> 
>   net/smc: Fix pos miscalculation in statistics (2023-10-11 10:36:35 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-10-13
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-10-13
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b10740ce74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



