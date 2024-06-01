Return-Path: <netdev+bounces-99961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3748D72C9
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7FE1F215F1
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD524F215;
	Sat,  1 Jun 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhmdO+Ko"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE6482D7
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717285232; cv=none; b=BozK6EUtsPF2gNBiSRDtHfCjJWcceN7RBgXnSmSN6EgQ1iAO9MiHrZ2wK8Sh/zuc1MR5Fm/btUkeLRHxsfsitib2dz9t9AWza26UWWM+Mqtl8hDeim4dS2kd4SeKQSVzd0ee6WoZH831kvbKU+uI+MuaLmLWazHDrJT7RoswSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717285232; c=relaxed/simple;
	bh=CbstIZGUuYmfs/ctMt0ctXPWJdwCW8ukWTlRuVVqoh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bOT+yemrOH+aq6hWVZZrbhCFAK9qfUkBGqwsgNiGd19hszFEITV4n9yXPlSyJ8LOHxuoHJfU3kA2V+r3MPNRg/nSVoiLW1iV72ISr1tr2Od3HN6Sx57uHpFNIMFFhGxhCxqs0Fzs12GejCSiYJS9IVPhgpqStlyZhmZIfTZCrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhmdO+Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89510C4AF0F;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717285232;
	bh=CbstIZGUuYmfs/ctMt0ctXPWJdwCW8ukWTlRuVVqoh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KhmdO+KoMV5M3bNgZsUOREuKcx9bThCTAk1aWmUUW8FmE3MsgzB1WNKWCQmTU/F28
	 r6zKMDhpRrnPt+Blb7mhAPSTuI1TJmJzaX6axTxsVMiQ15Mt09NGx5hoGAh5cVYUuM
	 4yASwfO+Xexu7ZL2LOjORdwwIAUUi3FUpj7iu+jSatqTg9E6K1dDQYoXR99sB55ENx
	 VQr9rOh2DjaU3QpDfejpqKSxHYsv6npgkqoxeGcoTvc4KBC2Og2itZTqaHco+CM7lk
	 s0P0+peBJXpbilPGFVbP/2eD/BltCCs3N0yBROMbUfTG4dddj00loQQ+T+D5YmZnv1
	 fXnx5moMwM6uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EE1DC4936D;
	Sat,  1 Jun 2024 23:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] af_unix: Remove dead code in
 unix_stream_read_generic().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728523251.22535.15178017480909563092.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:40:32 +0000
References: <20240529144648.68591-1-kuniyu@amazon.com>
In-Reply-To: <20240529144648.68591-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 May 2024 07:46:48 -0700 you wrote:
> When splice() support was added in commit 2b514574f7e8 ("net:
> af_unix: implement splice for stream af_unix sockets"), we had
> to release unix_sk(sk)->readlock (current iolock) before calling
> splice_to_pipe().
> 
> Due to the unlock, commit 73ed5d25dce0 ("af-unix: fix use-after-free
> with concurrent readers while splicing") added a safeguard in
> unix_stream_read_generic(); we had to bump the skb refcount before
> calling ->recv_actor() and then check if the skb was consumed by a
> concurrent reader.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] af_unix: Remove dead code in unix_stream_read_generic().
    https://git.kernel.org/netdev/net-next/c/b5c089880723

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



