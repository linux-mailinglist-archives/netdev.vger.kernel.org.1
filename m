Return-Path: <netdev+bounces-230083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1CBE3CE4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30A81884988
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E52E6135;
	Thu, 16 Oct 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QueDoo6Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504D1D5CD9
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622626; cv=none; b=tuas/MhC8WEpqq3xMZwbnuLJkOqvugcpXY3xQSoMBDj4RqG/PkB47S0oAYj9HnQi+A5ed5dfkcLjg1lh37cs9z8Qf3k/8krGuQ/bGrWi5bKhr66nU8gz1OQgZGuA6YtZF+7JtrJv3JjihFxJo046SLoGOg5ZAwYx34A85jpkemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622626; c=relaxed/simple;
	bh=tgWyjDN8idpl+H0MCL3Bs9cXjUjwJgxwgtu6S0PJp+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uaV3+f2w+Qslup4Fj+wtBQhu+dVfO9f1r0ooPdJVytA9VHhS7t1TQIhYmOxHyRbYJNJR2NyyWf5uy8u3cdcCWWvth2ViCfuKJ4BvPAjJ/KNKaV0bthyYzru6XfNo/bjkugoZ3lEYppmRlOYdhfcYlG/6fqEqpeYT5MJIL/isaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QueDoo6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389E8C4CEF1;
	Thu, 16 Oct 2025 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760622626;
	bh=tgWyjDN8idpl+H0MCL3Bs9cXjUjwJgxwgtu6S0PJp+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QueDoo6QSddBdw+PaekYs/I1FQVEGit77r+BX8wGyuOX0t4can3h6yBJrJcdKDrvF
	 +dXzaTXMs3uvWvkm07cCYKnnIgcpSirqioy/TVp06s7ujlvzakXi1/bKKhzbthKx+U
	 HloirsEzpKOj2jhwIkjyRig68tL0inyShzTI0f9wQLDyJHKGAqxboG3QCi2dO5RZ8q
	 XfGQqBs7h/weGw1HwAygBwHItSsGvapirifHbvX/eQK3nVcd4zkknIG9rJ8XlYmKqf
	 hAdTJnpmk+QQPyWLNkWE1RKVDGM5WM47RUCk5EDEA/Kb1Zto8+ww5QPNkNWQGoRdh8
	 +8DX4+w8wUjkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC17383BA08;
	Thu, 16 Oct 2025 13:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] TXGBE feat new AML firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176062261050.1361509.17000287492387086672.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 13:50:10 +0000
References: <20251014061726.36660-1-jiawenwu@trustnetic.com>
In-Reply-To: <20251014061726.36660-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 rmk+kernel@armlinux.org.uk, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 14 Oct 2025 14:17:23 +0800 you wrote:
> The firmware of AML devices are redesigned to adapt to more PHY
> interfaces. Optimize the driver to be compatible with the new firmware.
> 
> ---
> v2:
> - Detail the commit logs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: txgbe: expend SW-FW mailbox buffer size to identify QSFP module
    https://git.kernel.org/netdev/net-next/c/af3fce9f1bb4
  - [net-next,v2,2/3] net: txgbe: optimize the flow to setup PHY for AML devices
    https://git.kernel.org/netdev/net-next/c/1f863ce5c712
  - [net-next,v2,3/3] net: txgbe: rename txgbe_get_phy_link()
    https://git.kernel.org/netdev/net-next/c/a058de9262f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



