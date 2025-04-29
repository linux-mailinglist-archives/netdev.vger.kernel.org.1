Return-Path: <netdev+bounces-186816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4AAA1A66
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3F11C01AB2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C18255228;
	Tue, 29 Apr 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4rbV6u0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3202550D7
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950799; cv=none; b=UCVTKHMOMlT1/+EJl90tasVldweN+N3tZhXG8uw4ikvLsNnzBiGDzWoRNkRj3ETu7v+oXr+F5kC83U/K47gbIbskaq/Qu+5hE5nQIjQb3bGqZHUEMEDk5E1LKbtuR7mVTVX9ODI706Z9jAVql003bWv3+lzu7XvB0onmnUnTjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950799; c=relaxed/simple;
	bh=/0I130ApBFerRdSFLCFarP7NvbAMLnJTGxTbfxj92Ew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUh0965LZxhltyKiI1Pp8upQWFqm2RCpIOVWx53O1kWSoGCz98YVudem81f7ExLovLBbZoLfjw+4OQIsbgv/ruiRkt09I3+3Ww5vMOpJziKUFrPL3s060kv+xs2yHVbYbzKoglVvYKA6iN6fP4AV2mLsn6BcOaPhfYcOiKo3eOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4rbV6u0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4653BC4CEE3;
	Tue, 29 Apr 2025 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950799;
	bh=/0I130ApBFerRdSFLCFarP7NvbAMLnJTGxTbfxj92Ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K4rbV6u0oHj2awlm9E3lHz3b3IC/jsTe047niglg5WjW4aY/3qceSh0ShUVnpET5B
	 D36QuSLs/345txSjhwrG+8DFe299iBmc00iwi9APEJQwDwDU3rODyuKW9AMyTqUxdz
	 fBrN3Acq9fnySV4K9tiJnOsUOG7ONWyj9gT3p77aTSd6ofVYEko4G24dHwzhcd4s7C
	 JpKcnm7n7LMRmqNwaHDyfqcds2ooWiCoMcpzuXpPDQ2T1QfXi+IXFb34WIVTjI1OeG
	 c3R5kNYgMnqFj/7bpLzIIU2iqSgNKa/lfD5e+HNLkqf+sJDAJqRYQgIe0GC5SHko4o
	 lu2mLTm0otVdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711E63822D4C;
	Tue, 29 Apr 2025 18:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/2] io_uring/zcrx: selftests: more cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595083798.1759531.8429412307722121984.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 18:20:37 +0000
References: <20250426195525.1906774-1-dw@davidwei.uk>
In-Reply-To: <20250426195525.1906774-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Apr 2025 12:55:23 -0700 you wrote:
> Patch 1 use rand_port() instead of hard coding port 9999. Patch 2 parses
> JSON from ethtool -g instead of string.
> 
> David Wei (2):
>   io_uring/zcrx: selftests: use rand_port
>   io_uring/zcrx: selftests: parse json from ethtool -g
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/2] io_uring/zcrx: selftests: use rand_port()
    https://git.kernel.org/netdev/net-next/c/187e0216366f
  - [net-next,v1,2/2] io_uring/zcrx: selftests: parse json from ethtool -g
    https://git.kernel.org/netdev/net-next/c/6fbb4d3f7262

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



