Return-Path: <netdev+bounces-155238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D71A017C5
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B42C3A3589
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233CC2F2;
	Sun,  5 Jan 2025 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ial6G1Ws"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ABB184F
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736041809; cv=none; b=L+C5Wl9PxN9eBi+70+TjeOHMi4LIfkx1Ic7C0KRc6uLI8CtqzZH/pxM2sqikGAbYsJN8x2ekYv5SVyG3MZLKVuwRAtTrRixJ5mC5bCuqxkAtLWpKVv3zBdN2eh4icVnXojDrQsRKNkGxt7BB1oWfBkvLdmT0D73ASYhd64NssXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736041809; c=relaxed/simple;
	bh=+navMi6DkrYSSzBkL5EktxbosF/4KL1yoh1vHosdhys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fzKHA67FaGoUMDrLbtowDEFbMH8Uqb9SrMTBDitJ+8grF++SnF9Ej+GBvbXM0r/ExwO802aWdQnQBL4r9ZJ0L3IdOF8j2ERzR2NPJI3pWo5/u79/rV+vyjduyxT/onlJiK33ChbhX/1TV16SUsoIvvFE6oKRIMcqQYSIVZ3tEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ial6G1Ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3318C4CED1;
	Sun,  5 Jan 2025 01:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736041808;
	bh=+navMi6DkrYSSzBkL5EktxbosF/4KL1yoh1vHosdhys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ial6G1WsjiitI/nUbuVZyteVUdId0w+ttT7xAYIrCYXyHZ4qbZxsFPqt/rR/ngUJF
	 rk2rX1HoxjnwObl73ydfe+5YZi5/FaDq23wa74yFTKDlQZNXBeUToXeD77BjdtoZ7V
	 NAZ7ePzAnqHUu/v0/vCrblTZJvBlebgz6rRsLuNpDbaqFg6R9Sr41YbL2amFpHp7/N
	 XTWK11BGofBpEMwG6aBoqDozHqfOuOVorrtny2pTr25R2fsbzm04l8lbMh+OUQ3ctd
	 1ScN5OKDT6r7s/aeEF2vgVuObfckX1No4j/VH13ByoSzT1HPgvetFgwtzT1wIMDZlL
	 J2etH6WMHk26A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC22380A96F;
	Sun,  5 Jan 2025 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: libwx: fix firmware mailbox abnormal return
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173604182952.2530845.14741725018021165991.git-patchwork-notify@kernel.org>
Date: Sun, 05 Jan 2025 01:50:29 +0000
References: <20250103081013.1995939-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250103081013.1995939-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org, mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 16:10:13 +0800 you wrote:
> The existing SW-FW interaction flow on the driver is wrong. Follow this
> wrong flow, driver would never return error if there is a unknown command.
> Since firmware writes back 'firmware ready' and 'unknown command' in the
> mailbox message if there is an unknown command sent by driver. So reading
> 'firmware ready' does not timeout. Then driver would mistakenly believe
> that the interaction has completed successfully.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: libwx: fix firmware mailbox abnormal return
    https://git.kernel.org/netdev/net/c/8ce4f287524c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



