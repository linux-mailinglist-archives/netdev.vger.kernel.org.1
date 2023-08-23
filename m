Return-Path: <netdev+bounces-29902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894CE785188
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14901C20C19
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330699461;
	Wed, 23 Aug 2023 07:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E088BF6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D640C433C9;
	Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692775827;
	bh=UoNr0I3PN+m5IXJXj8vEbzRCw/SFNCU8EZ146umxEXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MN1zclOMwcRTVq6iGGde39Qh4Ig6DU5Kg7M0hzui01IxxWlk3Xi23WgOVujMXFRnF
	 WPDL95gqeuCdUjDyDOGABjrQIQ+QIVXF4KiD2Pn+VzQ0PA8aiStTh6I5lpg7fCajYJ
	 SVhF+WcacrpuYLFsDVMsOdiqn3KChcB8CokGv9bNomThQZXwga/S660mWbqWfoWWDg
	 plq8qkhIbOgSh6A2zKwJq3eWe1wlfvXVobfYyC7qkqyOvp3fBkEhcLMLZ0ABTNXCDR
	 b7oy7zBmHjErNCD0IxwQ7nPkkwDrNl2CMIn2QZlWojMfTlJEXqFT8KPaXlG5vcFAoC
	 wRXICQOuW4hBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 016BAE4EAF6;
	Wed, 23 Aug 2023 07:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/11] Convert mlx4 to use auxiliary bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169277582700.32405.5371653311791450161.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 07:30:27 +0000
References: <20230821131225.11290-1-petr.pavlu@suse.com>
In-Reply-To: <20230821131225.11290-1-petr.pavlu@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 15:12:14 +0200 you wrote:
> This series converts the mlx4 drivers to use auxiliary bus, similarly to
> how mlx5 was converted [1]. The first 6 patches are preparatory changes,
> the remaining 4 are the final conversion.
> 
> Initial motivation for this change was to address a problem related to
> loading mlx4_en/mlx4_ib by mlx4_core using request_module_nowait(). When
> doing such a load in initrd, the operation is asynchronous to any init
> control and can get unexpectedly affected/interrupted by an eventual
> root switch. Using an auxiliary bus leaves these module loads to udevd
> which better integrates with systemd processing. [2]
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/11] mlx4: Get rid of the mlx4_interface.get_dev callback
    https://git.kernel.org/netdev/net-next/c/71ab55a9af80
  - [net-next,v3,02/11] mlx4: Rename member mlx4_en_dev.nb to netdev_nb
    https://git.kernel.org/netdev/net-next/c/ef5617e34376
  - [net-next,v3,03/11] mlx4: Use 'void *' as the event param of mlx4_dispatch_event()
    https://git.kernel.org/netdev/net-next/c/7ba189ac52ac
  - [net-next,v3,04/11] mlx4: Replace the mlx4_interface.event callback with a notifier
    https://git.kernel.org/netdev/net-next/c/73d68002a02e
  - [net-next,v3,05/11] mlx4: Get rid of the mlx4_interface.activate callback
    https://git.kernel.org/netdev/net-next/c/13f857111cb2
  - [net-next,v3,06/11] mlx4: Move the bond work to the core driver
    https://git.kernel.org/netdev/net-next/c/e2fb47d4eb5c
  - [net-next,v3,07/11] mlx4: Avoid resetting MLX4_INTFF_BONDING per driver
    https://git.kernel.org/netdev/net-next/c/c9452b8fd2ec
  - [net-next,v3,08/11] mlx4: Register mlx4 devices to an auxiliary virtual bus
    https://git.kernel.org/netdev/net-next/c/8c2d2b87719b
  - [net-next,v3,09/11] mlx4: Connect the ethernet part to the auxiliary bus
    https://git.kernel.org/netdev/net-next/c/eb93ae495a73
  - [net-next,v3,10/11] mlx4: Connect the infiniband part to the auxiliary bus
    https://git.kernel.org/netdev/net-next/c/7d22b1cb9d84
  - [net-next,v3,11/11] mlx4: Delete custom device management logic
    https://git.kernel.org/netdev/net-next/c/c138cdb89a14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



