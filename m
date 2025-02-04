Return-Path: <netdev+bounces-162362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ADAA26A3E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 03:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BBBA7A2FE0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3729E142E7C;
	Tue,  4 Feb 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxL3gCTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136B25A634
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738637407; cv=none; b=LshqOV35RecMFcfMVLlJGwUvNWw52bRIfPYvlLdh5/aFigfFq/p5Rc/CaygSg+VNPgpXtOwDvL4jLdsFa3Ghqs/mZa1LIh4a3KdzGVqYN2xfUrNDRIfrVRFniVuvD920CdSCCk1OMAYEuYWAuq0BpaloLsT1Q7xB+lTIi1saXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738637407; c=relaxed/simple;
	bh=3nW+gL2OJzhamvUDQ3NVRjubbFHJOfzHepSSb2tWQlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZxIm+16PLnvufQp44eMSJy9qNIeqNc1tMcvrDJG3XZC+op0KBPSXnf/gCqKBErBACeoBPUOErxkEXFdntpu05AoWbb+2+5hXP7JZSrtQxc/h/RtxUsvEvpD+8gaXRRqsxAOnf6knnBhSsqtRmYalaCYUCyC1i6TkLpfp+pIVM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxL3gCTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3FBC4CEE0;
	Tue,  4 Feb 2025 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738637406;
	bh=3nW+gL2OJzhamvUDQ3NVRjubbFHJOfzHepSSb2tWQlA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lxL3gCTRyipvzJMsdHJhNPm8/LTnoRSMv3HqGGEYgXaDgiTgvY+Dq7HTrFHM4ouEZ
	 QNwBUn9XqymjE49Or6pZbh09Rl0nEka+sAixjxqZawuhxZfsA5nN8BWFFzH5GP7ORd
	 xndD8raI+eDcY4UyXNDwXA2UoVCtZ0rlBuO70C5OpNtCQtYJwRi0sHLm1+IfxeKiMK
	 CXgZ5SidLHc0UjWUn4PsZe2mKMAFIHk8VaIbHwxHqqnFkwRr1o0xkRZzAGOXRxBy5M
	 M6frZaYHLbyZdRfhSIM7gyNGPL5rLdaZqevm9hpK/XAq3w1eAIVMnlYKRgRs148yya
	 NYC8hnbjltRKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFFA380AA67;
	Tue,  4 Feb 2025 02:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: armonize tstats and dstats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173863743353.3581294.5552119952119307159.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 02:50:33 +0000
References: <2e1c444cf0f63ae472baff29862c4c869be17031.1738432804.git.pabeni@redhat.com>
In-Reply-To: <2e1c444cf0f63ae472baff29862c4c869be17031.1738432804.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch, gnault@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Feb 2025 19:02:51 +0100 you wrote:
> After the blamed commits below, some UDP tunnel use dstats for
> accounting. On the xmit path, all the UDP-base tunnels ends up
> using iptunnel_xmit_stats() for stats accounting, and the latter
> assumes the relevant (tunnel) network device uses tstats.
> 
> The end result is some 'funny' stat report for the mentioned UDP
> tunnel, e.g. when no packet is actually dropped and a bunch of
> packets are transmitted:
> 
> [...]

Here is the summary with links:
  - [net] net: armonize tstats and dstats
    https://git.kernel.org/netdev/net/c/d3ed6dee73c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



