Return-Path: <netdev+bounces-85663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816FE89BCB3
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38F51C2173F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF62535A2;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqSh7Kpq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4752F8C
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571027; cv=none; b=EAVqZz+HJPHzPxew4iOyyDQ2fABX9k+MgP4G60TKWxHUmqU73VU3hcvCdks9mDiy8naK9gslPzhvLFCR1LyyAPURPuTk8vSir3i52YOhfjXNThYCpqtfsLm1xcJgIhCEueBaoqHl3x1xBlaTcJ6vyvdl1QsNF5TR/CghrrgNYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571027; c=relaxed/simple;
	bh=39+ATP77TqVFkQoDCRdFK7GDCUTRTdwxFjJvujnDuR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qznxEFYgb65azLLmLNvsA2aJTULid/6DfD6YQup6EaBccGCoMMAVVGvF+t03CixI6Wxs4iqIaEv8lnbKYujtIhTjD3X7xQYnSBvYM052yN8sYdi5e5AG0loM7Ox4wUr4ca2kUt8u43MgKBv52pE4JhVOD/zZsVSef9wL6MAURhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqSh7Kpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33E5FC433C7;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712571027;
	bh=39+ATP77TqVFkQoDCRdFK7GDCUTRTdwxFjJvujnDuR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OqSh7KpqSY2u2uhgREgXjkbKFc3RSdn7X0BMpMbfhnCVN1hs8142+Y7lm4b1c4S0Y
	 Q6wJGOACaGYXeiDdScEBCrYPBH+yG9/xD3iycTKilsq3jYb3gxk0L/zU6ce3FqnuRx
	 MgIjgYcTj0I+k1m26zZm9AmCpUUZcvhfI4+C5ZttlH3I5aCtYWGwdF3Va5HLM737Xd
	 yXR0jdn4jRCQhzLJ/K5oopx/xqwY1jVkF7Sb5OA4kqEq3FFlKmjVSIUnHGkhIP/ZoJ
	 TxlNdH9T3Di/glJXpAlDbBGiQqG/mmiw+5QPuU9gpB1hrjhAm3Mwee2QK7ej63m0e/
	 jb2P4lEF/oIQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28AD4C54BD4;
	Mon,  8 Apr 2024 10:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: remove RTNL protection from
 ip6addrlbl_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257102716.30740.8422777331851626057.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 10:10:27 +0000
References: <20240404132413.2633866-1-edumazet@google.com>
In-Reply-To: <20240404132413.2633866-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Apr 2024 13:24:13 +0000 you wrote:
> No longer hold RTNL while calling ip6addrlbl_dump()
> ("ip addrlabel show")
> 
> ip6addrlbl_dump() was already mostly relying on RCU anyway.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations around
> net->ipv6.ip6addrlbl_table.seq
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: remove RTNL protection from ip6addrlbl_dump()
    https://git.kernel.org/netdev/net-next/c/eec53cc38c4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



