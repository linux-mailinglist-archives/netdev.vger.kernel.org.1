Return-Path: <netdev+bounces-24810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15ED771BFA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B61528120B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BAC2F2;
	Mon,  7 Aug 2023 08:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA615CA70
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99A0FC433B6;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691395222;
	bh=/w6Ef22oJHP0zz2QP4zPpsWK7gAQARFp0bGa/bkMC00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gw/kL/nyN3yeuMLZKcmv7QkgO5Jfr1hGsUq1V2T2ypaiqJuue69joSo/CRy30hnYG
	 73/oYmYg9GIzeAF5FcjIAZArAXiTJooGgKqul044kqRA4UYIQoX81VN+A11I5K37zg
	 9OcG8x7rAPwjCQ+ixvXCJtLUInusFhG7hzZOMdd3WcPRVAjFBdIVyPG3KHmklqFJKX
	 WwOgQrTM4FRsV6KMo7TbQJYIZdgU5+AFz7QiT7dkT01Cw8Kbx1SlDcp2XHarczSYxW
	 5+UprDNxIg+HG4JTQ+8L2WGPz0Cq5tyALMI5N/ZWhD0KyU09IB9yky3pxgCNRYk6Hp
	 XqwMJJgfcPuHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E940E270C3;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: Remove unused function declaration
 sfp_link_configure()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169139522251.32661.7802155445996134133.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 08:00:22 +0000
References: <20230805105740.45980-1-yuehaibing@huawei.com>
In-Reply-To: <20230805105740.45980-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 18:57:40 +0800 you wrote:
> Commit ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
> declared but never implemented it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/phy/sfp.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: sfp: Remove unused function declaration sfp_link_configure()
    https://git.kernel.org/netdev/net-next/c/a6ab5c29b8d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



