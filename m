Return-Path: <netdev+bounces-208873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF8B0D739
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DC4189C787
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4B2E1C50;
	Tue, 22 Jul 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKkiBw6n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FA21FF28;
	Tue, 22 Jul 2025 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753179592; cv=none; b=ikpU5n7w+5UooYriVjdQCnqfKWOmWje1sq4efm9lujtmh9Huo/PjnAqXqOlASofk0JRCR5KNAqopwu56gw4oHgZ6tPddmMlTFxycro3nOCagp7K7wbiPyU/+AGmQRrdoitO74WAtxXkGgpU4mG/qdVcehXFnRC0yMyQjQDozSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753179592; c=relaxed/simple;
	bh=N4lta+iRaP8HTgkPuXx4HSQLcEbrftCLPjAmWO9W3n8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DpCqTdGgLSwtvcFT+RhfoNMQu4dEokOxrA4aMn1zC8Ef/PmC0FT89ttwwkHuLIK+aQtoOXkFxr14hjlJbJ4TOKxG5qMtGPWAsMZ+ZCPA0MX7mbA2ZXf5ZbSNsB0kHnfjGw7JH4UqNmFL39VNeGovHSHxFTBTRSrKV2P9Q1mLX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKkiBw6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC99C4CEEB;
	Tue, 22 Jul 2025 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753179591;
	bh=N4lta+iRaP8HTgkPuXx4HSQLcEbrftCLPjAmWO9W3n8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QKkiBw6nyhMbXAuV0PAc++rZ/mvGLBIon3w/naAQA0BxwOw3J6r98JI8yjKFm6URl
	 qOQ2QJElV2+i/ap7jIGJh7KaS/77/TvMi3b7ghbIOvZI/O7LV5j7yh6+dj/XljSpZq
	 /iOpusMMaarWlpxkUYCwFs2LYAi5bgo4hbxdjBvNKWJ2RV+qOA75onBy00Pt6TQ6zL
	 znLROzZfHaHmVYThmPhV2LeJ08JGHBE2+UUjxv7VqqN7BY7SyoqDdHhQWZ5ZHZ8iEt
	 uTk5yQGFsh3s6oWvjycthBbyHxkGHfLKgusmGzBU1fFy9vUJcOZ1oBBZ9IS8SsvNyS
	 qbzo9OPZjuf2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1C383BF5D;
	Tue, 22 Jul 2025 10:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip6_gre: Factor out common ip6gre tunnel match
 into
 helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175317961005.748884.3426552031363042058.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 10:20:10 +0000
References: <20250719081551.963670-1-yuehaibing@huawei.com>
In-Reply-To: <20250719081551.963670-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 19 Jul 2025 16:15:51 +0800 you wrote:
> Extract common ip6gre tunnel match from ip6gre_tunnel_lookup() into new
> helper function ip6gre_tunnel_match() to reduces code duplication.
> 
> No functional change intended.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ip6_gre: Factor out common ip6gre tunnel match into helper
    https://git.kernel.org/netdev/net-next/c/db8a5149fa36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



