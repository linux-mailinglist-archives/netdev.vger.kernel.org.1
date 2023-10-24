Return-Path: <netdev+bounces-43807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD57D4DC2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC01F2818B0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCE168AF;
	Tue, 24 Oct 2023 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1U/BXKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8A2511F
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A83C433C9;
	Tue, 24 Oct 2023 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698143423;
	bh=AqU64/CD01QTzaTEgkHsvpgU2LfFNf/GKnwiGfPwf+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q1U/BXKzLT8KtXpLEhIoOZCIur3ACd8SEUMk7oG1TCILF///e7djuBIiiKPNUpMO5
	 9ga2vTv0jd1BbvBk6wvWATedGy9KndqPo41LqAMCi4Twk0AUlFw+/fx5jltzDhszL+
	 rqCevrg6Vl76XcUoQGkfNz5qaiMkBQQrlF89UyEGNHtAnowpNEgTUiug+J8r3QK4q7
	 vv8ZCpB3FcnTraWUfjLAqcp9z2M0vAp0f2L7UAjUae2zm4Fg4xDpdRcvXifsEuLR1d
	 Ru+UM7EFcRda4Z8F/LmwyXvyCs0nZkARAawQ6LoMWm7a55FLwnjnjb1tCDRYmIqIq9
	 D+fmHPY/efPNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A871FC00446;
	Tue, 24 Oct 2023 10:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] GTP tunnel driver fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169814342368.26648.13083436369390100934.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 10:30:23 +0000
References: <20231022202519.659526-1-pablo@netfilter.org>
In-Reply-To: <20231022202519.659526-1-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 laforge@osmocom.org, laforge@gnumonks.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Oct 2023 22:25:16 +0200 you wrote:
> Hi,
> 
> The following patchset contains two fixes for the GTP tunnel driver:
> 
> 1) Incorrect GTPA_MAX definition in UAPI headers. This is updating an
>    existing UAPI definition but for a good reason, this is certainly
>    broken. Similar fixes for incorrect _MAX definition in netlink
>    headers were applied in the past too.
> 
> [...]

Here is the summary with links:
  - [net,1/2] gtp: uapi: fix GTPA_MAX
    https://git.kernel.org/netdev/net/c/adc8df12d91a
  - [net,2/2] gtp: fix fragmentation needed check with gso
    https://git.kernel.org/netdev/net/c/4530e5b8e2da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



