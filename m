Return-Path: <netdev+bounces-163749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A5A2B76B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EB11885C60
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B4200CD;
	Fri,  7 Feb 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6VupFm7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073EBA50
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890010; cv=none; b=NblKOJJRMcE9juwV+bgYV1o7PYxPRVtJxVwyF2yWY9LTKrDCbE+608eUzV8vSymspqsKrFf0HZuAcvOMNNbZt59zXE45CqHRnAJL179hbC++9sPfp8xNKzkQbBKtjIUckgN96A+aS/nFRFYRsMZp5fuvRG+lOxqCxA/VA7BEqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890010; c=relaxed/simple;
	bh=ARX2lG3AcAie0/Od6DbXiEivD6ZmPS2KmNPTsbz22iI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N3fpAHN5QEgnrmG/qp8Gr1CuKPVY+i711mlmHPmgGduUnrWfJwEb++0mCOXCiIg6Bn5YTc+GgEzm8JFNZVZGJmakpxhaLt2gCtGOsU+l/C9DIDOyM09sMERPlDpr+d3aWhw+DJILRBdhpAr4c9Bk3X1AUibASc0S68dUEy4b/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6VupFm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5438C4CEDD;
	Fri,  7 Feb 2025 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738890009;
	bh=ARX2lG3AcAie0/Od6DbXiEivD6ZmPS2KmNPTsbz22iI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f6VupFm7hxWjR06EGUje74vdXglWY3n69kVb8QXaGRgqjm0a/MWL0kTkHbxqmRf5k
	 bZXrTIG73Z45VMOYXBxLz4GXwpSRj6h5kEEXzMXt0ZI4UuZxuAY3Hl1gSyg9HQtX+t
	 d+t58UZdggIVQCgDS4ZKhxpxy2K+3CxvZTxxXrDUnA+LM+wrxnbhvm+x/5Ib3Mnvjl
	 wB997B22eOXz4faQzKGRBC18foOoYnLM/eFGLW+2/5naneQelBlN8sWBmOTUIb4LqG
	 VUqKqMohUt/k43r58XMhJzJPzYOIoCIb6Q0ilePHdnrM0OMJlv9X8+itW75jhTdktq
	 KzhksHWLcqhSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4BD380AADE;
	Fri,  7 Feb 2025 01:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173889003753.1718886.8005844111195907451.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 01:00:37 +0000
References: <20250204215622.695511-1-dw@davidwei.uk>
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, asml.silence@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 dsahern@kernel.org, almasrymina@google.com, stfomichev@gmail.com,
 jdamato@fastly.com, pctammela@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Feb 2025 13:56:11 -0800 you wrote:
> This patchset contains net/ patches needed by a new io_uring request
> implementing zero copy rx into userspace pages, eliminating a kernel
> to user copy.
> 
> We configure a page pool that a driver uses to fill a hw rx queue to
> hand out user pages instead of kernel pages. Any data that ends up
> hitting this hw rx queue will thus be dma'd into userspace memory
> directly, without needing to be bounced through kernel memory. 'Reading'
> data out of a socket instead becomes a _notification_ mechanism, where
> the kernel tells userspace where the data is. The overall approach is
> similar to the devmem TCP proposal.
> 
> [...]

Here is the summary with links:
  - [net-next,v13,01/10] net: page_pool: don't cast mp param to devmem
    https://git.kernel.org/netdev/net-next/c/8d522566ae9c
  - [net-next,v13,02/10] net: prefix devmem specific helpers
    https://git.kernel.org/netdev/net-next/c/297d389e9e5b
  - [net-next,v13,03/10] net: generalise net_iov chunk owners
    https://git.kernel.org/netdev/net-next/c/7d60fa9e1ab1
  - [net-next,v13,04/10] net: page_pool: create hooks for custom memory providers
    https://git.kernel.org/netdev/net-next/c/57afb4830157
  - [net-next,v13,05/10] netdev: add io_uring memory provider info
    https://git.kernel.org/netdev/net-next/c/dcc0113acd3b
  - [net-next,v13,06/10] net: page_pool: add callback for mp info printing
    https://git.kernel.org/netdev/net-next/c/2508a46f920a
  - [net-next,v13,07/10] net: page_pool: add a mp hook to unregister_netdevice*
    https://git.kernel.org/netdev/net-next/c/f8350a4358fc
  - [net-next,v13,08/10] net: prepare for non devmem TCP memory providers
    https://git.kernel.org/netdev/net-next/c/69e39537b662
  - [net-next,v13,09/10] net: page_pool: add memory provider helpers
    https://git.kernel.org/netdev/net-next/c/56102c013fa7
  - [net-next,v13,10/10] net: add helpers for setting a memory provider on an rx queue
    https://git.kernel.org/netdev/net-next/c/6e18ed929d3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



