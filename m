Return-Path: <netdev+bounces-47331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B67E9AC9
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3F5B20A49
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D81CA90;
	Mon, 13 Nov 2023 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJNoYI/m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB01C6B7
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99047C433CD;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699873824;
	bh=vVg6FRkkta/ogCT2/KXPlW4+P3XtletmhVt1qTizlWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJNoYI/mlQOQC+woI+t6cXqu/JfGm9lKSS5JpEXctTuGPZeA7Le3oGUSf/OakeJBY
	 YzhQUF5LLfMYJ6/KWAJYI5ir3+Y/odfa+DArJFlJxnvkvdTKourDA0YyyGkDjUnC++
	 iMqAhpR2pto5DC9p52j7VJ0S84evOraON1EYWReuWXQyrtcjxIuqUDSKvp4eq73Kec
	 uDCUQkxu/1nbsRLbwAqRgh0zDma/I+liIVBWQAOCDb2ZKUtV63rAUotm6uSaOhCjOD
	 xq2mgE0zWNJ67nLM5c9ZeZHIH3VlEYie8I3RtqfUlC0jw4jauk2zFabPKN2pAVzcq0
	 Zjq4XTE3UU/wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A893E32712;
	Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] net: mvneta: fix calls to page_pool_get_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169987382449.356.6300472910901255906.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 11:10:24 +0000
References: <ydvyjmjgpppf2hd7rzb6iu2hi6aiuxoa7sq5qnorknwk5txuca@7fgznkjwynsf>
In-Reply-To: <ydvyjmjgpppf2hd7rzb6iu2hi6aiuxoa7sq5qnorknwk5txuca@7fgznkjwynsf>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, brouer@redhat.com,
 lorenzo@kernel.org, ilias.apalodimas@linaro.org, mcroce@microsoft.com,
 leon@kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 11 Nov 2023 05:41:12 +0100 you wrote:
> Calling page_pool_get_stats in the mvneta driver without checks
> leads to kernel crashes.
> First the page pool is only available if the bm is not used.
> The page pool is also not allocated when the port is stopped.
> It can also be not allocated in case of errors.
> 
> The current implementation leads to the following crash calling
> ethstats on a port that is down or when calling it at the wrong moment:
> 
> [...]

Here is the summary with links:
  - [v5] net: mvneta: fix calls to page_pool_get_stats
    https://git.kernel.org/netdev/net/c/ca8add922f9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



