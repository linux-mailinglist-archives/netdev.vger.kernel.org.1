Return-Path: <netdev+bounces-35193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7E7A786F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8493B281BC7
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCC156E4;
	Wed, 20 Sep 2023 10:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AE15AC4
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F0DC433D9;
	Wed, 20 Sep 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695204023;
	bh=QhbCbpfn2CpH0TG7BAJc7BKryofUNRWE93fuHsckosU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RDDwC9D2s9qShQVZcH2XRb/PsLG04/xPeW+hfasmUSXpIJMcJeHF0slgRMYVRexAN
	 SGHoVlWCSAsSKFoGOu6GE+GZ3YVcZBBSimmnQv2W8w1wWXQSCF2fmwpoDzdxxZhTp7
	 hHL5/RtBhQYBvqcT1LQKBF9JJv79A+jzpEyy1jRYT4gNeCIFNxNqc0fgzKfQHY3fcj
	 vOgZdR3jA5cfISWoFetGDT/4WymOUWTAyQWWTc1deUPKbfCYMC96bXBTcIEYj5IE14
	 6T2+uc2qt/D0AUQrsthnYeVTNonLhiXJIFuNK+kpliWTYUAwbAQ5a6LhOgkK+JVY2x
	 s+qym8931eNvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A87D6C561EE;
	Wed, 20 Sep 2023 10:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] ionic: better Tx SG handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520402368.26831.12597729815090185512.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 10:00:23 +0000
References: <20230918222136.40251-1-shannon.nelson@amd.com>
In-Reply-To: <20230918222136.40251-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Sep 2023 15:21:33 -0700 you wrote:
> The primary patch here is to be sure we're not hitting linearize on a Tx
> skb when we don't really need to.  The other two are related details.
> 
> Shannon Nelson (3):
>   ionic: count SGs in packet to minimize linearize
>   ionic: add a check for max SGs and SKB frags
>   ionic: expand the descriptor bufs array
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] ionic: count SGs in packet to minimize linearize
    https://git.kernel.org/netdev/net-next/c/4d9d72200d4c
  - [net-next,2/3] ionic: add a check for max SGs and SKB frags
    https://git.kernel.org/netdev/net-next/c/40d835391b4f
  - [net-next,3/3] ionic: expand the descriptor bufs array
    https://git.kernel.org/netdev/net-next/c/529cdfd5e3a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



