Return-Path: <netdev+bounces-220198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D6B44B90
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFCE1C81E44
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5791FF1A1;
	Fri,  5 Sep 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlZUBVD4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B314E2F2
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038811; cv=none; b=HI3u+aNBhvJyrDW1+t7/TBQSknbnwE+4ZVZ+AECKfflMDY/OqUz+Ed5iiuOU4458QAD+PNdWnq2AKOdfylhIvMB6P0sObnP32t4HoVa7gWSLFYEj2H18R8+TTwAr+hC4gRUP+Nas9qdgPULrl8qs3I220A7tNeDh7sSusmEgAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038811; c=relaxed/simple;
	bh=tcc2kBp8KJiLKZghvxBSoNigUkyN6m4IGtCt4gfs53o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z1JKnnGg3P0d6FDixLAq80imNvMnxbQpfvwQKYbj/581IEDJ9xgdvmTx1nZy9CVOPi4nT2WBSLT/Og4G5svKnRKQ0iSUWGCABzaB49BsKLSCDxXhyCCg+OkzId8CJ2oL4lcxPOJNn9C08YNrCxSoHCRyUyT7802PvQtoFds2xQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlZUBVD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B50C4CEF0;
	Fri,  5 Sep 2025 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757038811;
	bh=tcc2kBp8KJiLKZghvxBSoNigUkyN6m4IGtCt4gfs53o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qlZUBVD4cUYU099KYHv1Fk0nVD8puYDajTkzVw9FpORz9kjzX71K30+qeKIBKJ3bw
	 2KCPK2m1LBfzxb7Wi5eEPFdzcUbn3mJuujrHVAuI9a9Ga/pdCSwijnx5T5e2N7TYit
	 ++yshPCbNIHjgGh7FQSQ2M+CPGluZNQvXCxTkNaeh7mUM/Z7Anhdd7rvLkpdLXPaDG
	 0SHuA2q0CgitVSpGaKg/goXFKC64MgZYIq5I2k8I/C5qxoQFoNAbSQ236FJRtrhOpy
	 0x2VounlTPvvkFEm85o1VUsUFwKY1WLhTwfdSzWeCLNN0U0YEA0VIl9lPmFaziG/mT
	 U10kaMBDxzMUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C01383BF69;
	Fri,  5 Sep 2025 02:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tcp: __tcp_close() changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175703881570.2010527.15438685119496692902.git-patchwork-notify@kernel.org>
Date: Fri, 05 Sep 2025 02:20:15 +0000
References: <20250903084720.1168904-1-edumazet@google.com>
In-Reply-To: <20250903084720.1168904-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 08:47:17 +0000 you wrote:
> First patch fixes a rare bug.
> 
> Second patch adds a corresponding packetdrill test.
> 
> Third patch is a small optimization.
> 
> Eric Dumazet (3):
>   tcp: fix __tcp_close() to only send RST when required
>   selftests/net: packetdrill: add tcp_close_no_rst.pkt
>   tcp: use tcp_eat_recv_skb in __tcp_close()
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tcp: fix __tcp_close() to only send RST when required
    https://git.kernel.org/netdev/net-next/c/5f9238530970
  - [net-next,2/3] selftests/net: packetdrill: add tcp_close_no_rst.pkt
    https://git.kernel.org/netdev/net-next/c/8bc316cf3a9e
  - [net-next,3/3] tcp: use tcp_eat_recv_skb in __tcp_close()
    https://git.kernel.org/netdev/net-next/c/b13592d20b21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



