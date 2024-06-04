Return-Path: <netdev+bounces-100546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC038FB128
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972621F22A92
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83AA145343;
	Tue,  4 Jun 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyDqI2nM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5661442E3;
	Tue,  4 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500631; cv=none; b=nOxvMPXwsvYDeEmDrMCm93LxW3+8HWXXmstSw3lFAEB4bcAZ4hdKRr3OasyTef2V+14kXbURCUniUjtJpNgFDVhgeYJDrGTxKkF8NeOMT5QW4slb9ZR74oXxTnbtK5y/vgOr4bfLHZCCXDqIqLLB3XEQ7BIZQDrHxydugRRYrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500631; c=relaxed/simple;
	bh=wnPcpCiwYuJB7xUl04rFUO/ubRVn7YZK2/gMWkW9BcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qigoq51RlQ/365gNolXVbPdwAraSFNIfQAvd5Qc80Pt/EqFFD9ddwjVbGlwvTZtFAwT7WhrdeZ22Bw8xwja6usnZGIsxEGKvXtDvdw3W25oRdEs2JC+MWvnRWoG0W2zyWkygqs6yP+6MF9OV2MMvck9uYUvthXp0pEG4lrBJWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyDqI2nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62657C3277B;
	Tue,  4 Jun 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717500630;
	bh=wnPcpCiwYuJB7xUl04rFUO/ubRVn7YZK2/gMWkW9BcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nyDqI2nMvMFveZZfpCTZu1AXUT47TsUedrdNGqoZ3DbCZGk0bDfY0fETJbnwhC1aD
	 86GK/4BjOaO8zP/Dxu5j+4ifZIpJfpjYF9riogcK5/ydkBw42Dhc1E3G47WZb24KT2
	 Dr+BSZURU7siH0l0sYqEfist+YEoillL+6kKfmdVZv/4h3VBtkGQbZGgsCeKu3gPsM
	 Fc1/vfmbjXHQ3ozOSgMcZA05jRhbNNRPeHWnY4U86ZGHPuQaDnsQ/1hRj5VAD0jGHm
	 lYoH5LYsyWSo+s0aMs7AvTrxxjoTYzppJZyKRWMt8yJKBHBdyx0LeX5O44PoIbl/lj
	 Ac3oH7JCiPTNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 510D5C43617;
	Tue,  4 Jun 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tcp: refactor skb_cmp_decrypted() checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171750063032.8045.5135732857456695804.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 11:30:30 +0000
References: <20240530233616.85897-1-kuba@kernel.org>
In-Reply-To: <20240530233616.85897-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, borisp@nvidia.com, willemdebruijn.kernel@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 30 May 2024 16:36:13 -0700 you wrote:
> Refactor the input patch coalescing checks and wrap "EOR forcing"
> logic into a helper. This will hopefully make the code easier to
> follow. While at it throw some DEBUG_NET checks into skb_shift().
> 
> Jakub Kicinski (3):
>   tcp: wrap mptcp and decrypted checks into tcp_skb_can_collapse_rx()
>   tcp: add a helper for setting EOR on tail skb
>   net: skb: add compatibility warnings to skb_shift()
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tcp: wrap mptcp and decrypted checks into tcp_skb_can_collapse_rx()
    https://git.kernel.org/netdev/net-next/c/071115301838
  - [net-next,2/3] tcp: add a helper for setting EOR on tail skb
    https://git.kernel.org/netdev/net-next/c/1be68a87ab33
  - [net-next,3/3] net: skb: add compatibility warnings to skb_shift()
    https://git.kernel.org/netdev/net-next/c/99b8add01f98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



