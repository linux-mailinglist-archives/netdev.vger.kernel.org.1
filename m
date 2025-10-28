Return-Path: <netdev+bounces-233366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE86C12859
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88294228FB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4022A4DA;
	Tue, 28 Oct 2025 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZkX9iUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6D224220;
	Tue, 28 Oct 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614455; cv=none; b=QfP2fnrMvxz7faRhnZZiK0Pn2N9eeD2XFqli0xA0OamZI51WqBZYlgZ07wtWPWTNSaaf4cqIIX+NcuOOyIyPpr6+R8h4jQ9WphlH5ItA9Of5/ptOdV8HVPkr+aqnHmMKXZJ/QifqcGUghm7vxfNfGTop2b6YV2ox3byMcfAfSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614455; c=relaxed/simple;
	bh=AJUw3Rf9CvBUuFKjRWBjbXvzNsLMA0vSpgLIFniF95Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mrJ1Mu5HpmMRDmo+u0jmhxFEEDdw31iVtcAOjLF6ff/j5ubr6GKRRPmzokMR/F2QNSXyOeim9BMSbmP4JeQ/rT/VJSHCm2tAIXeGvMwiLYmQHg5Fz5PEO84dmobj2Gyw1zSFL5RZGaG/DSO4IwP5XAe3V6FQq2zIXyUf+zq882U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZkX9iUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB5DC4CEF1;
	Tue, 28 Oct 2025 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761614455;
	bh=AJUw3Rf9CvBUuFKjRWBjbXvzNsLMA0vSpgLIFniF95Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SZkX9iUzZu9t47ftNTeDGbZ63jkpHLNeLpII9HGuWNMBuv6Txq4y4OZv6uG7aH8AM
	 DUPB/kClgRsa6KW44f1n77M1k/fmLvzwL+jyXC6D19mg476pwjhj4VsEM5PyWe2MKe
	 PW++/LwWasdR5EFUNOsfRXP9bAzHeEqNVNA/GKeSuXdZ8YdmCC4s3ypMAlFF6a8ELI
	 T7R1t8xkO++TI/qWSFab9Xn601Zhc/XvTcmN9ffyqhtrY9pM5Nbt8UsxGnY91lhXiz
	 rtz7J+jnKNyltLc5DnwrsR9ElEq6AEeZAsWtSaYK9KUnz3wwAqN/+bmPxKBDmfuJWV
	 SzO5YiEmlxM5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCA39D60B9;
	Tue, 28 Oct 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: Remove unused typedef psched_tdiff_t
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161443349.1651448.7947829102277754548.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:20:33 +0000
References: <20251024025145.4069583-1-yuehaibing@huawei.com>
In-Reply-To: <20251024025145.4069583-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, xmei5@asu.edu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 10:51:45 +0800 you wrote:
> Since commit 051d44209842 ("net/sched: Retire CBQ qdisc")
> this is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/pkt_sched.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net/sched: Remove unused typedef psched_tdiff_t
    https://git.kernel.org/netdev/net-next/c/6f147c8328e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



