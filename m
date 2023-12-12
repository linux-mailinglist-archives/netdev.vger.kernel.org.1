Return-Path: <netdev+bounces-56433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46B80ED94
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9367D1F211D1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D061FA7;
	Tue, 12 Dec 2023 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4Z8BveF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB361699
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 13:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ECD4C433CA;
	Tue, 12 Dec 2023 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702387826;
	bh=o2ZngpIt315TyOOz+uMaM8A711SA4BcZl1S9PdBQLcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k4Z8BveFej3OzArqXJ1msE/6qsiPfH8yfLE0FB2IqhOXr8Q6QzmIaIWl4NDIa41Bh
	 XPjipt5mDL8chPoXHpc0Qw0XH/p6gL2lZDr0IanVtnxAQjcZoTp1WGtO7Iq5aM4/aJ
	 NEVK4Wd7H5DO5JKLJUrhdcInaYWSqF+8aEYZJKDnWznsqXntNC5g4O4a10CXJ8ssme
	 ewAEbrSGxU7K1Yep3WnthQ9bxZ8qxkPlm59pcvi/j8WShnixklRO6KtKN77In5M2qs
	 UQ3XPeTDsLQa0OjnlE+x2YuQ9fu2GgrD+y7/AyeqPeMMDfouxER0EBeGS5zTCYubX1
	 ahy2bQt7zViuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA4FDDFC907;
	Tue, 12 Dec 2023 13:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: dsa: realtek: Two RTL8366RB fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170238782595.14412.3820310748559815932.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 13:30:25 +0000
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 09 Dec 2023 23:37:33 +0100 you wrote:
> These minor fixes were found while digging into other
> issues: a weirdly named variable and bogus MTU handling.
> Fix it up.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (2):
>       net: dsa: realtek: Rename bogus RTL8368S variable
>       net: dsa: realtek: Rewrite RTL8366RB MTU handling
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: realtek: Rename bogus RTL8368S variable
    https://git.kernel.org/netdev/net-next/c/389119c84218
  - [net-next,2/2] net: dsa: realtek: Rewrite RTL8366RB MTU handling
    https://git.kernel.org/netdev/net-next/c/d577ca429af3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



