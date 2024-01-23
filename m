Return-Path: <netdev+bounces-65071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA73A839193
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642A128AFC9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA235FBA1;
	Tue, 23 Jan 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyooC02e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C95FB9F
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020830; cv=none; b=fSbNPMRcoZd6vYneuEnjdxoVAfIHFm4O50fxRRLWzEX+VcGtFLy43kPgcQ0D2d/f3tX+UnvwkClIdmSZH7PmB8Urz+u8NnF6QqHyQUdfb113bW4oIm5PuDZCJ3A4+1zYhP8TupV/46RxrS3YmEU4XLc1EMzXNAMQhhyEnzKot3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020830; c=relaxed/simple;
	bh=jxTu5Z/otgsgtCbht1dnELdw3VqyfpU0Eih1orrXcgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gSR9+L1OpkCQLP1LCPduzDv7Mn39KlNcH94YH/zWjIpSm0BgPf4A+UVCguoPFfUwLLveorb+CzkwPSQHiQRVSiHDobeOJjO28T9fEEZOaHn7qclZik1HwIpC6FbtKrAUdsp5IReMWgD6/SDJHQbh5G74LWL23B3G16AZS0bS0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyooC02e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 772A2C433A6;
	Tue, 23 Jan 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706020829;
	bh=jxTu5Z/otgsgtCbht1dnELdw3VqyfpU0Eih1orrXcgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JyooC02e9QHcVioi9YgZs7teDfeZrz8GttOUh6LmxhEw3pU3XsUA/iaefn8D9p+k0
	 FWC4sqgfn8F5jyfU6ZPEaNcLheslb1iKOLVDxTANRGiAQt/GZYsPvbINixQKMxQAnC
	 FXTPEVFM3WUjY8faHhPFmnoN3LIKVZALT8W7eG+ifxp3ebKA2k6+BMHZPZ0laRaYZZ
	 J0Jm/7e2hXyFMQqlyiuw18i6IhVB8JUsaAJKeXlJjS6JITTsej4lTh9v9optnX69Gz
	 j0khsfsDuteg6ULCAqUXa6Wn9dhI/dknYZpW/lL1GGEsdRkxWrSS3kDr+OEPHGnoY4
	 8FcbP+u3FrTqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60E16D8C982;
	Tue, 23 Jan 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9]  inet_diag: remove three mutexes in diag dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170602082939.8656.18071628062095024675.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 14:40:29 +0000
References: <20240122112603.3270097-1-edumazet@google.com>
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, kuniyu@amazon.com, kafai@fb.com, gnault@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 Jan 2024 11:25:54 +0000 you wrote:
> Surprisingly, inet_diag operations are serialized over a stack
> of three mutexes, giving legacy /proc based files an unfair
> advantage on modern hosts.
> 
> This series removes all of them, making inet_diag operations
> (eg iproute2/ss) fully parallel.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] sock_diag: annotate data-races around sock_diag_handlers[family]
    https://git.kernel.org/netdev/net-next/c/efd402537673
  - [net-next,2/9] inet_diag: annotate data-races around inet_diag_table[]
    https://git.kernel.org/netdev/net-next/c/e50e10ae5d81
  - [net-next,3/9] inet_diag: add module pointer to "struct inet_diag_handler"
    https://git.kernel.org/netdev/net-next/c/db5914695a84
  - [net-next,4/9] inet_diag: allow concurrent operations
    https://git.kernel.org/netdev/net-next/c/223f55196bbd
  - [net-next,5/9] sock_diag: add module pointer to "struct sock_diag_handler"
    https://git.kernel.org/netdev/net-next/c/114b4bb1cc19
  - [net-next,6/9] sock_diag: allow concurrent operations
    https://git.kernel.org/netdev/net-next/c/1d55a6974756
  - [net-next,7/9] sock_diag: allow concurrent operation in sock_diag_rcv_msg()
    https://git.kernel.org/netdev/net-next/c/86e8921df05c
  - [net-next,8/9] sock_diag: remove sock_diag_mutex
    https://git.kernel.org/netdev/net-next/c/f44e64990beb
  - [net-next,9/9] inet_diag: skip over empty buckets
    https://git.kernel.org/netdev/net-next/c/622a08e8de9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



