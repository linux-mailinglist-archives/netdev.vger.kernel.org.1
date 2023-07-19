Return-Path: <netdev+bounces-18799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C1758AF0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1C1C20EAE
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9717C8;
	Wed, 19 Jul 2023 01:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2715D1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13D8DC433C7;
	Wed, 19 Jul 2023 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689730821;
	bh=Z0TyEYtGqfI6IcND0lcSyqGPYZx0ajPjBcu/XotKGcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CqYT9gy4epOXt6zQpL/m5n6BiQztEEgdDmrpxSQ0GTZaeKUvOXCSatuMRkBsfrcaI
	 fmOw8iuqTSHdLbus8OimQFigPKKwGwEWjWxa0N3r1kPirB+rMNQidm1/AYZIrYh9kP
	 ekkFOm0qPGTD6rSqxjx8+bgXDXlFVI9Urak7JF+ABolxiWXqZWD4Jo/NkYv/aaAPqt
	 b+qBq9OzLpEdFpyN3f6FeE8tXdqkrj3BOQgQQPrW5lpt9rjRItB6jfjFT6hknjbFog
	 nc0yksKBqbbqOlgrv8dhBcbpxKUcJ+mgqf2gSrmELi85bv94zEDHD/7pNDyM1IkUCj
	 j7jSDa2KOzPIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E05F7E22AE0;
	Wed, 19 Jul 2023 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] can: raw: fix receiver memory leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973082091.10560.7182619527362375946.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 01:40:20 +0000
References: <20230717180938.230816-2-mkl@pengutronix.de>
In-Reply-To: <20230717180938.230816-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 william.xuanziyang@huawei.com, socketcan@hartkopp.net, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon, 17 Jul 2023 20:09:34 +0200 you wrote:
> From: Ziyang Xuan <william.xuanziyang@huawei.com>
> 
> Got kmemleak errors with the following ltp can_filter testcase:
> 
> for ((i=1; i<=100; i++))
> do
>         ./can_filter &
>         sleep 0.1
> done
> 
> [...]

Here is the summary with links:
  - [net,1/5] can: raw: fix receiver memory leak
    https://git.kernel.org/netdev/net/c/ee8b94c8510c
  - [net,2/5] can: bcm: Fix UAF in bcm_proc_show()
    https://git.kernel.org/netdev/net/c/55c3b96074f3
  - [net,3/5] can: gs_usb: gs_can_open(): improve error handling
    https://git.kernel.org/netdev/net/c/2603be9e8167
  - [net,4/5] can: gs_usb: fix time stamp counter initialization
    https://git.kernel.org/netdev/net/c/5886e4d5ecec
  - [net,5/5] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout
    https://git.kernel.org/netdev/net/c/9efa1a5407e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



