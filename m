Return-Path: <netdev+bounces-46560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099917E4F50
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 04:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFFC281077
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF4111D;
	Wed,  8 Nov 2023 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbJQIu+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A9ED9
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92601C433C9;
	Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699413024;
	bh=llQU8Pes1IGXQFYzPmGojtT5gHQipVIj9ECTpYMLMiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DbJQIu+60glOyktYCDa6DJwPqWyjir8M/P3cPcVpV/0JfmnPhMS04axa4AcAdKZag
	 bWTl+j/+3U6aiwynpVv0gd1ReEPNX6/on5RsPZuAF5QTXybvwidK91HTFz+7rPpBDC
	 7M2J/QRz5ApN7aGnMXzFs3tCafICzjznGtgc6AI/fkWtozVTlvVqXt4l8CnC5sONHc
	 L850nLHi2J48mBl5L/RAMoXvQ/CJlYkIgOveT103tbFkvjdPfs4L/GICJqLwo6cAju
	 xyDUAitYUcAL8ZBYcnZAff2OY7UAD0nm2v5ePQs26y+J1dL/jO0K/zqWONTUmW3dYT
	 LeL61UqvrBfPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7770DE00084;
	Wed,  8 Nov 2023 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: respect userspace disabling IFF_MULTICAST
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169941302448.21503.16017954065411686425.git-patchwork-notify@kernel.org>
Date: Wed, 08 Nov 2023 03:10:24 +0000
References: <4a57ba02-d52d-4369-9f14-3565e6c1f7dc@gmail.com>
In-Reply-To: <4a57ba02-d52d-4369-9f14-3565e6c1f7dc@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, nic_swsd@realtek.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 5 Nov 2023 23:43:36 +0100 you wrote:
> So far we ignore the setting of IFF_MULTICAST. Fix this and clear bit
> AcceptMulticast if IFF_MULTICAST isn't set.
> 
> Note: Based on the implementations I've seen it doesn't seem to be 100% clear
> what a driver is supposed to do if IFF_ALLMULTI is set but IFF_MULTICAST
> is not. This patch is based on the understanding that IFF_MULTICAST has
> precedence.
> 
> [...]

Here is the summary with links:
  - [net] r8169: respect userspace disabling IFF_MULTICAST
    https://git.kernel.org/netdev/net/c/8999ce4cfc87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



