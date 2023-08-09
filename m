Return-Path: <netdev+bounces-25774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361047756F8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC7281B2F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F314F9B;
	Wed,  9 Aug 2023 10:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F563B5
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B59C433C9;
	Wed,  9 Aug 2023 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691576421;
	bh=/+9lymJKyP44fPxbXQaX8UUcGW4yh/CxLJ/wYewBowc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RiG38HKgWHg+FktyHOZa9ULx3997G7y9tHVufecxm8s+crzdlGnGsulf9J/mVd+iT
	 1Bvo7exwjNLzUtGrMGQpD5CVKaDV17cwi+J6FfQ6/R2jaAToIIOSjXaTlpOY9dpqRG
	 O8cAtfI+bpDVe06tOBRees7DqOjhETIgihKdukWw529dt0W2Y3Q9AWRY0luWJpkH9K
	 0y2/Dn4y34VE8QSucw7J3puu+sMGwG5dq4I623e5cpnxija9qhHgVOIq6NhAqHr+Cj
	 tFUYc0tqAAmN/dRfR0Gh0hvSh+LT65O+gCh9+B4nMDx/OHQoVj1waRuKKrMqEv/tkf
	 M5J0rPxq0Ar2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06397E270C1;
	Wed,  9 Aug 2023 10:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/7] sfc: basic conntrack offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169157642102.31305.7403062205482739405.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 10:20:21 +0000
References: <cover.1691415479.git.ecree.xilinx@gmail.com>
In-Reply-To: <cover.1691415479.git.ecree.xilinx@gmail.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org, habetsm.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 7 Aug 2023 14:48:04 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Support offloading tracked connections and matching against them in
>  TC chains on the PF and on representors.
> Later patch serieses will add NAT and conntrack-on-tunnel-netdevs;
>  keep it simple for now.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/7] sfc: add MAE table machinery for conntrack table
    https://git.kernel.org/netdev/net-next/c/3bf969e88ada
  - [v2,net-next,2/7] sfc: functions to register for conntrack zone offload
    https://git.kernel.org/netdev/net-next/c/c3bb5c6acd4e
  - [v2,net-next,3/7] sfc: functions to insert/remove conntrack entries to MAE hardware
    https://git.kernel.org/netdev/net-next/c/94aa05bdc777
  - [v2,net-next,4/7] sfc: offload conntrack flow entries (match only) from CT zones
    https://git.kernel.org/netdev/net-next/c/1909387fcfcf
  - [v2,net-next,5/7] sfc: handle non-zero chain_index on TC rules
    https://git.kernel.org/netdev/net-next/c/294160251853
  - [v2,net-next,6/7] sfc: conntrack state matches in TC rules
    https://git.kernel.org/netdev/net-next/c/1dfc29be4d74
  - [v2,net-next,7/7] sfc: offload left-hand side rules for conntrack
    https://git.kernel.org/netdev/net-next/c/01ad088fb05c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



