Return-Path: <netdev+bounces-170211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771F0A47D19
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB63B0589
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7319C233D88;
	Thu, 27 Feb 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvHmvkBD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FD22F38B;
	Thu, 27 Feb 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658198; cv=none; b=TrqtDh4OTKlPTLw8mRjl7KDK7aMStvXlf19JpbV4hTryXzoqyBTQqmBmtg5gBeKw+Az4dVGyGtFSt7bheJD4WPFy1fMooizDBq9LICJ6YCT43chOibLEKaoF8LRi+mko1pcnyE44zVodT7+E3RK2vGRZ//prJ7csnzUnAeV3a5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658198; c=relaxed/simple;
	bh=yqRB5lzPN6YFf0epR/fplLg16wEnwUaEt6MfRnoCkG0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b8reY4NJMQ2vuFF5vuEMxxAUR+yF3atuKN1qHTZSBzL0pY4cJ8NLjdHmRPEhkEo0KX1EvfhRMvFK1gWPOk/q5HSvG54HW2nExXxV49HfmQPYn7tHEzODaqVNE+STs6Q2HY8lb3va5Nq3cn+IWcK9Sbt/Jvy7FN8PUKAxHQkbxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvHmvkBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDDAC4CEDD;
	Thu, 27 Feb 2025 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658197;
	bh=yqRB5lzPN6YFf0epR/fplLg16wEnwUaEt6MfRnoCkG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BvHmvkBDxKI81m8GYkC48N4ySh3HjxU/wMO/QOWxsXxRBQM7yvSQ7KwsaO+ukxM5l
	 6NflidsF3RlQOPTyL0WzQrB8ZkBpiPTC3otpou6w7NYEoCf34s8NhtzyP437jSLBsQ
	 uzUzXXMkNj47VP+lkgX5e0zcwNTivGzK9335PlxsUxM76h49r5Jtv7H4S/vvbXw156
	 gxzkxbrazRaz76/5tp2Ug5j2E0I37BLWOHLeeuK58392O1U27gcVBfnddrre2I0JwC
	 ICTVZRjbNdfNF38m+yEJhqtm9XtQIqX37VgG9/JWwNz7Q/j3OKH+lSx5bCXtVAictC
	 co8bKMPuJqtxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB19C380AA7F;
	Thu, 27 Feb 2025 12:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] pktgen: avoid unused-const-variable warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174065822975.1403860.8629807772029389054.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 12:10:29 +0000
References: <20250225085722.469868-1-arnd@kernel.org>
In-Reply-To: <20250225085722.469868-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arnd@arndb.de, horms@kernel.org, ps.report@gmx.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Feb 2025 09:57:14 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When extra warnings are enable, there are configurations that build
> pktgen without CONFIG_XFRM, which leaves a static const variable unused:
> 
> net/core/pktgen.c:213:1: error: unused variable 'F_IPSEC' [-Werror,-Wunused-const-variable]
>   213 | PKT_FLAGS
>       | ^~~~~~~~~
> net/core/pktgen.c:197:2: note: expanded from macro 'PKT_FLAGS'
>   197 |         pf(IPSEC)               /* ipsec on for flows */                \
>       |         ^~~~~~~~~
> 
> [...]

Here is the summary with links:
  - pktgen: avoid unused-const-variable warning
    https://git.kernel.org/netdev/net-next/c/af4a5da8ed54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



