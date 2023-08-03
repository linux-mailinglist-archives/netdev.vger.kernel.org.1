Return-Path: <netdev+bounces-23845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33576DD8E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76281C21018
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946A525E;
	Thu,  3 Aug 2023 01:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB273C26
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A77AC433C7;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691027425;
	bh=s2APEwdxxKvxXC/1BhyOJK26Y8ogJ+br6yYfTJV7RR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ij8nqXFCEWuQKF603LDidpGTGYwNihmYFdLDlMaWrTl6tROOkvGbEzIgiitiCDlYO
	 VjtF37B77FXxtoHph5+eQD84zm/A6kx5SS0ohohHyhL4ugZ/C26FThJCO/gB1EBNSJ
	 8BUqPzVqt0BXuI4+KcDf0k8lsZHrxmI9c7gSMFVkY/LLNvB7L+gsITB5kNpg0ITC9t
	 Au2TfqhJ8l0/OnD97iT29BjbzOZ77Bqf6zZj2hxSQf9BsNfHO4Q91ZW+NLQE9KbEN1
	 MT29/B34IJL5tpSd5StjIfPOl6K7R4tvIKIlD1NeQMJiQE6h/HldXscnFBvEDF9t2S
	 hSHz7v8T76U9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87B1BE270D2;
	Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 00/13] mlx5 IPsec packet offload support in
 eswitch mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169102742555.3352.12014834871177271942.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 01:50:25 +0000
References: <cover.1690802064.git.leon@kernel.org>
In-Reply-To: <cover.1690802064.git.leon@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org, leonro@nvidia.com, steffen.klassert@secunet.com,
 edumazet@google.com, jianbol@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
 davem@davemloft.net, simon.horman@corigine.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 14:28:11 +0300 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v1:
>  * Fixed ipv6 flow steering table destination in IPsec initialization routine.
>  * Removed Fixes line from "net/mlx5: Compare with..." patch as this fix
>    is required for this series only.
>  * Added patch to enforce same order for HW and SW IPsec flows when TC
>    is involved, which is "host <-> IPsec <-> TC <-> "wire"/switch".
> v0: https://lore.kernel.org/all/cover.1689064922.git.leonro@nvidia.com
> 
> [...]

Here is the summary with links:
  - [net-next,v1,01/13] net/mlx5e: Add function to get IPsec offload namespace
    https://git.kernel.org/netdev/net-next/c/fbd517549c32
  - [net-next,v1,02/13] net/mlx5e: Change the parameter of IPsec RX skb handle function
    https://git.kernel.org/netdev/net-next/c/33b18a0f75cd
  - [net-next,v1,03/13] net/mlx5e: Prepare IPsec packet offload for switchdev mode
    https://git.kernel.org/netdev/net-next/c/f5c5abc4c041
  - [net-next,v1,04/13] net/mlx5e: Refactor IPsec RX tables creation and destruction
    https://git.kernel.org/netdev/net-next/c/6e125265d52d
  - [net-next,v1,05/13] net/mlx5e: Support IPsec packet offload for RX in switchdev mode
    https://git.kernel.org/netdev/net-next/c/1762f132d542
  - [net-next,v1,06/13] net/mlx5e: Handle IPsec offload for RX datapath in switchdev mode
    https://git.kernel.org/netdev/net-next/c/91bafc638ed4
  - [net-next,v1,07/13] net/mlx5e: Refactor IPsec TX tables creation
    https://git.kernel.org/netdev/net-next/c/f46e92d664fb
  - [net-next,v1,08/13] net/mlx5e: Support IPsec packet offload for TX in switchdev mode
    https://git.kernel.org/netdev/net-next/c/c6c2bf5db4ea
  - [net-next,v1,09/13] net/mlx5: Compare with old_dest param to modify rule destination
    https://git.kernel.org/netdev/net-next/c/1632649d2dbd
  - [net-next,v1,10/13] net/mlx5e: Make IPsec offload work together with eswitch and TC
    https://git.kernel.org/netdev/net-next/c/366e46242b8e
  - [net-next,v1,11/13] net/mlx5e: Modify and restore TC rules for IPSec TX rules
    https://git.kernel.org/netdev/net-next/c/d1569537a837
  - [net-next,v1,12/13] net/mlx5e: Add get IPsec offload stats for uplink representor
    https://git.kernel.org/netdev/net-next/c/6e56ab1c9059
  - [net-next,v1,13/13] net/mlx5e: Make TC and IPsec offloads mutually exclusive on a netdev
    https://git.kernel.org/netdev/net-next/c/c8e350e62fc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



