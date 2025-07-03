Return-Path: <netdev+bounces-203837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC6AF76BC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E61165DC2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521511A83F5;
	Thu,  3 Jul 2025 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP9Dqhjh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A7139CE3;
	Thu,  3 Jul 2025 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551783; cv=none; b=XOg6J6juUUexoQUiV101+cZvVec1LUiZOHLQsLxUXv5OINkj+ey+U4hsRZAvnzslyxi5OkuTLFHnvGppJWH3oZhuuAWX7boOTYKAZTO/BhhSfeFCnoi7kczcQSTuAyMMbBg3jsgmdCgXNmJ/l3x5+zp02ZgsSsDibbQiy9canDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551783; c=relaxed/simple;
	bh=d+AA0aIYAW35Jbva39DX8xWrBth5P9tSdGBsyJyna3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sfo8ndwSK0GtyVpq3K5qmur3yMzrbJ+DiK+0hUlBt6nQfnZD1k2cuu6xd4QMXXQIZKhVNbaR3Mz6Bn3dFckmyK8y1J/Yxk1IrJbZMvdV+/zT/ZImAk1cdCN3psEZEqrCWo23xefIKJkyrnn0YRMgXPfuK4EXdDtFEIw3QuOwjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP9Dqhjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E29C4CEE3;
	Thu,  3 Jul 2025 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751551783;
	bh=d+AA0aIYAW35Jbva39DX8xWrBth5P9tSdGBsyJyna3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MP9DqhjhcPcuMyF0VjpyQq4q0EiSfjSQCvt/TaWp2y7W37AgU1FugOfBn5tSDqu5I
	 ICtkQIOCL8cEvl0otyvFwfcpP4J9WbYu4JU5Mm2/K3JGF3mo+1Ua5t4TlknZhDbuV7
	 1BWg2aQmA4R/va8Z/U99F85OXMh0Ups9+PTEhJhJ+V8jv6W+6dOl3sb+nh3LTsMoL6
	 r2artAeUVZL/1O94BxcvIpflK9LLI5oHsqJKZn038pMNJ7B9pfi8VyAkP3jvcJNkn8
	 E0IEHHP3RdlvxLz9lwNw5eDcMN/6ntNzX1+M8rkAH/wJ641s6I+sJhSld+M538fjJm
	 +O7Bah6l97F3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714B0383B274;
	Thu,  3 Jul 2025 14:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: Cleanup fib6_drop_pcpu_from()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175155180726.1495268.10436751896909260694.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 14:10:07 +0000
References: <20250701041235.1333687-1-yuehaibing@huawei.com>
In-Reply-To: <20250701041235.1333687-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 1 Jul 2025 12:12:35 +0800 you wrote:
> Since commit 0e2338749192 ("ipv6: fix races in ip6_dst_destroy()"),
> 'table' is unused in __fib6_drop_pcpu_from(), no need pass it from
> fib6_drop_pcpu_from().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/ip6_fib.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [net-next] ipv6: Cleanup fib6_drop_pcpu_from()
    https://git.kernel.org/netdev/net-next/c/5f712c3877f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



