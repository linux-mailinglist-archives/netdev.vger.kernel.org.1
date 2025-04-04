Return-Path: <netdev+bounces-179318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0AA7BFAC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A37717B4CC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 14:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AC71F4282;
	Fri,  4 Apr 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afcHv0pI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59A1F4196;
	Fri,  4 Apr 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777599; cv=none; b=g7QmahYnn5QlMr6rVK6hLFlDgo0LyeC/4wrGXQEHPTt+JDCG6JdMlVo1l0PBo0B8L13upjodvdrmWfZoXlyEG6/O+9+GPeaWazA9azj2+hJMaHCfxRwi7evpXjjtFiPN7Yidm7iRc4b6SlsmvGWyg8TJy4NVjdESKLKaFmsIQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777599; c=relaxed/simple;
	bh=iXNWa94UwMAcNEi/QIGmOJRBOrQZ8V7nXBmtotp1tL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zqiz+J6+c+3MYXc8aihDM0Yb/mTDz+FAVH7v59OHrzcQmTWobYjYRwgVXQS0qsmWAqX9dQ3+tilVXxQvsksjiYqoX3lZ63IjRwSa4hzeDf9jsosAaP1DidyhwHHTpvz2LEj/ae1IBrDJrPFrhowW6pr9qy24Kdn1kdKbcq1LJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afcHv0pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5ACC4CEDD;
	Fri,  4 Apr 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743777599;
	bh=iXNWa94UwMAcNEi/QIGmOJRBOrQZ8V7nXBmtotp1tL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=afcHv0pIe8QLXIn/bsBu0d+f5xduxXpjHoER2qO8uwkePLnpp3iP2WhY1qlyjpZiM
	 SUSD4ziKCRusDiVzOKbex1VMdTAcYO5uZ7G7yERFHzFgtCqDBMgXRrnXopZq6P2Ef6
	 IpLD/SI7lwHIn2yRwSgCk4PixUlt8aFFfZ7sIihWepV3S6A4yGviAPKdBATOtYXboa
	 /iAcqD1w95R6Hof0AP8g0mQrGmVxiSaPl+TY58jbw3VhmvpvNFpMVr3L2jHzcFMbV3
	 7hXEyTJrAtvo27w9XUMFrL++QbxxJkU5hge2mFsFA8YVSAv8eEgrc/LBUukRQgk0hx
	 KnabVfmeG7xmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE13822D28;
	Fri,  4 Apr 2025 14:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] arcnet: Add NULL check in com20020pci_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377763574.3283451.6914615027976743568.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 14:40:35 +0000
References: <20250402135036.44697-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20250402135036.44697-1-bsdhenrymartin@gmail.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 21:50:36 +0800 you wrote:
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> com20020pci_probe() does not check for this case, which results in a
> NULL pointer dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue and ensure
> no resources are left allocated.
> 
> [...]

Here is the summary with links:
  - [v3] arcnet: Add NULL check in com20020pci_probe()
    https://git.kernel.org/netdev/net/c/fda8c491db2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



