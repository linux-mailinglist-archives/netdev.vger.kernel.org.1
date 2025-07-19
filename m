Return-Path: <netdev+bounces-208279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FDB0ACB1
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C69AC0F0B
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110848C0B;
	Sat, 19 Jul 2025 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5YXJy7T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6379DA;
	Sat, 19 Jul 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883789; cv=none; b=aJQ3RbBFxmuX1z82P2eLuCPuDZ9albrNGU/z0Agzsxopp17B97x6zdzSe3JKbWl/CFiH1Ea6bpL0wY5H/DOnkpzlThXD7c8edlmdy7oj1236DQaSRrGUpYiD/7fDW4Xa7PNYufi27Bq75CxMczoD2epheqHvZ2/cU1E3VrunoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883789; c=relaxed/simple;
	bh=L86YVyx0apxTgB24V2M98O9bhmi45r78/Kb29rRjzuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mzixdZXEBqD/nj1/MuRaGNtDyIUM90ONJmMTSw2kchnjdm3dq1VNm+DrXoBjjNAGxrC3ZEh5E9y6kFJNGFFVayy7HM5qr0jGL4+HM3HzLKz9QgQv6UC3cerq/axoXtFf6vlwnPkH3VsDpmmhFYEzD8Z1GJxzTqUYoP8g2YOriX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5YXJy7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C05CC4CEF7;
	Sat, 19 Jul 2025 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752883789;
	bh=L86YVyx0apxTgB24V2M98O9bhmi45r78/Kb29rRjzuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E5YXJy7T2ksdjnStajnIQUP1DKdcUwoAjxRkloGSEo4iSwjVDslktIfC1e82GYfu5
	 /9vMAcVjugGG6LtYFAy7J1+ICjuPqO/HxgDxwYjuyxpkkQLCQMrYZu1HmR+d7pmBc4
	 4Ffhvl/zJlDJVWxHIPJcg2HDuNr62cO6LMjJtD/NM6BMEwZ71kJZlRWmcTBNdaIHFh
	 83xEbEVWeXg75cG0vjDan0VPimxtJ3rK3coDqQN3K3nQbzuvij3q/KcSo7lqZ4PIR3
	 FIt7Hfu7XMWEbG6OR/96MCospk/JnElc9n/K9l6ohutVPhJF9PdLX6owFgXMM4YTaJ
	 /kiHwbenCHRCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C75383BA3C;
	Sat, 19 Jul 2025 00:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stream: add description for sk_stream_write_space()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288380900.2831723.3967614204984051373.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:10:09 +0000
References: <20250716153404.7385-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250716153404.7385-1-suchitkarunakaran@gmail.com>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 21:04:04 +0530 you wrote:
> Add a proper description for the sk_stream_write_space() function as
> previously marked by a FIXME comment.
> No functional changes.
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  net/core/stream.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: stream: add description for sk_stream_write_space()
    https://git.kernel.org/netdev/net-next/c/8b7ab8eb52b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



