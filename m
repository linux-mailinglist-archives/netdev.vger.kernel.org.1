Return-Path: <netdev+bounces-127178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18A9747E3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF781C25C94
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA662B9BB;
	Wed, 11 Sep 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzQLIYOt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7433F6
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018832; cv=none; b=PkzvFyRmhWIBVDJx6bTyHLYZgTqlkYylzEtdSwgj3QdUTunio5r2ChhaQ6BH8m/Hzvmf7AE2Av5UJnnqgD0/p6RpwlLA+PkAoGHX4tbiQsSfrGZAP/WO6ZGnar+G6/a6ghv2oQwNSoir/ON/zgncrf0EPeGfukjjz4am+w5err0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018832; c=relaxed/simple;
	bh=qld/VT1QyB2w9eoW1MzyzE30mUWIbUSfmL8OEc8q5uY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AsSQ3IvVH72RmEdPAbBHPhFgX8sqTD3EKYg/0EEc9/pyGndsfCXRvC7rRDueWQLk2rcBFhohY6qhCt5eS8lSwMjFMEpqM44helbMyM/Qb91GAlboUceeS8RhRcGzWQ23P7z7NlT89qNB84qu/zbUg1iQ2bUfLjUHaZcL+tuiXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzQLIYOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF42DC4CEC3;
	Wed, 11 Sep 2024 01:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726018831;
	bh=qld/VT1QyB2w9eoW1MzyzE30mUWIbUSfmL8OEc8q5uY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzQLIYOtR/USoE2OnqLFFZekqqIO9U8UOwDk6ZIBsbA67DiAMr3UDnVIDYANZlhAs
	 CgC1ieEc0pb0oKYsfxcqbDrCiiSRrwb642Qtc1r41moQsoUXA1SQ6NI75BrAdRVui9
	 SGqqHEYk1OsqESXZRxPcKk2T4AapiSeXmTRg4HE4WAIXmxEDL08hyBXmrrp64NgBV/
	 SRUGgOz2gUlHbUqlYdrmB71AL85xP14ZAvLqBXe3VExWwPl06r5K88limCRApLiVz0
	 JPTnFXEW6LgSHVMgM6ggZpo8GeF4lZC+/eazFbuFPuXLVBDVktqVJxQj/g5UzG2WQW
	 pD8+sOTyfUDKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB23D3822FA4;
	Wed, 11 Sep 2024 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sch_cake: constify inverse square root cache
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172601883250.456797.7178255147295116839.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 01:40:32 +0000
References: <20240909091630.22177-1-toke@redhat.com>
In-Reply-To: <20240909091630.22177-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, dave.taht@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 11:16:28 +0200 you wrote:
> From: Dave Taht <dave.taht@gmail.com>
> 
> sch_cake uses a cache of the first 16 values of the inverse square root
> calculation for the Cobalt AQM to save some cycles on the fast path.
> This cache is populated when the qdisc is first loaded, but there's
> really no reason why it can't just be pre-populated. So change it to be
> pre-populated with constants, which also makes it possible to constify
> it.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] sch_cake: constify inverse square root cache
    https://git.kernel.org/netdev/net-next/c/c48994baefdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



