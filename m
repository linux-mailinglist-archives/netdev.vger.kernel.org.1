Return-Path: <netdev+bounces-43370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8166C7D2BE1
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C545281547
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF5107BC;
	Mon, 23 Oct 2023 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH3QDLOK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7739107B3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5095EC433CA;
	Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698047424;
	bh=+U7j2qtatUoFBI4oFqBF6orCmx8kUC87RsgM91a7bUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bH3QDLOKGQvA/biusFOqlHRoUUS91fb7+7q/WrBL9iIhY8tZHG1aocjElZWFP8+uu
	 kqADhWOjl1uJC73dbc95eD0cjCgJuA4LS8rulNs7Q9CWynHYgMcm4AJ4dh6ANqEDE8
	 +H3MLXNLl7IJ7MzdiVFTuFn52Be8ON3QyrY7ugdP23MdAfryaTgapmOj3pXOhz02Xp
	 GFE7+KEIhKMPP2EFdNs8NKR95A5I8yPUgBgmy75OVkgUjBeARx/aBJHN/fJyVPanPD
	 sAHnBISE+9YUZ11BS0Tb5eu7vOoG4MYnnIWCH/3u617bRQVZniXEEHW8l2ynncwdmT
	 Edt3UmNZ/SwlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3298FE4CC1D;
	Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atm: Remove redundant check.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169804742420.31388.11517029296336664393.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 07:50:24 +0000
References: <20231020121853.3454896-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231020121853.3454896-1-Ilia.Gavrilov@infotecs.ru>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, gregkh@linuxfoundation.org, sre@kernel.org,
 rafael@kernel.org, chas@cmf.nrl.navy.mil, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 12:21:16 +0000 you wrote:
> Checking the 'adev' variable is unnecessary,
> because 'cdev' has already been checked earlier.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 656d98b09d57 ("[ATM]: basic sysfs support for ATM devices")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> 
> [...]

Here is the summary with links:
  - [net-next] net: atm: Remove redundant check.
    https://git.kernel.org/netdev/net-next/c/92fc97ae9cfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



