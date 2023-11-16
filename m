Return-Path: <netdev+bounces-48244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DE7EDBA3
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2EB209A8
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 06:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45D45948;
	Thu, 16 Nov 2023 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXZ0Senf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282D23C1
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E0CFC433C8;
	Thu, 16 Nov 2023 06:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700116826;
	bh=uEQDCWFhBN3ZJpV+FkXynmy/iG15JJnWTUaZddSFl/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZXZ0SenfujXCKkcJgJObMhyW/3/zelc+6xAs6hFVnrlIDQUacmabOoJOJiKZtCJVN
	 QHUG2n3Ema7K/Z2GnE47OG2yXTlb2d70/SMAn8hCzGI8n9D72hEaA7H7fMDNDjRsfH
	 x71ype6blpDEDiRMeXWUDmU9XKrhfHzI7IVa7NZuCgSNhtCinPmnGxRFk+xIRpLuc0
	 JcyCtmr4aQaVxlfempLDfM8TP4LUf4XFOYaWPrIFu/np64OyVz8bH36KDdNc640LNH
	 IWf8388P+v/ekES7vDGiAYQchYiNfrsjHXwzttGl1VyOBRUpq20YhrKkkVY8oGc77p
	 +v/8wAXKsnxZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 450D8C4166E;
	Thu, 16 Nov 2023 06:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net V2 01/15] Revert "net/mlx5: DR,
 Supporting inline WQE when possible"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170011682627.8628.2407932465504734181.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 06:40:26 +0000
References: <20231114215846.5902-2-saeed@kernel.org>
In-Reply-To: <20231114215846.5902-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, igozlan@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Nov 2023 13:58:32 -0800 you wrote:
> From: Itamar Gozlan <igozlan@nvidia.com>
> 
> This reverts commit 95c337cce0e11d06a715da73e6796ade9216637f.
> The revert is required due to the suspicion it cause some tests
> fail and will be moved to further investigation.
> 
> Fixes: 95c337cce0e1 ("net/mlx5: DR, Supporting inline WQE when possible")
> Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net,V2,01/15] Revert "net/mlx5: DR, Supporting inline WQE when possible"
    https://git.kernel.org/netdev/net/c/df3aafe50185
  - [net,V2,02/15] net/mlx5: Free used cpus mask when an IRQ is released
    https://git.kernel.org/netdev/net/c/7d2f74d1d438
  - [net,V2,03/15] net/mlx5: DR, Allow old devices to use multi destination FTE
    https://git.kernel.org/netdev/net/c/ad4d82c3eacd
  - [net,V2,04/15] net/mlx5: Decouple PHC .adjtime and .adjphase implementations
    https://git.kernel.org/netdev/net/c/fd64fd13c49a
  - [net,V2,05/15] net/mlx5e: fix double free of encap_header
    https://git.kernel.org/netdev/net/c/6f9b1a073166
  - [net,V2,06/15] net/mlx5e: fix double free of encap_header in update funcs
    https://git.kernel.org/netdev/net/c/3a4aa3cb8356
  - [net,V2,07/15] net/mlx5e: Fix pedit endianness
    https://git.kernel.org/netdev/net/c/0c101a23ca7e
  - [net,V2,08/15] net/mlx5e: Don't modify the peer sent-to-vport rules for IPSec offload
    https://git.kernel.org/netdev/net/c/bdf788cf224f
  - [net,V2,09/15] net/mlx5e: Avoid referencing skb after free-ing in drop path of mlx5e_sq_xmit_wqe
    https://git.kernel.org/netdev/net/c/64f14d16eef1
  - [net,V2,10/15] net/mlx5e: Track xmit submission to PTP WQ after populating metadata map
    https://git.kernel.org/netdev/net/c/7e3f3ba97e6c
  - [net,V2,11/15] net/mlx5e: Update doorbell for port timestamping CQ before the software counter
    https://git.kernel.org/netdev/net/c/92214be5979c
  - [net,V2,12/15] net/mlx5: Increase size of irq name buffer
    https://git.kernel.org/netdev/net/c/3338bebfc26a
  - [net,V2,13/15] net/mlx5e: Reduce the size of icosq_str
    https://git.kernel.org/netdev/net/c/dce94142842e
  - [net,V2,14/15] net/mlx5e: Check return value of snprintf writing to fw_version buffer
    https://git.kernel.org/netdev/net/c/41e63c2baa11
  - [net,V2,15/15] net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors
    https://git.kernel.org/netdev/net/c/1b2bd0c0264f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



