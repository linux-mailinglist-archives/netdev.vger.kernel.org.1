Return-Path: <netdev+bounces-109085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E806926D71
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1191F22C27
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA7812B82;
	Thu,  4 Jul 2024 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2aHYHy6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01CFC02
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060229; cv=none; b=lOM2VlQ+S9aPM9DzgP+KLDgElUu+dt42aYued9b5kx6l+92OyviUNsDKfODt7YEjIRC9j7TZg0i8ItiCAYcfnpTaqGZHSvmxwP+Z5DfJWurx0pXs/EvXcJ0nHasuWdTmL8ROSMxJQCRC4bf/9ldMGzKTL+0gTooOmc+hLcEw7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060229; c=relaxed/simple;
	bh=Y0oT0x81D7NSX5F0Q5aylZte8X5OF92Itj1icNn7IQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Llft9QBDuAjzEG/7WZLl0qd5PfM8F/gLvWlxVrw4vCrZutfOUdlcvhSl0RjKuJPK0FiOy5/uOxtOqlIjsalpssnCodt59rICtWLLG208uiXDuN77ShQFKNYLA/B3NhdCeR0/lW1ly8WhbbSY+68EeXOquiJf4NRC/JlHg629D0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2aHYHy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FADFC4AF0F;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720060228;
	bh=Y0oT0x81D7NSX5F0Q5aylZte8X5OF92Itj1icNn7IQ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2aHYHy6zsM200w1DmIGbatvq5vPrtSYrpSIvrS1k/2FCNMFmseBQDRNTq2t4LdUR
	 TRa2nxqWilA91Qedn4Cyi+ppdorZHeLGlaUm+RIaKyuIfUnaLU3VR6RSobIOmIPjCP
	 YBQVAHJWXHLJLlIQ36uosUYI4RBefKidogShyHIa0LT509Kd3hDjH+aIXVPgkvxMsM
	 VXLH8NVo3kRNVde+NKu1xkJxzVn7jKt3NHSyYWIpSDyyVnD5mnHfaYFbrvxr17YVfT
	 EzB0olodUSWHRDs+WHAopAnu+dKR3dqDpwf1bF2D6B8x7y4qgVMGc4Dkv62kwFNSL1
	 AW/NGJybePb9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85AA8C433A2;
	Thu,  4 Jul 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: rss_ctx: allow more noise on
 default context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172006022854.6400.9654309823031582639.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 02:30:28 +0000
References: <20240702233728.4183387-1-kuba@kernel.org>
In-Reply-To: <20240702233728.4183387-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dw@davidwei.uk, petrm@nvidia.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jul 2024 16:37:28 -0700 you wrote:
> As predicted by David running the test on a machine with a single
> interface is a bit unreliable. We try to send 20k packets with
> iperf and expect fewer than 10k packets on the default context.
> The test isn't very quick, iperf will usually send 100k packets
> by the time we stop it. So we're off by 5x on the number of iperf
> packets but still expect default context to only get the hardcoded
> 10k. The intent is to make sure we get noticeably less traffic
> on the default context. Use half of the resulting iperf traffic
> instead of the hard coded 10k.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: rss_ctx: allow more noise on default context
    https://git.kernel.org/netdev/net-next/c/0b8774586be5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



