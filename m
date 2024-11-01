Return-Path: <netdev+bounces-140914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABD9B896D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CBC1C21C12
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653E148857;
	Fri,  1 Nov 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT5BfTSd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEA148827;
	Fri,  1 Nov 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428831; cv=none; b=d9zv0x5YRYkQX7t3fYNaKInylOtEfjuNAc0HcDEd4iu5wCDBnhXIieh2CGVCQHgS3HOxiNt8qUrYpNp8iZuE+EzIfiLqFPvpC6tubFQDB3JRuNZb+s1ZmF5hyZefmuaBETyduDH5XJUzN/8A+agQP6hn8AofHpZua9LinH16qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428831; c=relaxed/simple;
	bh=PzhGqm5cQ0OgHUAFof6xHq9gPxNOGYC923YOkb/ygWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R4/DLcJRbHjI+hi9wmrNyU6MufhdpscyHzVResatbKgWF2j/XHwUJX1O7Ekyk4RBX+oBR1npwbcaJ4asBnQnMtnMWeaIdXhIsMyes7uCB3hgtnYsZTFhLWXpxjr2TqUFBcIOq4fJ/zekawbMrd4U4MTxHp5tkXLdRkPchd0E3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT5BfTSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DFCC4CED4;
	Fri,  1 Nov 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428831;
	bh=PzhGqm5cQ0OgHUAFof6xHq9gPxNOGYC923YOkb/ygWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KT5BfTSdrbxUKAddydys1s82aug+cObZAWe+g7iwmJ8gAEBmKrEgfQgw7FzJFxxb+
	 6YAdRAH23GDCrC9gBw7hBGlmzQ4Fe1sFsT0HwnVLlYONtFeUALYWQQ/uqYMTzFgb7d
	 0xbMpmCJcgCFBCChM8sta69gf30XuphEeUC2fzA7tVZFhOGzRo9fKh2WqJMFVJpa44
	 KvnQIf+Xm000MfTSvc0/CGAp6qaoAvocFpziSae+GPkqCx4for9Ja/BEvDrLApYiR/
	 oOehPVPgoDnX6TZgdVpk3UyI8J0CeckFPBV6kVWRbKbZjHOkeNGt3yGT/l8Fd5ttiR
	 tmnt43WxvkugQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E1F380AC02;
	Fri,  1 Nov 2024 02:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netlink: Remove the dead code in
 netlink_proto_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042883900.2159382.7835628012758950930.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:40:39 +0000
References: <20241030012147.357400-1-ruanjinjie@huawei.com>
In-Reply-To: <20241030012147.357400-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com, dsahern@kernel.org,
 lirongqing@baidu.com, ryasuoka@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 09:21:47 +0800 you wrote:
> In the error path of netlink_proto_init(), frees the already allocated
> bucket table for new hash tables in a loop, but it is going to panic,
> so it is not necessary to clean up the resources, just remove the
> dead code.
> 
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netlink: Remove the dead code in netlink_proto_init()
    https://git.kernel.org/netdev/net-next/c/bc74d329ceba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



