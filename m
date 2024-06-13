Return-Path: <netdev+bounces-103025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3147905FDD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC5D284004
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F6944E;
	Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE6nAKp5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED0E652;
	Thu, 13 Jun 2024 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240431; cv=none; b=qwTasA09K9SyENLx7wzRx+HA4zWJzeAqCFDstjEFvlfwWw3rBRp48i4l/c2dr1Pgr55cKEmJKBFAtsj3JhNYhPCTTXUKLRF4/pz3wIK12FnPTkS0urk4Sb0mwVdURDb4TSe88X7xZxByiYc7mJlaXQoxFztjHJIwOY2pKLQRVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240431; c=relaxed/simple;
	bh=pFYd5dnt9JC+PVxse7/Tyb5tD3NHqqNXEcsD4Ej/9lc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IwQb7VCJ4da+0nctt863U5nnx/U1isVKh0H7SBvDkgaUbdttSKEE4DVoJprd8CdDp5WT1fE0Uwd4FbvDy3F99ckIdS3YMn5MPNQeUgFAYDUpLRZz+QT1S0Fw7i4WTvkFIRUi8VTNH7b0mSLoQEyTYxNigpfNcHDNZ92E4Q9xVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE6nAKp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D606FC3277B;
	Thu, 13 Jun 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718240430;
	bh=pFYd5dnt9JC+PVxse7/Tyb5tD3NHqqNXEcsD4Ej/9lc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HE6nAKp5SQI14CCKCUR2Ltva6iqDvuPYbLR4nW+jFyiJPamVqx2Mx4hJ88AwOYK91
	 h1VJA/x4C9Djryg6VxQtSNqanyhX2WnndLZGk2vEq6JrMMDBTi3vfoHnPMe454Pysj
	 K3TO5VA/cn4iM/8H0+wIFEHV60+b/BwxN3R0oh4U1m3OQx9hUY67DWglJxoezwgoCY
	 tSrZ6CPZxkRrEOdYYaUeYxYOa09CZE1wZwO2gDhcIe0bhlzK3uV4TMxW2MxGv4cKeX
	 5z1f8yvF1giK9/Ns7ZpgXO4FexsnrrL8nishrx2WrNx7CrcqTB+jHf9lqkJtV0y0Tj
	 c02IJv/LvAoGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C12AAC43619;
	Thu, 13 Jun 2024 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/ipv6: Fix the RT cache flush via sysctl using a
 previous delay
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171824043078.29237.14154022901138989230.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 01:00:30 +0000
References: <20240607112828.30285-1-petr.pavlu@suse.com>
In-Reply-To: <20240607112828.30285-1-petr.pavlu@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, thinker.li@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 13:28:28 +0200 you wrote:
> The net.ipv6.route.flush system parameter takes a value which specifies
> a delay used during the flush operation for aging exception routes. The
> written value is however not used in the currently requested flush and
> instead utilized only in the next one.
> 
> A problem is that ipv6_sysctl_rtcache_flush() first reads the old value
> of net->ipv6.sysctl.flush_delay into a local delay variable and then
> calls proc_dointvec() which actually updates the sysctl based on the
> provided input.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/ipv6: Fix the RT cache flush via sysctl using a previous delay
    https://git.kernel.org/bpf/bpf/c/14a20e5b4ad9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



