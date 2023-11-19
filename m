Return-Path: <netdev+bounces-49059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A367F08A1
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 20:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71B61F21010
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F81944B;
	Sun, 19 Nov 2023 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNImtz2X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4AC18C0A
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5788FC433C8;
	Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700423423;
	bh=2ndYzSeM4M85tVv7Ozf3E57uaVKbVurkw+JQM4qiER8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BNImtz2X4x68AzuduWxlpQXLPRnF9mmZL5CO4bMcsF72gmo5PSGYOEjF24LeLVo1h
	 ymuvHe/nKe3drXgALie5poflb1AlBJxZYbas5SbbVPm2lORzI5jMWm0cNdcc4I0Hpq
	 cbe2CKlryYjVeQeiJJ9zjYjqCs8keiL6prgoJwEM3uBmJzBtuzvBinEUJFFjT94xrf
	 5KXSbYy9aQZjMUZ6+VUSX33aoH8vB1g51NBE5mn1KoYv4fi1WqU35b0C0ynZhFWKXR
	 Xkttjxe7BmfLcbSVIrzL7XlPzDX2w/SrWuPxl3h+f5dYfkP+Y9Nlmtye+tPDmp0FoJ
	 d3edO2weUl8AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A8CCC3274D;
	Sun, 19 Nov 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: wangxun: fix kernel panic due to null pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170042342323.11006.720383593121756548.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 19:50:23 +0000
References: <20231117101108.893335-1-jiawenwu@trustnetic.com>
In-Reply-To: <20231117101108.893335-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, mengyuanlou@net-swift.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 18:11:08 +0800 you wrote:
> When the device uses a custom subsystem vendor ID, the function
> wx_sw_init() returns before the memory of 'wx->mac_table' is allocated.
> The null pointer will causes the kernel panic.
> 
> Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net] net: wangxun: fix kernel panic due to null pointer
    https://git.kernel.org/netdev/net/c/8ba2c459668c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



