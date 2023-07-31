Return-Path: <netdev+bounces-22750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A9E7690F1
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAFD1C208F7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7D14F70;
	Mon, 31 Jul 2023 09:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5F111D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 09:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBD4CC433BB;
	Mon, 31 Jul 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690794019;
	bh=JgCRzdweZ5zFpfF5Al/HYmMZ4ccc1nyLaeGu4f+nfdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F8/Tr1pqR4qgR+TjizvFhyGyzMXICtx8vdppGkvM4mBIOLUKgoT7w6ck5oA7Ro/wG
	 /zzirGrVpTy3PuFGmerf9ZAbehh9rv/fv86aU2KHE6WwIfPeWSHYkzLBGuarWNYiMT
	 l1NBRWBr06XUij9da9kP9wLkrVP2jXTGc3kuXfHYW7WNdgKdCidSUimivsO0U8OXwV
	 TJB0p5kCgewskEx0PbjvLLpuATzUPtBItw+YgDnTFizicgznY22pEHt0awOx6uxbm2
	 lIWOCkux8ZP24QBpfpzIZl32otduNN+lwpu3pD+wpa9jwa6nQaGtcLNdmrk4Q41iev
	 LWPcjVul2tjxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B84C8E96AC0;
	Mon, 31 Jul 2023 09:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: lan78xx: reorder cleanup operations to avoid
 UAF bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169079401974.32402.6450872761583182908.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 09:00:19 +0000
References: <20230726081407.18977-1-duoming@zju.edu.cn>
In-Reply-To: <20230726081407.18977-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, UNGLinuxDriver@microchip.com,
 woojung.huh@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Jul 2023 16:14:07 +0800 you wrote:
> The timer dev->stat_monitor can schedule the delayed work dev->wq and
> the delayed work dev->wq can also arm the dev->stat_monitor timer.
> 
> When the device is detaching, the net_device will be deallocated. but
> the net_device private data could still be dereferenced in delayed work
> or timer handler. As a result, the UAF bugs will happen.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs
    https://git.kernel.org/netdev/net/c/1e7417c188d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



