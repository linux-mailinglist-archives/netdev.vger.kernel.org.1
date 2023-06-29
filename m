Return-Path: <netdev+bounces-14512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF9E742317
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1F3280D23
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C96A92D;
	Thu, 29 Jun 2023 09:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F228F2
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1789FC433C9;
	Thu, 29 Jun 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688030421;
	bh=sjrhlxMoc3gMI+6YuwBO+Xl5zd/guz3kTM9x73kxq5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eIea9TTtxrkRQxhJ1gdDnA2cjP6IXlLy3ZL8VD0rolkFQXuD99lrPLSpABAkDLRUI
	 KEgLn6I3Mdlo7MTJZW98tVMYFYc3qzIt/zXXat9RGIBA8waFSiswEm5FGHPAwyhHbF
	 vTK9KUv/qhUpmRGBj/sUZObI9qW2TI+EV2jJxprduanXBpHQpVc7CjFXg+XlhuJmRA
	 JdT+4mRxaxV7GbSCaPVxE8aYXHtTih/MPRy0WD8BdxfZ1lOMjgsEDa2OUf0pQiKMYi
	 5FjdQ5uiShVcX89m/OLbnJEa03wZ5HqSllc+MSPibMA3+6vgneRV+qBPYFMfNug5+P
	 7TswPHR3Sifow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF516C41671;
	Thu, 29 Jun 2023 09:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168803042097.16415.15204725768156666010.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jun 2023 09:20:20 +0000
References: <20230627035000.1295254-1-moritzf@google.com>
In-Reply-To: <20230627035000.1295254-1-moritzf@google.com>
To: Moritz Fischer <moritzf@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, mdf@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Jun 2023 03:50:00 +0000 you wrote:
> dev_set_rx_mode() grabs a spin_lock, and the lan743x implementation
> proceeds subsequently to go to sleep using readx_poll_timeout().
> 
> Introduce a helper wrapping the readx_poll_timeout_atomic() function
> and use it to replace the calls to readx_polL_timeout().
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
> Cc: stable@vger.kernel.org
> Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: lan743x: Don't sleep in atomic context
    https://git.kernel.org/netdev/net/c/7a8227b2e76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



