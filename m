Return-Path: <netdev+bounces-115455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C468B946673
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9E71F21DFA
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5E917F7;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTIRpTmN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477E193;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645034; cv=none; b=pNwwDK2AL4xeX/3t4tLgIerJu1UGr5shgQt8CBnejqIRPNm7CL8YNVsigi00akL5urb4ZKdJ/cCKTngphwRga9AA++fFnFFoywrXytx4LL4KUXt81pct+RYd+isX5MhP6ZeeBVgRx2rWfKGld1jdqF1T/t1RlHRc6S1m9yhFJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645034; c=relaxed/simple;
	bh=dvcv47e/mnw1odLhgf9G+DkKF8UhBC6d70AzDqoco2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m2wjkkwfDZiaNXY5SEgOWvVo/2ctpyF7Ax9ZRoet100M8FxvsqU7ZR8DK9B4pfzQcOrB/no3iBI7Lq4oNP2WMPN/e3mE7e/+/l/O0FXwUkFr6YXxB/UZ5o5DTLzG+qyI4J25vLPfY1K6drEDmjqUkLWOqQW2Cp7CGSgBBlSDtvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTIRpTmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 513AAC4AF0E;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722645034;
	bh=dvcv47e/mnw1odLhgf9G+DkKF8UhBC6d70AzDqoco2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FTIRpTmN1eN5RdDMIXZ1cdXRhSYsWp70zOBtwazRu5ttmAxr7TeH9JnHQZPjS8Nc/
	 uL2EbcQINbUkdO8pkEDn7sx1jLnrXnhXM8mSJ3Er59eFz6sB5+tzt3w7qKZVWRpUXB
	 TOMXJTnULR8VSDt9LJEcpuclsvAPE6yzgG6kLBPA5ozr7zw3sUpSGBlJ4Iq4h4xcVF
	 W7FAvZxwt2A9ANa8HUUYnQoOj8ZoEdX/y+f8Dyo5B6Xkmo0E9DAjJ6j29seOosvAto
	 EdYPWSjXNk18e2WiXfBjLTH1Ukat7Bg/6za7zLUsR4RXK8YeMUCsM8rTu/fl7pA1qv
	 cR47B0l6iG+Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DC87C4333D;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: core: annotate socks of struct sock_reuseport with
 __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264503424.23714.10623886159740508620.git-patchwork-notify@kernel.org>
Date: Sat, 03 Aug 2024 00:30:34 +0000
References: <20240801142311.42837-1-dmantipov@yandex.ru>
In-Reply-To: <20240801142311.42837-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: kuba@kernel.org, pabeni@redhat.com, gustavo@embeddedor.com,
 kuniyu@amazon.com, kees@kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Aug 2024 17:23:11 +0300 you wrote:
> According to '__reuseport_alloc()', annotate flexible array member
> 'sock' of 'struct sock_reuseport' with '__counted_by()' and use
> convenient 'struct_size()' to simplify the math used in 'kzalloc()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v3: one more style nit (Jakub)
>     https://lore.kernel.org/netdev/20240731165029.5f4b4e60@kernel.org
> v2: style (Jakub), title and commit message (Gustavo) adjustments
>     https://lore.kernel.org/netdev/20240730170142.32a6e9aa@kernel.org
>     https://lore.kernel.org/netdev/c815078e-67f9-4235-b66c-29f8bdd1a9e0@embeddedor.com
> 
> [...]

Here is the summary with links:
  - [v3] net: core: annotate socks of struct sock_reuseport with __counted_by
    https://git.kernel.org/netdev/net-next/c/f94074687d05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



