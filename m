Return-Path: <netdev+bounces-30963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D136A78A3D0
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 03:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBF21C208BC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB63645;
	Mon, 28 Aug 2023 01:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5263C
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE226C433C7;
	Mon, 28 Aug 2023 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693185031;
	bh=QRmOPvx9D9/PLSiCy4aLCffOEvM2qWLY/47vdibgt4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ifheZnjZGKE3+/qltlLoUW/+KzlMLL5RiJP5HnAqOcEdsAf+U1/k9fgNsAtSUHIzz
	 UutvXHBLEv5ESLfuzMIvG0OgN76X6FhvVVI/5xCwqRHXBFKzm4mXD0slkr4MBTmRwp
	 w3D2YGTdc05ibB7eud7e3ufxVrRh7osv7pYMusDN+osrtOJD9tOUneCDmufCuc5lFn
	 K64D53NUrM58u7/U5NumovGOsjCrj1Svuj59yE/q0t3T7uE4TZ0LGnPweuuzdr8SJe
	 jJ0+ZSSkUqVvyMfHBPqwUpp2nyYW/RSZ0Gv4U6fT1e0CtoamrGqD0VJNuClr1aDBWT
	 C1EcQRl3E9n1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C158CE21EC9;
	Mon, 28 Aug 2023 01:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V4 0/8] {devlink,mlx5}: Add port function attributes
 for ipsec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169318503178.15537.10958349208856861902.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 01:10:31 +0000
References: <20230825062836.103744-1-saeed@kernel.org>
In-Reply-To: <20230825062836.103744-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, jiri@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Aug 2023 23:28:28 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> v4:
>  - Rebased on top of latest mlx5 changes, align with new code, fix build
>    warnings
> 
> v3:
>  - Changed newly introduced IPsec blocking routine
>    and as an outcome of testing already existing one.
>    I'm sending them together to avoid merge conflicts.
>  - Refactored patches to separate IFC part
>  - Simplified
> v2: https://lore.kernel.org/netdev/20230421104901.897946-1-dchumak@nvidia.com/
>  - Improve docs of ipsec_crypto vs ipsec_packet devlink attributes
>  - also see patches 2,4 for the changelog.
> 
> [...]

Here is the summary with links:
  - [net-next,V4,1/8] devlink: Expose port function commands to control IPsec crypto offloads
    https://git.kernel.org/netdev/net-next/c/62b6442c58dc
  - [net-next,V4,2/8] devlink: Expose port function commands to control IPsec packet offloads
    https://git.kernel.org/netdev/net-next/c/390a24cbc396
  - [net-next,V4,3/8] net/mlx5: Drop extra layer of locks in IPsec
    https://git.kernel.org/netdev/net-next/c/c46fb77383a6
  - [net-next,V4,4/8] net/mlx5e: Rewrite IPsec vs. TC block interface
    https://git.kernel.org/netdev/net-next/c/e25373416678
  - [net-next,V4,5/8] net/mlx5: Add IFC bits to support IPsec enable/disable
    https://git.kernel.org/netdev/net-next/c/17c8da5a3423
  - [net-next,V4,6/8] net/mlx5: Provide an interface to block change of IPsec capabilities
    https://git.kernel.org/netdev/net-next/c/8efd7b17a3b0
  - [net-next,V4,7/8] net/mlx5: Implement devlink port function cmds to control ipsec_crypto
    https://git.kernel.org/netdev/net-next/c/06bab69658a8
  - [net-next,V4,8/8] net/mlx5: Implement devlink port function cmds to control ipsec_packet
    https://git.kernel.org/netdev/net-next/c/b691b1116e82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



