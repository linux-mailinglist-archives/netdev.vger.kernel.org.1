Return-Path: <netdev+bounces-220169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E5B44965
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8760A3A3A42
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CA2E8B73;
	Thu,  4 Sep 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLXVsbDn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B028C5B8;
	Thu,  4 Sep 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024401; cv=none; b=LMlnszlQY6PJDcme4BnTiNmAPrH6UQGpUIVOcRyZgCTmmG1C4KDpM7dZiKfolosTbMPOWG01hRS03/va9aNcujxjM+AzEx4TJvVWCMqYDp/VUuYt6RLhO93bv+CDdTOLZyfuV9vyJxDsb5+m1pT78RqF/ZeJWS7zVe62qnAqW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024401; c=relaxed/simple;
	bh=8+7EoiLf/43iRVtI/oWnMiMUJHq6j/EVSSsjKcIqSE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTkl9DkQtiNrOv0c9qP61qQ7EKSI0Onj+a+8QQ/Avum28ug2BILl6oKQrzoUVUotGP+tw6NTAn4MAYcvvRgTT2YznhZGfgp9049plIrFLMrATqJ6afENAKEUc+bwAEcEjYz0skvxX9FECls73DW/bqfgpNiyl7TDwq1U2n3y3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLXVsbDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01953C4CEF0;
	Thu,  4 Sep 2025 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757024401;
	bh=8+7EoiLf/43iRVtI/oWnMiMUJHq6j/EVSSsjKcIqSE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QLXVsbDn/f50eSGH/tzeWT2lNvEzEIONGmq14wULZynp+ozEeC6lV9Izmm9Bi+Lcq
	 Hu7G9T5eEornyavggeAAbBX8N18b7dzNsl5q2latvPaG0E1C8eL83ny2BzdYPQ8ei2
	 4TdYum/5FhWnZXxcLP2bFR/2EdBxMLVEUEOgndj97sC3gutx+U0h4dN5pG7wEl11xk
	 RKtWi7GdMEirey/OLr/DnPzE8w/XfzHEkm/HiusQqOyvM1AoXwbtFKCVpf0FfQ8i+e
	 zEtg1Z+mSEVXlaDXt8Y3CTN2pTDCH4td7JU/9sZqMnY7qvJyEtqL5ySHrlMeyQMsvd
	 7XQfBW3aCnYVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0A383BF69;
	Thu,  4 Sep 2025 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: libwx: fix to enable RSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175702440575.1969494.12197743418210295816.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 22:20:05 +0000
References: <A3B7449A08A044D0+20250904024322.87145-1-jiawenwu@trustnetic.com>
In-Reply-To: <A3B7449A08A044D0+20250904024322.87145-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Sep 2025 10:43:22 +0800 you wrote:
> Now when SRIOV is enabled, PF with multiple queues can only receive
> all packets on queue 0. This is caused by an incorrect flag judgement,
> which prevents RSS from being enabled.
> 
> In fact, RSS is supported for the functions when SRIOV is enabled.
> Remove the flag judgement to fix it.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: libwx: fix to enable RSS
    https://git.kernel.org/netdev/net/c/157cf360c4a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



