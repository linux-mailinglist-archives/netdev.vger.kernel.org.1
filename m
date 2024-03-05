Return-Path: <netdev+bounces-77499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C35871F79
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C8B22CDC
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA548563A;
	Tue,  5 Mar 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5b8nfyN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584958AB6
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643031; cv=none; b=Ck8aUbKoOK0+hZFJbYdBEFWyjY8FEG5zJKpS42OmnwFRixamU3ex58OynR9o5ZljG6THuY8YHBFTilH8JGlyFxarI6ncZWsIFeTMN49IczzVatExKxnSbEa74Av4E85d8ojHfcKTNu/+YsQ5ga6413AJCtdGKrrL/1UTthDFsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643031; c=relaxed/simple;
	bh=YwI5aym865kGdrXZKdKUJgEWsEfkRO3eIsQQOg2CvMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mUu1WSc1jZpDoRUAuzWuCTTOxHDdALMt163kbnyvkBAp4XO1ls+yLHNhFDb1EVEuwrJatW0e/0Eiy1hqdmhA1zZikUQ0G9sRxRXJ7bmxh1uQaqjHtdPb3nbk9Gyx5ywGhVu4kC/ILeiZdaCoeHXVt6N/FtFn5dxarGO+8EJOy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5b8nfyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3575BC43390;
	Tue,  5 Mar 2024 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709643031;
	bh=YwI5aym865kGdrXZKdKUJgEWsEfkRO3eIsQQOg2CvMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C5b8nfyNnlyGMopVXfC1PAKqUpz4W37CPo1TjL52mXGLBG8O7AKeEZahfAt/SkSt9
	 fgwPtRpaNh7lyeOkB9xDwJg1BnCzKfENSwD1FMca1dHQbxdCOFUgBnZD3hCQjpMvov
	 fCuK/pGx3h1ZobFNA9Q3gpIlJWVIhFtpYLrjc/VbMxFAdyu5XO22e34M9FQVxHH4UX
	 MqLGXORPb3peNs2wyqrDRmAL/VW7ZiUZ6aDh631+SxuHv6mhTBdDscLa+daicuX/7y
	 vuI+HBkvmaqbYOGxz/h41sD0UVRqj4Av+tJn1L6PI9nzrdGngqZeRrkPzGkszn1FWR
	 IQGQNH2ft6QgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A288D88F80;
	Tue,  5 Mar 2024 12:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: gro: cleanups and fast path refinement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170964303110.9176.6238299590966925699.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 12:50:31 +0000
References: <20240301193740.3436871-1-edumazet@google.com>
In-Reply-To: <20240301193740.3436871-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 richardbgobert@gmail.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Mar 2024 19:37:36 +0000 you wrote:
> Current GRO stack has a 'fast path' for a subset of drivers,
> users of napi_frags_skb().
> 
> With TCP zerocopy/direct uses, header split at receive is becoming
> more important, and GRO fast path is disabled.
> 
> This series makes GRO (a bit) more efficient for almost all use cases.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: gro: rename skb_gro_header_hard()
    https://git.kernel.org/netdev/net-next/c/93e16ea025d2
  - [net-next,2/4] net: gro: change skb_gro_network_header()
    https://git.kernel.org/netdev/net-next/c/bd56a29c7a4e
  - [net-next,3/4] net: gro: enable fast path for more cases
    https://git.kernel.org/netdev/net-next/c/c7583e9f768e
  - [net-next,4/4] tcp: gro: micro optimizations in tcp[4]_gro_complete()
    https://git.kernel.org/netdev/net-next/c/8f78010b701d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



