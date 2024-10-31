Return-Path: <netdev+bounces-140584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4BA9B7181
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F20282667
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4513EA71;
	Thu, 31 Oct 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcZW1tB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129803BBE2;
	Thu, 31 Oct 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337028; cv=none; b=TPsQ4DcNOdVp0MlbmxAG//mg1jh4MMPic/vN4D122JX53MARhNq3YhsexSh3lyyJhGLyfpPOHWj54FzicxtW4DqgW0A7h+140Wq6kTkeex3UtmUQvmwiVElAXb4i0nzxm8Gi5pfBBAySBCyj7uv5nFXH4QMr9FgnwWJeAzpwpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337028; c=relaxed/simple;
	bh=o9iyYc/C1RIvijh/llnoBsHUv63/+tNy2AxkwT0LKMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3Jqcen48521zCpujQXWpVTVW13OwpL+kQvwrI4mkrljNSj5f72AyFxRavmekb3LPif8O5/r3ZBcJWeHQd7Kb4PCBTTLLPghP6JcPfPsidQOKFF0Wc3s4eQ5yxvjQPN+kQJEZqzxRyeEdnC1h2U80dZoAqpv09CBOi+94nhk2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcZW1tB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5DAC4CECE;
	Thu, 31 Oct 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730337025;
	bh=o9iyYc/C1RIvijh/llnoBsHUv63/+tNy2AxkwT0LKMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bcZW1tB7cctWMxuw11mzIUQ4oxm80L8JYaMBwpGjgjKzVI/W4hboJu2rz0JZI0zVo
	 1mJrfzKNYh2jcRBpLzCUPmV4CanPZaluhPbVnwGW3ScpGxcJRI422OUQRArbtWYU3p
	 yGF+rUMn5P6V8l/VjIBevMhSt5a2dJRmAmNhwjmHVijvqi/ifYcvBecWl0xPLV/Zyf
	 b+dqoV3tuaQSDw/6axyLhtSbLqV4srrCCTXMuM10iganHu1W1ik6CgMwAa8ywTc4ou
	 LgLEoGNC3lQycW9XE3zYP4EdhuH7AIYk+H9igBwasZBKr1Er3595hxVap4DYu6DI8l
	 qfnbCf3jJGLwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7164D380AC22;
	Thu, 31 Oct 2024 01:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v4 0/4] Refactoring RVU NIC driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033703326.1512423.9132461037726826431.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 01:10:33 +0000
References: <20241023161843.15543-1-gakula@marvell.com>
In-Reply-To: <20241023161843.15543-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, jiri@resnulli.us,
 edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 21:48:39 +0530 you wrote:
> This is a preparation pathset for follow-up "Introducing RVU representors driver"
> patches. The RVU representor driver creates representor netdev of each rvu device
> when switch dev mode is enabled.
> 
> RVU representor and NIC have a similar set of HW resources(NIX_LF,RQ/SQ/CQ)
> and implements a subset of NIC functionality.
> This patch set groups hw resources and queue configuration code into single API
> and export the existing functions so, that code can be shared between NIC and
> representor drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] octeontx2-pf: Define common API for HW resources configuration
    https://git.kernel.org/netdev/net-next/c/fbc704b3104b
  - [net-next,v4,2/4] octeontx2-pf: Add new APIs for queue memory alloc/free.
    https://git.kernel.org/netdev/net-next/c/03d80a1ba526
  - [net-next,v4,3/4] octeontx2-pf: Reuse PF max mtu value
    https://git.kernel.org/netdev/net-next/c/dec6f5ebd724
  - [net-next,v4,4/4] octeontx2-pf: Move shared APIs to header file
    https://git.kernel.org/netdev/net-next/c/78bd5d81241e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



