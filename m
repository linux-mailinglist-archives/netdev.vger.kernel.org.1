Return-Path: <netdev+bounces-99616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469AC8D57C5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D898F1F24C1D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A20C156;
	Fri, 31 May 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/CyCm+d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79B5C89
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119033; cv=none; b=cJSCEybJ2dRsiWXyZFPbnBe72YGY6eYnk667YmCHFDmxW9swOHRu9hS7HfmrSbMRtoKJuY/StxMDvXWBqFg1w5GeGgu1bPuHvS0eN3lcNG39Nx5HzPd9ud5GO8qpEdXPCOFlbKA2dbgx/XADcuffFdWC61kTY/k+QLlJnOTt4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119033; c=relaxed/simple;
	bh=gplwgHz1Me2WRmbeY9JqmQgoik6i3sjcmYTeSXrTurw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gH/D1vWQOv9phRmQWf8Mtw68nEghwXYaHcXDZBLcgH1zCyacTu/1LOv//++2LlpZIu9XFT5QcfLs2W4IYPVoHOSHn9/+vOTy6BYSR9GYO2XayeRpLpENeKzN+LL/NiirPgbcrB87um7sKH8yGM9lajraumS6/flTVoQ6T0wkPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/CyCm+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A50C32786;
	Fri, 31 May 2024 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119033;
	bh=gplwgHz1Me2WRmbeY9JqmQgoik6i3sjcmYTeSXrTurw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/CyCm+dy5mMqbYCSn/QexoTaEqyZfZTsQ9iyWJdEfh6VKfO49WL2W69kPNRyy1yE
	 CjbgM8l5yq9KaLDwOXZNBBo3xuPoBSiAF+EilI2geJj0GpIy2iOUylWOTB0AmE0m4D
	 SgXqDrP4al7Ec2+d1+SsmvrrBlYF6WPQlm5LW2w2ruMz+jeStpIa9hP2APXJXRuZqJ
	 7F4a7aDrYXrDhR9zAjkGUG36lloOYF7huSOHRt17rSRwTlgtwiBZwEVakwK5Wtfm0Y
	 tjFeT7BKjzNPFGqrm4aXvW0Tkf/gWlfCBmqovBL9QZWriaF91v6/NHtVkrzj7YM4dJ
	 FUMWeWShUgBbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF754CF21F3;
	Fri, 31 May 2024 01:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] ionic: updates for v6.11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711903291.12927.4247643339908614644.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 01:30:32 +0000
References: <20240529000259.25775-1-shannon.nelson@amd.com>
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 brett.creeley@amd.com, drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 17:02:52 -0700 you wrote:
> These are a few minor fixes for the ionic driver to clean
> up a some little things that have been waiting for attention.
> These were originally sent for net, but now respun for net-next.
> 
> v1: https://lore.kernel.org/netdev/20240521013715.12098-1-shannon.nelson@amd.com/
> 
> Brett Creeley (3):
>   ionic: Pass ionic_txq_desc to ionic_tx_tso_post
>   ionic: Mark error paths in the data path as unlikely
>   ionic: Use netdev_name() function instead of netdev->name
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] ionic: fix potential irq name truncation
    https://git.kernel.org/netdev/net-next/c/3eb76e71b16e
  - [net-next,v2,2/7] ionic: Reset LIF device while restarting LIF
    https://git.kernel.org/netdev/net-next/c/8097a2f3d21a
  - [net-next,v2,3/7] ionic: Pass ionic_txq_desc to ionic_tx_tso_post
    https://git.kernel.org/netdev/net-next/c/4dde9588c54d
  - [net-next,v2,4/7] ionic: Mark error paths in the data path as unlikely
    https://git.kernel.org/netdev/net-next/c/d9c04209990b
  - [net-next,v2,5/7] ionic: Use netdev_name() function instead of netdev->name
    https://git.kernel.org/netdev/net-next/c/fc53d4652448
  - [net-next,v2,6/7] ionic: only sync frag_len in first buffer of xdp
    https://git.kernel.org/netdev/net-next/c/488da00479d5
  - [net-next,v2,7/7] ionic: fix up ionic_if.h kernel-doc issues
    https://git.kernel.org/netdev/net-next/c/a54e2a36b68c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



