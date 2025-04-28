Return-Path: <netdev+bounces-186594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750FCA9FD61
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F125A802D
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A62144C1;
	Mon, 28 Apr 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8d3bWax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3C2144BC
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881203; cv=none; b=Sy/3DdmeYWDDCFVY6W2uiMzWaDpLhCLJ2s4PvAGeYV610aqUmTOlbBeLxM0Nkt9JF7Vskcsk+ePxI52r3SGopn0V1Au2wp2xpA8rx3xuiBzfXsFAs28/7glH65+L7fGlBYnR91TwqrsTmiU8uJgOGIP98Bp/5do01w/1oP7J0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881203; c=relaxed/simple;
	bh=n3pFAz4v0tyB0wQX3/qs3xOKR4YjG4edCdThMbxjCCE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nsd5vpu3omgOx6cOlx70Z4NP2LZAXmTS7881KHpcgUdjsvFRO/Ku9oHYYTbkkBDzcdQg9txqU6wU8md6KztStFT729i81M1p2Ab00UfAo3s1d8Zo5AeE/BvlBpwlVsZoOx+lMuOPYeTcG08eHonK0GagMC+n9hyZVaUFdhAjRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8d3bWax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC39C4CEE4;
	Mon, 28 Apr 2025 23:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881202;
	bh=n3pFAz4v0tyB0wQX3/qs3xOKR4YjG4edCdThMbxjCCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t8d3bWaxKuh1uF2SY61emStCKTVnj1qQrGS8tkLojiEvz4lVVngkUlH5ky8ZyQY1H
	 7E8sDGyrln4gRTMT+XTgZzEPFbkr1bZughDU84pA8sbUZZM3ZNXb6rwJBlDseUUcnE
	 dEgsBrrqk3xqqwRC4VnZ2DtZ2Pp7nlOah4rykjkO62omYPLt94yMqxOAL5syPJXFl3
	 LUEyAGMwokoaGiBTW2pbeF7K/O5yoJqp+UyP30iLkmYeUmKFdi4W9azkI01s0tAjuK
	 AYzKJ2WITJh6ZPT4+HLdQerUqo6r9Uf0D2RfG+8nT/DTRD2zU1vxte3UqldsGpdxl+
	 EsUM1FvxIScug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB03822D43;
	Mon, 28 Apr 2025 23:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588124150.1071900.16673877697022974652.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 23:00:41 +0000
References: <20250425220710.3964791-1-victor@mojatatu.com>
In-Reply-To: <20250425220710.3964791-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, toke@redhat.com, gerrard.tai@starlabs.sg,
 pctammela@mojatatu.com, stephen@networkplumber.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 19:07:04 -0300 you wrote:
> As described in Gerrard's report [1], there are cases where netem can
> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
> qfq) break whenever the enqueue callback has reentrant behaviour.
> This series addresses these issues by adding extra checks that cater for
> these reentrant corner cases. This series has passed all relevant test
> cases in the TDC suite.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/5] net_sched: drr: Fix double list add in class with netem as child qdisc
    https://git.kernel.org/netdev/net/c/f99a3fbf023e
  - [net,v3,2/5] net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
    https://git.kernel.org/netdev/net/c/141d34391abb
  - [net,v3,3/5] net_sched: ets: Fix double list add in class with netem as child qdisc
    https://git.kernel.org/netdev/net/c/1a6d0c00fa07
  - [net,v3,4/5] net_sched: qfq: Fix double list add in class with netem as child qdisc
    https://git.kernel.org/netdev/net/c/f139f37dcdf3
  - [net,v3,5/5] selftests: tc-testing: Add TDC tests that exercise reentrant enqueue behaviour
    https://git.kernel.org/netdev/net/c/a6e1c5aa16dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



