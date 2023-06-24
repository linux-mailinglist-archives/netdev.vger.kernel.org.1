Return-Path: <netdev+bounces-13641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF71173C64F
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF26281E9E
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAF0378;
	Sat, 24 Jun 2023 02:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6538B
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C114C433C0;
	Sat, 24 Jun 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687572622;
	bh=GP4MDPPblruUuyOewU5M/8WX4/YKL/gkyhGgbnT04Fw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=guGasW07Ts7ImeQZ3yMpgJZ/84eeFkA+Gm1tCHaB31vEQpgkjIHb5aQCT7QyB6f2h
	 1hImYaAPoAXOlN8AQaaMZvBiKwMhoAM39uzC+8G7p78hBa9dIo+n4k2Ans42G7pf2q
	 47i6yqe9cJ5E7qjZ4YkrvduYbtTRFeZcE7D1RqLBxL/WdVv0w5v3QuqGDDBlRJR1oq
	 py4qy/mmPBZJbaAw3u472PGm1ftPG9iSTaCSQeV9Zs8fF0ETeXKAQ4l0gASkJGeXue
	 VAzjkhhUq1lMR5GtgN/R5xF6qiEzRvQ4CvZXNFCEu/ejdEydcF0wh0GmqAoELp4B+W
	 8+LBwFJKz2cvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB158C43157;
	Sat, 24 Jun 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] mlxsw: Maintain candidate RIFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168757262195.25434.17193714700819777953.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 02:10:21 +0000
References: <cover.1687438411.git.petrm@nvidia.com>
In-Reply-To: <cover.1687438411.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 danieller@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 15:33:01 +0200 you wrote:
> The mlxsw driver currently makes the assumption that the user applies
> configuration in a bottom-up manner. Thus netdevices need to be added to
> the bridge before IP addresses are configured on that bridge or SVI added
> on top of it. Enslaving a netdevice to another netdevice that already has
> uppers is in fact forbidden by mlxsw for this reason. Despite this safety,
> it is rather easy to get into situations where the offloaded configuration
> is just plain wrong.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] mlxsw: spectrum_router: Add extack argument to mlxsw_sp_lb_rif_init()
    https://git.kernel.org/netdev/net-next/c/ebbd17ce297a
  - [net-next,2/8] mlxsw: spectrum_router: Use mlxsw_sp_ul_rif_get() to get main VRF LB RIF
    https://git.kernel.org/netdev/net-next/c/f3c85eed1ac3
  - [net-next,3/8] mlxsw: spectrum_router: Maintain a hash table of CRIFs
    https://git.kernel.org/netdev/net-next/c/4796c287b70a
  - [net-next,4/8] mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF
    https://git.kernel.org/netdev/net-next/c/78126cfd5dc9
  - [net-next,5/8] mlxsw: spectrum_router: Link CRIFs to RIFs
    https://git.kernel.org/netdev/net-next/c/aa21242b07a8
  - [net-next,6/8] mlxsw: spectrum_router: Use router.lb_crif instead of .lb_rif_index
    https://git.kernel.org/netdev/net-next/c/bdc0b78e79a6
  - [net-next,7/8] mlxsw: spectrum_router: Split nexthop finalization to two stages
    https://git.kernel.org/netdev/net-next/c/a285d664236e
  - [net-next,8/8] mlxsw: spectrum_router: Track next hops at CRIFs
    https://git.kernel.org/netdev/net-next/c/9464a3d68ea9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



