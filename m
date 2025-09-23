Return-Path: <netdev+bounces-225517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF6B94FF9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3293AC942
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CCC31D36B;
	Tue, 23 Sep 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWXKGnFd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E432D6E76
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616219; cv=none; b=EChg5PrDmVHYeGSpYNCsrEmepTQiuA/28RiFbaHS28nBgLur8+psAqN15eMdwcJFyExLNw2iGjqJJAzjr85+hvEQ7YEZPAuNrOic796PYPMcjaF49lLu7EO1M/Y+73jIvoYVY39cWBh7Ie2MfzUGwoHQy2Dmp6hyR3/SVgND/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616219; c=relaxed/simple;
	bh=g2MbcZk24K4lUWLpBrwSeztPM2dkso/xozfF/Nh6uM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z6d12LQUPaa65pJwqZarM1GoFBNftpeE1IOdS20ATDIftmzcb1DXmb+BSpibnXC13XjHfZRiMyWtj7GUkd+/8eDZKUwx4vYmA/1Mlj5JU7JIuFKtB1VVoIc6AHixWL6LFcHu/Z4wh1hQEERvhY66hXEwiMECUShDz1AX2Lg/sws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWXKGnFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6800CC4CEF5;
	Tue, 23 Sep 2025 08:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616218;
	bh=g2MbcZk24K4lUWLpBrwSeztPM2dkso/xozfF/Nh6uM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HWXKGnFde3Ndigw7D8oLaoTW4P23GGqa6o60N2icUS3r/iAKx9iX/G1HjIs1Bp1Co
	 AaAhNTxGJnfH7RxIZMP5Ruptr+GhT2eV55co3axclI/LGI3/nzIus31IdMHe0gNNkH
	 F7LSgSEHng1huqXz5LNNBd87jxi0zwGvphM4sRrxEUkhmO7cU8XRLgR3tseSVa65x0
	 1OnBnXYH8qCq/16gbqTeNj5JjqtQqXUDcQkquToiPWLxp5vRSePhc1lfB0pm7fJbRk
	 yN4OhpAtKfHI/rBfuiLemnBgDtxvOuLXSCNEjAiOio0e/QXkiMs62yZFyUrrTo8bMD
	 jRJfvBIRFdTbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0239D0C20;
	Tue, 23 Sep 2025 08:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] tcp: Update bind bucket state on port
 release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175861621549.1332476.3068231637451205538.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 08:30:15 +0000
References: 
 <20250917-update-bind-bucket-state-on-unhash-v5-0-57168b661b47@cloudflare.com>
In-Reply-To: 
 <20250917-update-bind-bucket-state-on-unhash-v5-0-57168b661b47@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuniyu@google.com, ncardwell@google.com, pabeni@redhat.com,
 kernel-team@cloudflare.com, lvalentine@cloudflare.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Sep 2025 15:22:03 +0200 you wrote:
> TL;DR
> -----
> 
> This is another take on addressing the issue we already raised earlier [1].
> 
> This time around, instead of trying to relax the bind-conflict checks in
> connect(), we make an attempt to fix the tcp bind bucket state accounting.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] tcp: Update bind bucket state on port release
    https://git.kernel.org/netdev/net-next/c/d57f4b874946
  - [net-next,v5,2/2] selftests/net: Test tcp port reuse after unbinding a socket
    https://git.kernel.org/netdev/net-next/c/8a8241cdaa34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



