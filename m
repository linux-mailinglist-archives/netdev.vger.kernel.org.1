Return-Path: <netdev+bounces-28017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230DA77DE7F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7602817BF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9DFC0A;
	Wed, 16 Aug 2023 10:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952D101C6
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01812C433CA;
	Wed, 16 Aug 2023 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692181227;
	bh=GeA63F6Zgbd13UeisGMcqF1r8qYA3P1vsPBM0UzvEQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ngixz+S1adpIzJ5U/7T7gpxGiibb8hJnB38akYVGNjS4IZaz5A6P6x6zioIAFu7CS
	 Nk2D5hchbsZJ++ydclnZ6kD/po8xTPN3skcgIbLqEHcQvvuqQR6WFX2ypnXrJohrof
	 z8Ha4cIGK3rv1YC7dyf3Dkyw1vFUmLYH7XnXCPMB53/VCPllJWHOPS7yOJ+Ikj8ClE
	 do/KH6PicxMNMYoYXQwK2rVnz37Rp/ra7FHOVfS7/0IQIXklQ/uvixJ27Uu4BsVFTZ
	 SaMsIrYEPyrBE8EqOGq191C0OPYCIBTpCyfWuqUzx8cFh1ZbPj0SGK4VLv61VnGtW3
	 1eO7jJGUiJxyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFD55C691E1;
	Wed, 16 Aug 2023 10:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/15] inet: socket lock and data-races avoidance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169218122691.20553.967730777451496109.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 10:20:26 +0000
References: <20230816081547.1272409-1-edumazet@google.com>
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 simon.horman@corigine.com, soheil@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 16 Aug 2023 08:15:32 +0000 you wrote:
> In this series, I converted 20 bits in "struct inet_sock" and made
> them truly atomic.
> 
> This allows to implement many IP_ socket options in a lockless
> fashion (no need to acquire socket lock), and fixes data-races
> that were showing up in various KCSAN reports.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/15] inet: introduce inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/c274af224269
  - [v4,net-next,02/15] inet: set/get simple options locklessly
    https://git.kernel.org/netdev/net-next/c/b4d84bce4c43
  - [v4,net-next,03/15] inet: move inet->recverr to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/6b5f43ea0815
  - [v4,net-next,04/15] inet: move inet->recverr_rfc4884 to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/8e8cfb114d9f
  - [v4,net-next,05/15] inet: move inet->freebind to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/3f7e753206bb
  - [v4,net-next,06/15] inet: move inet->hdrincl to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/cafbe182a467
  - [v4,net-next,07/15] inet: move inet->mc_loop to inet->inet_frags
    https://git.kernel.org/netdev/net-next/c/b09bde5c3554
  - [v4,net-next,08/15] inet: move inet->mc_all to inet->inet_frags
    https://git.kernel.org/netdev/net-next/c/307b4ac6dc18
  - [v4,net-next,09/15] inet: move inet->transparent to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/4bd0623f04ee
  - [v4,net-next,10/15] inet: move inet->is_icsk to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/b1c0356a5857
  - [v4,net-next,11/15] inet: move inet->nodefrag to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/f04b8d3478a3
  - [v4,net-next,12/15] inet: move inet->bind_address_no_port to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/ca571e2eb7eb
  - [v4,net-next,13/15] inet: move inet->defer_connect to inet->inet_flags
    https://git.kernel.org/netdev/net-next/c/08e39c0dfa29
  - [v4,net-next,14/15] inet: implement lockless IP_TTL
    https://git.kernel.org/netdev/net-next/c/10f42426e5bc
  - [v4,net-next,15/15] inet: implement lockless IP_MINTTL
    https://git.kernel.org/netdev/net-next/c/12af73269fd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



