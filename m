Return-Path: <netdev+bounces-29755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C51784944
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B8A28119D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AB31DDFE;
	Tue, 22 Aug 2023 18:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDA1DDF9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E660BC4339A;
	Tue, 22 Aug 2023 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727831;
	bh=tlzkIhBRXghihtM5HbSPZaaP5bzYXrrOFT3p+UvMY1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y1S998hnLdfp12ft8OAzLMTgzUq0XvOSeSGixVKz4/hkP8W3xVyQKiALt+1ES7OZj
	 G1NA0p3E36NsTvwDT9bftMIiagnsvfJK6oW1+aZSsaeczl0DeYkqqNM2k/PMeJiJP0
	 aCwOHZNozLtfwz2EM9yG5WtRIuzRv5h5sYfUncFyRfozqR8MXJo2IXhyO6b3XZg6Iu
	 RTInGnZ1Cg4cUZamaCqrRfrIRjAFn2sja5DuAsvmpNFz2UlJPyJMpZXXKcRZkLyEcf
	 5TTffYNUyf64T1hB3Tu/MWbC/OmsclpcUNlBpvXodtaOzlvW+6djDrd9Y0mZ6NthZX
	 JjsNrulqVeh6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7345C595CE;
	Tue, 22 Aug 2023 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V2 01/14] net/mlx5e: aRFS,
 Prevent repeated kernel rule migrations requests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272783080.18530.1504106217283170391.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:10:30 +0000
References: <20230821175739.81188-2-saeed@kernel.org>
In-Reply-To: <20230821175739.81188-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, afaris@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Mon, 21 Aug 2023 10:57:26 -0700 you wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> aRFS rule movement requests from one Rx ring to other Rx ring arrive
> from the kernel to ensure that packets are steered to the right Rx ring.
> In the time interval until satisfying such a request, several more
> requests might follow, for the same flow.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/14] net/mlx5e: aRFS, Prevent repeated kernel rule migrations requests
    https://git.kernel.org/netdev/net-next/c/7a73cf0bf7f9
  - [net-next,V2,02/14] net/mlx5e: aRFS, Warn if aRFS table does not exist for aRFS rule
    https://git.kernel.org/netdev/net-next/c/7653d8067245
  - [net-next,V2,03/14] net/mlx5e: aRFS, Introduce ethtool stats
    https://git.kernel.org/netdev/net-next/c/f98e51585f2c
  - [net-next,V2,04/14] net/mlx5e: Fix spelling mistake "Faided" -> "Failed"
    https://git.kernel.org/netdev/net-next/c/d7cea02a1fac
  - [net-next,V2,05/14] net/mlx5: IRQ, consolidate irq and affinity mask allocation
    https://git.kernel.org/netdev/net-next/c/9e9ff54e63b4
  - [net-next,V2,06/14] net/mlx5: DR, Fix code indentation
    https://git.kernel.org/netdev/net-next/c/f83e2d8aef4a
  - [net-next,V2,07/14] net/mlx5: DR, Remove unneeded local variable
    https://git.kernel.org/netdev/net-next/c/a15e472f8834
  - [net-next,V2,08/14] net/mlx5: Remove health syndrome enum duplication
    https://git.kernel.org/netdev/net-next/c/ab943e2efd5d
  - [net-next,V2,09/14] net/mlx5: Update dead links in Kconfig documentation
    https://git.kernel.org/netdev/net-next/c/6c8f7c434487
  - [net-next,V2,10/14] net/mlx5: Call mlx5_esw_offloads_rep_load/unload() for uplink port directly
    https://git.kernel.org/netdev/net-next/c/ba3d85f008f2
  - [net-next,V2,11/14] net/mlx5: Remove VPORT_UPLINK handling from devlink_port.c
    https://git.kernel.org/netdev/net-next/c/52020903f35c
  - [net-next,V2,12/14] net/mlx5: Rename devlink port ops struct for PFs/VFs
    https://git.kernel.org/netdev/net-next/c/df3822f5808d
  - [net-next,V2,13/14] net/mlx5: DR, Supporting inline WQE when possible
    https://git.kernel.org/netdev/net-next/c/95c337cce0e1
  - [net-next,V2,14/14] net/mlx5: Devcom, only use devcom after NULL check in mlx5_devcom_send_event()
    https://git.kernel.org/netdev/net-next/c/7d7c6e8c5fe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



