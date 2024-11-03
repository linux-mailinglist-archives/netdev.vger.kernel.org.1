Return-Path: <netdev+bounces-141333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BE9BA7BA
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C5F1F214C6
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4485B187344;
	Sun,  3 Nov 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM7PbOwT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27D14F9E9;
	Sun,  3 Nov 2024 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663428; cv=none; b=iBQMFm2rXiIML8JEO4K9YA5PR4CVbsUS7F0JXH9/4rlP1DHZgkpnHFiq83sHwaYcywdgCtN0LK1XUpzn377Rmj+YRWGG8F6bTmbR7L93YdZs06Q56Kd660zPtsp9LJIOzG57kLgHrtE/bM5hmn7peXqS/sY61x6LslJVh7S3fu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663428; c=relaxed/simple;
	bh=DwXnLqlGXWdhz7snuRCrc4GmO/s5ftOnkWrDN4a4hd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=At9RrnUaYwOFqO88RIwulULty1b7DY+M2PrBWVo8FLhIKcmpLxHNJ2jknQLjpy8MjZlFGuj4XDjcWvMDFzW3bOV2w4Qe/7rmkI0rhfH7JZ4MQspDjAXiKdluTcbhAucuyQWo3PLbeDw0ILaQt60EDexKvfs6dnYxmrZcmDHJn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM7PbOwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F971C4CECD;
	Sun,  3 Nov 2024 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730663425;
	bh=DwXnLqlGXWdhz7snuRCrc4GmO/s5ftOnkWrDN4a4hd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KM7PbOwTnKg1Uhuuv3ofs4QxYo0b1ZhhMaSF6QlOvALaI40/PiqKT4zLkG4CVZEW+
	 GIPl6Pq4cW9gRQW51dr3Z5PeYU3accyTHW39ynULxn4ocECZeGrBS5auByOgtnKmho
	 gN4rCsV7PxCM+9mdOOzOx3ZrW58dD0aaQrg/6rgLA9z67FyCm0aEEi5E9flvIJvkhc
	 jvpvqObqeLNvX2owqMuhX7R99KQya/XztLArRHcA0BVenSdQaspKQ/GIRQ3etQbN90
	 zPkWBAzZ2hLvZMJhzthzWSf5LeyTe7mj4vLb2ABZq6WfmhUOnSGQSwW7YPxty31Ula
	 s+wogwN6S2+Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ADD38363C3;
	Sun,  3 Nov 2024 19:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftest: netconsole: Enhance selftest to
 validate userdata transmission
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066343373.3240688.8461037491221753272.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 19:50:33 +0000
References: <20241029090030.1793551-1-leitao@debian.org>
In-Reply-To: <20241029090030.1793551-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, matttbe@kernel.org,
 thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com, kernel-team@meta.com, aehkn@xenhub.one

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 02:00:27 -0700 you wrote:
> The netconsole selftest has been extended to cover userdata, a
> significant subsystem within netconsole. This patch introduces support
> for testing userdata by appending a key-value pair and verifying its
> successful transmission via netconsole/netpoll.
> 
> Additionally, this patchseries addresses a pending change in the subnet
> configuration for the selftest.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: netconsole: selftests: Change the IP subnet
    https://git.kernel.org/netdev/net-next/c/d051cd72dcb7
  - [net-next,v2,2/2] net: netconsole: selftests: Add userdata validation
    https://git.kernel.org/netdev/net-next/c/afa4ceb0fb64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



