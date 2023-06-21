Return-Path: <netdev+bounces-12459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C37379CB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C949B2813DB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A31FAF;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816A17EF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A2C7C433C9;
	Wed, 21 Jun 2023 03:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318820;
	bh=8E/d83d2PjD2CAnsmnYln81HoleY0SjSe6Is7JmwC2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lN2vwXZpqkmXUvfOw6+NeTLZ0O5mvg+v+eICY2yQWEHQKJN2Jw1jcVN+SZUZLmc9P
	 quts0ucnL5Z57Evz5tE4rbUzfU/BuIRRzefiNUxfoxS3zuNk3qomVFHplGwM/weIU8
	 TXzZWs1Xm/f+Fn5cDv+qg3AfhpS8AHD1nIrNuXHiph8p+JMuOV0j2wsmWwxQMOAXIT
	 DZzAuBkOTXcKUcaZmRRZvO/lk/GNoXppJod+4Fp5QPhNtoadmoGHxa8E6lCkhAK4XM
	 KvguJR0Xpvqc/gqpqHPrAT85aHYXUoxiDzQ9mamittt/AGOBM7NHaaTjyszr3pgWny
	 v2D3fQZYVx4aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCF08E301FA;
	Wed, 21 Jun 2023 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: fix the wrong parameters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731881989.8371.8922786578746044579.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:19 +0000
References: <20230619094948.84452-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230619094948.84452-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 17:49:48 +0800 you wrote:
> PHY address and device address are passed in the wrong order.
> 
> Fixes: 4e4aafcddbbf ("net: mdio: Add dedicated C45 API to MDIO bus drivers")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/phy/mdio_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: mdio: fix the wrong parameters
    https://git.kernel.org/netdev/net/c/408c090002c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



