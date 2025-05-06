Return-Path: <netdev+bounces-188195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36FAAB814
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298FD162E1D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9033FD;
	Tue,  6 May 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FM2wHW1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED372608;
	Tue,  6 May 2025 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489659; cv=none; b=gjwAdvZO5JGpcowwqPKpn/Otgm9RbFx0AGDoIv6HZZT4Pxpy4zZENRrgRSe6P7mNQvmXgs6X9vlPtSL+cvhHcIpMWcR1uw1It98alQM7qbAdwlTGZJcdEHtJSxiYhOl2hAvGzXqXTv3MTylYIocLnWBJAKPhTsM8hT/AnB6DQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489659; c=relaxed/simple;
	bh=ohwRQqT8f4gA0hGto1P20xGk4Fv8/oc8Sx1xdg9N55s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AsQoV3TGPEorp1ruGDXpDBJ8G/CnbKaTucEQqyXS1CpO+5AOn1R35caRsyrDzB+FH3oJJRVD3Z3hheBfSfxwPUnyfEO+mZvqixdRpI3bXjhcoKlPrKaqoBKsnYGjY7UWvMu0/lPFcAw2veQaZD5ANjHUNDcmdWw/pbppzO/2LFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FM2wHW1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A60C4CEE4;
	Tue,  6 May 2025 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489657;
	bh=ohwRQqT8f4gA0hGto1P20xGk4Fv8/oc8Sx1xdg9N55s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FM2wHW1z5TZG7kYwr40gNKwOCilhhadPpCPaxuAElAZSQFWSiZOENUrFldE6G0N1z
	 Z6O4046Wvk6ayM42fbCZ3cF4f2OLEpLpfIOvSpV72g5c2xcsPjiBTSrZUSs4AkeQtH
	 8y+BaQkOTYEAyGaAYu+As1lPI8jRLMJ0zOa41rxaFsvXWIAtiWhBcyT+1vHejrC871
	 DGMALtL4bBruMpcJFakaXn84l07wpAWQYpD9svKR/X7y3e4MzdkckmNYhtG7wFJbJv
	 UOc2dNUN1U/5uOdEvjBG1P/W5CUsO7pcn41838bfSBsWLwIw1K6PpQllTTF/XelGVg
	 nlEpWE/ruWY6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3398D380CFD9;
	Tue,  6 May 2025 00:01:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] strparser: Remove unused __strp_unpause
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648969574.970984.7703121156952254735.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 00:01:35 +0000
References: <20250501002402.308843-1-linux@treblig.org>
In-Reply-To: <20250501002402.308843-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 May 2025 01:24:02 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of __strp_unpause() was removed in 2022 by
> commit 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] strparser: Remove unused __strp_unpause
    https://git.kernel.org/netdev/net-next/c/320a66f84022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



