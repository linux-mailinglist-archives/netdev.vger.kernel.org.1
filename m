Return-Path: <netdev+bounces-38701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2B7BC2B8
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EA028249F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3745F6B;
	Fri,  6 Oct 2023 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjcbllhp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3445F63
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1FB6C433CD;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696633225;
	bh=LfQooawKEYZwQA00sS7p2QtSAGgFWZXkm9YUOOhwqfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vjcbllhpiv6s+mK8HJDnSj2c9bsS8IZSy3RkRVqx8K0iky4mR+Yh9NsgAkLqtfEQH
	 xth6Vri7SKUh7KZNkHv0HjzAIw613iribuO7rkyW9Z0nRsf5x2pVh40wj/Ml/BmG6z
	 6uWLkoGIJy2nPgqadcqUy/yYmqxKy6abUg3FLzrG214CJ/xohDy8C5WyDKLPoX86m6
	 X6bdu1UEXyFP83TKFgfIGO10T8DwN7QUunBgwaUsUFXkkRG7ipaJbdm192k0zEICR0
	 tcnzDQyxoLiCzvvZ/yUIrWXUlj8XjHdNNu9P8a/8uiU7Q8G7vb2uH7WgZYsLvHu0En
	 A42NMwIHy10KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90C77C595CB;
	Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: ixp4xx_eth: Support changing the MTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169663322558.31337.17347302646463011874.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 23:00:25 +0000
References: <20231005-ixp4xx-eth-mtu-v4-1-08c66ed0bc69@linaro.org>
In-Reply-To: <20231005-ixp4xx-eth-mtu-v4-1-08c66ed0bc69@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 00:43:53 +0200 you wrote:
> As we don't specify the MTU in the driver, the framework
> will fall back to 1500 bytes and this doesn't work very
> well when we try to attach a DSA switch:
> 
>   eth1: mtu greater than device maximum
>   ixp4xx_eth c800a000.ethernet eth1: error -22 setting
>   MTU to 1504 to include DSA overhead
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: ixp4xx_eth: Support changing the MTU
    https://git.kernel.org/netdev/net-next/c/4f08c2570239

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



