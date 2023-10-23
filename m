Return-Path: <netdev+bounces-43382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B47D2CF2
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90C8281471
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A867472;
	Mon, 23 Oct 2023 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp51Iw/y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACF4C9E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD0F6C433C9;
	Mon, 23 Oct 2023 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698050422;
	bh=7K+dMddgIAudi/Xn6O8edWOR81jrB9lTM0jGIiW7u78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gp51Iw/y3sQHBiz2dRQIZSjCG936URQ1Gc43AePYf/KN7KcCVSNmf0c2iEYwgjGYZ
	 lFogx1bWTftSGDw0B+NmTzzHUTxP7MUerhITAT6Y3xmoMEUS2/u7HNmakmnqJhUo78
	 BJLowdXaeQPSjv9ClHM6M9IOM3pbbHD0YVAJ09/hzj4aWqnWQ/HcFbftXSW1UYrwG4
	 E6qFQWbFzFEVJqG2wZdX9UNjt41MQKnY1EkjiaTvtOdL2a7r1SoIuFJsjZDzgOKz3I
	 RFCnDKHQdcX6fDzjZWSBgwNxWoUnzplFM1+POAkizDE/vYu3DIlxfCZIXOzwaK6KeA
	 n35WtX4nk0vbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90870E4CC11;
	Mon, 23 Oct 2023 08:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] isdn: mISDN: hfcsusb: Spelling fix in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169805042258.28420.13891530581677919696.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 08:40:22 +0000
References: <20231023063758.719718-1-chentao@kylinos.cn>
In-Reply-To: <20231023063758.719718-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: isdn@linux-pingi.de, kuba@kernel.org, yangyingliang@huawei.com,
 alexanderduyck@fb.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kunwu.chan@hotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 23 Oct 2023 14:37:58 +0800 you wrote:
> protocoll -> protocol
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/isdn/hardware/mISDN/hfcsusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - isdn: mISDN: hfcsusb: Spelling fix in comment
    https://git.kernel.org/netdev/net/c/13454e6e0df2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



