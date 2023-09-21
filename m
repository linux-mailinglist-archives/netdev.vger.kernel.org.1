Return-Path: <netdev+bounces-35404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A47A9527
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C31BB20A02
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681CBB67A;
	Thu, 21 Sep 2023 14:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D0B676
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 14:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D48E3C4E755;
	Thu, 21 Sep 2023 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695306022;
	bh=WBpt0UJgzXAKDLTjwPscCIHs+G2g2Gy4mXrkc6WDOS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lHqMUpxmk5mzil1T6dqxSSOJlWKcVRpUK8QUxua1r0kiQ+SZc1wl4wKlv4nKHq0ck
	 c+6j+wOlgtH5dD9c/nseoxc8LU3h/yDzzHyG8TmLYpRXe5MxrtODaM0/0aBMjNHgpY
	 lBo3J3B/3sOr6x74f/G3NWvaeycU2wBMt6JKqe7m3vPSxKaqCJrezzQETdGAmNNAb8
	 J0eH5q3okKfdo1vzxaDBmS86uJIExByXI/0/uW9V3qB+YXARn4Sj8e+m8+iFTS+Atd
	 ZOLUheqv97C7IAytIG+GQeyWh2beqrNv+YOfAV0sozERVbsQvPhyANp6/3LFcB5hnj
	 tcBqePEeoLO6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA84DC04DD9;
	Thu, 21 Sep 2023 14:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: sja1105: make read-only const arrays static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169530602276.5007.573256202106314126.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 14:20:22 +0000
References: <20230919093606.24446-1-colin.i.king@gmail.com>
In-Reply-To: <20230919093606.24446-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: olteanv@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 10:36:06 +0100 you wrote:
> Don't populate read-only const arrays on the stack, instead make them
> static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_clocking.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [next] net: dsa: sja1105: make read-only const arrays static
    https://git.kernel.org/netdev/net-next/c/f30e5323a188

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



