Return-Path: <netdev+bounces-42187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85B7CD8E5
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B44CB20F6F
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1B18AE5;
	Wed, 18 Oct 2023 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oszNCLfk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B129C15AFE;
	Wed, 18 Oct 2023 10:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16995C433C9;
	Wed, 18 Oct 2023 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697623822;
	bh=W/5u6OVDfqhE3ZX1uUx7ETUjO9nJMhtB+mgRgMbWv6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oszNCLfkzVCHLT6ShibsHQOhLOOxQupDqP7/3WQCj+wIJjFm1f/BCZa6CTzEkwn0m
	 7cAhnjVKLT3h2x2t+xTDnqYZOLph49oy663J6JJTfOlo+jC2ZMokLqM8j3UkisCxAK
	 oPnQIGQFVvvH8gtZDDH4RUzq5LTnqkDvNNjwzjwMOmlvha5Pmp1MVLWyzJV7ZjZNXe
	 ot3ynVcdkXX5GxJq72hZMDpNn4uwTJAPuk/26l4q+QPbl2ruAjcDkBYm1uwjBrhvnK
	 cuK9+53H0aUDN7XRz19O9GeMrmqAmuIknTvhIwA1MjVnJwvTk143M5THSB6tLHg7aI
	 T77mjDKQhq/yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F26A3C04E27;
	Wed, 18 Oct 2023 10:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: wwan: iosm: enable runtime pm support for
 7560"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169762382198.3133.9349110613879495903.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 10:10:21 +0000
References: <20231017080812.117892-1-bagasdotme@gmail.com>
In-Reply-To: <20231017080812.117892-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mwolf@adiumentum.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 17 Oct 2023 15:08:12 +0700 you wrote:
> Runtime power management support breaks Intel LTE modem where dmesg dump
> showes timeout errors:
> 
> ```
> [   72.027442] iosm 0000:01:00.0: msg timeout
> [   72.531638] iosm 0000:01:00.0: msg timeout
> [   73.035414] iosm 0000:01:00.0: msg timeout
> [   73.540359] iosm 0000:01:00.0: msg timeout
> ```
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: wwan: iosm: enable runtime pm support for 7560"
    https://git.kernel.org/netdev/net/c/1db34aa58d80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



